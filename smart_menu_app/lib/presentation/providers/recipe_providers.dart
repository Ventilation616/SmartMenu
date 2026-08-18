import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../../domain/use_cases/create_recipe_use_case.dart';
import '../../domain/use_cases/delete_recipe_use_case.dart';
import '../../domain/use_cases/get_recipe_detail_use_case.dart';
import '../../domain/use_cases/get_recipe_list_use_case.dart';
import '../../domain/use_cases/search_recipes_use_case.dart';
import '../../domain/use_cases/update_recipe_use_case.dart';
import '../view_models/recipe_list_view_model.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepositoryImpl(
    database: ref.watch(appDatabaseProvider),
    recipeDao: ref.watch(recipeDaoProvider),
    ingredientDao: ref.watch(ingredientDaoProvider),
    cookingStepDao: ref.watch(cookingStepDaoProvider),
  );
});

final recipeListViewModelProvider = Provider<RecipeListViewModel>(
  (ref) => const RecipeListViewModel(),
);

final createRecipeUseCaseProvider = Provider<CreateRecipeUseCase>((ref) {
  return CreateRecipeUseCase(ref.watch(recipeRepositoryProvider));
});

final updateRecipeUseCaseProvider = Provider<UpdateRecipeUseCase>((ref) {
  return UpdateRecipeUseCase(ref.watch(recipeRepositoryProvider));
});

final getRecipeListUseCaseProvider = Provider<GetRecipeListUseCase>((ref) {
  return GetRecipeListUseCase(ref.watch(recipeRepositoryProvider));
});

final searchRecipesUseCaseProvider = Provider<SearchRecipesUseCase>((ref) {
  return SearchRecipesUseCase(ref.watch(recipeRepositoryProvider));
});

final getRecipeDetailUseCaseProvider = Provider<GetRecipeDetailUseCase>((ref) {
  return GetRecipeDetailUseCase(ref.watch(recipeRepositoryProvider));
});

final deleteRecipeUseCaseProvider = Provider<DeleteRecipeUseCase>((ref) {
  return DeleteRecipeUseCase(ref.watch(recipeRepositoryProvider));
});
