import '../../domain/models/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/local/database.dart';
import '../mappers/recipe_mapper.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl({
    required this._database,
    required this._recipeDao,
    required this._ingredientDao,
    required this._cookingStepDao,
  });

  final AppDatabase _database;
  final RecipeDao _recipeDao;
  final IngredientDao _ingredientDao;
  final CookingStepDao _cookingStepDao;

  @override
  Future<void> deleteRecipe(String id) async {
    await _recipeDao.deleteRecipeById(id);
  }

  @override
  Future<Recipe?> getRecipeById(String id) async {
    final recipeRow = await _recipeDao.getRecipeById(id);

    if (recipeRow == null) {
      return null;
    }

    final ingredients = await _ingredientDao.getIngredientsByRecipeId(id);
    final cookingSteps = await _cookingStepDao.getCookingStepsByRecipeId(id);

    return RecipeMapper.toDomain(recipeRow, ingredients, cookingSteps);
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    final recipes = await _recipeDao.getAllRecipes();
    return _toDomainRecipes(recipes);
  }

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    final recipeCompanion = RecipeMapper.toRecipeCompanion(recipe);
    final ingredientCompanions = RecipeMapper.toIngredientCompanions(
      recipe.id,
      recipe.ingredients,
    );
    final cookingStepCompanions = RecipeMapper.toCookingStepCompanions(
      recipe.id,
      recipe.steps,
    );

    await _database.transaction(() async {
      await _recipeDao.upsertRecipe(recipeCompanion);
      await _ingredientDao.replaceIngredients(recipe.id, ingredientCompanions);
      await _cookingStepDao.replaceCookingSteps(
        recipe.id,
        cookingStepCompanions,
      );
    });
  }

  @override
  Future<List<Recipe>> searchRecipes(String keyword) async {
    final recipes = await _recipeDao.searchRecipesByName(keyword);
    return _toDomainRecipes(recipes);
  }

  Future<List<Recipe>> _toDomainRecipes(List<RecipeEntity> recipes) async {
    return Future.wait(
      recipes.map((recipe) async {
        final ingredients = await _ingredientDao.getIngredientsByRecipeId(
          recipe.id,
        );
        final cookingSteps = await _cookingStepDao.getCookingStepsByRecipeId(
          recipe.id,
        );

        return RecipeMapper.toDomain(recipe, ingredients, cookingSteps);
      }),
    );
  }
}
