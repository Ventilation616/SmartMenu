import 'package:flutter/material.dart';

class RecipeActionBar extends StatelessWidget {
  const RecipeActionBar({
    required this.primaryLabel,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    this.secondaryLabel = '取消',
    this.isPrimaryLoading = false,
    super.key,
  });

  final String primaryLabel;
  final String secondaryLabel;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool isPrimaryLoading;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: OutlinedButton(
              onPressed: isPrimaryLoading ? null : onSecondaryPressed,
              child: Text(secondaryLabel),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: isPrimaryLoading ? null : onPrimaryPressed,
              child: isPrimaryLoading
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(primaryLabel),
            ),
          ),
        ],
      ),
    );
  }
}
