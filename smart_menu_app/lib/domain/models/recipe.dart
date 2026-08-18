import 'cooking_step.dart';
import 'ingredient.dart';

class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.steps,
  });

  final String id;
  final String name;
  final String category;
  final String description;
  final List<Ingredient> ingredients;
  final List<CookingStep> steps;
}
