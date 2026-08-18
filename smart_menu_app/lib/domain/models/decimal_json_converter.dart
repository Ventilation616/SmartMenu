import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class DecimalJsonConverter implements JsonConverter<Decimal?, String?> {
  const DecimalJsonConverter();

  @override
  Decimal? fromJson(String? json) {
    if (json == null || json.trim().isEmpty) {
      return null;
    }

    try {
      return Decimal.parse(json);
    } on FormatException {
      return null;
    }
  }

  @override
  String? toJson(Decimal? object) => object?.toString();
}
