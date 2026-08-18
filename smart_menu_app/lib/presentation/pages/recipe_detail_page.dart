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
                child: Text(
                  '食材 ${recipe.ingredients.length} 项 · 步骤 ${recipe.steps.length} 项',
                ),
              ),
              const SizedBox(height: 16),
              _DetailSection(
                title: '食材清单',
                child: recipe.ingredients.isEmpty
                    ? const Text('暂未添加食材')
                    : Column(
                        children: recipe.ingredients
                            .map(
                              (ingredient) =>
                                  _IngredientTile(ingredient: ingredient),
                            )
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
  const _DetailSection({required this.title, required this.child});

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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x14000000))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  ingredient.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text(
                '${ingredient.amountText}${ingredient.unit.label}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _IngredientMetaChip(value: ingredient.type.label),
            ],
          ),
        ],
      ),
    );
  }
}

class _IngredientMetaChip extends StatelessWidget {
  const _IngredientMetaChip({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(value),
      ),
    );
  }
}
