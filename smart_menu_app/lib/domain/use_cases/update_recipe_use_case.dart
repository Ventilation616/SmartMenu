import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/decimal_utils.dart';
import '../../core/utils/rounding_utils.dart';
import '../../core/validators/validators.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';
import 'recipe_input_preparer.dart';
import 'use_case.dart';

class UpdateRecipeCommand {
  const UpdateRecipeCommand({
    required this.originalRecipe,
    required this.editedRecipe,
  });

  final Recipe originalRecipe;
  final Recipe editedRecipe;
}

class UpdateRecipeUseCase implements UseCase<Recipe, UpdateRecipeCommand> {
  UpdateRecipeUseCase(this._repository, {Uuid? uuid, DateTime Function()? now})
    : _uuid = uuid ?? const Uuid(),
      _now = now ?? DateTime.now;

  final RecipeRepository _repository;
  final Uuid _uuid;
  final DateTime Function() _now;

  @override
  Future<Recipe> call(UpdateRecipeCommand input) async {
    final preparedEditedRecipe = RecipeInputPreparer.prepareForUpdate(
      input.editedRecipe,
      originalRecipe: input.originalRecipe,
      now: _now(),
      uuid: _uuid,
    );

    final scaleTarget = Validators.findScaleTarget(
      originalRecipe: input.originalRecipe,
      editedRecipe: preparedEditedRecipe,
    );

    final finalRecipe = scaleTarget == null
        ? preparedEditedRecipe
        : _applyDynamicScaling(
            originalRecipe: input.originalRecipe,
            editedRecipe: preparedEditedRecipe,
            target: scaleTarget,
          );

    Validators.validateRecipeForSave(finalRecipe);
    await _repository.saveRecipe(finalRecipe);
    return finalRecipe;
  }

  Recipe _applyDynamicScaling({
    required Recipe originalRecipe,
    required Recipe editedRecipe,
    required ScaleTargetSelection target,
  }) {
    final originalIngredientMap = <String, Ingredient>{
      for (final ingredient in originalRecipe.ingredients)
        ingredient.id: ingredient,
    };
    final originalTargetAmount = _getNumericAmount(target.originalIngredient)!;
    final editedTargetAmount = _getNumericAmount(target.editedIngredient)!;
    final scale = editedTargetAmount / originalTargetAmount;

    final updatedIngredients = editedRecipe.ingredients
        .map((ingredient) {
          if (ingredient.id == target.editedIngredient.id) {
            return ingredient.copyWith(
              amount: editedTargetAmount,
              amountText: DecimalUtils.formatDecimal(editedTargetAmount),
            );
          }

          final originalIngredient = originalIngredientMap[ingredient.id];
          if (originalIngredient == null || !ingredient.scalable) {
            return ingredient;
          }

          final originalAmount = _getNumericAmount(originalIngredient);
          if (originalAmount == null) {
            return ingredient;
          }

          final rawAmount = (originalAmount.toRational() * scale).toDecimal(
            scaleOnInfinitePrecision: _calculationScale(ingredient),
          );
          final roundedAmount = RoundingUtils.applyPrecision(
            rawAmount,
            precision: ingredient.precision,
            roundingMode: ingredient.roundingMode,
          );

          return ingredient.copyWith(
            amount: roundedAmount,
            amountText: DecimalUtils.formatDecimal(roundedAmount),
          );
        })
        .toList(growable: false);

    return editedRecipe.copyWith(ingredients: updatedIngredients);
  }

  Decimal? _getNumericAmount(Ingredient ingredient) {
    return ingredient.amount ??
        DecimalUtils.tryParseAmount(ingredient.amountText);
  }

  int _calculationScale(Ingredient ingredient) {
    final precisionScale = Decimal.parse(ingredient.precision.value).scale;
    return max(precisionScale + 6, 8);
  }
}
