import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_menu_app/core/exceptions/app_exception.dart';
import 'package:smart_menu_app/domain/models/cooking_step.dart';
import 'package:smart_menu_app/domain/models/ingredient.dart';
import 'package:smart_menu_app/domain/models/recipe.dart';
import 'package:smart_menu_app/domain/repositories/recipe_repository.dart';
import 'package:smart_menu_app/domain/use_cases/create_recipe_use_case.dart';
import 'package:smart_menu_app/domain/use_cases/update_recipe_use_case.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_type.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_unit.dart';
import 'package:smart_menu_app/domain/value_objects/precision_option.dart';
import 'package:smart_menu_app/domain/value_objects/rounding_mode.dart';

void main() {
  group('CreateRecipeUseCase', () {
    test('新建时保留原始数据并自动处理描述性用量为不可计算', () async {
      final repository = InMemoryRecipeRepository();
      final useCase = CreateRecipeUseCase(
        repository,
        now: () => DateTime(2026, 8, 18, 12),
      );

      final recipe = _buildRecipe(
        id: '',
        ingredients: <Ingredient>[
          _buildIngredient(id: '', name: '盐', amountText: '适量', scalable: true),
        ],
      );

      final savedRecipe = await useCase(recipe);

      expect(savedRecipe.id, isNotEmpty);
      expect(savedRecipe.ingredients.single.scalable, isFalse);
      expect(savedRecipe.ingredients.single.amount, isNull);
      expect(savedRecipe.ingredients.single.amountText, '适量');
      expect(repository.savedRecipe, equals(savedRecipe));
    });
  });

  group('UpdateRecipeUseCase', () {
    test('保存时按调整基准重算其他可计算食材', () async {
      final repository = InMemoryRecipeRepository();
      final useCase = UpdateRecipeUseCase(
        repository,
        now: () => DateTime(2026, 8, 18, 13),
      );

      final originalRecipe = _buildRecipe(
        id: 'recipe-1',
        ingredients: <Ingredient>[
          _buildIngredient(
            id: 'i-1',
            name: '鸡腿',
            amount: Decimal.parse('500'),
            amountText: '500',
            precision: PrecisionOption.one,
            roundingMode: IngredientRoundingMode.floor,
          ),
          _buildIngredient(
            id: 'i-2',
            name: '土豆',
            amount: Decimal.parse('300'),
            amountText: '300',
            precision: PrecisionOption.one,
            roundingMode: IngredientRoundingMode.floor,
          ),
          _buildIngredient(
            id: 'i-3',
            name: '盐',
            amount: Decimal.parse('5'),
            amountText: '5',
            precision: PrecisionOption.tenth,
            roundingMode: IngredientRoundingMode.ceil,
          ),
          _buildIngredient(
            id: 'i-4',
            name: '生抽',
            amount: Decimal.parse('30'),
            amountText: '30',
            unit: IngredientUnit.milliliter,
            precision: PrecisionOption.half,
            roundingMode: IngredientRoundingMode.floor,
          ),
          _buildIngredient(
            id: 'i-5',
            name: '香菜',
            amountText: '少许',
            scalable: false,
          ),
        ],
      );

      final editedRecipe = originalRecipe.copyWith(
        name: '红烧鸡腿升级版',
        ingredients: <Ingredient>[
          originalRecipe.ingredients[0].copyWith(
            amount: Decimal.parse('777'),
            amountText: '777',
          ),
          originalRecipe.ingredients[1],
          originalRecipe.ingredients[2],
          originalRecipe.ingredients[3],
          originalRecipe.ingredients[4],
        ],
      );

      final savedRecipe = await useCase(
        UpdateRecipeCommand(
          originalRecipe: originalRecipe,
          editedRecipe: editedRecipe,
        ),
      );

      expect(savedRecipe.name, '红烧鸡腿升级版');
      expect(savedRecipe.ingredients[0].amountText, '777');
      expect(savedRecipe.ingredients[1].amountText, '466');
      expect(savedRecipe.ingredients[2].amountText, '7.8');
      expect(savedRecipe.ingredients[3].amountText, '46.5');
      expect(savedRecipe.ingredients[4].amountText, '少许');
      expect(repository.savedRecipe, equals(savedRecipe));
    });

    test('界面已联动更新多个可计算食材时仍能识别调整基准', () async {
      final repository = InMemoryRecipeRepository();
      final useCase = UpdateRecipeUseCase(
        repository,
        now: () => DateTime(2026, 8, 18, 13),
      );

      final originalRecipe = _buildRecipe(
        id: 'recipe-3',
        ingredients: <Ingredient>[
          _buildIngredient(
            id: 'i-1',
            name: '鸡腿',
            amount: Decimal.parse('500'),
            amountText: '500',
            precision: PrecisionOption.one,
          ),
          _buildIngredient(
            id: 'i-2',
            name: '土豆',
            amount: Decimal.parse('300'),
            amountText: '300',
            precision: PrecisionOption.one,
          ),
          _buildIngredient(
            id: 'i-3',
            name: '盐',
            amount: Decimal.parse('5'),
            amountText: '5',
            precision: PrecisionOption.tenth,
            roundingMode: IngredientRoundingMode.ceil,
          ),
          _buildIngredient(
            id: 'i-4',
            name: '生抽',
            amount: Decimal.parse('30'),
            amountText: '30',
            unit: IngredientUnit.milliliter,
            precision: PrecisionOption.half,
          ),
        ],
      );

      final editedRecipe = originalRecipe.copyWith(
        ingredients: <Ingredient>[
          originalRecipe.ingredients[0].copyWith(
            amount: Decimal.parse('777'),
            amountText: '777',
          ),
          originalRecipe.ingredients[1].copyWith(
            amount: Decimal.parse('466'),
            amountText: '466',
          ),
          originalRecipe.ingredients[2].copyWith(
            amount: Decimal.parse('7.8'),
            amountText: '7.8',
          ),
          originalRecipe.ingredients[3].copyWith(
            amount: Decimal.parse('46.5'),
            amountText: '46.5',
          ),
        ],
      );

      final savedRecipe = await useCase(
        UpdateRecipeCommand(
          originalRecipe: originalRecipe,
          editedRecipe: editedRecipe,
        ),
      );

      expect(savedRecipe.ingredients[0].amountText, '777');
      expect(savedRecipe.ingredients[1].amountText, '466');
      expect(savedRecipe.ingredients[2].amountText, '7.8');
      expect(savedRecipe.ingredients[3].amountText, '46.5');
    });

    test('同时手动修改多个可计算食材时报错', () async {
      final repository = InMemoryRecipeRepository();
      final useCase = UpdateRecipeUseCase(repository);
      final originalRecipe = _buildRecipe(
        id: 'recipe-2',
        ingredients: <Ingredient>[
          _buildIngredient(
            id: 'i-1',
            name: '鸡腿',
            amount: Decimal.parse('500'),
            amountText: '500',
          ),
          _buildIngredient(
            id: 'i-2',
            name: '土豆',
            amount: Decimal.parse('300'),
            amountText: '300',
          ),
        ],
      );

      final editedRecipe = originalRecipe.copyWith(
        ingredients: <Ingredient>[
          originalRecipe.ingredients[0].copyWith(
            amount: Decimal.parse('800'),
            amountText: '800',
          ),
          originalRecipe.ingredients[1].copyWith(
            amount: Decimal.parse('500'),
            amountText: '500',
          ),
        ],
      );

      expect(
        () => useCase(
          UpdateRecipeCommand(
            originalRecipe: originalRecipe,
            editedRecipe: editedRecipe,
          ),
        ),
        throwsA(
          isA<ValidationException>().having(
            (error) => error.message,
            'message',
            '同一时间只能有一个参与比例计算的食材作为调整基准',
          ),
        ),
      );
    });
  });
}

class InMemoryRecipeRepository implements RecipeRepository {
  Recipe? savedRecipe;

  @override
  Future<void> deleteRecipe(String id) async {}

  @override
  Future<Recipe?> getRecipeById(String id) async => null;

  @override
  Future<List<Recipe>> getRecipes() async => <Recipe>[];

  @override
  Future<void> saveRecipe(Recipe recipe) async {
    savedRecipe = recipe;
  }

  @override
  Future<List<Recipe>> searchRecipes(String keyword) async => <Recipe>[];
}

Recipe _buildRecipe({
  required String id,
  List<Ingredient> ingredients = const <Ingredient>[],
}) {
  return Recipe(
    id: id,
    name: '红烧鸡腿',
    createdAt: DateTime(2026, 8, 18, 10),
    updatedAt: DateTime(2026, 8, 18, 10),
    ingredients: ingredients,
    steps: const <CookingStep>[
      CookingStep(id: 'step-1', stepNo: 1, content: '下锅炖煮'),
    ],
  );
}

Ingredient _buildIngredient({
  required String id,
  required String name,
  Decimal? amount,
  String amountText = '',
  IngredientUnit unit = IngredientUnit.gram,
  bool scalable = true,
  PrecisionOption precision = PrecisionOption.one,
  IngredientRoundingMode roundingMode = IngredientRoundingMode.floor,
}) {
  return Ingredient(
    id: id,
    name: name,
    amount: amount,
    amountText: amountText,
    unit: unit,
    type: IngredientType.main,
    scalable: scalable,
    precision: precision,
    roundingMode: roundingMode,
    remark: '',
  );
}
