// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cooking_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CookingStep {

 String get id; int get stepNo; String get content; int get sortOrder;
/// Create a copy of CookingStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CookingStepCopyWith<CookingStep> get copyWith => _$CookingStepCopyWithImpl<CookingStep>(this as CookingStep, _$identity);

  /// Serializes this CookingStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CookingStep&&(identical(other.id, id) || other.id == id)&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.content, content) || other.content == content)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,stepNo,content,sortOrder);

@override
String toString() {
  return 'CookingStep(id: $id, stepNo: $stepNo, content: $content, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $CookingStepCopyWith<$Res>  {
  factory $CookingStepCopyWith(CookingStep value, $Res Function(CookingStep) _then) = _$CookingStepCopyWithImpl;
@useResult
$Res call({
 String id, int stepNo, String content, int sortOrder
});




}
/// @nodoc
class _$CookingStepCopyWithImpl<$Res>
    implements $CookingStepCopyWith<$Res> {
  _$CookingStepCopyWithImpl(this._self, this._then);

  final CookingStep _self;
  final $Res Function(CookingStep) _then;

/// Create a copy of CookingStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? stepNo = null,Object? content = null,Object? sortOrder = null,}) {
  return _then(CookingStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CookingStep].
extension CookingStepPatterns on CookingStep {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CookingStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CookingStep() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CookingStep value)  $default,){
final _that = this;
switch (_that) {
case _CookingStep():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CookingStep value)?  $default,){
final _that = this;
switch (_that) {
case _CookingStep() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int stepNo,  String content,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CookingStep() when $default != null:
return $default(_that.id,_that.stepNo,_that.content,_that.sortOrder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int stepNo,  String content,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _CookingStep():
return $default(_that.id,_that.stepNo,_that.content,_that.sortOrder);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int stepNo,  String content,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _CookingStep() when $default != null:
return $default(_that.id,_that.stepNo,_that.content,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CookingStep implements CookingStep {
  const _CookingStep({required this.id, required this.stepNo, required this.content, this.sortOrder = 0});
  factory _CookingStep.fromJson(Map<String, dynamic> json) => _$CookingStepFromJson(json);

@override final  String id;
@override final  int stepNo;
@override final  String content;
@override@JsonKey() final  int sortOrder;

/// Create a copy of CookingStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CookingStepCopyWith<_CookingStep> get copyWith => __$CookingStepCopyWithImpl<_CookingStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CookingStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CookingStep&&(identical(other.id, id) || other.id == id)&&(identical(other.stepNo, stepNo) || other.stepNo == stepNo)&&(identical(other.content, content) || other.content == content)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,stepNo,content,sortOrder);

@override
String toString() {
  return 'CookingStep(id: $id, stepNo: $stepNo, content: $content, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$CookingStepCopyWith<$Res> implements $CookingStepCopyWith<$Res> {
  factory _$CookingStepCopyWith(_CookingStep value, $Res Function(_CookingStep) _then) = __$CookingStepCopyWithImpl;
@override @useResult
$Res call({
 String id, int stepNo, String content, int sortOrder
});




}
/// @nodoc
class __$CookingStepCopyWithImpl<$Res>
    implements _$CookingStepCopyWith<$Res> {
  __$CookingStepCopyWithImpl(this._self, this._then);

  final _CookingStep _self;
  final $Res Function(_CookingStep) _then;

/// Create a copy of CookingStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? stepNo = null,Object? content = null,Object? sortOrder = null,}) {
  return _then(_CookingStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,stepNo: null == stepNo ? _self.stepNo : stepNo // ignore: cast_nullable_to_non_nullable
as int,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
