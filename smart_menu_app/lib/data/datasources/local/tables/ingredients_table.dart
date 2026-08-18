import 'package:drift/drift.dart';

import 'recipes_table.dart';

class IngredientEntities extends Table {
  @override
  String get tableName => 'ingredients';

  TextColumn get id => text()();

  TextColumn get recipeId =>
      text().references(RecipeEntities, #id, onDelete: KeyAction.cascade)();

  TextColumn get name => text()();

  TextColumn get amount => text()();

  TextColumn get unit => text()();

  TextColumn get type => text()();

  BoolColumn get scalable => boolean().withDefault(const Constant(true))();

  TextColumn get precision => text()();

  TextColumn get roundingMode => text()();

  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  TextColumn get remark => text().withDefault(const Constant(''))();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
