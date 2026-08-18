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
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
