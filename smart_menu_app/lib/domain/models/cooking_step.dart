import 'package:freezed_annotation/freezed_annotation.dart';

part 'cooking_step.freezed.dart';
part 'cooking_step.g.dart';

@freezed
abstract class CookingStep with _$CookingStep {
  const factory CookingStep({
    required String id,
    required int stepNo,
    required String content,
    @Default(0) int sortOrder,
  }) = _CookingStep;

  factory CookingStep.fromJson(Map<String, dynamic> json) =>
      _$CookingStepFromJson(json);
}
