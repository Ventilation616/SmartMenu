import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_menu_app/domain/models/cooking_step.dart';
import 'package:smart_menu_app/domain/models/ingredient.dart';
import 'package:smart_menu_app/domain/models/recipe.dart';
import 'package:smart_menu_app/domain/repositories/recipe_repository.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_type.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_unit.dart';
import 'package:smart_menu_app/domain/value_objects/precision_option.dart';
import 'package:smart_menu_app/domain/value_objects/rounding_mode.dart';
import 'package:smart_menu_app/presentation/pages/recipe_detail_page.dart';
import 'package:smart_menu_app/presentation/providers/recipe_providers.dart';
import 'package:smart_menu_app/presentation/widgets/recipe_editor_page.dart';

void main() {
  group('RecipeDetailPage', () {
    testWidgets('食材详情仅展示名字 类型 用量和单位', (tester) async {
      final recipe = _buildRecipe();

      await tester.pumpWidget(
        ProviderScope(
          overrides: <Override>[
            recipeRepositoryProvider.overrideWithValue(
              _FakeRecipeRepository(recipe: recipe),
            ),
          ],
          child: const MaterialApp(
            home: RecipeDetailPage(recipeId: 'recipe-1'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('鸡腿'), findsOneWidget);
      expect(find.text('500g'), findsOneWidget);
      expect(find.text('主料'), findsOneWidget);
      expect(find.textContaining('类型：'), findsNothing);
      expect(find.textContaining('单位：'), findsNothing);
      expect(find.textContaining('参与计算'), findsNothing);
      expect(find.textContaining('精度'), findsNothing);
      expect(find.text('向下'), findsNothing);
      expect(find.text('口感更软烂'), findsNothing);
    });
  });

  group('RecipeEditorPage', () {
    testWidgets('移除调整基准控件后仍会自动联动重算食材用量', (tester) async {
      final recipe = _buildRecipe();

      await tester.pumpWidget(
        MaterialApp(
          home: RecipeEditorPage(
            pageTitle: '编辑配方',
            primaryActionLabel: '保存',
            isEditMode: true,
            initialRecipe: recipe,
            onSubmit: (draft) async => draft,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('设为调整基准'), findsNothing);
      expect(find.textContaining('当前未显式选择调整基准'), findsNothing);
      expect(find.text('例如：500 / 适量'), findsNothing);

      await tester.enterText(
        find.byKey(const ValueKey<String>('ingredient_amount_0')),
        '800',
      );
      await tester.pumpAndSettle();

      final potatoField = tester.widget<TextFormField>(
        find.byKey(const ValueKey<String>('ingredient_amount_1')),
      );
      expect(potatoField.controller?.text, '480');
    });
  });
}

class _FakeRecipeRepository implements RecipeRepository {
  _FakeRecipeRepository({required this.recipe});

  final Recipe recipe;

  @override
  Future<void> deleteRecipe(String id) async {}

  @override
  Future<Recipe?> getRecipeById(String id) async {
    if (id == recipe.id) {
      return recipe;
    }
    return null;
  }

  @override
  Future<List<Recipe>> getRecipes() async => <Recipe>[recipe];

  @override
  Future<void> saveRecipe(Recipe recipe) async {}

  @override
  Future<List<Recipe>> searchRecipes(String keyword) async => <Recipe>[recipe];
}

Recipe _buildRecipe() {
  return Recipe(
    id: 'recipe-1',
    name: '红烧鸡腿',
    createdAt: DateTime(2026, 8, 18, 10),
    updatedAt: DateTime(2026, 8, 18, 10),
    ingredients: <Ingredient>[
      _buildIngredient(
        id: 'ingredient-1',
        name: '鸡腿',
        amount: Decimal.parse('500'),
        amountText: '500',
      ),
      _buildIngredient(
        id: 'ingredient-2',
        name: '土豆',
        amount: Decimal.parse('300'),
        amountText: '300',
        precision: PrecisionOption.one,
      ),
      _buildIngredient(
        id: 'ingredient-3',
        name: '生抽',
        amount: Decimal.parse('30'),
        amountText: '30',
        unit: IngredientUnit.milliliter,
        type: IngredientType.seasoning,
        precision: PrecisionOption.half,
      ),
    ],
    steps: const <CookingStep>[
      CookingStep(id: 'step-1', stepNo: 1, content: '焯水', sortOrder: 0),
    ],
  );
}

Ingredient _buildIngredient({
  required String id,
  required String name,
  Decimal? amount,
  String amountText = '',
  IngredientUnit unit = IngredientUnit.gram,
  IngredientType type = IngredientType.main,
  bool scalable = true,
  PrecisionOption precision = PrecisionOption.one,
}) {
  return Ingredient(
    id: id,
    name: name,
    amount: amount,
    amountText: amountText,
    unit: unit,
    type: type,
    scalable: scalable,
    precision: precision,
    roundingMode: IngredientRoundingMode.floor,
    remark: '口感更软烂',
  );
}
