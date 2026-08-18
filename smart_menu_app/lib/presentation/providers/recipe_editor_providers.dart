import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/recipe_editor_controller.dart';

final recipeEditorControllerProvider = ChangeNotifierProvider.autoDispose
    .family<RecipeEditorController, RecipeEditorConfig>((ref, config) {
      return RecipeEditorController(
        initialRecipe: config.initialRecipe,
        isEditMode: config.isEditMode,
      );
    });
