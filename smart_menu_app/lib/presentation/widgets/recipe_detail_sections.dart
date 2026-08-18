import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../domain/models/cooking_step.dart';
import '../../domain/models/ingredient.dart';

class RecipeIngredientsSection extends StatelessWidget {
  const RecipeIngredientsSection({required this.ingredients, super.key});

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    if (ingredients.isEmpty) {
      return const _RecipeSection(
        title: '食材',
        child: _SectionEmptyState(message: '暂未添加食材'),
      );
    }

    return _RecipeSection(
      title: '食材',
      child: Column(
        children: List<Widget>.generate(ingredients.length, (index) {
          final ingredient = ingredients[index];
          return _IngredientRow(
            ingredient: ingredient,
            showDivider: index != ingredients.length - 1,
          );
        }),
      ),
    );
  }
}

class RecipeCookingStepsSection extends StatelessWidget {
  const RecipeCookingStepsSection({required this.steps, super.key});

  final List<CookingStep> steps;

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) {
      return const _RecipeSection(
        title: '步骤',
        child: _SectionEmptyState(message: '暂未添加步骤'),
      );
    }

    return _RecipeSection(
      title: '步骤',
      child: Column(
        children: List<Widget>.generate(steps.length, (index) {
          final step = steps[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == steps.length - 1 ? 0 : 16,
            ),
            child: _CookingStepRow(step: step),
          );
        }),
      ),
    );
  }
}

class _RecipeSection extends StatelessWidget {
  const _RecipeSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.line),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 18),
            child,
          ],
        ),
      ),
    );
  }
}

class _IngredientRow extends StatelessWidget {
  const _IngredientRow({required this.ingredient, required this.showDivider});

  final Ingredient ingredient;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.line))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ingredient.name,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _MetaPill(label: ingredient.type.label),
                    _MetaPill(
                      label: ingredient.scalable ? '可换算' : '固定',
                      highlight: !ingredient.scalable,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                ingredient.amountText.isEmpty ? '-' : ingredient.amountText,
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                ingredient.unit.label,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.moss,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CookingStepRow extends StatelessWidget {
  const _CookingStepRow({required this.step});

  final CookingStep step;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.line),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0x1FB39355),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                '${step.stepNo}',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const <FontFeature>[
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                step.content,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.ink,
                  height: 1.75,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({required this.label, this.highlight = false});

  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: highlight ? AppColors.basis : AppColors.stable,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: highlight ? AppColors.accent : AppColors.moss,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SectionEmptyState extends StatelessWidget {
  const _SectionEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyMedium
          ?.copyWith(color: AppColors.muted, height: 1.6),
    );
  }
}
