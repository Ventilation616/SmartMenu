import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
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
  });

  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController remarkController;
  IngredientUnit unit;
  IngredientType type;
  PrecisionOption precision;
  IngredientRoundingMode roundingMode;
  bool scalable;
}

class IngredientFormItem extends StatelessWidget {
  const IngredientFormItem({
    required this.index,
    required this.data,
    required this.onRemove,
    required this.onChanged,
    super.key,
  });

  final int index;
  final IngredientFormData data;
  final VoidCallback onRemove;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final amountText = data.amountController.text.trim();
    final usesDescriptor = DecimalUtils.isDescriptorAmount(amountText);

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
              key: ValueKey<String>('ingredient_name_$index'),
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
                    key: ValueKey<String>('ingredient_amount_$index'),
                    controller: data.amountController,
                    decoration: const InputDecoration(labelText: '用量'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: _ScalingSwitchField(
                    usesDescriptor: usesDescriptor,
                    value: usesDescriptor ? false : data.scalable,
                    onChanged: usesDescriptor
                        ? null
                        : (value) {
                            data.scalable = value;
                            onChanged();
                          },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
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

class _ScalingSwitchField extends StatelessWidget {
  const _ScalingSwitchField({
    required this.usesDescriptor,
    required this.value,
    required this.onChanged,
  });

  final bool usesDescriptor;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      borderRadius: BorderRadius.circular(12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: onChanged == null
                  ? null
                  : (checked) => onChanged!(checked ?? false),
              activeColor: AppColors.accent,
            ),
            Expanded(
              child: Text(
                '动态计算',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: onChanged == null ? AppColors.muted : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
