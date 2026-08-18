import 'package:drift/drift.dart';

import 'recipes_table.dart';

class CookingStepEntities extends Table {
  @override
  String get tableName => 'cooking_steps';

  TextColumn get id => text()();

  TextColumn get recipeId => text().references(RecipeEntities, #id)();

  IntColumn get stepNo => integer()();

  TextColumn get content => text()();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
