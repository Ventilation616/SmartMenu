import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_strings.dart';
import '../providers/recipe_providers.dart';
import '../widgets/recipe_editor_page.dart';

class RecipeCreatePage extends ConsumerWidget {
  const RecipeCreatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RecipeEditorPage(
      pageTitle: AppStrings.recipeCreateTitle,
      primaryActionLabel: '确认',
      onSubmit: (draft) async {
        final savedRecipe = await ref.read(createRecipeUseCaseProvider)(draft);
        ref.invalidate(recipeListProvider);
        return savedRecipe;
      },
    );
  }
}
