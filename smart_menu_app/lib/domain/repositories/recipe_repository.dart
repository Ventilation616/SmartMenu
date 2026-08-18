import '../models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes();

  Future<List<Recipe>> searchRecipes(String keyword);

  Future<Recipe?> getRecipeById(String id);

  Future<void> saveRecipe(Recipe recipe);

  Future<void> deleteRecipe(String id);
}
