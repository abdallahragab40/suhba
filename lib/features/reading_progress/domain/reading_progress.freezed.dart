// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reading_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReadingProgress {

 ProgressTarget get target; String get targetId;/// The companion of a section, or the story of a chapter.
 String get parentId;/// 0–1, the share of the text scrolled through.
 double get fraction; bool get completed; String get contentVersion; DateTime get updatedAt;/// The passage's content revision when the position was recorded
/// (`BiographySection.revision`, `StoryChapter.revision`). Null for
/// positions saved before revisions existed.
 String? get targetRevision;/// The block at the top of the screen and how far into it (0–1); see
/// [PassagePosition]. Null for positions saved before anchors existed.
 int? get blockIndex; double? get blockOffset;
/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingProgressCopyWith<ReadingProgress> get copyWith => _$ReadingProgressCopyWithImpl<ReadingProgress>(this as ReadingProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingProgress&&(identical(other.target, target) || other.target == target)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.fraction, fraction) || other.fraction == fraction)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.targetRevision, targetRevision) || other.targetRevision == targetRevision)&&(identical(other.blockIndex, blockIndex) || other.blockIndex == blockIndex)&&(identical(other.blockOffset, blockOffset) || other.blockOffset == blockOffset));
}


@override
int get hashCode => Object.hash(runtimeType,target,targetId,parentId,fraction,completed,contentVersion,updatedAt,targetRevision,blockIndex,blockOffset);

@override
String toString() {
  return 'ReadingProgress(target: $target, targetId: $targetId, parentId: $parentId, fraction: $fraction, completed: $completed, contentVersion: $contentVersion, updatedAt: $updatedAt, targetRevision: $targetRevision, blockIndex: $blockIndex, blockOffset: $blockOffset)';
}


}

/// @nodoc
abstract mixin class $ReadingProgressCopyWith<$Res>  {
  factory $ReadingProgressCopyWith(ReadingProgress value, $Res Function(ReadingProgress) _then) = _$ReadingProgressCopyWithImpl;
@useResult
$Res call({
 ProgressTarget target, String targetId, String parentId, double fraction, bool completed, String contentVersion, DateTime updatedAt, String? targetRevision, int? blockIndex, double? blockOffset
});




}
/// @nodoc
class _$ReadingProgressCopyWithImpl<$Res>
    implements $ReadingProgressCopyWith<$Res> {
  _$ReadingProgressCopyWithImpl(this._self, this._then);

  final ReadingProgress _self;
  final $Res Function(ReadingProgress) _then;

/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = null,Object? targetId = null,Object? parentId = null,Object? fraction = null,Object? completed = null,Object? contentVersion = null,Object? updatedAt = null,Object? targetRevision = freezed,Object? blockIndex = freezed,Object? blockOffset = freezed,}) {
  return _then(_self.copyWith(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as ProgressTarget,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,parentId: null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String,fraction: null == fraction ? _self.fraction : fraction // ignore: cast_nullable_to_non_nullable
as double,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetRevision: freezed == targetRevision ? _self.targetRevision : targetRevision // ignore: cast_nullable_to_non_nullable
as String?,blockIndex: freezed == blockIndex ? _self.blockIndex : blockIndex // ignore: cast_nullable_to_non_nullable
as int?,blockOffset: freezed == blockOffset ? _self.blockOffset : blockOffset // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingProgress].
extension ReadingProgressPatterns on ReadingProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingProgress value)  $default,){
final _that = this;
switch (_that) {
case _ReadingProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingProgress value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProgressTarget target,  String targetId,  String parentId,  double fraction,  bool completed,  String contentVersion,  DateTime updatedAt,  String? targetRevision,  int? blockIndex,  double? blockOffset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
return $default(_that.target,_that.targetId,_that.parentId,_that.fraction,_that.completed,_that.contentVersion,_that.updatedAt,_that.targetRevision,_that.blockIndex,_that.blockOffset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProgressTarget target,  String targetId,  String parentId,  double fraction,  bool completed,  String contentVersion,  DateTime updatedAt,  String? targetRevision,  int? blockIndex,  double? blockOffset)  $default,) {final _that = this;
switch (_that) {
case _ReadingProgress():
return $default(_that.target,_that.targetId,_that.parentId,_that.fraction,_that.completed,_that.contentVersion,_that.updatedAt,_that.targetRevision,_that.blockIndex,_that.blockOffset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProgressTarget target,  String targetId,  String parentId,  double fraction,  bool completed,  String contentVersion,  DateTime updatedAt,  String? targetRevision,  int? blockIndex,  double? blockOffset)?  $default,) {final _that = this;
switch (_that) {
case _ReadingProgress() when $default != null:
return $default(_that.target,_that.targetId,_that.parentId,_that.fraction,_that.completed,_that.contentVersion,_that.updatedAt,_that.targetRevision,_that.blockIndex,_that.blockOffset);case _:
  return null;

}
}

}

/// @nodoc


class _ReadingProgress extends ReadingProgress {
  const _ReadingProgress({required this.target, required this.targetId, required this.parentId, required this.fraction, required this.completed, required this.contentVersion, required this.updatedAt, this.targetRevision, this.blockIndex, this.blockOffset}): super._();
  

@override final  ProgressTarget target;
@override final  String targetId;
/// The companion of a section, or the story of a chapter.
@override final  String parentId;
/// 0–1, the share of the text scrolled through.
@override final  double fraction;
@override final  bool completed;
@override final  String contentVersion;
@override final  DateTime updatedAt;
/// The passage's content revision when the position was recorded
/// (`BiographySection.revision`, `StoryChapter.revision`). Null for
/// positions saved before revisions existed.
@override final  String? targetRevision;
/// The block at the top of the screen and how far into it (0–1); see
/// [PassagePosition]. Null for positions saved before anchors existed.
@override final  int? blockIndex;
@override final  double? blockOffset;

/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingProgressCopyWith<_ReadingProgress> get copyWith => __$ReadingProgressCopyWithImpl<_ReadingProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingProgress&&(identical(other.target, target) || other.target == target)&&(identical(other.targetId, targetId) || other.targetId == targetId)&&(identical(other.parentId, parentId) || other.parentId == parentId)&&(identical(other.fraction, fraction) || other.fraction == fraction)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.targetRevision, targetRevision) || other.targetRevision == targetRevision)&&(identical(other.blockIndex, blockIndex) || other.blockIndex == blockIndex)&&(identical(other.blockOffset, blockOffset) || other.blockOffset == blockOffset));
}


@override
int get hashCode => Object.hash(runtimeType,target,targetId,parentId,fraction,completed,contentVersion,updatedAt,targetRevision,blockIndex,blockOffset);

@override
String toString() {
  return 'ReadingProgress(target: $target, targetId: $targetId, parentId: $parentId, fraction: $fraction, completed: $completed, contentVersion: $contentVersion, updatedAt: $updatedAt, targetRevision: $targetRevision, blockIndex: $blockIndex, blockOffset: $blockOffset)';
}


}

/// @nodoc
abstract mixin class _$ReadingProgressCopyWith<$Res> implements $ReadingProgressCopyWith<$Res> {
  factory _$ReadingProgressCopyWith(_ReadingProgress value, $Res Function(_ReadingProgress) _then) = __$ReadingProgressCopyWithImpl;
@override @useResult
$Res call({
 ProgressTarget target, String targetId, String parentId, double fraction, bool completed, String contentVersion, DateTime updatedAt, String? targetRevision, int? blockIndex, double? blockOffset
});




}
/// @nodoc
class __$ReadingProgressCopyWithImpl<$Res>
    implements _$ReadingProgressCopyWith<$Res> {
  __$ReadingProgressCopyWithImpl(this._self, this._then);

  final _ReadingProgress _self;
  final $Res Function(_ReadingProgress) _then;

/// Create a copy of ReadingProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = null,Object? targetId = null,Object? parentId = null,Object? fraction = null,Object? completed = null,Object? contentVersion = null,Object? updatedAt = null,Object? targetRevision = freezed,Object? blockIndex = freezed,Object? blockOffset = freezed,}) {
  return _then(_ReadingProgress(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as ProgressTarget,targetId: null == targetId ? _self.targetId : targetId // ignore: cast_nullable_to_non_nullable
as String,parentId: null == parentId ? _self.parentId : parentId // ignore: cast_nullable_to_non_nullable
as String,fraction: null == fraction ? _self.fraction : fraction // ignore: cast_nullable_to_non_nullable
as double,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as bool,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,targetRevision: freezed == targetRevision ? _self.targetRevision : targetRevision // ignore: cast_nullable_to_non_nullable
as String?,blockIndex: freezed == blockIndex ? _self.blockIndex : blockIndex // ignore: cast_nullable_to_non_nullable
as int?,blockOffset: freezed == blockOffset ? _self.blockOffset : blockOffset // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
