import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/constants/app_strings.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({required this.recipeId, super.key});

  final String recipeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.recipeDetailTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('配方 ID: $recipeId'),
            const SizedBox(height: 16),
            const Text('详情页骨架已就位，T14 开始接入配方详情数据。'),
          ],
        ),
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
