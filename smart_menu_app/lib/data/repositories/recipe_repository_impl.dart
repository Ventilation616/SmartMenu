import '../../domain/models/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  const RecipeRepositoryImpl();

  @override
  Future<void> deleteRecipe(String id) async {}

  @override
  Future<Recipe?> getRecipeById(String id) async {
    return null;
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    return const <Recipe>[];
  }

  @override
  Future<void> saveRecipe(Recipe recipe) async {}
}
