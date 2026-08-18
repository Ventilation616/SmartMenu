import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';
import 'use_case.dart';

class GetRecipeDetailUseCase implements UseCase<Recipe?, String> {
  GetRecipeDetailUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<Recipe?> call(String input) {
    return _repository.getRecipeById(input);
  }
}
