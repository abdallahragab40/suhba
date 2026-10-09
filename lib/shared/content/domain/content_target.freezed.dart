// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContentTarget {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentTarget);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContentTarget()';
}


}

/// @nodoc
class $ContentTargetCopyWith<$Res>  {
$ContentTargetCopyWith(ContentTarget _, $Res Function(ContentTarget) __);
}


/// Adds pattern-matching-related methods to [ContentTarget].
extension ContentTargetPatterns on ContentTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CompanionTarget value)?  companion,TResult Function( SectionTarget value)?  section,TResult Function( StoryTarget value)?  story,TResult Function( ChapterTarget value)?  chapter,TResult Function( SeerahChapterTarget value)?  seerahChapter,TResult Function( SeerahTopicTarget value)?  seerahTopic,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CompanionTarget() when companion != null:
return companion(_that);case SectionTarget() when section != null:
return section(_that);case StoryTarget() when story != null:
return story(_that);case ChapterTarget() when chapter != null:
return chapter(_that);case SeerahChapterTarget() when seerahChapter != null:
return seerahChapter(_that);case SeerahTopicTarget() when seerahTopic != null:
return seerahTopic(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CompanionTarget value)  companion,required TResult Function( SectionTarget value)  section,required TResult Function( StoryTarget value)  story,required TResult Function( ChapterTarget value)  chapter,required TResult Function( SeerahChapterTarget value)  seerahChapter,required TResult Function( SeerahTopicTarget value)  seerahTopic,}){
final _that = this;
switch (_that) {
case CompanionTarget():
return companion(_that);case SectionTarget():
return section(_that);case StoryTarget():
return story(_that);case ChapterTarget():
return chapter(_that);case SeerahChapterTarget():
return seerahChapter(_that);case SeerahTopicTarget():
return seerahTopic(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CompanionTarget value)?  companion,TResult? Function( SectionTarget value)?  section,TResult? Function( StoryTarget value)?  story,TResult? Function( ChapterTarget value)?  chapter,TResult? Function( SeerahChapterTarget value)?  seerahChapter,TResult? Function( SeerahTopicTarget value)?  seerahTopic,}){
final _that = this;
switch (_that) {
case CompanionTarget() when companion != null:
return companion(_that);case SectionTarget() when section != null:
return section(_that);case StoryTarget() when story != null:
return story(_that);case ChapterTarget() when chapter != null:
return chapter(_that);case SeerahChapterTarget() when seerahChapter != null:
return seerahChapter(_that);case SeerahTopicTarget() when seerahTopic != null:
return seerahTopic(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id)?  companion,TResult Function( String companionId,  String sectionId)?  section,TResult Function( String id)?  story,TResult Function( String storyId,  String chapterId)?  chapter,TResult Function( String id)?  seerahChapter,TResult Function( String id)?  seerahTopic,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CompanionTarget() when companion != null:
return companion(_that.id);case SectionTarget() when section != null:
return section(_that.companionId,_that.sectionId);case StoryTarget() when story != null:
return story(_that.id);case ChapterTarget() when chapter != null:
return chapter(_that.storyId,_that.chapterId);case SeerahChapterTarget() when seerahChapter != null:
return seerahChapter(_that.id);case SeerahTopicTarget() when seerahTopic != null:
return seerahTopic(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id)  companion,required TResult Function( String companionId,  String sectionId)  section,required TResult Function( String id)  story,required TResult Function( String storyId,  String chapterId)  chapter,required TResult Function( String id)  seerahChapter,required TResult Function( String id)  seerahTopic,}) {final _that = this;
switch (_that) {
case CompanionTarget():
return companion(_that.id);case SectionTarget():
return section(_that.companionId,_that.sectionId);case StoryTarget():
return story(_that.id);case ChapterTarget():
return chapter(_that.storyId,_that.chapterId);case SeerahChapterTarget():
return seerahChapter(_that.id);case SeerahTopicTarget():
return seerahTopic(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id)?  companion,TResult? Function( String companionId,  String sectionId)?  section,TResult? Function( String id)?  story,TResult? Function( String storyId,  String chapterId)?  chapter,TResult? Function( String id)?  seerahChapter,TResult? Function( String id)?  seerahTopic,}) {final _that = this;
switch (_that) {
case CompanionTarget() when companion != null:
return companion(_that.id);case SectionTarget() when section != null:
return section(_that.companionId,_that.sectionId);case StoryTarget() when story != null:
return story(_that.id);case ChapterTarget() when chapter != null:
return chapter(_that.storyId,_that.chapterId);case SeerahChapterTarget() when seerahChapter != null:
return seerahChapter(_that.id);case SeerahTopicTarget() when seerahTopic != null:
return seerahTopic(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class CompanionTarget implements ContentTarget {
  const CompanionTarget(this.id);
  

 final  String id;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanionTargetCopyWith<CompanionTarget> get copyWith => _$CompanionTargetCopyWithImpl<CompanionTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanionTarget&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContentTarget.companion(id: $id)';
}


}

/// @nodoc
abstract mixin class $CompanionTargetCopyWith<$Res> implements $ContentTargetCopyWith<$Res> {
  factory $CompanionTargetCopyWith(CompanionTarget value, $Res Function(CompanionTarget) _then) = _$CompanionTargetCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$CompanionTargetCopyWithImpl<$Res>
    implements $CompanionTargetCopyWith<$Res> {
  _$CompanionTargetCopyWithImpl(this._self, this._then);

  final CompanionTarget _self;
  final $Res Function(CompanionTarget) _then;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(CompanionTarget(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SectionTarget implements ContentTarget {
  const SectionTarget(this.companionId, this.sectionId);
  

 final  String companionId;
 final  String sectionId;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SectionTargetCopyWith<SectionTarget> get copyWith => _$SectionTargetCopyWithImpl<SectionTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SectionTarget&&(identical(other.companionId, companionId) || other.companionId == companionId)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId));
}


@override
int get hashCode => Object.hash(runtimeType,companionId,sectionId);

@override
String toString() {
  return 'ContentTarget.section(companionId: $companionId, sectionId: $sectionId)';
}


}

/// @nodoc
abstract mixin class $SectionTargetCopyWith<$Res> implements $ContentTargetCopyWith<$Res> {
  factory $SectionTargetCopyWith(SectionTarget value, $Res Function(SectionTarget) _then) = _$SectionTargetCopyWithImpl;
@useResult
$Res call({
 String companionId, String sectionId
});




}
/// @nodoc
class _$SectionTargetCopyWithImpl<$Res>
    implements $SectionTargetCopyWith<$Res> {
  _$SectionTargetCopyWithImpl(this._self, this._then);

  final SectionTarget _self;
  final $Res Function(SectionTarget) _then;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? companionId = null,Object? sectionId = null,}) {
  return _then(SectionTarget(
null == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String,null == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class StoryTarget implements ContentTarget {
  const StoryTarget(this.id);
  

 final  String id;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StoryTargetCopyWith<StoryTarget> get copyWith => _$StoryTargetCopyWithImpl<StoryTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StoryTarget&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContentTarget.story(id: $id)';
}


}

/// @nodoc
abstract mixin class $StoryTargetCopyWith<$Res> implements $ContentTargetCopyWith<$Res> {
  factory $StoryTargetCopyWith(StoryTarget value, $Res Function(StoryTarget) _then) = _$StoryTargetCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$StoryTargetCopyWithImpl<$Res>
    implements $StoryTargetCopyWith<$Res> {
  _$StoryTargetCopyWithImpl(this._self, this._then);

  final StoryTarget _self;
  final $Res Function(StoryTarget) _then;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(StoryTarget(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChapterTarget implements ContentTarget {
  const ChapterTarget(this.storyId, this.chapterId);
  

 final  String storyId;
 final  String chapterId;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterTargetCopyWith<ChapterTarget> get copyWith => _$ChapterTargetCopyWithImpl<ChapterTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterTarget&&(identical(other.storyId, storyId) || other.storyId == storyId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId));
}


@override
int get hashCode => Object.hash(runtimeType,storyId,chapterId);

@override
String toString() {
  return 'ContentTarget.chapter(storyId: $storyId, chapterId: $chapterId)';
}


}

/// @nodoc
abstract mixin class $ChapterTargetCopyWith<$Res> implements $ContentTargetCopyWith<$Res> {
  factory $ChapterTargetCopyWith(ChapterTarget value, $Res Function(ChapterTarget) _then) = _$ChapterTargetCopyWithImpl;
@useResult
$Res call({
 String storyId, String chapterId
});




}
/// @nodoc
class _$ChapterTargetCopyWithImpl<$Res>
    implements $ChapterTargetCopyWith<$Res> {
  _$ChapterTargetCopyWithImpl(this._self, this._then);

  final ChapterTarget _self;
  final $Res Function(ChapterTarget) _then;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? storyId = null,Object? chapterId = null,}) {
  return _then(ChapterTarget(
null == storyId ? _self.storyId : storyId // ignore: cast_nullable_to_non_nullable
as String,null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SeerahChapterTarget implements ContentTarget {
  const SeerahChapterTarget(this.id);
  

 final  String id;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahChapterTargetCopyWith<SeerahChapterTarget> get copyWith => _$SeerahChapterTargetCopyWithImpl<SeerahChapterTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahChapterTarget&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContentTarget.seerahChapter(id: $id)';
}


}

/// @nodoc
abstract mixin class $SeerahChapterTargetCopyWith<$Res> implements $ContentTargetCopyWith<$Res> {
  factory $SeerahChapterTargetCopyWith(SeerahChapterTarget value, $Res Function(SeerahChapterTarget) _then) = _$SeerahChapterTargetCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$SeerahChapterTargetCopyWithImpl<$Res>
    implements $SeerahChapterTargetCopyWith<$Res> {
  _$SeerahChapterTargetCopyWithImpl(this._self, this._then);

  final SeerahChapterTarget _self;
  final $Res Function(SeerahChapterTarget) _then;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(SeerahChapterTarget(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SeerahTopicTarget implements ContentTarget {
  const SeerahTopicTarget(this.id);
  

 final  String id;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahTopicTargetCopyWith<SeerahTopicTarget> get copyWith => _$SeerahTopicTargetCopyWithImpl<SeerahTopicTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahTopicTarget&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContentTarget.seerahTopic(id: $id)';
}


}

/// @nodoc
abstract mixin class $SeerahTopicTargetCopyWith<$Res> implements $ContentTargetCopyWith<$Res> {
  factory $SeerahTopicTargetCopyWith(SeerahTopicTarget value, $Res Function(SeerahTopicTarget) _then) = _$SeerahTopicTargetCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$SeerahTopicTargetCopyWithImpl<$Res>
    implements $SeerahTopicTargetCopyWith<$Res> {
  _$SeerahTopicTargetCopyWithImpl(this._self, this._then);

  final SeerahTopicTarget _self;
  final $Res Function(SeerahTopicTarget) _then;

/// Create a copy of ContentTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(SeerahTopicTarget(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
