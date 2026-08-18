import 'package:decimal/decimal.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_menu_app/data/datasources/local/database.dart';
import 'package:smart_menu_app/data/repositories/recipe_repository_impl.dart';
import 'package:smart_menu_app/domain/models/cooking_step.dart';
import 'package:smart_menu_app/domain/models/ingredient.dart';
import 'package:smart_menu_app/domain/models/recipe.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_type.dart';
import 'package:smart_menu_app/domain/value_objects/ingredient_unit.dart';
import 'package:smart_menu_app/domain/value_objects/precision_option.dart';
import 'package:smart_menu_app/domain/value_objects/rounding_mode.dart';

void main() {
  late AppDatabase database;
  late RecipeRepositoryImpl repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = RecipeRepositoryImpl(
      database: database,
      recipeDao: database.recipeDao,
      ingredientDao: database.ingredientDao,
      cookingStepDao: database.cookingStepDao,
    );
  });

  tearDown(() async {
    await database.close();
  });

  group('RecipeRepositoryImpl', () {
    test('保存后可查询完整配方详情', () async {
      final recipe = _buildRecipe();

      await repository.saveRecipe(recipe);
      final savedRecipe = await repository.getRecipeById(recipe.id);

      expect(savedRecipe, isNotNull);
      expect(savedRecipe!.name, recipe.name);
      expect(savedRecipe.ingredients.length, 3);
      expect(savedRecipe.ingredients[0].amountText, '500');
      expect(savedRecipe.ingredients[1].amountText, '少许');
      expect(savedRecipe.ingredients[1].amount, isNull);
      expect(savedRecipe.steps.map((step) => step.content), <String>[
        '鸡腿焯水',
        '小火炖煮',
      ]);
    });

    test('更新配方时替换关联食材和步骤，并支持搜索', () async {
      final recipe = _buildRecipe();
      await repository.saveRecipe(recipe);

      final updatedRecipe = recipe.copyWith(
        name: '香辣鸡腿煲',
        updatedAt: DateTime(2026, 8, 18, 12),
        ingredients: <Ingredient>[
          recipe.ingredients[0].copyWith(
            amount: Decimal.parse('800'),
            amountText: '800',
          ),
          _buildIngredient(
            id: 'ingredient-4',
            name: '土豆',
            amount: Decimal.parse('450'),
            amountText: '450',
            sortOrder: 1,
          ),
        ],
        steps: const <CookingStep>[
          CookingStep(
            id: 'step-3',
            stepNo: 1,
            content: '加入土豆继续焖煮',
            sortOrder: 0,
          ),
        ],
      );

      await repository.saveRecipe(updatedRecipe);

      final searchResult = await repository.searchRecipes('鸡腿煲');
      final savedRecipe = await repository.getRecipeById(recipe.id);

      expect(searchResult.map((item) => item.name), <String>['香辣鸡腿煲']);
      expect(savedRecipe, isNotNull);
      expect(savedRecipe!.ingredients.map((item) => item.name), <String>[
        '鸡腿',
        '土豆',
      ]);
      expect(savedRecipe.steps.single.content, '加入土豆继续焖煮');
      expect(
        await database.ingredientDao.getIngredientsByRecipeId(recipe.id),
        hasLength(2),
      );
      expect(
        await database.cookingStepDao.getCookingStepsByRecipeId(recipe.id),
        hasLength(1),
      );
    });

    test('删除配方时级联删除食材和步骤', () async {
      final recipe = _buildRecipe();
      await repository.saveRecipe(recipe);

      await repository.deleteRecipe(recipe.id);

      expect(await repository.getRecipeById(recipe.id), isNull);
      expect(
        await database.ingredientDao.getIngredientsByRecipeId(recipe.id),
        isEmpty,
      );
      expect(
        await database.cookingStepDao.getCookingStepsByRecipeId(recipe.id),
        isEmpty,
      );
    });
  });
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
        sortOrder: 0,
      ),
      _buildIngredient(
        id: 'ingredient-2',
        name: '香菜',
        amountText: '少许',
        scalable: false,
        sortOrder: 1,
      ),
      _buildIngredient(
        id: 'ingredient-3',
        name: '生抽',
        amount: Decimal.parse('30'),
        amountText: '30',
        unit: IngredientUnit.milliliter,
        precision: PrecisionOption.half,
        sortOrder: 2,
      ),
    ],
    steps: const <CookingStep>[
      CookingStep(id: 'step-1', stepNo: 1, content: '鸡腿焯水', sortOrder: 0),
      CookingStep(id: 'step-2', stepNo: 2, content: '小火炖煮', sortOrder: 1),
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
  int sortOrder = 0,
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
    roundingMode: IngredientRoundingMode.floor,
    sortOrder: sortOrder,
    remark: '',
  );
}
