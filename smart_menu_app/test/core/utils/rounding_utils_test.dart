import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_menu_app/core/utils/rounding_utils.dart';
import 'package:smart_menu_app/domain/value_objects/precision_option.dart';
import 'package:smart_menu_app/domain/value_objects/rounding_mode.dart';

void main() {
  group('RoundingUtils', () {
    test('按 0.5 向下取整', () {
      final result = RoundingUtils.applyPrecision(
        Decimal.parse('10.76'),
        precision: PrecisionOption.half,
        roundingMode: IngredientRoundingMode.floor,
      );

      expect(result.toString(), '10.5');
    });

    test('按 0.5 向上取整', () {
      final result = RoundingUtils.applyPrecision(
        Decimal.parse('10.76'),
        precision: PrecisionOption.half,
        roundingMode: IngredientRoundingMode.ceil,
      );

      expect(result.toString(), '11');
    });
  });
}
