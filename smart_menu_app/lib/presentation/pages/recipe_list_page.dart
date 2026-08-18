import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/constants/app_strings.dart';
import '../widgets/empty_state_view.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.recipeListTitle)),
      body: const EmptyStateView(
        title: '还没有配方',
        description: 'M1 已完成工程骨架，M2 开始接入数据库与业务逻辑。',
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutePath.recipeCreate),
        label: const Text('新建'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
