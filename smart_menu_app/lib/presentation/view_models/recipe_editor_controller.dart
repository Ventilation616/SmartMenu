import 'package:flutter/material.dart';

import '../../core/utils/decimal_utils.dart';
import '../../domain/models/cooking_step.dart';
import '../../domain/models/ingredient.dart';
import '../../domain/models/recipe.dart';
import '../../domain/value_objects/ingredient_type.dart';
import '../../domain/value_objects/ingredient_unit.dart';
import '../../domain/value_objects/precision_option.dart';
import '../../domain/value_objects/rounding_mode.dart';

@immutable
class RecipeEditorConfig {
  const RecipeEditorConfig({this.initialRecipe, this.isEditMode = false});

  final Recipe? initialRecipe;
  final bool isEditMode;

  @override
  bool operator ==(Object other) {
    return other is RecipeEditorConfig &&
        other.isEditMode == isEditMode &&
        other.initialRecipe?.id == initialRecipe?.id &&
        other.initialRecipe?.updatedAt == initialRecipe?.updatedAt;
  }

  @override
  int get hashCode =>
      Object.hash(initialRecipe?.id, initialRecipe?.updatedAt, isEditMode);
}

class IngredientEditorDraft {
  IngredientEditorDraft({
    required this.localKey,
    required this.id,
    required this.nameController,
    required this.amountController,
    required this.remarkController,
    required this.unit,
    required this.type,
    required this.precision,
    required this.roundingMode,
    required this.scalable,
  });

  factory IngredientEditorDraft.empty({required String localKey}) {
    return IngredientEditorDraft(
      localKey: localKey,
      id: '',
      nameController: TextEditingController(),
      amountController: TextEditingController(),
      remarkController: TextEditingController(),
      unit: IngredientUnit.gram,
      type: IngredientType.main,
      precision: PrecisionOption.one,
      roundingMode: IngredientRoundingMode.floor,
      scalable: true,
    );
  }

  factory IngredientEditorDraft.fromIngredient(
    Ingredient ingredient, {
    required String localKey,
  }) {
    return IngredientEditorDraft(
      localKey: localKey,
      id: ingredient.id,
      nameController: TextEditingController(text: ingredient.name),
      amountController: TextEditingController(text: ingredient.amountText),
      remarkController: TextEditingController(text: ingredient.remark),
      unit: ingredient.unit,
      type: ingredient.type,
      precision: ingredient.precision,
      roundingMode: ingredient.roundingMode,
      scalable: ingredient.scalable,
    );
  }

  final String localKey;
  final String id;
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController remarkController;
  IngredientUnit unit;
  IngredientType type;
  PrecisionOption precision;
  IngredientRoundingMode roundingMode;
  bool scalable;

  String get amountText => amountController.text.trim();

  bool get usesDescriptor => DecimalUtils.isDescriptorAmount(amountText);

  bool get supportsScaling => scalable && !usesDescriptor;

  void dispose() {
    nameController.dispose();
    amountController.dispose();
    remarkController.dispose();
  }
}

class StepEditorDraft {
  StepEditorDraft({required this.id, required this.controller});

  factory StepEditorDraft.empty() {
    return StepEditorDraft(id: '', controller: TextEditingController());
  }

  factory StepEditorDraft.fromStep(CookingStep step) {
    return StepEditorDraft(
      id: step.id,
      controller: TextEditingController(text: step.content),
    );
  }

  final String id;
  final TextEditingController controller;

  void dispose() {
    controller.dispose();
  }
}

class RecipeEditorController extends ChangeNotifier {
  RecipeEditorController({Recipe? initialRecipe, this.isEditMode = false})
    : _initialRecipe = initialRecipe,
      nameController = TextEditingController(text: initialRecipe?.name ?? '') {
    _originalIngredientsById = <String, Ingredient>{
      for (final ingredient
          in initialRecipe?.ingredients ?? const <Ingredient>[])
        ingredient.id: ingredient,
    };
    _ingredients = initialRecipe == null
        ? <IngredientEditorDraft>[
            IngredientEditorDraft.empty(localKey: _nextDraftKey()),
          ]
        : initialRecipe.ingredients
              .map(
                (ingredient) => IngredientEditorDraft.fromIngredient(
                  ingredient,
                  localKey: _nextDraftKey(),
                ),
              )
              .toList(growable: true);
    _steps = initialRecipe == null
        ? <StepEditorDraft>[StepEditorDraft.empty()]
        : initialRecipe.steps
              .map(StepEditorDraft.fromStep)
              .toList(growable: true);
    _refreshAdjustmentBasis();
  }

  final Recipe? _initialRecipe;
  final bool isEditMode;
  final TextEditingController nameController;

  late final Map<String, Ingredient> _originalIngredientsById;
  late final List<IngredientEditorDraft> _ingredients;
  late final List<StepEditorDraft> _steps;

  int _draftSeed = 0;
  String? _activeBasisLocalKey;
  bool _isSaving = false;

  List<IngredientEditorDraft> get ingredients =>
      List<IngredientEditorDraft>.unmodifiable(_ingredients);

  List<StepEditorDraft> get steps => List<StepEditorDraft>.unmodifiable(_steps);

  bool get isSaving => _isSaving;

  IngredientEditorDraft? get activeBasisIngredient {
    final localKey = _activeBasisLocalKey;
    if (localKey == null) {
      return null;
    }

    for (final ingredient in _ingredients) {
      if (ingredient.localKey == localKey) {
        return ingredient;
      }
    }

    return null;
  }

  bool get hasMultipleScaledChanges => _changedScalableIngredients.length > 1;

  String get ratioGuidanceText {
    if (!isEditMode) {
      return '新建时先记录原始配方；比例重算会在之后的编辑保存时触发。';
    }

    if (hasMultipleScaledChanges) {
      return '当前有多个可计算食材的数值被改动。保存前请保留一个调整基准。';
    }

    final basis = activeBasisIngredient;
    if (basis != null) {
      final name = basis.nameController.text.trim();
      final displayName = name.isEmpty ? '当前食材' : '「$name」';
      return '已将$displayName标记为当前调整基准，其他可计算食材会在保存时统一重算。';
    }

    return '修改一个可计算食材的用量后，它会被标记为当前调整基准；保存时再统一重算其他可计算食材。';
  }

  void addIngredient() {
    _ingredients.add(IngredientEditorDraft.empty(localKey: _nextDraftKey()));
    notifyListeners();
  }

  void removeIngredientAt(int index) {
    final ingredient = _ingredients.removeAt(index);
    ingredient.dispose();
    if (_activeBasisLocalKey == ingredient.localKey) {
      _activeBasisLocalKey = null;
    }
    _refreshAdjustmentBasis(notify: true);
  }

  void addStep() {
    _steps.add(StepEditorDraft.empty());
    notifyListeners();
  }

  void removeStepAt(int index) {
    final step = _steps.removeAt(index);
    step.dispose();
    notifyListeners();
  }

  void handleIngredientChanged(IngredientEditorDraft ingredient) {
    if (ingredient.usesDescriptor) {
      ingredient.scalable = false;
    }

    _refreshAdjustmentBasis(
      preferredLocalKey: ingredient.supportsScaling
          ? ingredient.localKey
          : null,
      notify: true,
    );
  }

  void handleIngredientMetaChanged(IngredientEditorDraft ingredient) {
    if (!ingredient.supportsScaling &&
        _activeBasisLocalKey == ingredient.localKey) {
      _activeBasisLocalKey = null;
    }
    _refreshAdjustmentBasis(notify: true);
  }

  bool isAdjustmentBasis(IngredientEditorDraft ingredient) {
    return ingredient.localKey == _activeBasisLocalKey;
  }

  bool isExistingIngredient(IngredientEditorDraft ingredient) {
    return ingredient.id.trim().isNotEmpty;
  }

  String helperTextForIngredient(IngredientEditorDraft ingredient) {
    if (!ingredient.supportsScaling) {
      return '固定食材，不参与自动重算。';
    }

    if (isAdjustmentBasis(ingredient)) {
      return '当前调整基准，保存时会按它的变动比例重算其他可计算食材。';
    }

    if (!isEditMode) {
      return '原始可计算食材，后续编辑时可作为调整基准。';
    }

    if (!isExistingIngredient(ingredient)) {
      return '新添加食材会按当前输入保存，后续编辑时可参与比例计算。';
    }

    return '可计算食材，保存时会跟随当前调整基准统一重算。';
  }

  void setSaving(bool value) {
    if (_isSaving == value) {
      return;
    }
    _isSaving = value;
    notifyListeners();
  }

  Recipe buildRecipeDraft() {
    final now = DateTime.now();

    return Recipe(
      id: _initialRecipe?.id ?? '',
      name: nameController.text.trim(),
      createdAt: _initialRecipe?.createdAt ?? now,
      updatedAt: _initialRecipe?.updatedAt ?? now,
      ingredients: _ingredients
          .asMap()
          .entries
          .map((entry) {
            final index = entry.key;
            final ingredient = entry.value;
            final amountText = ingredient.amountText;
            final amount = DecimalUtils.tryParseAmount(amountText);

            return Ingredient(
              id: ingredient.id,
              name: ingredient.nameController.text.trim(),
              amount: amount,
              amountText: amountText,
              unit: ingredient.unit,
              type: ingredient.type,
              scalable: ingredient.usesDescriptor ? false : ingredient.scalable,
              precision: ingredient.precision,
              roundingMode: ingredient.roundingMode,
              sortOrder: index,
              remark: ingredient.remarkController.text.trim(),
            );
          })
          .toList(growable: false),
      steps: _steps
          .asMap()
          .entries
          .map((entry) {
            final index = entry.key;
            final step = entry.value;
            return CookingStep(
              id: step.id,
              stepNo: index + 1,
              content: step.controller.text.trim(),
              sortOrder: index,
            );
          })
          .toList(growable: false),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    for (final ingredient in _ingredients) {
      ingredient.dispose();
    }
    for (final step in _steps) {
      step.dispose();
    }
    super.dispose();
  }

  List<IngredientEditorDraft> get _changedScalableIngredients {
    return _ingredients
        .where(_hasChangedScalableAmountFromOriginal)
        .toList(growable: false);
  }

  bool _hasChangedScalableAmountFromOriginal(IngredientEditorDraft ingredient) {
    if (!isEditMode || !ingredient.supportsScaling) {
      return false;
    }

    final originalIngredient = _originalIngredientsById[ingredient.id];
    if (originalIngredient == null) {
      return false;
    }

    final originalAmount =
        originalIngredient.amount ??
        DecimalUtils.tryParseAmount(originalIngredient.amountText);
    final editedAmount = DecimalUtils.tryParseAmount(ingredient.amountText);

    return editedAmount != null && editedAmount != originalAmount;
  }

  void _refreshAdjustmentBasis({
    String? preferredLocalKey,
    bool notify = false,
  }) {
    if (!isEditMode) {
      _activeBasisLocalKey = null;
      if (notify) {
        notifyListeners();
      }
      return;
    }

    final changedIngredients = _changedScalableIngredients;
    if (changedIngredients.isEmpty) {
      _activeBasisLocalKey = null;
    } else if (preferredLocalKey != null &&
        changedIngredients.any(
          (ingredient) => ingredient.localKey == preferredLocalKey,
        )) {
      _activeBasisLocalKey = preferredLocalKey;
    } else if (_activeBasisLocalKey != null &&
        changedIngredients.any(
          (ingredient) => ingredient.localKey == _activeBasisLocalKey,
        )) {
      // Keep the current basis if it still qualifies.
    } else {
      _activeBasisLocalKey = changedIngredients.last.localKey;
    }

    if (notify) {
      notifyListeners();
    }
  }

  String _nextDraftKey() {
    _draftSeed += 1;
    return 'ingredient-draft-$_draftSeed';
  }
}
