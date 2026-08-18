import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';
import 'use_case.dart';

class SearchRecipesUseCase implements UseCase<List<Recipe>, String> {
  SearchRecipesUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<List<Recipe>> call(String input) {
    return _repository.searchRecipes(input.trim());
  }
}
