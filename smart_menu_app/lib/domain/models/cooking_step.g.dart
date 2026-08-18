// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cooking_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CookingStep _$CookingStepFromJson(Map<String, dynamic> json) => _CookingStep(
  id: json['id'] as String,
  stepNo: (json['stepNo'] as num).toInt(),
  content: json['content'] as String,
  sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$CookingStepToJson(_CookingStep instance) =>
    <String, dynamic>{
      'id': instance.id,
      'stepNo': instance.stepNo,
      'content': instance.content,
      'sortOrder': instance.sortOrder,
    };
