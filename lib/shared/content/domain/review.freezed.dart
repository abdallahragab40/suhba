// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewInfo {

 ReviewStatus get status; Set<EditorialFlag> get editorialFlags;
/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<ReviewInfo> get copyWith => _$ReviewInfoCopyWithImpl<ReviewInfo>(this as ReviewInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewInfo&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.editorialFlags, editorialFlags));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(editorialFlags));

@override
String toString() {
  return 'ReviewInfo(status: $status, editorialFlags: $editorialFlags)';
}


}

/// @nodoc
abstract mixin class $ReviewInfoCopyWith<$Res>  {
  factory $ReviewInfoCopyWith(ReviewInfo value, $Res Function(ReviewInfo) _then) = _$ReviewInfoCopyWithImpl;
@useResult
$Res call({
 ReviewStatus status, Set<EditorialFlag> editorialFlags
});




}
/// @nodoc
class _$ReviewInfoCopyWithImpl<$Res>
    implements $ReviewInfoCopyWith<$Res> {
  _$ReviewInfoCopyWithImpl(this._self, this._then);

  final ReviewInfo _self;
  final $Res Function(ReviewInfo) _then;

/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? editorialFlags = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,editorialFlags: null == editorialFlags ? _self.editorialFlags : editorialFlags // ignore: cast_nullable_to_non_nullable
as Set<EditorialFlag>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewInfo].
extension ReviewInfoPatterns on ReviewInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewInfo value)  $default,){
final _that = this;
switch (_that) {
case _ReviewInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReviewStatus status,  Set<EditorialFlag> editorialFlags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
return $default(_that.status,_that.editorialFlags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReviewStatus status,  Set<EditorialFlag> editorialFlags)  $default,) {final _that = this;
switch (_that) {
case _ReviewInfo():
return $default(_that.status,_that.editorialFlags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReviewStatus status,  Set<EditorialFlag> editorialFlags)?  $default,) {final _that = this;
switch (_that) {
case _ReviewInfo() when $default != null:
return $default(_that.status,_that.editorialFlags);case _:
  return null;

}
}

}

/// @nodoc


class _ReviewInfo extends ReviewInfo {
  const _ReviewInfo({required this.status, final  Set<EditorialFlag> editorialFlags = const <EditorialFlag>{}}): _editorialFlags = editorialFlags,super._();
  

@override final  ReviewStatus status;
 final  Set<EditorialFlag> _editorialFlags;
@override@JsonKey() Set<EditorialFlag> get editorialFlags {
  if (_editorialFlags is EqualUnmodifiableSetView) return _editorialFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_editorialFlags);
}


/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewInfoCopyWith<_ReviewInfo> get copyWith => __$ReviewInfoCopyWithImpl<_ReviewInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewInfo&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._editorialFlags, _editorialFlags));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_editorialFlags));

@override
String toString() {
  return 'ReviewInfo(status: $status, editorialFlags: $editorialFlags)';
}


}

/// @nodoc
abstract mixin class _$ReviewInfoCopyWith<$Res> implements $ReviewInfoCopyWith<$Res> {
  factory _$ReviewInfoCopyWith(_ReviewInfo value, $Res Function(_ReviewInfo) _then) = __$ReviewInfoCopyWithImpl;
@override @useResult
$Res call({
 ReviewStatus status, Set<EditorialFlag> editorialFlags
});




}
/// @nodoc
class __$ReviewInfoCopyWithImpl<$Res>
    implements _$ReviewInfoCopyWith<$Res> {
  __$ReviewInfoCopyWithImpl(this._self, this._then);

  final _ReviewInfo _self;
  final $Res Function(_ReviewInfo) _then;

/// Create a copy of ReviewInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? editorialFlags = null,}) {
  return _then(_ReviewInfo(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,editorialFlags: null == editorialFlags ? _self._editorialFlags : editorialFlags // ignore: cast_nullable_to_non_nullable
as Set<EditorialFlag>,
  ));
}


}

// dart format on
