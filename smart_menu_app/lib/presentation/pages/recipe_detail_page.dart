import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/models/ingredient.dart';
import '../providers/recipe_providers.dart';
import '../widgets/empty_state_view.dart';

class RecipeDetailPage extends ConsumerWidget {
  const RecipeDetailPage({required this.recipeId, super.key});

  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(recipeDetailProvider(recipeId));

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.recipeDetailTitle)),
      body: recipeAsync.when(
        data: (recipe) {
          if (recipe == null) {
            return const EmptyStateView(
              title: '配方不存在',
              description: '该配方可能已被删除，请返回列表重新选择。',
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              _DetailSection(
                title: recipe.name,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (recipe.category.isNotEmpty) Text('分类：${recipe.category}'),
                    if (recipe.description.isNotEmpty) ...<Widget>[
                      const SizedBox(height: 8),
                      Text(recipe.description),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _DetailSection(
                title: '食材清单',
                child: recipe.ingredients.isEmpty
                    ? const Text('暂未添加食材')
                    : Column(
                        children: recipe.ingredients
                            .map((ingredient) => _IngredientTile(ingredient: ingredient))
                            .toList(growable: false),
                      ),
              ),
              const SizedBox(height: 16),
              _DetailSection(
                title: '烹饪步骤',
                child: recipe.steps.isEmpty
                    ? const Text('暂未添加步骤')
                    : Column(
                        children: recipe.steps
                            .map(
                              (step) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 14,
                                  child: Text('${step.stepNo}'),
                                ),
                                title: Text(step.content),
                              ),
                            )
                            .toList(growable: false),
                      ),
              ),
            ],
          );
        },
        error: (error, stackTrace) => const EmptyStateView(
          title: '加载失败',
          description: '详情页暂时无法展示，请稍后重试。',
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          AppRoutePath.recipeEdit.replaceFirst(':recipeId', recipeId),
        ),
        icon: const Icon(Icons.edit_outlined),
        label: const Text('编辑'),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _IngredientTile extends StatelessWidget {
  const _IngredientTile({required this.ingredient});

  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final detailParts = <String>[
      ingredient.type.label,
      if (ingredient.scalable)
        '参与计算'
      else
        '不参与计算',
      '精度 ${ingredient.precision.value}',
      ingredient.roundingMode.label,
    ];

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(ingredient.name),
      subtitle: Text(detailParts.join(' · ')),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('${ingredient.amountText} ${ingredient.unit.label}'),
          if (ingredient.remark.isNotEmpty)
            Text(
              ingredient.remark,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
