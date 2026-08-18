import 'package:freezed_annotation/freezed_annotation.dart';

import 'cooking_step.dart';
import 'ingredient.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

@freezed
abstract class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(<Ingredient>[]) List<Ingredient> ingredients,
    @Default(<CookingStep>[]) List<CookingStep> steps,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
