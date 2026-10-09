// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContentManifest {

 String get contentVersion; int get schemaVersion; ContentChannel get channel; int get companionCount; int get storyCount; int get approvedCount; int get unapprovedCount; int get seerahChapterCount; int get seerahTopicCount; int get placeCount; int get visualCount;
/// Create a copy of ContentManifest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentManifestCopyWith<ContentManifest> get copyWith => _$ContentManifestCopyWithImpl<ContentManifest>(this as ContentManifest, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentManifest&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.companionCount, companionCount) || other.companionCount == companionCount)&&(identical(other.storyCount, storyCount) || other.storyCount == storyCount)&&(identical(other.approvedCount, approvedCount) || other.approvedCount == approvedCount)&&(identical(other.unapprovedCount, unapprovedCount) || other.unapprovedCount == unapprovedCount)&&(identical(other.seerahChapterCount, seerahChapterCount) || other.seerahChapterCount == seerahChapterCount)&&(identical(other.seerahTopicCount, seerahTopicCount) || other.seerahTopicCount == seerahTopicCount)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.visualCount, visualCount) || other.visualCount == visualCount));
}


@override
int get hashCode => Object.hash(runtimeType,contentVersion,schemaVersion,channel,companionCount,storyCount,approvedCount,unapprovedCount,seerahChapterCount,seerahTopicCount,placeCount,visualCount);

@override
String toString() {
  return 'ContentManifest(contentVersion: $contentVersion, schemaVersion: $schemaVersion, channel: $channel, companionCount: $companionCount, storyCount: $storyCount, approvedCount: $approvedCount, unapprovedCount: $unapprovedCount, seerahChapterCount: $seerahChapterCount, seerahTopicCount: $seerahTopicCount, placeCount: $placeCount, visualCount: $visualCount)';
}


}

/// @nodoc
abstract mixin class $ContentManifestCopyWith<$Res>  {
  factory $ContentManifestCopyWith(ContentManifest value, $Res Function(ContentManifest) _then) = _$ContentManifestCopyWithImpl;
@useResult
$Res call({
 String contentVersion, int schemaVersion, ContentChannel channel, int companionCount, int storyCount, int approvedCount, int unapprovedCount, int seerahChapterCount, int seerahTopicCount, int placeCount, int visualCount
});




}
/// @nodoc
class _$ContentManifestCopyWithImpl<$Res>
    implements $ContentManifestCopyWith<$Res> {
  _$ContentManifestCopyWithImpl(this._self, this._then);

  final ContentManifest _self;
  final $Res Function(ContentManifest) _then;

/// Create a copy of ContentManifest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentVersion = null,Object? schemaVersion = null,Object? channel = null,Object? companionCount = null,Object? storyCount = null,Object? approvedCount = null,Object? unapprovedCount = null,Object? seerahChapterCount = null,Object? seerahTopicCount = null,Object? placeCount = null,Object? visualCount = null,}) {
  return _then(_self.copyWith(
contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ContentChannel,companionCount: null == companionCount ? _self.companionCount : companionCount // ignore: cast_nullable_to_non_nullable
as int,storyCount: null == storyCount ? _self.storyCount : storyCount // ignore: cast_nullable_to_non_nullable
as int,approvedCount: null == approvedCount ? _self.approvedCount : approvedCount // ignore: cast_nullable_to_non_nullable
as int,unapprovedCount: null == unapprovedCount ? _self.unapprovedCount : unapprovedCount // ignore: cast_nullable_to_non_nullable
as int,seerahChapterCount: null == seerahChapterCount ? _self.seerahChapterCount : seerahChapterCount // ignore: cast_nullable_to_non_nullable
as int,seerahTopicCount: null == seerahTopicCount ? _self.seerahTopicCount : seerahTopicCount // ignore: cast_nullable_to_non_nullable
as int,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,visualCount: null == visualCount ? _self.visualCount : visualCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentManifest].
extension ContentManifestPatterns on ContentManifest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentManifest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentManifest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentManifest value)  $default,){
final _that = this;
switch (_that) {
case _ContentManifest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentManifest value)?  $default,){
final _that = this;
switch (_that) {
case _ContentManifest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String contentVersion,  int schemaVersion,  ContentChannel channel,  int companionCount,  int storyCount,  int approvedCount,  int unapprovedCount,  int seerahChapterCount,  int seerahTopicCount,  int placeCount,  int visualCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentManifest() when $default != null:
return $default(_that.contentVersion,_that.schemaVersion,_that.channel,_that.companionCount,_that.storyCount,_that.approvedCount,_that.unapprovedCount,_that.seerahChapterCount,_that.seerahTopicCount,_that.placeCount,_that.visualCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String contentVersion,  int schemaVersion,  ContentChannel channel,  int companionCount,  int storyCount,  int approvedCount,  int unapprovedCount,  int seerahChapterCount,  int seerahTopicCount,  int placeCount,  int visualCount)  $default,) {final _that = this;
switch (_that) {
case _ContentManifest():
return $default(_that.contentVersion,_that.schemaVersion,_that.channel,_that.companionCount,_that.storyCount,_that.approvedCount,_that.unapprovedCount,_that.seerahChapterCount,_that.seerahTopicCount,_that.placeCount,_that.visualCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String contentVersion,  int schemaVersion,  ContentChannel channel,  int companionCount,  int storyCount,  int approvedCount,  int unapprovedCount,  int seerahChapterCount,  int seerahTopicCount,  int placeCount,  int visualCount)?  $default,) {final _that = this;
switch (_that) {
case _ContentManifest() when $default != null:
return $default(_that.contentVersion,_that.schemaVersion,_that.channel,_that.companionCount,_that.storyCount,_that.approvedCount,_that.unapprovedCount,_that.seerahChapterCount,_that.seerahTopicCount,_that.placeCount,_that.visualCount);case _:
  return null;

}
}

}

/// @nodoc


class _ContentManifest extends ContentManifest {
  const _ContentManifest({required this.contentVersion, required this.schemaVersion, required this.channel, required this.companionCount, required this.storyCount, required this.approvedCount, required this.unapprovedCount, this.seerahChapterCount = 0, this.seerahTopicCount = 0, this.placeCount = 0, this.visualCount = 0}): super._();
  

@override final  String contentVersion;
@override final  int schemaVersion;
@override final  ContentChannel channel;
@override final  int companionCount;
@override final  int storyCount;
@override final  int approvedCount;
@override final  int unapprovedCount;
@override@JsonKey() final  int seerahChapterCount;
@override@JsonKey() final  int seerahTopicCount;
@override@JsonKey() final  int placeCount;
@override@JsonKey() final  int visualCount;

/// Create a copy of ContentManifest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentManifestCopyWith<_ContentManifest> get copyWith => __$ContentManifestCopyWithImpl<_ContentManifest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentManifest&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.companionCount, companionCount) || other.companionCount == companionCount)&&(identical(other.storyCount, storyCount) || other.storyCount == storyCount)&&(identical(other.approvedCount, approvedCount) || other.approvedCount == approvedCount)&&(identical(other.unapprovedCount, unapprovedCount) || other.unapprovedCount == unapprovedCount)&&(identical(other.seerahChapterCount, seerahChapterCount) || other.seerahChapterCount == seerahChapterCount)&&(identical(other.seerahTopicCount, seerahTopicCount) || other.seerahTopicCount == seerahTopicCount)&&(identical(other.placeCount, placeCount) || other.placeCount == placeCount)&&(identical(other.visualCount, visualCount) || other.visualCount == visualCount));
}


@override
int get hashCode => Object.hash(runtimeType,contentVersion,schemaVersion,channel,companionCount,storyCount,approvedCount,unapprovedCount,seerahChapterCount,seerahTopicCount,placeCount,visualCount);

@override
String toString() {
  return 'ContentManifest(contentVersion: $contentVersion, schemaVersion: $schemaVersion, channel: $channel, companionCount: $companionCount, storyCount: $storyCount, approvedCount: $approvedCount, unapprovedCount: $unapprovedCount, seerahChapterCount: $seerahChapterCount, seerahTopicCount: $seerahTopicCount, placeCount: $placeCount, visualCount: $visualCount)';
}


}

/// @nodoc
abstract mixin class _$ContentManifestCopyWith<$Res> implements $ContentManifestCopyWith<$Res> {
  factory _$ContentManifestCopyWith(_ContentManifest value, $Res Function(_ContentManifest) _then) = __$ContentManifestCopyWithImpl;
@override @useResult
$Res call({
 String contentVersion, int schemaVersion, ContentChannel channel, int companionCount, int storyCount, int approvedCount, int unapprovedCount, int seerahChapterCount, int seerahTopicCount, int placeCount, int visualCount
});




}
/// @nodoc
class __$ContentManifestCopyWithImpl<$Res>
    implements _$ContentManifestCopyWith<$Res> {
  __$ContentManifestCopyWithImpl(this._self, this._then);

  final _ContentManifest _self;
  final $Res Function(_ContentManifest) _then;

/// Create a copy of ContentManifest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentVersion = null,Object? schemaVersion = null,Object? channel = null,Object? companionCount = null,Object? storyCount = null,Object? approvedCount = null,Object? unapprovedCount = null,Object? seerahChapterCount = null,Object? seerahTopicCount = null,Object? placeCount = null,Object? visualCount = null,}) {
  return _then(_ContentManifest(
contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ContentChannel,companionCount: null == companionCount ? _self.companionCount : companionCount // ignore: cast_nullable_to_non_nullable
as int,storyCount: null == storyCount ? _self.storyCount : storyCount // ignore: cast_nullable_to_non_nullable
as int,approvedCount: null == approvedCount ? _self.approvedCount : approvedCount // ignore: cast_nullable_to_non_nullable
as int,unapprovedCount: null == unapprovedCount ? _self.unapprovedCount : unapprovedCount // ignore: cast_nullable_to_non_nullable
as int,seerahChapterCount: null == seerahChapterCount ? _self.seerahChapterCount : seerahChapterCount // ignore: cast_nullable_to_non_nullable
as int,seerahTopicCount: null == seerahTopicCount ? _self.seerahTopicCount : seerahTopicCount // ignore: cast_nullable_to_non_nullable
as int,placeCount: null == placeCount ? _self.placeCount : placeCount // ignore: cast_nullable_to_non_nullable
as int,visualCount: null == visualCount ? _self.visualCount : visualCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
