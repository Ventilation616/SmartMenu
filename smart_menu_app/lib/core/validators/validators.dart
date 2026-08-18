import 'dart:math';

import 'package:decimal/decimal.dart';
// ignore: depend_on_referenced_packages
import 'package:rational/rational.dart';

import '../../domain/models/ingredient.dart';
import '../../domain/models/recipe.dart';
import '../exceptions/app_exception.dart';
import '../utils/decimal_utils.dart';
import '../utils/rounding_utils.dart';

class ScaleTargetSelection {
  const ScaleTargetSelection({
    required this.originalIngredient,
    required this.editedIngredient,
  });

  final Ingredient originalIngredient;
  final Ingredient editedIngredient;
}

class Validators {
  const Validators._();

  static String? requiredText(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName不能为空';
    }

    return null;
  }

  static void validateRecipeForSave(Recipe recipe) {
    final recipeNameError = requiredText(recipe.name, fieldName: '菜名');
    if (recipeNameError != null) {
      throw ValidationException(recipeNameError);
    }

    for (var index = 0; index < recipe.ingredients.length; index++) {
      final ingredient = recipe.ingredients[index];
      final prefix = '第${index + 1}个食材';

      final ingredientNameError = requiredText(
        ingredient.name,
        fieldName: '$prefix名称',
      );
      if (ingredientNameError != null) {
        throw ValidationException(ingredientNameError);
      }

      if (ingredient.amountText.trim().isEmpty) {
        throw ValidationException('$prefix用量不能为空');
      }

      final numericAmount =
          ingredient.amount ??
          DecimalUtils.tryParseAmount(ingredient.amountText);

      if (numericAmount != null && numericAmount < Decimal.zero) {
        throw ValidationException('$prefix用量必须是合法非负数字');
      }

      if (ingredient.scalable && numericAmount == null) {
        throw ValidationException('$prefix用量必须是合法非负数字');
      }
    }

    for (var index = 0; index < recipe.steps.length; index++) {
      final step = recipe.steps[index];
      final stepError = requiredText(
        step.content,
        fieldName: '第${index + 1}个步骤内容',
      );
      if (stepError != null) {
        throw ValidationException(stepError);
      }
    }
  }

  static ScaleTargetSelection? findScaleTarget({
    required Recipe originalRecipe,
    required Recipe editedRecipe,
  }) {
    final originalIngredientMap = <String, Ingredient>{
      for (final ingredient in originalRecipe.ingredients)
        ingredient.id: ingredient,
    };

    final changedScalableIngredients = <ScaleTargetSelection>[];

    for (final editedIngredient in editedRecipe.ingredients) {
      final originalIngredient = originalIngredientMap[editedIngredient.id];
      if (originalIngredient == null) {
        continue;
      }

      final originalAmount =
          originalIngredient.amount ??
          DecimalUtils.tryParseAmount(originalIngredient.amountText);
      final editedAmount =
          editedIngredient.amount ??
          DecimalUtils.tryParseAmount(editedIngredient.amountText);

      if (originalAmount == editedAmount) {
        continue;
      }

      if (editedIngredient.scalable) {
        changedScalableIngredients.add(
          ScaleTargetSelection(
            originalIngredient: originalIngredient,
            editedIngredient: editedIngredient,
          ),
        );
      }
    }

    if (changedScalableIngredients.isEmpty) {
      return null;
    }

    final selection = changedScalableIngredients.length == 1
        ? changedScalableIngredients.single
        : _resolveScaleTargetByConsistentScale(changedScalableIngredients);

    if (selection == null) {
      throw ValidationException('同一时间只能有一个参与比例计算的食材作为调整基准');
    }

    final originalAmount = _getNumericAmount(selection.originalIngredient);
    final editedAmount = _getNumericAmount(selection.editedIngredient);

    if (!selection.editedIngredient.scalable) {
      throw ValidationException('调整基准食材必须参与比例计算');
    }

    if (originalAmount == null || originalAmount <= Decimal.zero) {
      throw ValidationException('调整基准食材的原始用量必须大于 0');
    }

    if (editedAmount == null || editedAmount < Decimal.zero) {
      throw ValidationException('调整基准食材的新用量必须是合法非负数字');
    }

    return selection;
  }

  static ScaleTargetSelection? _resolveScaleTargetByConsistentScale(
    List<ScaleTargetSelection> changedScalableIngredients,
  ) {
    for (final candidate in changedScalableIngredients) {
      final originalAmount = _getNumericAmount(candidate.originalIngredient);
      final editedAmount = _getNumericAmount(candidate.editedIngredient);
      if (originalAmount == null ||
          originalAmount <= Decimal.zero ||
          editedAmount == null ||
          editedAmount < Decimal.zero) {
        continue;
      }

      final scale = editedAmount / originalAmount;
      final matchesAllScaledValues = changedScalableIngredients.every(
        (selection) => _matchesScaledValue(
          selection: selection,
          target: candidate,
          scale: scale,
        ),
      );

      if (matchesAllScaledValues) {
        return candidate;
      }
    }

    return null;
  }

  static bool _matchesScaledValue({
    required ScaleTargetSelection selection,
    required ScaleTargetSelection target,
    required Rational scale,
  }) {
    final originalAmount = _getNumericAmount(selection.originalIngredient);
    final editedAmount = _getNumericAmount(selection.editedIngredient);
    if (originalAmount == null || editedAmount == null) {
      return false;
    }

    if (selection.editedIngredient.id == target.editedIngredient.id) {
      return editedAmount == _getNumericAmount(target.editedIngredient);
    }

    final rawAmount = (originalAmount.toRational() * scale).toDecimal(
      scaleOnInfinitePrecision: _calculationScale(selection.editedIngredient),
    );
    final expectedAmount = RoundingUtils.applyPrecision(
      rawAmount,
      precision: selection.editedIngredient.precision,
      roundingMode: selection.editedIngredient.roundingMode,
    );
    return editedAmount == expectedAmount;
  }

  static Decimal? _getNumericAmount(Ingredient ingredient) {
    return ingredient.amount ??
        DecimalUtils.tryParseAmount(ingredient.amountText);
  }

  static int _calculationScale(Ingredient ingredient) {
    final precisionScale = Decimal.parse(ingredient.precision.value).scale;
    return max(precisionScale + 6, 8);
  }
}
