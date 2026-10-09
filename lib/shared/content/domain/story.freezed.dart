// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StoryChapter {

 String get id; LocalizedText get title; List<ContentBlock> get blocks;/// Fingerprint of the chapter's content; changes whenever it is edited.
 String get revision;
/// Create a copy of StoryChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryChapterCopyWith<StoryChapter> get copyWith => _$StoryChapterCopyWithImpl<StoryChapter>(this as StoryChapter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(blocks),revision);

@override
String toString() {
  return 'StoryChapter(id: $id, title: $title, blocks: $blocks, revision: $revision)';
}


}

/// @nodoc
abstract mixin class $StoryChapterCopyWith<$Res>  {
  factory $StoryChapterCopyWith(StoryChapter value, $Res Function(StoryChapter) _then) = _$StoryChapterCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText title, List<ContentBlock> blocks, String revision
});


$LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class _$StoryChapterCopyWithImpl<$Res>
    implements $StoryChapterCopyWith<$Res> {
  _$StoryChapterCopyWithImpl(this._self, this._then);

  final StoryChapter _self;
  final $Res Function(StoryChapter) _then;

/// Create a copy of StoryChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? blocks = null,Object? revision = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of StoryChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [StoryChapter].
extension StoryChapterPatterns on StoryChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StoryChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StoryChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StoryChapter value)  $default,){
final _that = this;
switch (_that) {
case _StoryChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StoryChapter value)?  $default,){
final _that = this;
switch (_that) {
case _StoryChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  List<ContentBlock> blocks,  String revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StoryChapter() when $default != null:
return $default(_that.id,_that.title,_that.blocks,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  List<ContentBlock> blocks,  String revision)  $default,) {final _that = this;
switch (_that) {
case _StoryChapter():
return $default(_that.id,_that.title,_that.blocks,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText title,  List<ContentBlock> blocks,  String revision)?  $default,) {final _that = this;
switch (_that) {
case _StoryChapter() when $default != null:
return $default(_that.id,_that.title,_that.blocks,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _StoryChapter implements StoryChapter {
  const _StoryChapter({required this.id, required this.title, required final  List<ContentBlock> blocks, required this.revision}): _blocks = blocks;
  

@override final  String id;
@override final  LocalizedText title;
 final  List<ContentBlock> _blocks;
@override List<ContentBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

/// Fingerprint of the chapter's content; changes whenever it is edited.
@override final  String revision;

/// Create a copy of StoryChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryChapterCopyWith<_StoryChapter> get copyWith => __$StoryChapterCopyWithImpl<_StoryChapter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StoryChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_blocks),revision);

@override
String toString() {
  return 'StoryChapter(id: $id, title: $title, blocks: $blocks, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$StoryChapterCopyWith<$Res> implements $StoryChapterCopyWith<$Res> {
  factory _$StoryChapterCopyWith(_StoryChapter value, $Res Function(_StoryChapter) _then) = __$StoryChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText title, List<ContentBlock> blocks, String revision
});


@override $LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class __$StoryChapterCopyWithImpl<$Res>
    implements _$StoryChapterCopyWith<$Res> {
  __$StoryChapterCopyWithImpl(this._self, this._then);

  final _StoryChapter _self;
  final $Res Function(_StoryChapter) _then;

/// Create a copy of StoryChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? blocks = null,Object? revision = null,}) {
  return _then(_StoryChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of StoryChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}

/// @nodoc
mixin _$StorySummary {

 String get id; LocalizedText get title; LocalizedText get synopsis; List<String> get companionIds; int get readingMinutes; ReviewInfo get review;
/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorySummaryCopyWith<StorySummary> get copyWith => _$StorySummaryCopyWithImpl<StorySummary>(this as StorySummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorySummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&(identical(other.review, review) || other.review == review));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,synopsis,const DeepCollectionEquality().hash(companionIds),readingMinutes,review);

@override
String toString() {
  return 'StorySummary(id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, review: $review)';
}


}

/// @nodoc
abstract mixin class $StorySummaryCopyWith<$Res>  {
  factory $StorySummaryCopyWith(StorySummary value, $Res Function(StorySummary) _then) = _$StorySummaryCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText title, LocalizedText synopsis, List<String> companionIds, int readingMinutes, ReviewInfo review
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get synopsis;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$StorySummaryCopyWithImpl<$Res>
    implements $StorySummaryCopyWith<$Res> {
  _$StorySummaryCopyWithImpl(this._self, this._then);

  final StorySummary _self;
  final $Res Function(StorySummary) _then;

/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? review = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedText,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,
  ));
}
/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get synopsis {
  
  return $LocalizedTextCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [StorySummary].
extension StorySummaryPatterns on StorySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorySummary value)  $default,){
final _that = this;
switch (_that) {
case _StorySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorySummary value)?  $default,){
final _that = this;
switch (_that) {
case _StorySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  LocalizedText synopsis,  List<String> companionIds,  int readingMinutes,  ReviewInfo review)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorySummary() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  LocalizedText synopsis,  List<String> companionIds,  int readingMinutes,  ReviewInfo review)  $default,) {final _that = this;
switch (_that) {
case _StorySummary():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText title,  LocalizedText synopsis,  List<String> companionIds,  int readingMinutes,  ReviewInfo review)?  $default,) {final _that = this;
switch (_that) {
case _StorySummary() when $default != null:
return $default(_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.review);case _:
  return null;

}
}

}

/// @nodoc


class _StorySummary implements StorySummary {
  const _StorySummary({required this.id, required this.title, required this.synopsis, required final  List<String> companionIds, required this.readingMinutes, required this.review}): _companionIds = companionIds;
  

@override final  String id;
@override final  LocalizedText title;
@override final  LocalizedText synopsis;
 final  List<String> _companionIds;
@override List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}

@override final  int readingMinutes;
@override final  ReviewInfo review;

/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorySummaryCopyWith<_StorySummary> get copyWith => __$StorySummaryCopyWithImpl<_StorySummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorySummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&(identical(other.review, review) || other.review == review));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,synopsis,const DeepCollectionEquality().hash(_companionIds),readingMinutes,review);

@override
String toString() {
  return 'StorySummary(id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, review: $review)';
}


}

/// @nodoc
abstract mixin class _$StorySummaryCopyWith<$Res> implements $StorySummaryCopyWith<$Res> {
  factory _$StorySummaryCopyWith(_StorySummary value, $Res Function(_StorySummary) _then) = __$StorySummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText title, LocalizedText synopsis, List<String> companionIds, int readingMinutes, ReviewInfo review
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get synopsis;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$StorySummaryCopyWithImpl<$Res>
    implements _$StorySummaryCopyWith<$Res> {
  __$StorySummaryCopyWithImpl(this._self, this._then);

  final _StorySummary _self;
  final $Res Function(_StorySummary) _then;

/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? review = null,}) {
  return _then(_StorySummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedText,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,
  ));
}

/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get synopsis {
  
  return $LocalizedTextCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of StorySummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

/// @nodoc
mixin _$Story {

 String get id; LocalizedText get title; LocalizedText get synopsis; List<String> get companionIds; int get readingMinutes; List<StoryChapter> get chapters; ReviewInfo get review; List<String> get eventIds;
/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryCopyWith<Story> get copyWith => _$StoryCopyWithImpl<Story>(this as Story, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Story&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.eventIds, eventIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,synopsis,const DeepCollectionEquality().hash(companionIds),readingMinutes,const DeepCollectionEquality().hash(chapters),review,const DeepCollectionEquality().hash(eventIds));

@override
String toString() {
  return 'Story(id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, chapters: $chapters, review: $review, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class $StoryCopyWith<$Res>  {
  factory $StoryCopyWith(Story value, $Res Function(Story) _then) = _$StoryCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText title, LocalizedText synopsis, List<String> companionIds, int readingMinutes, List<StoryChapter> chapters, ReviewInfo review, List<String> eventIds
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get synopsis;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$StoryCopyWithImpl<$Res>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._self, this._then);

  final Story _self;
  final $Res Function(Story) _then;

/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? chapters = null,Object? review = null,Object? eventIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedText,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<StoryChapter>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get synopsis {
  
  return $LocalizedTextCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [Story].
extension StoryPatterns on Story {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Story value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Story() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Story value)  $default,){
final _that = this;
switch (_that) {
case _Story():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Story value)?  $default,){
final _that = this;
switch (_that) {
case _Story() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  LocalizedText synopsis,  List<String> companionIds,  int readingMinutes,  List<StoryChapter> chapters,  ReviewInfo review,  List<String> eventIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Story() when $default != null:
return $default(_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.chapters,_that.review,_that.eventIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText title,  LocalizedText synopsis,  List<String> companionIds,  int readingMinutes,  List<StoryChapter> chapters,  ReviewInfo review,  List<String> eventIds)  $default,) {final _that = this;
switch (_that) {
case _Story():
return $default(_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.chapters,_that.review,_that.eventIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText title,  LocalizedText synopsis,  List<String> companionIds,  int readingMinutes,  List<StoryChapter> chapters,  ReviewInfo review,  List<String> eventIds)?  $default,) {final _that = this;
switch (_that) {
case _Story() when $default != null:
return $default(_that.id,_that.title,_that.synopsis,_that.companionIds,_that.readingMinutes,_that.chapters,_that.review,_that.eventIds);case _:
  return null;

}
}

}

/// @nodoc


class _Story implements Story {
  const _Story({required this.id, required this.title, required this.synopsis, required final  List<String> companionIds, required this.readingMinutes, required final  List<StoryChapter> chapters, required this.review, final  List<String> eventIds = const <String>[]}): _companionIds = companionIds,_chapters = chapters,_eventIds = eventIds;
  

@override final  String id;
@override final  LocalizedText title;
@override final  LocalizedText synopsis;
 final  List<String> _companionIds;
@override List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}

@override final  int readingMinutes;
 final  List<StoryChapter> _chapters;
@override List<StoryChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

@override final  ReviewInfo review;
 final  List<String> _eventIds;
@override@JsonKey() List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}


/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StoryCopyWith<_Story> get copyWith => __$StoryCopyWithImpl<_Story>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Story&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.synopsis, synopsis) || other.synopsis == synopsis)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&(identical(other.readingMinutes, readingMinutes) || other.readingMinutes == readingMinutes)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,synopsis,const DeepCollectionEquality().hash(_companionIds),readingMinutes,const DeepCollectionEquality().hash(_chapters),review,const DeepCollectionEquality().hash(_eventIds));

@override
String toString() {
  return 'Story(id: $id, title: $title, synopsis: $synopsis, companionIds: $companionIds, readingMinutes: $readingMinutes, chapters: $chapters, review: $review, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class _$StoryCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$StoryCopyWith(_Story value, $Res Function(_Story) _then) = __$StoryCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText title, LocalizedText synopsis, List<String> companionIds, int readingMinutes, List<StoryChapter> chapters, ReviewInfo review, List<String> eventIds
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get synopsis;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$StoryCopyWithImpl<$Res>
    implements _$StoryCopyWith<$Res> {
  __$StoryCopyWithImpl(this._self, this._then);

  final _Story _self;
  final $Res Function(_Story) _then;

/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? synopsis = null,Object? companionIds = null,Object? readingMinutes = null,Object? chapters = null,Object? review = null,Object? eventIds = null,}) {
  return _then(_Story(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,synopsis: null == synopsis ? _self.synopsis : synopsis // ignore: cast_nullable_to_non_nullable
as LocalizedText,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingMinutes: null == readingMinutes ? _self.readingMinutes : readingMinutes // ignore: cast_nullable_to_non_nullable
as int,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<StoryChapter>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get synopsis {
  
  return $LocalizedTextCopyWith<$Res>(_self.synopsis, (value) {
    return _then(_self.copyWith(synopsis: value));
  });
}/// Create a copy of Story
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

// dart format on
