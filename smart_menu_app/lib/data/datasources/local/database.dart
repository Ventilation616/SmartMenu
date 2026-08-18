import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/cooking_steps_table.dart';
import 'tables/ingredients_table.dart';
import 'tables/recipes_table.dart';

part 'daos/cooking_step_dao.dart';
part 'daos/ingredient_dao.dart';
part 'daos/recipe_dao.dart';
part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(p.join(directory.path, 'smart_menu.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: <Type>[RecipeEntities, IngredientEntities, CookingStepEntities],
  daos: <Type>[RecipeDao, IngredientDao, CookingStepDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await customStatement('ALTER TABLE recipes DROP COLUMN category');
        await customStatement('ALTER TABLE recipes DROP COLUMN description');
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  @override
  int get schemaVersion => 2;
}
