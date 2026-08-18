// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recipe _$RecipeFromJson(Map<String, dynamic> json) => _Recipe(
  id: json['id'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  ingredients:
      (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Ingredient>[],
  steps:
      (json['steps'] as List<dynamic>?)
          ?.map((e) => CookingStep.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <CookingStep>[],
);

Map<String, dynamic> _$RecipeToJson(_Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
  'steps': instance.steps.map((e) => e.toJson()).toList(),
};
