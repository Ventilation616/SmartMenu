import 'package:uuid/uuid.dart';

import '../../core/utils/decimal_utils.dart';
import '../models/cooking_step.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';

class RecipeInputPreparer {
  const RecipeInputPreparer._();

  static Recipe prepareForCreate(
    Recipe recipe, {
    required DateTime now,
    required Uuid uuid,
  }) {
    return _prepareRecipe(
      recipe,
      now: now,
      uuid: uuid,
      recipeId: recipe.id.trim().isEmpty ? uuid.v4() : recipe.id.trim(),
      createdAt: now,
    );
  }

  static Recipe prepareForUpdate(
    Recipe editedRecipe, {
    required Recipe originalRecipe,
    required DateTime now,
    required Uuid uuid,
  }) {
    return _prepareRecipe(
      editedRecipe,
      now: now,
      uuid: uuid,
      recipeId: originalRecipe.id,
      createdAt: originalRecipe.createdAt,
    );
  }

  static Recipe _prepareRecipe(
    Recipe recipe, {
    required DateTime now,
    required Uuid uuid,
    required String recipeId,
    required DateTime createdAt,
  }) {
    return recipe.copyWith(
      id: recipeId,
      name: recipe.name.trim(),
      category: recipe.category.trim(),
      description: recipe.description.trim(),
      createdAt: createdAt,
      updatedAt: now,
      ingredients: _prepareIngredients(recipe.ingredients, uuid),
      steps: _prepareSteps(recipe.steps, uuid),
    );
  }

  static List<Ingredient> _prepareIngredients(
    List<Ingredient> ingredients,
    Uuid uuid,
  ) {
    return ingredients
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final ingredient = entry.value;
          final rawAmountText = ingredient.amountText.trim();
          final numericAmount =
              ingredient.amount ?? DecimalUtils.tryParseAmount(rawAmountText);
          final normalizedAmountText = numericAmount != null
              ? DecimalUtils.formatDecimal(numericAmount)
              : rawAmountText;
          final shouldDisableScaling = DecimalUtils.isDescriptorAmount(
            normalizedAmountText,
          );

          return ingredient.copyWith(
            id: ingredient.id.trim().isEmpty ? uuid.v4() : ingredient.id.trim(),
            name: ingredient.name.trim(),
            amount: numericAmount,
            amountText: normalizedAmountText,
            scalable: shouldDisableScaling ? false : ingredient.scalable,
            sortOrder: index,
            remark: ingredient.remark.trim(),
          );
        })
        .toList(growable: false);
  }

  static List<CookingStep> _prepareSteps(List<CookingStep> steps, Uuid uuid) {
    return steps
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final step = entry.value;

          return step.copyWith(
            id: step.id.trim().isEmpty ? uuid.v4() : step.id.trim(),
            stepNo: index + 1,
            sortOrder: index,
            content: step.content.trim(),
          );
        })
        .toList(growable: false);
  }
}
