import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';

import '../../domain/models/cooking_step.dart';
import '../../domain/models/ingredient.dart';
import '../../domain/models/recipe.dart';
import '../../domain/value_objects/ingredient_type.dart';
import '../../domain/value_objects/ingredient_unit.dart';
import '../../domain/value_objects/precision_option.dart';
import '../../domain/value_objects/rounding_mode.dart';
import '../datasources/local/database.dart';

class RecipeMapper {
  const RecipeMapper._();

  static Recipe toDomain(
    RecipeEntity recipe,
    List<IngredientEntity> ingredients,
    List<CookingStepEntity> cookingSteps,
  ) {
    return Recipe(
      id: recipe.id,
      name: recipe.name,
      createdAt: recipe.createdAt,
      updatedAt: recipe.updatedAt,
      ingredients: ingredients.map(toDomainIngredient).toList(growable: false),
      steps: cookingSteps.map(toDomainCookingStep).toList(growable: false),
    );
  }

  static Ingredient toDomainIngredient(IngredientEntity ingredient) {
    final numericAmount = _parseDecimalOrNull(ingredient.amount);

    return Ingredient(
      id: ingredient.id,
      name: ingredient.name,
      amount: numericAmount,
      amountText: ingredient.amount,
      unit: _ingredientUnitFromDb(ingredient.unit),
      type: _ingredientTypeFromDb(ingredient.type),
      scalable: ingredient.scalable,
      precision: _precisionOptionFromDb(ingredient.precision),
      roundingMode: _roundingModeFromDb(ingredient.roundingMode),
      sortOrder: ingredient.sortOrder,
      remark: ingredient.remark,
    );
  }

  static CookingStep toDomainCookingStep(CookingStepEntity cookingStep) {
    return CookingStep(
      id: cookingStep.id,
      stepNo: cookingStep.stepNo,
      content: cookingStep.content,
      sortOrder: cookingStep.sortOrder,
    );
  }

  static RecipeEntitiesCompanion toRecipeCompanion(Recipe recipe) {
    return RecipeEntitiesCompanion(
      id: Value(recipe.id),
      name: Value(recipe.name),
      createdAt: Value(recipe.createdAt),
      updatedAt: Value(recipe.updatedAt),
    );
  }

  static List<IngredientEntitiesCompanion> toIngredientCompanions(
    String recipeId,
    List<Ingredient> ingredients,
  ) {
    return ingredients
        .map(
          (ingredient) => IngredientEntitiesCompanion(
            id: Value(ingredient.id),
            recipeId: Value(recipeId),
            name: Value(ingredient.name),
            amount: Value(_ingredientAmountToDb(ingredient)),
            unit: Value(ingredient.unit.name),
            type: Value(ingredient.type.name),
            scalable: Value(ingredient.scalable),
            precision: Value(ingredient.precision.name),
            roundingMode: Value(ingredient.roundingMode.name),
            sortOrder: Value(ingredient.sortOrder),
            remark: Value(ingredient.remark),
          ),
        )
        .toList(growable: false);
  }

  static List<CookingStepEntitiesCompanion> toCookingStepCompanions(
    String recipeId,
    List<CookingStep> cookingSteps,
  ) {
    return cookingSteps
        .map(
          (cookingStep) => CookingStepEntitiesCompanion(
            id: Value(cookingStep.id),
            recipeId: Value(recipeId),
            stepNo: Value(cookingStep.stepNo),
            content: Value(cookingStep.content),
            sortOrder: Value(cookingStep.sortOrder),
          ),
        )
        .toList(growable: false);
  }

  static String _ingredientAmountToDb(Ingredient ingredient) {
    return ingredient.amount?.toString() ?? ingredient.amountText;
  }

  static Decimal? _parseDecimalOrNull(String rawValue) {
    try {
      return Decimal.parse(rawValue);
    } on FormatException {
      return null;
    }
  }

  static IngredientUnit _ingredientUnitFromDb(String value) {
    return IngredientUnit.values.firstWhere(
      (item) => item.name == value,
      orElse: () => IngredientUnit.other,
    );
  }

  static IngredientType _ingredientTypeFromDb(String value) {
    return IngredientType.values.firstWhere(
      (item) => item.name == value,
      orElse: () => IngredientType.other,
    );
  }

  static PrecisionOption _precisionOptionFromDb(String value) {
    return PrecisionOption.values.firstWhere(
      (item) => item.name == value,
      orElse: () => PrecisionOption.one,
    );
  }

  static IngredientRoundingMode _roundingModeFromDb(String value) {
    return IngredientRoundingMode.values.firstWhere(
      (item) => item.name == value,
      orElse: () => IngredientRoundingMode.floor,
    );
  }
}
