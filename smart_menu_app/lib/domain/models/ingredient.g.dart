// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ingredient _$IngredientFromJson(Map<String, dynamic> json) => _Ingredient(
  id: json['id'] as String,
  name: json['name'] as String,
  amount: const DecimalJsonConverter().fromJson(json['amount'] as String?),
  amountText: json['amountText'] as String,
  unit: $enumDecode(_$IngredientUnitEnumMap, json['unit']),
  type: $enumDecode(_$IngredientTypeEnumMap, json['type']),
  scalable: json['scalable'] as bool? ?? true,
  precision:
      $enumDecodeNullable(_$PrecisionOptionEnumMap, json['precision']) ??
      PrecisionOption.one,
  roundingMode:
      $enumDecodeNullable(
        _$IngredientRoundingModeEnumMap,
        json['roundingMode'],
      ) ??
      IngredientRoundingMode.floor,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
  remark: json['remark'] as String? ?? '',
);

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'amount': const DecimalJsonConverter().toJson(instance.amount),
      'amountText': instance.amountText,
      'unit': _$IngredientUnitEnumMap[instance.unit]!,
      'type': _$IngredientTypeEnumMap[instance.type]!,
      'scalable': instance.scalable,
      'precision': _$PrecisionOptionEnumMap[instance.precision]!,
      'roundingMode': _$IngredientRoundingModeEnumMap[instance.roundingMode]!,
      'sortOrder': instance.sortOrder,
      'remark': instance.remark,
    };

const _$IngredientUnitEnumMap = {
  IngredientUnit.gram: 'gram',
  IngredientUnit.milliliter: 'milliliter',
  IngredientUnit.piece: 'piece',
  IngredientUnit.tablespoon: 'tablespoon',
  IngredientUnit.teaspoon: 'teaspoon',
  IngredientUnit.other: 'other',
};

const _$IngredientTypeEnumMap = {
  IngredientType.main: 'main',
  IngredientType.side: 'side',
  IngredientType.seasoning: 'seasoning',
  IngredientType.garnish: 'garnish',
  IngredientType.other: 'other',
};

const _$PrecisionOptionEnumMap = {
  PrecisionOption.one: 'one',
  PrecisionOption.half: 'half',
  PrecisionOption.tenth: 'tenth',
};

const _$IngredientRoundingModeEnumMap = {
  IngredientRoundingMode.floor: 'floor',
  IngredientRoundingMode.ceil: 'ceil',
};
