import 'package:go_router/go_router.dart';

import '../presentation/pages/recipe_create_page.dart';
import '../presentation/pages/recipe_detail_page.dart';
import '../presentation/pages/recipe_edit_page.dart';
import '../presentation/pages/recipe_list_page.dart';

class AppRoutePath {
  const AppRoutePath._();

  static const recipeList = '/';
  static const recipeCreate = '/recipes/create';
  static const recipeDetail = '/recipes/:recipeId';
  static const recipeEdit = '/recipes/:recipeId/edit';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutePath.recipeList,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutePath.recipeList,
      builder: (context, state) => const RecipeListPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'recipes/create',
          builder: (context, state) => const RecipeCreatePage(),
        ),
        GoRoute(
          path: 'recipes/:recipeId',
          builder: (context, state) {
            final recipeId = state.pathParameters['recipeId'] ?? '';
            return RecipeDetailPage(recipeId: recipeId);
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'edit',
              builder: (context, state) {
                final recipeId = state.pathParameters['recipeId'] ?? '';
                return RecipeEditPage(recipeId: recipeId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
