import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/models/recipe.dart';
import '../providers/recipe_providers.dart';
import '../widgets/empty_state_view.dart';
import '../widgets/recipe_feedback.dart';

class RecipeListPage extends ConsumerStatefulWidget {
  const RecipeListPage({super.key});

  @override
  ConsumerState<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends ConsumerState<RecipeListPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(
      text: ref.read(recipeListSearchKeywordProvider),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(recipeListProvider);
    final keyword = ref.watch(recipeListSearchKeywordProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.recipeListTitle)),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: '搜索配方',
                suffixIcon: keyword.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          ref
                                  .read(
                                    recipeListSearchKeywordProvider.notifier,
                                  )
                                  .state =
                              '';
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
              onChanged: (value) {
                ref.read(recipeListSearchKeywordProvider.notifier).state =
                    value;
              },
            ),
          ),
          Expanded(
            child: recipesAsync.when(
              data: (recipes) {
                if (recipes.isEmpty) {
                  return EmptyStateView(
                    title: keyword.isEmpty ? '还没有配方' : '没有找到匹配的配方',
                    description: keyword.isEmpty
                        ? '从右下角开始新建你的第一道菜。'
                        : '换个关键词试试，或者新建一个新的配方。',
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: recipes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return _RecipeCard(
                      recipe: recipe,
                      onTap: () => context.push(
                        AppRoutePath.recipeDetail.replaceFirst(
                          ':recipeId',
                          recipe.id,
                        ),
                      ),
                      onDelete: () => _deleteRecipe(context, recipe),
                    );
                  },
                );
              },
              error: (error, stackTrace) =>
                  const EmptyStateView(title: '列表加载失败', description: '请稍后重试。'),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutePath.recipeCreate),
        label: const Text('新建'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _deleteRecipe(BuildContext context, Recipe recipe) async {
    final confirmed = await RecipeFeedback.confirmDelete(
      context,
      recipeName: recipe.name,
    );
    if (!confirmed || !context.mounted) {
      return;
    }

    try {
      await ref.read(deleteRecipeUseCaseProvider)(recipe.id);
      ref.invalidate(recipeListProvider);
      if (!context.mounted) {
        return;
      }
      RecipeFeedback.showSuccess(context, '已删除“${recipe.name}”');
    } catch (_) {
      if (!context.mounted) {
        return;
      }
      RecipeFeedback.showError(context, '删除失败，请稍后重试');
    }
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.recipe,
    required this.onTap,
    required this.onDelete,
  });

  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(recipe.name),
        subtitle: Text(
          [
            '食材 ${recipe.ingredients.length} 项',
            '步骤 ${recipe.steps.length} 项',
          ].join(' · '),
        ),
        trailing: IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline),
          tooltip: '删除配方',
        ),
      ),
    );
  }
}
