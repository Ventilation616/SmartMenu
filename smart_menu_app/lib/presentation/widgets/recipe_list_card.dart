import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../domain/models/recipe.dart';

class RecipeListCard extends StatelessWidget {
  const RecipeListCard({
    required this.recipe,
    required this.onTap,
    this.onDelete,
    super.key,
  });

  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = _buildSummary(recipe);

    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(28),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.pressed)) {
            return theme.colorScheme.secondary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return theme.colorScheme.primary.withValues(alpha: 0.08);
          }
          return null;
        }),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 104),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 12, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        recipe.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        summary,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.66,
                          ),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onDelete != null) ...<Widget>[
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: onDelete,
                    tooltip: '删除配方',
                    icon: const Icon(Icons.delete_outline_rounded),
                    style: ButtonStyle(
                      minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return theme.colorScheme.onSurface.withValues(
                            alpha: 0.28,
                          );
                        }
                        if (states.contains(WidgetState.pressed)) {
                          return theme.colorScheme.onSurface.withValues(
                            alpha: 0.72,
                          );
                        }
                        return theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        );
                      }),
                      overlayColor: WidgetStateProperty.resolveWith<Color?>((
                        states,
                      ) {
                        if (states.contains(WidgetState.pressed)) {
                          return theme.colorScheme.onSurface.withValues(
                            alpha: 0.08,
                          );
                        }
                        if (states.contains(WidgetState.focused)) {
                          return theme.colorScheme.primary.withValues(
                            alpha: 0.08,
                          );
                        }
                        return null;
                      }),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _buildSummary(Recipe recipe) {
    if (recipe.ingredients.isEmpty && recipe.steps.isEmpty) {
      return '还没有填写内容';
    }

    return <String>[
      '食材 ${recipe.ingredients.length} 项',
      '步骤 ${recipe.steps.length} 项',
    ].join(' · ');
  }
}
