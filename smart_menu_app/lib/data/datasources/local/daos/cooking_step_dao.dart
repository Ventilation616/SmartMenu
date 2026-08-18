part of '../database.dart';

@DriftAccessor(tables: <Type>[CookingStepEntities])
class CookingStepDao extends DatabaseAccessor<AppDatabase>
    with _$CookingStepDaoMixin {
  CookingStepDao(super.attachedDatabase);

  Future<List<CookingStepEntity>> getCookingStepsByRecipeId(String recipeId) {
    return (select(cookingStepEntities)
          ..where((table) => table.recipeId.equals(recipeId))
          ..orderBy(<OrderingTerm Function(CookingStepEntities)>[
            (table) => OrderingTerm(expression: table.sortOrder),
          ]))
        .get();
  }

  Future<void> replaceCookingSteps(
    String recipeId,
    List<CookingStepEntitiesCompanion> cookingSteps,
  ) async {
    await (delete(cookingStepEntities)
          ..where((table) => table.recipeId.equals(recipeId)))
        .go();

    if (cookingSteps.isEmpty) {
      return;
    }

    await batch((batch) {
      batch.insertAll(cookingStepEntities, cookingSteps);
    });
  }
}
