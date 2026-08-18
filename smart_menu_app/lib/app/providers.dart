import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../data/datasources/local/database.dart';

final loggerProvider = Provider<Logger>((ref) {
  return Logger();
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() {
    database.close();
  });
  return database;
});

final recipeDaoProvider = Provider<RecipeDao>((ref) {
  return RecipeDao(ref.watch(appDatabaseProvider));
});

final ingredientDaoProvider = Provider<IngredientDao>((ref) {
  return IngredientDao(ref.watch(appDatabaseProvider));
});

final cookingStepDaoProvider = Provider<CookingStepDao>((ref) {
  return CookingStepDao(ref.watch(appDatabaseProvider));
});
