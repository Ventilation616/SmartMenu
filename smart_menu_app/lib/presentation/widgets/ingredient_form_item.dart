import 'package:flutter/material.dart';

import '../../core/utils/decimal_utils.dart';
import '../../domain/value_objects/ingredient_type.dart';
import '../../domain/value_objects/ingredient_unit.dart';
import '../../domain/value_objects/precision_option.dart';
import '../../domain/value_objects/rounding_mode.dart';

class IngredientFormData {
  IngredientFormData({
    required this.nameController,
    required this.amountController,
    required this.remarkController,
    this.unit = IngredientUnit.gram,
    this.type = IngredientType.main,
    this.precision = PrecisionOption.one,
    this.roundingMode = IngredientRoundingMode.floor,
    this.scalable = true,
    this.isScaleTarget = false,
  });

  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController remarkController;
  IngredientUnit unit;
  IngredientType type;
  PrecisionOption precision;
  IngredientRoundingMode roundingMode;
  bool scalable;
  bool isScaleTarget;
}

class IngredientFormItem extends StatelessWidget {
  const IngredientFormItem({
    required this.index,
    required this.data,
    required this.isEditMode,
    required this.isAmountEditable,
    required this.onRemove,
    required this.onChanged,
    required this.onScaleTargetChanged,
    super.key,
  });

  final int index;
  final IngredientFormData data;
  final bool isEditMode;
  final bool isAmountEditable;
  final VoidCallback onRemove;
  final VoidCallback onChanged;
  final ValueChanged<bool?> onScaleTargetChanged;

  @override
  Widget build(BuildContext context) {
    final amountText = data.amountController.text.trim();
    final usesDescriptor = DecimalUtils.isDescriptorAmount(amountText);
    final canUseScaleTarget =
        isEditMode && data.scalable && DecimalUtils.tryParseAmount(amountText) != null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '食材 ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  tooltip: '删除食材',
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: data.nameController,
              decoration: const InputDecoration(labelText: '食材名称'),
              onChanged: (_) => onChanged(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '食材名称不能为空';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: data.amountController,
                    readOnly: !isAmountEditable,
                    decoration: const InputDecoration(
                      labelText: '用量',
                      hintText: '例如：500 / 适量',
                    ),
                    onChanged: (_) => onChanged(),
                    validator: (value) {
                      final normalized = value?.trim() ?? '';
                      if (normalized.isEmpty) {
                        return '用量不能为空';
                      }
                      if (DecimalUtils.isDescriptorAmount(normalized)) {
                        return null;
                      }
                      if (!DecimalUtils.isNonNegativeNumeric(normalized)) {
                        return '请输入合法非负数字';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<IngredientUnit>(
                    initialValue: data.unit,
                    decoration: const InputDecoration(labelText: '单位'),
                    items: IngredientUnit.values
                        .map(
                          (unit) => DropdownMenuItem<IngredientUnit>(
                            value: unit,
                            child: Text(unit.label),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      data.unit = value;
                      onChanged();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<IngredientType>(
                    initialValue: data.type,
                    decoration: const InputDecoration(labelText: '类型'),
                    items: IngredientType.values
                        .map(
                          (type) => DropdownMenuItem<IngredientType>(
                            value: type,
                            child: Text(type.label),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      data.type = value;
                      onChanged();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<PrecisionOption>(
                    initialValue: data.precision,
                    decoration: const InputDecoration(labelText: '精度'),
                    items: PrecisionOption.values
                        .map(
                          (precision) => DropdownMenuItem<PrecisionOption>(
                            value: precision,
                            child: Text(precision.value),
                          ),
                        )
                        .toList(growable: false),
                    onChanged: usesDescriptor
                        ? null
                        : (value) {
                            if (value == null) {
                              return;
                            }
                            data.precision = value;
                            onChanged();
                          },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<IngredientRoundingMode>(
                    initialValue: data.roundingMode,
                    decoration: const InputDecoration(labelText: '取整方式'),
                    items: IngredientRoundingMode.values
                        .map(
                          (roundingMode) =>
                              DropdownMenuItem<IngredientRoundingMode>(
                                value: roundingMode,
                                child: Text(roundingMode.label),
                              ),
                        )
                        .toList(growable: false),
                    onChanged: usesDescriptor
                        ? null
                        : (value) {
                            if (value == null) {
                              return;
                            }
                            data.roundingMode = value;
                            onChanged();
                          },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('参与比例计算'),
                    subtitle: Text(usesDescriptor ? '描述型用量会自动关闭' : '可参与动态重算'),
                    value: usesDescriptor ? false : data.scalable,
                    onChanged: usesDescriptor
                        ? null
                        : (value) {
                            data.scalable = value;
                            if (!value) {
                              data.isScaleTarget = false;
                            }
                            onChanged();
                          },
                  ),
                ),
              ],
            ),
            if (isEditMode)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('设为调整基准'),
                  subtitle: Text(
                    canUseScaleTarget
                        ? '保存时将以这个食材的新用量作为比例基准'
                        : '仅数值型且参与计算的食材可作为基准',
                  ),
                  value: data.isScaleTarget,
                  onChanged:
                      canUseScaleTarget ? onScaleTargetChanged : null,
                ),
              ),
            if (isEditMode && data.scalable && !data.isScaleTarget)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  '当其他可计算食材被设为调整基准时，这个食材会在保存时自动计算。',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            TextFormField(
              controller: data.remarkController,
              decoration: const InputDecoration(labelText: '备注'),
              minLines: 1,
              maxLines: 2,
              onChanged: (_) => onChanged(),
            ),
          ],
        ),
      ),
    );
  }
}
