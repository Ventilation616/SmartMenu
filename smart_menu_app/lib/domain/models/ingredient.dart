import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/ingredient_type.dart';
import '../value_objects/ingredient_unit.dart';
import '../value_objects/precision_option.dart';
import '../value_objects/rounding_mode.dart';
import 'decimal_json_converter.dart';

part 'ingredient.freezed.dart';
part 'ingredient.g.dart';

@freezed
abstract class Ingredient with _$Ingredient {
  const Ingredient._();

  const factory Ingredient({
    required String id,
    required String name,
    @DecimalJsonConverter() Decimal? amount,
    required String amountText,
    required IngredientUnit unit,
    required IngredientType type,
    @Default(true) bool scalable,
    @Default(PrecisionOption.one) PrecisionOption precision,
    @Default(IngredientRoundingMode.floor) IngredientRoundingMode roundingMode,
    @Default(0) int sortOrder,
    @Default('') String remark,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  bool get hasNumericAmount => amount != null;
}
