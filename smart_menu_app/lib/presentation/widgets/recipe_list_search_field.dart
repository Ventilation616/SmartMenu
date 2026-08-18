import 'package:flutter/material.dart';

class RecipeListSearchField extends StatelessWidget {
  const RecipeListSearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.hasKeyword,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final bool hasKeyword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: '搜索配方',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: hasKeyword
            ? IconButton(
                onPressed: onClear,
                tooltip: '清空搜索',
                icon: const Icon(Icons.close_rounded),
              )
            : null,
      ),
    );
  }
}
