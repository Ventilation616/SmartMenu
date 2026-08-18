import 'package:uuid/uuid.dart';

import '../../core/validators/validators.dart';
import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';
import 'recipe_input_preparer.dart';
import 'use_case.dart';

class CreateRecipeUseCase implements UseCase<Recipe, Recipe> {
  CreateRecipeUseCase(this._repository, {Uuid? uuid, DateTime Function()? now})
    : _uuid = uuid ?? const Uuid(),
      _now = now ?? DateTime.now;

  final RecipeRepository _repository;
  final Uuid _uuid;
  final DateTime Function() _now;

  @override
  Future<Recipe> call(Recipe input) async {
    final preparedRecipe = RecipeInputPreparer.prepareForCreate(
      input,
      now: _now(),
      uuid: _uuid,
    );

    Validators.validateRecipeForSave(preparedRecipe);
    await _repository.saveRecipe(preparedRecipe);
    return preparedRecipe;
  }
}
