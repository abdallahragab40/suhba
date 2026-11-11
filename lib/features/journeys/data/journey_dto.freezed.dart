// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'journey_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepRefDto {

 StepRefType get type; String get targetId; String? get parentId;
/// Create a copy of StepRefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepRefDtoCopyWith<StepRefDto> get copyWith => _$StepRefDtoCopyWithImpl<StepRefDto>(this as StepRefDto, _$identity);

  /// Serializes this StepRefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepRefDto&&(identical(other.type, type) || other.type == type)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.parentId, parentId) || other.parentId == parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,targetId,parentId);

@override
String toString() {
  return 'StepRefDto(type: $type, targetId: $targetId, parentId: $parentId)';
}


}

/// @nodoc
abstract mixin class $StepRefDtoCopyWith<$Res>  {
  factory $StepRefDtoCopyWith(StepRefDto value, $Res Function(StepRefDto) _then) = _$StepRefDtoCopyWithImpl;
@useResult
$Res call({
 StepRefType type, String targetId, String? parentId
});




}
/// @nodoc
class _$StepRefDtoCopyWithImpl<$Res>
    implements $StepRefDtoCopyWith<$Res> {
  _$StepRefDtoCopyWithImpl(this._self, this._then);

  final StepRefDto _self;
  final $Res Function(StepRefDto) _then;

/// Create a copy of StepRefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? targetId = null,Object? parentId = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StepRefType,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StepRefDto].
extension StepRefDtoPatterns on StepRefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StepRefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StepRefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StepRefDto value)  $default,){
final _that = this;
switch (_that) {
case _StepRefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StepRefDto value)?  $default,){
final _that = this;
switch (_that) {
case _StepRefDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StepRefType type,  String targetId,  String? parentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StepRefDto() when $default != null:
return $default(_that.type,_that.targetId,_that.parentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StepRefType type,  String targetId,  String? parentId)  $default,) {final _that = this;
switch (_that) {
case _StepRefDto():
return $default(_that.type,_that.targetId,_that.parentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StepRefType type,  String targetId,  String? parentId)?  $default,) {final _that = this;
switch (_that) {
case _StepRefDto() when $default != null:
return $default(_that.type,_that.targetId,_that.parentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StepRefDto implements StepRefDto {
  const _StepRefDto({required this.type, required this.targetId, this.parentId});
  factory _StepRefDto.fromJson(Map<String, dynamic> json) => _$StepRefDtoFromJson(json);

@override final  StepRefType type;
@override final  String targetId;
@override final  String? parentId;

/// Create a copy of StepRefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StepRefDtoCopyWith<_StepRefDto> get copyWith => __$StepRefDtoCopyWithImpl<_StepRefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StepRefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StepRefDto&&(identical(other.type, type) || other.type == type)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.parentId, parentId) || other.parentId == parentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,targetId,parentId);

@override
String toString() {
  return 'StepRefDto(type: $type, targetId: $targetId, parentId: $parentId)';
}


}

/// @nodoc
abstract mixin class _$StepRefDtoCopyWith<$Res> implements $StepRefDtoCopyWith<$Res> {
  factory _$StepRefDtoCopyWith(_StepRefDto value, $Res Function(_StepRefDto) _then) = __$StepRefDtoCopyWithImpl;
@override @useResult
$Res call({
 StepRefType type, String targetId, String? parentId
});




}
/// @nodoc
class __$StepRefDtoCopyWithImpl<$Res>
    implements _$StepRefDtoCopyWith<$Res> {
  __$StepRefDtoCopyWithImpl(this._self, this._then);

  final _StepRefDto _self;
  final $Res Function(_StepRefDto) _then;

/// Create a copy of StepRefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? targetId = null,Object? parentId = freezed,}) {
  return _then(_StepRefDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as StepRefType,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,parentId: freezed == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$JourneyStepDto {

 String get id; LocalizedTextDto get title; List<StepRefDto> get readings; LocalizedTextDto? get framing; LocalizedTextDto? get reflection;
/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JourneyStepDtoCopyWith<JourneyStepDto> get copyWith => _$JourneyStepDtoCopyWithImpl<JourneyStepDto>(this as JourneyStepDto, _$identity);

  /// Serializes this JourneyStepDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyStepDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.readings, readings)&&(identical(other.framing, framing) || other.framing == framing)&&(identical(other.reflection, reflection) || other.reflection == reflection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(readings),framing,reflection);

@override
String toString() {
  return 'JourneyStepDto(id: $id, title: $title, readings: $readings, framing: $framing, reflection: $reflection)';
}


}

/// @nodoc
abstract mixin class $JourneyStepDtoCopyWith<$Res>  {
  factory $JourneyStepDtoCopyWith(JourneyStepDto value, $Res Function(JourneyStepDto) _then) = _$JourneyStepDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto title, List<StepRefDto> readings, LocalizedTextDto? framing, LocalizedTextDto? reflection
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res>? get framing;$LocalizedTextDtoCopyWith<$Res>? get reflection;

}
/// @nodoc
class _$JourneyStepDtoCopyWithImpl<$Res>
    implements $JourneyStepDtoCopyWith<$Res> {
  _$JourneyStepDtoCopyWithImpl(this._self, this._then);

  final JourneyStepDto _self;
  final $Res Function(JourneyStepDto) _then;

/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? readings = null,Object? framing = freezed,Object? reflection = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,readings: null == readings ? _self.readings : readings // ignore: cast_nullable_to_non_nullable
as List<StepRefDto>,framing: freezed == framing ? _self.framing : framing // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get framing {
    if (_self.framing == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.framing!, (value) {
    return _then(_self.copyWith(framing: value));
  });
}/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get reflection {
    if (_self.reflection == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.reflection!, (value) {
    return _then(_self.copyWith(reflection: value));
  });
}
}


/// Adds pattern-matching-related methods to [JourneyStepDto].
extension JourneyStepDtoPatterns on JourneyStepDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JourneyStepDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JourneyStepDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JourneyStepDto value)  $default,){
final _that = this;
switch (_that) {
case _JourneyStepDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JourneyStepDto value)?  $default,){
final _that = this;
switch (_that) {
case _JourneyStepDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  List<StepRefDto> readings,  LocalizedTextDto? framing,  LocalizedTextDto? reflection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JourneyStepDto() when $default != null:
return $default(_that.id,_that.title,_that.readings,_that.framing,_that.reflection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  List<StepRefDto> readings,  LocalizedTextDto? framing,  LocalizedTextDto? reflection)  $default,) {final _that = this;
switch (_that) {
case _JourneyStepDto():
return $default(_that.id,_that.title,_that.readings,_that.framing,_that.reflection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto title,  List<StepRefDto> readings,  LocalizedTextDto? framing,  LocalizedTextDto? reflection)?  $default,) {final _that = this;
switch (_that) {
case _JourneyStepDto() when $default != null:
return $default(_that.id,_that.title,_that.readings,_that.framing,_that.reflection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JourneyStepDto implements JourneyStepDto {
  const _JourneyStepDto({required this.id, required this.title, required final  List<StepRefDto> readings, this.framing, this.reflection}): _readings = readings;
  factory _JourneyStepDto.fromJson(Map<String, dynamic> json) => _$JourneyStepDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto title;
 final  List<StepRefDto> _readings;
@override List<StepRefDto> get readings {
  if (_readings is EqualUnmodifiableListView) return _readings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readings);
}

@override final  LocalizedTextDto? framing;
@override final  LocalizedTextDto? reflection;

/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JourneyStepDtoCopyWith<_JourneyStepDto> get copyWith => __$JourneyStepDtoCopyWithImpl<_JourneyStepDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JourneyStepDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JourneyStepDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._readings, _readings)&&(identical(other.framing, framing) || other.framing == framing)&&(identical(other.reflection, reflection) || other.reflection == reflection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_readings),framing,reflection);

@override
String toString() {
  return 'JourneyStepDto(id: $id, title: $title, readings: $readings, framing: $framing, reflection: $reflection)';
}


}

/// @nodoc
abstract mixin class _$JourneyStepDtoCopyWith<$Res> implements $JourneyStepDtoCopyWith<$Res> {
  factory _$JourneyStepDtoCopyWith(_JourneyStepDto value, $Res Function(_JourneyStepDto) _then) = __$JourneyStepDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto title, List<StepRefDto> readings, LocalizedTextDto? framing, LocalizedTextDto? reflection
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res>? get framing;@override $LocalizedTextDtoCopyWith<$Res>? get reflection;

}
/// @nodoc
class __$JourneyStepDtoCopyWithImpl<$Res>
    implements _$JourneyStepDtoCopyWith<$Res> {
  __$JourneyStepDtoCopyWithImpl(this._self, this._then);

  final _JourneyStepDto _self;
  final $Res Function(_JourneyStepDto) _then;

/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? readings = null,Object? framing = freezed,Object? reflection = freezed,}) {
  return _then(_JourneyStepDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,readings: null == readings ? _self._readings : readings // ignore: cast_nullable_to_non_nullable
as List<StepRefDto>,framing: freezed == framing ? _self.framing : framing // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get framing {
    if (_self.framing == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.framing!, (value) {
    return _then(_self.copyWith(framing: value));
  });
}/// Create a copy of JourneyStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get reflection {
    if (_self.reflection == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.reflection!, (value) {
    return _then(_self.copyWith(reflection: value));
  });
}
}


/// @nodoc
mixin _$JourneyDto {

 int get schemaVersion; String get id; LocalizedTextDto get title; LocalizedTextDto get description; List<JourneyStepDto> get steps; ReviewDto get review;
/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JourneyDtoCopyWith<JourneyDto> get copyWith => _$JourneyDtoCopyWithImpl<JourneyDto>(this as JourneyDto, _$identity);

  /// Serializes this JourneyDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JourneyDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,description,const DeepCollectionEquality().hash(steps),review);

@override
String toString() {
  return 'JourneyDto(schemaVersion: $schemaVersion, id: $id, title: $title, description: $description, steps: $steps, review: $review)';
}


}

/// @nodoc
abstract mixin class $JourneyDtoCopyWith<$Res>  {
  factory $JourneyDtoCopyWith(JourneyDto value, $Res Function(JourneyDto) _then) = _$JourneyDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto description, List<JourneyStepDto> steps, ReviewDto review
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get description;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$JourneyDtoCopyWithImpl<$Res>
    implements $JourneyDtoCopyWith<$Res> {
  _$JourneyDtoCopyWithImpl(this._self, this._then);

  final JourneyDto _self;
  final $Res Function(JourneyDto) _then;

/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? description = null,Object? steps = null,Object? review = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<JourneyStepDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,
  ));
}
/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get description {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [JourneyDto].
extension JourneyDtoPatterns on JourneyDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JourneyDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JourneyDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JourneyDto value)  $default,){
final _that = this;
switch (_that) {
case _JourneyDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JourneyDto value)?  $default,){
final _that = this;
switch (_that) {
case _JourneyDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto description,  List<JourneyStepDto> steps,  ReviewDto review)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JourneyDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.description,_that.steps,_that.review);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto description,  List<JourneyStepDto> steps,  ReviewDto review)  $default,) {final _that = this;
switch (_that) {
case _JourneyDto():
return $default(_that.schemaVersion,_that.id,_that.title,_that.description,_that.steps,_that.review);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto description,  List<JourneyStepDto> steps,  ReviewDto review)?  $default,) {final _that = this;
switch (_that) {
case _JourneyDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.description,_that.steps,_that.review);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JourneyDto implements JourneyDto {
  const _JourneyDto({required this.schemaVersion, required this.id, required this.title, required this.description, required final  List<JourneyStepDto> steps, required this.review}): _steps = steps;
  factory _JourneyDto.fromJson(Map<String, dynamic> json) => _$JourneyDtoFromJson(json);

@override final  int schemaVersion;
@override final  String id;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto description;
 final  List<JourneyStepDto> _steps;
@override List<JourneyStepDto> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  ReviewDto review;

/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JourneyDtoCopyWith<_JourneyDto> get copyWith => __$JourneyDtoCopyWithImpl<_JourneyDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JourneyDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JourneyDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,description,const DeepCollectionEquality().hash(_steps),review);

@override
String toString() {
  return 'JourneyDto(schemaVersion: $schemaVersion, id: $id, title: $title, description: $description, steps: $steps, review: $review)';
}


}

/// @nodoc
abstract mixin class _$JourneyDtoCopyWith<$Res> implements $JourneyDtoCopyWith<$Res> {
  factory _$JourneyDtoCopyWith(_JourneyDto value, $Res Function(_JourneyDto) _then) = __$JourneyDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto description, List<JourneyStepDto> steps, ReviewDto review
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get description;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$JourneyDtoCopyWithImpl<$Res>
    implements _$JourneyDtoCopyWith<$Res> {
  __$JourneyDtoCopyWithImpl(this._self, this._then);

  final _JourneyDto _self;
  final $Res Function(_JourneyDto) _then;

/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? description = null,Object? steps = null,Object? review = null,}) {
  return _then(_JourneyDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<JourneyStepDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,
  ));
}

/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get description {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.description, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of JourneyDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

// dart format on
