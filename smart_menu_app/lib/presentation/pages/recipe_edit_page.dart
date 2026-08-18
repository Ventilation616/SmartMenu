import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

class RecipeEditPage extends StatelessWidget {
  const RecipeEditPage({
    required this.recipeId,
    super.key,
  });

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.recipeEditTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('当前编辑配方: $recipeId'),
            const SizedBox(height: 16),
            const Text('编辑页骨架已完成，T16 开始接入编辑副本与基准食材交互。'),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('取消'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: () {},
                child: const Text('保存'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
