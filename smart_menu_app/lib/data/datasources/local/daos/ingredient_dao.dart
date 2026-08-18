part of '../database.dart';

@DriftAccessor(tables: <Type>[IngredientEntities])
class IngredientDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientDaoMixin {
  IngredientDao(super.attachedDatabase);

  Future<List<IngredientEntity>> getIngredientsByRecipeId(String recipeId) {
    return (select(ingredientEntities)
          ..where((table) => table.recipeId.equals(recipeId))
          ..orderBy(<OrderingTerm Function(IngredientEntities)>[
            (table) => OrderingTerm(expression: table.sortOrder),
          ]))
        .get();
  }

  Future<void> replaceIngredients(
    String recipeId,
    List<IngredientEntitiesCompanion> ingredients,
  ) async {
    await (delete(
      ingredientEntities,
    )..where((table) => table.recipeId.equals(recipeId))).go();

    if (ingredients.isEmpty) {
      return;
    }

    await batch((batch) {
      batch.insertAll(ingredientEntities, ingredients);
    });
  }
}
