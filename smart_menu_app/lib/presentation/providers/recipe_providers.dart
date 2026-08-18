import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../view_models/recipe_list_view_model.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepositoryImpl(
    database: ref.watch(appDatabaseProvider),
    recipeDao: ref.watch(recipeDaoProvider),
    ingredientDao: ref.watch(ingredientDaoProvider),
    cookingStepDao: ref.watch(cookingStepDaoProvider),
  );
});

final recipeListViewModelProvider =
    Provider<RecipeListViewModel>((ref) => const RecipeListViewModel());
