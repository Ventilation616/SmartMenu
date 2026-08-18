import 'package:decimal/decimal.dart';

import '../../domain/value_objects/precision_option.dart';
import '../../domain/value_objects/rounding_mode.dart';

class RoundingUtils {
  const RoundingUtils._();

  static Decimal applyPrecision(
    Decimal amount, {
    required PrecisionOption precision,
    required IngredientRoundingMode roundingMode,
  }) {
    final precisionValue = Decimal.parse(precision.value);

    if (precisionValue <= Decimal.zero) {
      throw ArgumentError.value(precision, 'precision', '精度必须大于 0');
    }

    final units = (amount / precisionValue).toDecimal();
    final roundedUnits = switch (roundingMode) {
      IngredientRoundingMode.floor => units.floor(),
      IngredientRoundingMode.ceil => units.ceil(),
    };

    return roundedUnits * precisionValue;
  }
}
