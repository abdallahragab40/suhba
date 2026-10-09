// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StoryChapterDto {

 String get id; LocalizedTextDto get title; List<ContentBlockDto> get blocks;
/// Create a copy of StoryChapterDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryChapterDtoCopyWith<StoryChapterDto> get copyWith => _$StoryChapterDtoCopyWithImpl<StoryChapterDto>(this as StoryChapterDto, _$identity);

  /// Serializes this StoryChapterDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryChapterDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.blocks, blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(blocks));

@override
String toString() {
  return 'StoryChapterDto(id: $id, title: $title, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $StoryChapterDtoCopyWith<$Res>  {
  factory $StoryChapterDtoCopyWith(StoryChapterDto value, $Res Function(StoryChapterDto) _then) = _$StoryChapterDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto title, List<ContentBlockDto> blocks
});


$LocalizedTextDtoCopyWith<$Res> get title;

}
/// @nodoc
class _$StoryChapterDtoCopyWithImpl<$Res>
    implements $StoryChapterDtoCopyWith<$Res> {
  _$StoryChapterDtoCopyWithImpl(this._self, this._then);

  final StoryChapterDto _self;
  final $Res Function(StoryChapterDto) _then;

/// Create a copy of StoryChapterDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? blocks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,
  ));
}
/// Create a copy of StoryChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [StoryChapterDto].
extension StoryChapterDtoPatterns on StoryChapterDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryChapterDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryChapterDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryChapterDto value)  $default,){
final _that = this;
switch (_that) {
case _StoryChapterDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryChapterDto value)?  $default,){
final _that = this;
switch (_that) {
case _StoryChapterDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  List<ContentBlockDto> blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryChapterDto() when $default != null:
return $default(_that.id,_that.title,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  List<ContentBlockDto> blocks)  $default,) {final _that = this;
switch (_that) {
case _StoryChapterDto():
return $default(_that.id,_that.title,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto title,  List<ContentBlockDto> blocks)?  $default,) {final _that = this;
switch (_that) {
case _StoryChapterDto() when $default != null:
return $default(_that.id,_that.title,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryChapterDto implements StoryChapterDto {
  const _StoryChapterDto({required this.id, required this.title, required final  List<ContentBlockDto> blocks}): _blocks = blocks;
  factory _StoryChapterDto.fromJson(Map<String, dynamic> json) => _$StoryChapterDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto title;
 final  List<ContentBlockDto> _blocks;
@override List<ContentBlockDto> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}


/// Create a copy of StoryChapterDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryChapterDtoCopyWith<_StoryChapterDto> get copyWith => __$StoryChapterDtoCopyWithImpl<_StoryChapterDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryChapterDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryChapterDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._blocks, _blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_blocks));

@override
String toString() {
  return 'StoryChapterDto(id: $id, title: $title, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$StoryChapterDtoCopyWith<$Res> implements $StoryChapterDtoCopyWith<$Res> {
  factory _$StoryChapterDtoCopyWith(_StoryChapterDto value, $Res Function(_StoryChapterDto) _then) = __$StoryChapterDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto title, List<ContentBlockDto> blocks
});


@override $LocalizedTextDtoCopyWith<$Res> get title;

}
/// @nodoc
class __$StoryChapterDtoCopyWithImpl<$Res>
    implements _$StoryChapterDtoCopyWith<$Res> {
  __$StoryChapterDtoCopyWithImpl(this._self, this._then);

  final _StoryChapterDto _self;
  final $Res Function(_StoryChapterDto) _then;

/// Create a copy of StoryChapterDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? blocks = null,}) {
  return _then(_StoryChapterDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,
  ));
}

/// Create a copy of StoryChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// @nodoc
mixin _$StoryDto {

 int get schemaVersion; String get id; LocalizedTextDto get title; LocalizedTextDto get synopsis; List<String> get companionIds; int get readingMinutes; List<StoryChapterDto> get chapters; ReviewDto get review; List<String> get eventIds;
/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryDtoCopyWith<StoryDto> get copyWith => _$StoryDtoCopyWithImpl<StoryDto>(this as StoryDto, _$identity);

  /// Serializes this StoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.eventIds, eventIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,synopsis,const DeepCollectionEquality().hash(companionIds),readingMinutes,const DeepCollectionEquality().hash(chapters),review,const DeepCollectionEquality().hash(eventIds));

@override
String toString() {
  return 'StoryDto(schemaVersion: $schemaVersion, id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, chapters: $chapters, review: $review, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class $StoryDtoCopyWith<$Res>  {
  factory $StoryDtoCopyWith(StoryDto value, $Res Function(StoryDto) _then) = _$StoryDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto synopsis, List<String> companionIds, int readingMinutes, List<StoryChapterDto> chapters, ReviewDto review, List<String> eventIds
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get synopsis;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$StoryDtoCopyWithImpl<$Res>
    implements $StoryDtoCopyWith<$Res> {
  _$StoryDtoCopyWithImpl(this._self, this._then);

  final StoryDto _self;
  final $Res Function(StoryDto) _then;

/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? chapters = null,Object? review = null,Object? eventIds = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<StoryChapterDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get synopsis {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [StoryDto].
extension StoryDtoPatterns on StoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryDto value)  $default,){
final _that = this;
switch (_that) {
case _StoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _StoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto synopsis,  List<String> companionIds,  int readingMinutes,  List<StoryChapterDto> chapters,  ReviewDto review,  List<String> eventIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.chapters,_that.review,_that.eventIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto synopsis,  List<String> companionIds,  int readingMinutes,  List<StoryChapterDto> chapters,  ReviewDto review,  List<String> eventIds)  $default,) {final _that = this;
switch (_that) {
case _StoryDto():
return $default(_that.schemaVersion,_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.chapters,_that.review,_that.eventIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto synopsis,  List<String> companionIds,  int readingMinutes,  List<StoryChapterDto> chapters,  ReviewDto review,  List<String> eventIds)?  $default,) {final _that = this;
switch (_that) {
case _StoryDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.chapters,_that.review,_that.eventIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryDto implements StoryDto {
  const _StoryDto({required this.schemaVersion, required this.id, required this.title, required this.synopsis, required final  List<String> companionIds, required this.readingMinutes, required final  List<StoryChapterDto> chapters, required this.review, final  List<String> eventIds = const <String>[]}): _companionIds = companionIds,_chapters = chapters,_eventIds = eventIds;
  factory _StoryDto.fromJson(Map<String, dynamic> json) => _$StoryDtoFromJson(json);

@override final  int schemaVersion;
@override final  String id;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto synopsis;
 final  List<String> _companionIds;
@override List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}

@override final  int readingMinutes;
 final  List<StoryChapterDto> _chapters;
@override List<StoryChapterDto> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

@override final  ReviewDto review;
 final  List<String> _eventIds;
@override@JsonKey() List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}


/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryDtoCopyWith<_StoryDto> get copyWith => __$StoryDtoCopyWithImpl<_StoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,synopsis,const DeepCollectionEquality().hash(_companionIds),readingMinutes,const DeepCollectionEquality().hash(_chapters),review,const DeepCollectionEquality().hash(_eventIds));

@override
String toString() {
  return 'StoryDto(schemaVersion: $schemaVersion, id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, chapters: $chapters, review: $review, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class _$StoryDtoCopyWith<$Res> implements $StoryDtoCopyWith<$Res> {
  factory _$StoryDtoCopyWith(_StoryDto value, $Res Function(_StoryDto) _then) = __$StoryDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto synopsis, List<String> companionIds, int readingMinutes, List<StoryChapterDto> chapters, ReviewDto review, List<String> eventIds
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get synopsis;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$StoryDtoCopyWithImpl<$Res>
    implements _$StoryDtoCopyWith<$Res> {
  __$StoryDtoCopyWithImpl(this._self, this._then);

  final _StoryDto _self;
  final $Res Function(_StoryDto) _then;

/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? chapters = null,Object? review = null,Object? eventIds = null,}) {
  return _then(_StoryDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<StoryChapterDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get synopsis {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of StoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// @nodoc
mixin _$StorySummaryDto {

 String get id; LocalizedTextDto get title; LocalizedTextDto get synopsis; List<String> get companionIds; int get readingMinutes; ReviewDto get review;
/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorySummaryDtoCopyWith<StorySummaryDto> get copyWith => _$StorySummaryDtoCopyWithImpl<StorySummaryDto>(this as StorySummaryDto, _$identity);

  /// Serializes this StorySummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorySummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,synopsis,const DeepCollectionEquality().hash(companionIds),readingMinutes,review);

@override
String toString() {
  return 'StorySummaryDto(id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, review: $review)';
}


}

/// @nodoc
abstract mixin class $StorySummaryDtoCopyWith<$Res>  {
  factory $StorySummaryDtoCopyWith(StorySummaryDto value, $Res Function(StorySummaryDto) _then) = _$StorySummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto title, LocalizedTextDto synopsis, List<String> companionIds, int readingMinutes, ReviewDto review
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get synopsis;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$StorySummaryDtoCopyWithImpl<$Res>
    implements $StorySummaryDtoCopyWith<$Res> {
  _$StorySummaryDtoCopyWithImpl(this._self, this._then);

  final StorySummaryDto _self;
  final $Res Function(StorySummaryDto) _then;

/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? review = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,
  ));
}
/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get synopsis {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [StorySummaryDto].
extension StorySummaryDtoPatterns on StorySummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorySummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorySummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorySummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _StorySummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorySummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _StorySummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  LocalizedTextDto synopsis,  List<String> companionIds,  int readingMinutes,  ReviewDto review)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorySummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.review);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  LocalizedTextDto synopsis,  List<String> companionIds,  int readingMinutes,  ReviewDto review)  $default,) {final _that = this;
switch (_that) {
case _StorySummaryDto():
return $default(_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.review);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto title,  LocalizedTextDto synopsis,  List<String> companionIds,  int readingMinutes,  ReviewDto review)?  $default,) {final _that = this;
switch (_that) {
case _StorySummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.review);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StorySummaryDto implements StorySummaryDto {
  const _StorySummaryDto({required this.id, required this.title, required this.synopsis, required final  List<String> companionIds, required this.readingMinutes, required this.review}): _companionIds = companionIds;
  factory _StorySummaryDto.fromJson(Map<String, dynamic> json) => _$StorySummaryDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto synopsis;
 final  List<String> _companionIds;
@override List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}

@override final  int readingMinutes;
@override final  ReviewDto review;

/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorySummaryDtoCopyWith<_StorySummaryDto> get copyWith => __$StorySummaryDtoCopyWithImpl<_StorySummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorySummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorySummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,synopsis,const DeepCollectionEquality().hash(_companionIds),readingMinutes,review);

@override
String toString() {
  return 'StorySummaryDto(id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, review: $review)';
}


}

/// @nodoc
abstract mixin class _$StorySummaryDtoCopyWith<$Res> implements $StorySummaryDtoCopyWith<$Res> {
  factory _$StorySummaryDtoCopyWith(_StorySummaryDto value, $Res Function(_StorySummaryDto) _then) = __$StorySummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto title, LocalizedTextDto synopsis, List<String> companionIds, int readingMinutes, ReviewDto review
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get synopsis;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$StorySummaryDtoCopyWithImpl<$Res>
    implements _$StorySummaryDtoCopyWith<$Res> {
  __$StorySummaryDtoCopyWithImpl(this._self, this._then);

  final _StorySummaryDto _self;
  final $Res Function(_StorySummaryDto) _then;

/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? review = null,}) {
  return _then(_StorySummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,
  ));
}

/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get synopsis {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of StorySummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// @nodoc
mixin _$StoryIndexDto {

 int get schemaVersion; List<StorySummaryDto> get stories;
/// Create a copy of StoryIndexDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryIndexDtoCopyWith<StoryIndexDto> get copyWith => _$StoryIndexDtoCopyWithImpl<StoryIndexDto>(this as StoryIndexDto, _$identity);

  /// Serializes this StoryIndexDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryIndexDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.stories, stories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(stories));

@override
String toString() {
  return 'StoryIndexDto(schemaVersion: $schemaVersion, stories: $stories)';
}


}

/// @nodoc
abstract mixin class $StoryIndexDtoCopyWith<$Res>  {
  factory $StoryIndexDtoCopyWith(StoryIndexDto value, $Res Function(StoryIndexDto) _then) = _$StoryIndexDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<StorySummaryDto> stories
});




}
/// @nodoc
class _$StoryIndexDtoCopyWithImpl<$Res>
    implements $StoryIndexDtoCopyWith<$Res> {
  _$StoryIndexDtoCopyWithImpl(this._self, this._then);

  final StoryIndexDto _self;
  final $Res Function(StoryIndexDto) _then;

/// Create a copy of StoryIndexDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? stories = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,stories: null == stories ? _self.stories : stories // ignore: cast_nullable_to_non_nullable
as List<StorySummaryDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [StoryIndexDto].
extension StoryIndexDtoPatterns on StoryIndexDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryIndexDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryIndexDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryIndexDto value)  $default,){
final _that = this;
switch (_that) {
case _StoryIndexDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryIndexDto value)?  $default,){
final _that = this;
switch (_that) {
case _StoryIndexDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<StorySummaryDto> stories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryIndexDto() when $default != null:
return $default(_that.schemaVersion,_that.stories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<StorySummaryDto> stories)  $default,) {final _that = this;
switch (_that) {
case _StoryIndexDto():
return $default(_that.schemaVersion,_that.stories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<StorySummaryDto> stories)?  $default,) {final _that = this;
switch (_that) {
case _StoryIndexDto() when $default != null:
return $default(_that.schemaVersion,_that.stories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StoryIndexDto implements StoryIndexDto {
  const _StoryIndexDto({required this.schemaVersion, required final  List<StorySummaryDto> stories}): _stories = stories;
  factory _StoryIndexDto.fromJson(Map<String, dynamic> json) => _$StoryIndexDtoFromJson(json);

@override final  int schemaVersion;
 final  List<StorySummaryDto> _stories;
@override List<StorySummaryDto> get stories {
  if (_stories is EqualUnmodifiableListView) return _stories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stories);
}


/// Create a copy of StoryIndexDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryIndexDtoCopyWith<_StoryIndexDto> get copyWith => __$StoryIndexDtoCopyWithImpl<_StoryIndexDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StoryIndexDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryIndexDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._stories, _stories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_stories));

@override
String toString() {
  return 'StoryIndexDto(schemaVersion: $schemaVersion, stories: $stories)';
}


}

/// @nodoc
abstract mixin class _$StoryIndexDtoCopyWith<$Res> implements $StoryIndexDtoCopyWith<$Res> {
  factory _$StoryIndexDtoCopyWith(_StoryIndexDto value, $Res Function(_StoryIndexDto) _then) = __$StoryIndexDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<StorySummaryDto> stories
});




}
/// @nodoc
class __$StoryIndexDtoCopyWithImpl<$Res>
    implements _$StoryIndexDtoCopyWith<$Res> {
  __$StoryIndexDtoCopyWithImpl(this._self, this._then);

  final _StoryIndexDto _self;
  final $Res Function(_StoryIndexDto) _then;

/// Create a copy of StoryIndexDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? stories = null,}) {
  return _then(_StoryIndexDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,stories: null == stories ? _self._stories : stories // ignore: cast_nullable_to_non_nullable
as List<StorySummaryDto>,
  ));
}


}

// dart format on
