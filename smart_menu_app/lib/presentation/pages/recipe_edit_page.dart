import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_strings.dart';
import '../../domain/use_cases/update_recipe_use_case.dart';
import '../providers/recipe_providers.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/recipe_editor_page.dart';

class RecipeEditPage extends ConsumerWidget {
  const RecipeEditPage({required this.recipeId, super.key});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeDetailProvider(recipeId));

    return recipeAsync.when(
      data: (recipe) {
        if (recipe == null) {
          return Scaffold(
            appBar: AppBar(title: const Text(AppStrings.recipeEditTitle)),
            body: const EmptyStateView(
              title: '配方不存在',
              description: '该配方可能已被删除，请返回列表重新选择。',
            ),
          );
        }

        return RecipeEditorPage(
          pageTitle: AppStrings.recipeEditTitle,
          primaryActionLabel: '保存',
          isEditMode: true,
          initialRecipe: recipe,
          onSubmit: (draft) async {
            final savedRecipe = await ref.read(updateRecipeUseCaseProvider)(
              UpdateRecipeCommand(
                originalRecipe: recipe,
                editedRecipe: draft,
              ),
            );
            ref.invalidate(recipeListProvider);
            ref.invalidate(recipeDetailProvider(recipeId));
            return savedRecipe;
          },
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          appBar: AppBar(title: const Text(AppStrings.recipeEditTitle)),
          body: const EmptyStateView(
            title: '加载失败',
            description: '编辑页暂时无法打开，请稍后重试。',
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
