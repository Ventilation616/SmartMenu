import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_menu_app/core/exceptions/app_exception.dart';
import 'package:smart_menu_app/core/validators/validators.dart';
import 'package:smart_menu_app/domain/models/cooking_step.dart';
import 'package:smart_menu_app/domain/models/ingredient.dart';
import 'package:smart_menu_app/domain/models/recipe.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_type.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_unit.dart';
import 'package:smart_menu_app/domain/value_objects/precision_option.dart';
import 'package:smart_menu_app/domain/value_objects/rounding_mode.dart';

void main() {
  group('Validators.validateRecipeForSave', () {
    test('菜名为空时报错', () {
      final recipe = _buildRecipe(name: '   ');

      expect(
        () => Validators.validateRecipeForSave(recipe),
        throwsA(
          isA<ValidationException>().having(
            (error) => error.message,
            'message',
            '菜名不能为空',
          ),
        ),
      );
    });

    test('可计算食材使用非法文本用量时报错', () {
      final recipe = _buildRecipe(
        ingredients: <Ingredient>[
          _buildIngredient(name: '盐', amountText: '适量', scalable: true),
        ],
      );

      expect(
        () => Validators.validateRecipeForSave(recipe),
        throwsA(
          isA<ValidationException>().having(
            (error) => error.message,
            'message',
            '第1个食材用量必须是合法非负数字',
          ),
        ),
      );
    });
  });

  group('Validators.findScaleTarget', () {
    test('原始基准用量小于等于 0 时报错', () {
      final originalRecipe = _buildRecipe(
        ingredients: <Ingredient>[
          _buildIngredient(
            id: 'ingredient-1',
            name: '鸡腿',
            amount: Decimal.zero,
            amountText: '0',
          ),
        ],
      );
      final editedRecipe = originalRecipe.copyWith(
        ingredients: <Ingredient>[
          originalRecipe.ingredients.single.copyWith(
            amount: Decimal.parse('100'),
            amountText: '100',
          ),
        ],
      );

      expect(
        () => Validators.findScaleTarget(
          originalRecipe: originalRecipe,
          editedRecipe: editedRecipe,
        ),
        throwsA(
          isA<ValidationException>().having(
            (error) => error.message,
            'message',
            '调整基准食材的原始用量必须大于 0',
          ),
        ),
      );
    });
  });
}

Recipe _buildRecipe({
  String name = '红烧鸡腿',
  List<Ingredient> ingredients = const <Ingredient>[],
}) {
  return Recipe(
    id: 'recipe-1',
    name: name,
    createdAt: DateTime(2026, 8, 18, 10),
    updatedAt: DateTime(2026, 8, 18, 10),
    ingredients: ingredients,
    steps: const <CookingStep>[
      CookingStep(id: 'step-1', stepNo: 1, content: '开火炖煮'),
    ],
  );
}

Ingredient _buildIngredient({
  String id = 'ingredient-1',
  required String name,
  Decimal? amount,
  required String amountText,
  bool scalable = true,
}) {
  return Ingredient(
    id: id,
    name: name,
    amount: amount,
    amountText: amountText,
    unit: IngredientUnit.gram,
    type: IngredientType.main,
    scalable: scalable,
    precision: PrecisionOption.one,
    roundingMode: IngredientRoundingMode.floor,
  );
}
