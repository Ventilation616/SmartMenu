part of '../database.dart';

@DriftAccessor(tables: <Type>[RecipeEntities])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  RecipeDao(super.attachedDatabase);

  Future<List<RecipeEntity>> getAllRecipes() {
    return (select(recipeEntities)
          ..orderBy(<OrderingTerm Function(RecipeEntities)>[
            (table) => OrderingTerm(
              expression: table.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  Future<List<RecipeEntity>> searchRecipesByName(String keyword) {
    final normalizedKeyword = keyword.trim();

    if (normalizedKeyword.isEmpty) {
      return getAllRecipes();
    }

    return (select(recipeEntities)
          ..where((table) => table.name.like('%$normalizedKeyword%'))
          ..orderBy(<OrderingTerm Function(RecipeEntities)>[
            (table) => OrderingTerm(
              expression: table.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  Future<RecipeEntity?> getRecipeById(String id) {
    return (select(
      recipeEntities,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<void> upsertRecipe(RecipeEntitiesCompanion recipe) async {
    await into(recipeEntities).insertOnConflictUpdate(recipe);
  }

  Future<int> deleteRecipeById(String id) {
    return (delete(recipeEntities)..where((table) => table.id.equals(id))).go();
  }
}
