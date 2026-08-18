import '../value_objects/ingredient_type.dart';
import '../value_objects/ingredient_unit.dart';
import '../value_objects/precision_option.dart';
import '../value_objects/rounding_mode.dart';

class Ingredient {
  const Ingredient({
    required this.id,
    required this.name,
    required this.amount,
    required this.unit,
    required this.type,
    required this.scalable,
    required this.precision,
    required this.roundingMode,
    this.remark = '',
  });

  final String id;
  final String name;
  final String amount;
  final IngredientUnit unit;
  final IngredientType type;
  final bool scalable;
  final PrecisionOption precision;
  final IngredientRoundingMode roundingMode;
  final String remark;
}
