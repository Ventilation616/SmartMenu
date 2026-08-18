import '../repositories/recipe_repository.dart';
import 'use_case.dart';

class DeleteRecipeUseCase implements UseCase<void, String> {
  DeleteRecipeUseCase(this._repository);

  final RecipeRepository _repository;

  @override
  Future<void> call(String input) {
    return _repository.deleteRecipe(input);
  }
}
