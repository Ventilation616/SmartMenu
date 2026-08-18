import 'package:decimal/decimal.dart';

class DecimalUtils {
  const DecimalUtils._();

  static const Set<String> _nonScalableDescriptors = <String>{'适量', '少许', '若干'};

  static Decimal? tryParseAmount(String? rawValue) {
    final normalized = rawValue?.trim() ?? '';
    if (normalized.isEmpty) {
      return null;
    }

    return Decimal.tryParse(normalized);
  }

  static bool isNonNegativeNumeric(String? rawValue) {
    final decimal = tryParseAmount(rawValue);
    return decimal != null && decimal >= Decimal.zero;
  }

  static bool isDescriptorAmount(String? rawValue) {
    final normalized = rawValue?.trim() ?? '';
    return _nonScalableDescriptors.contains(normalized);
  }

  static String formatDecimal(Decimal value) {
    return value.toString();
  }
}
