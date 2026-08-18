import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';
import 'use_case.dart';

class GetRecipeListUseCase implements UseCase<List<Recipe>, NoParams> {
  GetRecipeListUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<List<Recipe>> call(NoParams input) {
    return _repository.getRecipes();
  }
}
