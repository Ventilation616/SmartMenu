import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../core/exceptions/app_exception.dart';
import '../../core/utils/decimal_utils.dart';
import '../../core/utils/rounding_utils.dart';
import '../../domain/models/cooking_step.dart';
import '../../domain/models/ingredient.dart';
import '../../domain/models/recipe.dart';
import '../../domain/value_objects/ingredient_type.dart';
import '../../domain/value_objects/ingredient_unit.dart';
import '../../domain/value_objects/precision_option.dart';
import '../../domain/value_objects/rounding_mode.dart';
import 'ingredient_form_item.dart';
import 'recipe_action_bar.dart';
import 'recipe_feedback.dart';
import 'step_form_item.dart';

class RecipeEditorPage extends StatefulWidget {
  const RecipeEditorPage({
    required this.pageTitle,
    required this.primaryActionLabel,
    required this.onSubmit,
    this.initialRecipe,
    this.isEditMode = false,
    super.key,
  });

  final String pageTitle;
  final String primaryActionLabel;
  final Recipe? initialRecipe;
  final bool isEditMode;
  final Future<Recipe> Function(Recipe draft) onSubmit;

  @override
  State<RecipeEditorPage> createState() => _RecipeEditorPageState();
}

class _RecipeEditorPageState extends State<RecipeEditorPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final List<_IngredientDraft> _ingredients;
  late final List<_StepDraft> _steps;
  late final Map<_IngredientDraft, Decimal?> _lastNumericAmounts;
  bool _isApplyingAutoScaling = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final recipe = widget.initialRecipe;
    _nameController = TextEditingController(text: recipe?.name ?? '');
    _ingredients = recipe == null
        ? <_IngredientDraft>[_IngredientDraft.empty()]
        : recipe.ingredients.map(_IngredientDraft.fromIngredient).toList();
    _steps = recipe == null
        ? <_StepDraft>[_StepDraft.empty()]
        : recipe.steps.map(_StepDraft.fromStep).toList();
    _lastNumericAmounts = <_IngredientDraft, Decimal?>{
      for (final ingredient in _ingredients)
        ingredient: DecimalUtils.tryParseAmount(
          ingredient.amountController.text.trim(),
        ),
    };
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final ingredient in _ingredients) {
      ingredient.dispose();
    }
    for (final step in _steps) {
      step.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pageTitle)),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _buildBasicInfoSection(),
            const SizedBox(height: 16),
            _buildIngredientSection(context),
            const SizedBox(height: 16),
            _buildStepSection(context),
          ],
        ),
      ),
      bottomNavigationBar: RecipeActionBar(
        primaryLabel: widget.primaryActionLabel,
        isPrimaryLoading: _isSaving,
        onPrimaryPressed: _handleSubmit,
        onSecondaryPressed: _handleCancel,
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('基本信息', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: '菜名'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '菜名不能为空';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('食材', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                FilledButton.tonalIcon(
                  onPressed: _addIngredient,
                  icon: const Icon(Icons.add),
                  label: const Text('添加食材'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._ingredients.asMap().entries.map((entry) {
              final index = entry.key;
              final ingredient = entry.value;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: IngredientFormItem(
                  index: index,
                  data: ingredient,
                  onRemove: () => _removeIngredient(index),
                  onChanged: () => _handleIngredientChanged(ingredient),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStepSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('烹饪步骤', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                FilledButton.tonalIcon(
                  onPressed: _addStep,
                  icon: const Icon(Icons.add),
                  label: const Text('添加步骤'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ..._steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: StepFormItem(
                  index: index,
                  controller: step.controller,
                  onRemove: () => _removeStep(index),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _addIngredient() {
    setState(() {
      final ingredient = _IngredientDraft.empty();
      _ingredients.add(ingredient);
      _lastNumericAmounts[ingredient] = null;
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      final ingredient = _ingredients.removeAt(index);
      _lastNumericAmounts.remove(ingredient);
      ingredient.dispose();
    });
  }

  void _addStep() {
    setState(() {
      _steps.add(_StepDraft.empty());
    });
  }

  void _removeStep(int index) {
    setState(() {
      final step = _steps.removeAt(index);
      step.dispose();
    });
  }

  Future<void> _handleSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final savedRecipe = await widget.onSubmit(_buildRecipeDraft());
      if (!mounted) {
        return;
      }
      RecipeFeedback.showSuccess(
        context,
        widget.isEditMode ? '配方已保存' : '配方已创建',
      );
      context.go(
        AppRoutePath.recipeDetail.replaceFirst(':recipeId', savedRecipe.id),
      );
    } on AppException catch (error) {
      if (!mounted) {
        return;
      }
      RecipeFeedback.showError(context, error.message);
    } catch (_) {
      if (!mounted) {
        return;
      }
      RecipeFeedback.showError(context, '操作失败，请稍后重试');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _handleCancel() {
    if (widget.isEditMode && widget.initialRecipe != null) {
      context.go(
        AppRoutePath.recipeDetail.replaceFirst(
          ':recipeId',
          widget.initialRecipe!.id,
        ),
      );
      return;
    }

    context.pop();
  }

  void _handleIngredientChanged(_IngredientDraft changedIngredient) {
    setState(() {
      final amountText = changedIngredient.amountController.text.trim();
      if (DecimalUtils.isDescriptorAmount(amountText)) {
        changedIngredient.scalable = false;
      }

      final currentAmount = DecimalUtils.tryParseAmount(amountText);
      final previousAmount = _lastNumericAmounts[changedIngredient];
      _lastNumericAmounts[changedIngredient] = currentAmount;

      if (_isApplyingAutoScaling ||
          !changedIngredient.scalable ||
          currentAmount == null ||
          previousAmount == null ||
          currentAmount == previousAmount ||
          previousAmount <= Decimal.zero) {
        return;
      }

      _applyAutomaticScaling(
        target: changedIngredient,
        originalAmount: previousAmount,
        updatedAmount: currentAmount,
      );
    });
  }

  void _applyAutomaticScaling({
    required _IngredientDraft target,
    required Decimal originalAmount,
    required Decimal updatedAmount,
  }) {
    _isApplyingAutoScaling = true;
    try {
      final scale = updatedAmount / originalAmount;
      for (final ingredient in _ingredients) {
        if (identical(ingredient, target)) {
          _lastNumericAmounts[ingredient] = updatedAmount;
          continue;
        }

        final amountText = ingredient.amountController.text.trim();
        if (!ingredient.scalable ||
            DecimalUtils.isDescriptorAmount(amountText)) {
          _lastNumericAmounts[ingredient] = DecimalUtils.tryParseAmount(
            amountText,
          );
          continue;
        }

        final baseAmount = _lastNumericAmounts[ingredient];
        if (baseAmount == null) {
          continue;
        }

        final rawAmount = (baseAmount.toRational() * scale).toDecimal(
          scaleOnInfinitePrecision: _calculationScale(ingredient),
        );
        final roundedAmount = RoundingUtils.applyPrecision(
          rawAmount,
          precision: ingredient.precision,
          roundingMode: ingredient.roundingMode,
        );
        final normalizedText = DecimalUtils.formatDecimal(roundedAmount);

        ingredient.amountController.value = TextEditingValue(
          text: normalizedText,
          selection: TextSelection.collapsed(offset: normalizedText.length),
        );
        _lastNumericAmounts[ingredient] = roundedAmount;
      }
    } finally {
      _isApplyingAutoScaling = false;
    }
  }

  int _calculationScale(_IngredientDraft ingredient) {
    final precisionScale = Decimal.parse(ingredient.precision.value).scale;
    return max(precisionScale + 6, 8);
  }

  Recipe _buildRecipeDraft() {
    final now = DateTime.now();

    return Recipe(
      id: widget.initialRecipe?.id ?? '',
      name: _nameController.text.trim(),
      createdAt: widget.initialRecipe?.createdAt ?? now,
      updatedAt: widget.initialRecipe?.updatedAt ?? now,
      ingredients: _ingredients
          .map((ingredient) {
            final amountText = ingredient.amountController.text.trim();
            final amount = DecimalUtils.tryParseAmount(amountText);
            return Ingredient(
              id: ingredient.id,
              name: ingredient.nameController.text.trim(),
              amount: amount,
              amountText: amountText,
              unit: ingredient.unit,
              type: ingredient.type,
              scalable: DecimalUtils.isDescriptorAmount(amountText)
                  ? false
                  : ingredient.scalable,
              precision: ingredient.precision,
              roundingMode: ingredient.roundingMode,
              sortOrder: ingredient.sortOrder,
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
}

class _IngredientDraft extends IngredientFormData {
  _IngredientDraft({
    required this.id,
    required this.sortOrder,
    required super.nameController,
    required super.amountController,
    required super.remarkController,
    required super.unit,
    required super.type,
    required super.precision,
    required super.roundingMode,
    required super.scalable,
  });

  factory _IngredientDraft.empty() {
    return _IngredientDraft(
      id: '',
      sortOrder: 0,
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

  factory _IngredientDraft.fromIngredient(Ingredient ingredient) {
    return _IngredientDraft(
      id: ingredient.id,
      sortOrder: ingredient.sortOrder,
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

  final String id;
  final int sortOrder;

  void dispose() {
    nameController.dispose();
    amountController.dispose();
    remarkController.dispose();
  }
}

class _StepDraft {
  _StepDraft({required this.id, required this.controller});

  factory _StepDraft.empty() {
    return _StepDraft(id: '', controller: TextEditingController());
  }

  factory _StepDraft.fromStep(CookingStep step) {
    return _StepDraft(
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
