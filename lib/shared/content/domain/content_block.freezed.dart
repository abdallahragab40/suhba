// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Opinion {

 LocalizedText get text; List<Citation> get citations;
/// Create a copy of Opinion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpinionCopyWith<Opinion> get copyWith => _$OpinionCopyWithImpl<Opinion>(this as Opinion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Opinion&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.citations, citations));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'Opinion(text: $text, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $OpinionCopyWith<$Res>  {
  factory $OpinionCopyWith(Opinion value, $Res Function(Opinion) _then) = _$OpinionCopyWithImpl;
@useResult
$Res call({
 LocalizedText text, List<Citation> citations
});


$LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class _$OpinionCopyWithImpl<$Res>
    implements $OpinionCopyWith<$Res> {
  _$OpinionCopyWithImpl(this._self, this._then);

  final Opinion _self;
  final $Res Function(Opinion) _then;

/// Create a copy of Opinion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? citations = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}
/// Create a copy of Opinion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get text {
  
  return $LocalizedTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}


/// Adds pattern-matching-related methods to [Opinion].
extension OpinionPatterns on Opinion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Opinion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Opinion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Opinion value)  $default,){
final _that = this;
switch (_that) {
case _Opinion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Opinion value)?  $default,){
final _that = this;
switch (_that) {
case _Opinion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedText text,  List<Citation> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Opinion() when $default != null:
return $default(_that.text,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedText text,  List<Citation> citations)  $default,) {final _that = this;
switch (_that) {
case _Opinion():
return $default(_that.text,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedText text,  List<Citation> citations)?  $default,) {final _that = this;
switch (_that) {
case _Opinion() when $default != null:
return $default(_that.text,_that.citations);case _:
  return null;

}
}

}

/// @nodoc


class _Opinion implements Opinion {
  const _Opinion({required this.text, required final  List<Citation> citations}): _citations = citations;
  

@override final  LocalizedText text;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of Opinion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpinionCopyWith<_Opinion> get copyWith => __$OpinionCopyWithImpl<_Opinion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Opinion&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._citations, _citations));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'Opinion(text: $text, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$OpinionCopyWith<$Res> implements $OpinionCopyWith<$Res> {
  factory _$OpinionCopyWith(_Opinion value, $Res Function(_Opinion) _then) = __$OpinionCopyWithImpl;
@override @useResult
$Res call({
 LocalizedText text, List<Citation> citations
});


@override $LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class __$OpinionCopyWithImpl<$Res>
    implements _$OpinionCopyWith<$Res> {
  __$OpinionCopyWithImpl(this._self, this._then);

  final _Opinion _self;
  final $Res Function(_Opinion) _then;

/// Create a copy of Opinion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? citations = null,}) {
  return _then(_Opinion(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}

/// Create a copy of Opinion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get text {
  
  return $LocalizedTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

/// @nodoc
mixin _$ContentBlock {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentBlock);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContentBlock()';
}


}

/// @nodoc
class $ContentBlockCopyWith<$Res>  {
$ContentBlockCopyWith(ContentBlock _, $Res Function(ContentBlock) __);
}


/// Adds pattern-matching-related methods to [ContentBlock].
extension ContentBlockPatterns on ContentBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ParagraphBlock value)?  paragraph,TResult Function( LessonBlock value)?  lesson,TResult Function( QuranQuoteBlock value)?  quranQuote,TResult Function( HadithQuoteBlock value)?  hadithQuote,TResult Function( ReportQuoteBlock value)?  reportQuote,TResult Function( DisputeNoteBlock value)?  disputeNote,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ParagraphBlock() when paragraph != null:
return paragraph(_that);case LessonBlock() when lesson != null:
return lesson(_that);case QuranQuoteBlock() when quranQuote != null:
return quranQuote(_that);case HadithQuoteBlock() when hadithQuote != null:
return hadithQuote(_that);case ReportQuoteBlock() when reportQuote != null:
return reportQuote(_that);case DisputeNoteBlock() when disputeNote != null:
return disputeNote(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ParagraphBlock value)  paragraph,required TResult Function( LessonBlock value)  lesson,required TResult Function( QuranQuoteBlock value)  quranQuote,required TResult Function( HadithQuoteBlock value)  hadithQuote,required TResult Function( ReportQuoteBlock value)  reportQuote,required TResult Function( DisputeNoteBlock value)  disputeNote,}){
final _that = this;
switch (_that) {
case ParagraphBlock():
return paragraph(_that);case LessonBlock():
return lesson(_that);case QuranQuoteBlock():
return quranQuote(_that);case HadithQuoteBlock():
return hadithQuote(_that);case ReportQuoteBlock():
return reportQuote(_that);case DisputeNoteBlock():
return disputeNote(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ParagraphBlock value)?  paragraph,TResult? Function( LessonBlock value)?  lesson,TResult? Function( QuranQuoteBlock value)?  quranQuote,TResult? Function( HadithQuoteBlock value)?  hadithQuote,TResult? Function( ReportQuoteBlock value)?  reportQuote,TResult? Function( DisputeNoteBlock value)?  disputeNote,}){
final _that = this;
switch (_that) {
case ParagraphBlock() when paragraph != null:
return paragraph(_that);case LessonBlock() when lesson != null:
return lesson(_that);case QuranQuoteBlock() when quranQuote != null:
return quranQuote(_that);case HadithQuoteBlock() when hadithQuote != null:
return hadithQuote(_that);case ReportQuoteBlock() when reportQuote != null:
return reportQuote(_that);case DisputeNoteBlock() when disputeNote != null:
return disputeNote(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( LocalizedText text,  Reliability reliability,  List<Citation> citations)?  paragraph,TResult Function( LocalizedText text)?  lesson,TResult Function( QuranRef ref,  LocalizedText? note)?  quranQuote,TResult Function( TextStatus textStatus,  Reliability reliability,  List<Citation> citations,  LocalizedText? text,  LocalizedText? summary)?  hadithQuote,TResult Function( TextStatus textStatus,  Reliability reliability,  List<Citation> citations,  LocalizedText? text,  LocalizedText? summary)?  reportQuote,TResult Function( LocalizedText text,  List<Opinion> opinions)?  disputeNote,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ParagraphBlock() when paragraph != null:
return paragraph(_that.text,_that.reliability,_that.citations);case LessonBlock() when lesson != null:
return lesson(_that.text);case QuranQuoteBlock() when quranQuote != null:
return quranQuote(_that.ref,_that.note);case HadithQuoteBlock() when hadithQuote != null:
return hadithQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case ReportQuoteBlock() when reportQuote != null:
return reportQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case DisputeNoteBlock() when disputeNote != null:
return disputeNote(_that.text,_that.opinions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( LocalizedText text,  Reliability reliability,  List<Citation> citations)  paragraph,required TResult Function( LocalizedText text)  lesson,required TResult Function( QuranRef ref,  LocalizedText? note)  quranQuote,required TResult Function( TextStatus textStatus,  Reliability reliability,  List<Citation> citations,  LocalizedText? text,  LocalizedText? summary)  hadithQuote,required TResult Function( TextStatus textStatus,  Reliability reliability,  List<Citation> citations,  LocalizedText? text,  LocalizedText? summary)  reportQuote,required TResult Function( LocalizedText text,  List<Opinion> opinions)  disputeNote,}) {final _that = this;
switch (_that) {
case ParagraphBlock():
return paragraph(_that.text,_that.reliability,_that.citations);case LessonBlock():
return lesson(_that.text);case QuranQuoteBlock():
return quranQuote(_that.ref,_that.note);case HadithQuoteBlock():
return hadithQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case ReportQuoteBlock():
return reportQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case DisputeNoteBlock():
return disputeNote(_that.text,_that.opinions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( LocalizedText text,  Reliability reliability,  List<Citation> citations)?  paragraph,TResult? Function( LocalizedText text)?  lesson,TResult? Function( QuranRef ref,  LocalizedText? note)?  quranQuote,TResult? Function( TextStatus textStatus,  Reliability reliability,  List<Citation> citations,  LocalizedText? text,  LocalizedText? summary)?  hadithQuote,TResult? Function( TextStatus textStatus,  Reliability reliability,  List<Citation> citations,  LocalizedText? text,  LocalizedText? summary)?  reportQuote,TResult? Function( LocalizedText text,  List<Opinion> opinions)?  disputeNote,}) {final _that = this;
switch (_that) {
case ParagraphBlock() when paragraph != null:
return paragraph(_that.text,_that.reliability,_that.citations);case LessonBlock() when lesson != null:
return lesson(_that.text);case QuranQuoteBlock() when quranQuote != null:
return quranQuote(_that.ref,_that.note);case HadithQuoteBlock() when hadithQuote != null:
return hadithQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case ReportQuoteBlock() when reportQuote != null:
return reportQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case DisputeNoteBlock() when disputeNote != null:
return disputeNote(_that.text,_that.opinions);case _:
  return null;

}
}

}

/// @nodoc


class ParagraphBlock implements ContentBlock {
  const ParagraphBlock({required this.text, required this.reliability, required final  List<Citation> citations}): _citations = citations;
  

 final  LocalizedText text;
 final  Reliability reliability;
 final  List<Citation> _citations;
 List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParagraphBlockCopyWith<ParagraphBlock> get copyWith => _$ParagraphBlockCopyWithImpl<ParagraphBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParagraphBlock&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations));
}


@override
int get hashCode => Object.hash(runtimeType,text,reliability,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'ContentBlock.paragraph(text: $text, reliability: $reliability, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $ParagraphBlockCopyWith<$Res> implements $ContentBlockCopyWith<$Res> {
  factory $ParagraphBlockCopyWith(ParagraphBlock value, $Res Function(ParagraphBlock) _then) = _$ParagraphBlockCopyWithImpl;
@useResult
$Res call({
 LocalizedText text, Reliability reliability, List<Citation> citations
});


$LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class _$ParagraphBlockCopyWithImpl<$Res>
    implements $ParagraphBlockCopyWith<$Res> {
  _$ParagraphBlockCopyWithImpl(this._self, this._then);

  final ParagraphBlock _self;
  final $Res Function(ParagraphBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? reliability = null,Object? citations = null,}) {
  return _then(ParagraphBlock(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get text {
  
  return $LocalizedTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

/// @nodoc


class LessonBlock implements ContentBlock {
  const LessonBlock({required this.text});
  

 final  LocalizedText text;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonBlockCopyWith<LessonBlock> get copyWith => _$LessonBlockCopyWithImpl<LessonBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonBlock&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ContentBlock.lesson(text: $text)';
}


}

/// @nodoc
abstract mixin class $LessonBlockCopyWith<$Res> implements $ContentBlockCopyWith<$Res> {
  factory $LessonBlockCopyWith(LessonBlock value, $Res Function(LessonBlock) _then) = _$LessonBlockCopyWithImpl;
@useResult
$Res call({
 LocalizedText text
});


$LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class _$LessonBlockCopyWithImpl<$Res>
    implements $LessonBlockCopyWith<$Res> {
  _$LessonBlockCopyWithImpl(this._self, this._then);

  final LessonBlock _self;
  final $Res Function(LessonBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(LessonBlock(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get text {
  
  return $LocalizedTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

/// @nodoc


class QuranQuoteBlock implements ContentBlock {
  const QuranQuoteBlock({required this.ref, this.note});
  

 final  QuranRef ref;
 final  LocalizedText? note;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranQuoteBlockCopyWith<QuranQuoteBlock> get copyWith => _$QuranQuoteBlockCopyWithImpl<QuranQuoteBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranQuoteBlock&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,ref,note);

@override
String toString() {
  return 'ContentBlock.quranQuote(ref: $ref, note: $note)';
}


}

/// @nodoc
abstract mixin class $QuranQuoteBlockCopyWith<$Res> implements $ContentBlockCopyWith<$Res> {
  factory $QuranQuoteBlockCopyWith(QuranQuoteBlock value, $Res Function(QuranQuoteBlock) _then) = _$QuranQuoteBlockCopyWithImpl;
@useResult
$Res call({
 QuranRef ref, LocalizedText? note
});


$LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class _$QuranQuoteBlockCopyWithImpl<$Res>
    implements $QuranQuoteBlockCopyWith<$Res> {
  _$QuranQuoteBlockCopyWithImpl(this._self, this._then);

  final QuranQuoteBlock _self;
  final $Res Function(QuranQuoteBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ref = null,Object? note = freezed,}) {
  return _then(QuranQuoteBlock(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as QuranRef,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get note {
    if (_self.note == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.note!, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}

/// @nodoc


class HadithQuoteBlock implements ContentBlock {
  const HadithQuoteBlock({required this.textStatus, required this.reliability, required final  List<Citation> citations, this.text, this.summary}): _citations = citations;
  

 final  TextStatus textStatus;
 final  Reliability reliability;
 final  List<Citation> _citations;
 List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

 final  LocalizedText? text;
 final  LocalizedText? summary;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithQuoteBlockCopyWith<HadithQuoteBlock> get copyWith => _$HadithQuoteBlockCopyWithImpl<HadithQuoteBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithQuoteBlock&&(identical(other.textStatus, textStatus) || other.textStatus == textStatus)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.text, text) || other.text == text)&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,textStatus,reliability,const DeepCollectionEquality().hash(_citations),text,summary);

@override
String toString() {
  return 'ContentBlock.hadithQuote(textStatus: $textStatus, reliability: $reliability, citations: $citations, text: $text, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $HadithQuoteBlockCopyWith<$Res> implements $ContentBlockCopyWith<$Res> {
  factory $HadithQuoteBlockCopyWith(HadithQuoteBlock value, $Res Function(HadithQuoteBlock) _then) = _$HadithQuoteBlockCopyWithImpl;
@useResult
$Res call({
 TextStatus textStatus, Reliability reliability, List<Citation> citations, LocalizedText? text, LocalizedText? summary
});


$LocalizedTextCopyWith<$Res>? get text;$LocalizedTextCopyWith<$Res>? get summary;

}
/// @nodoc
class _$HadithQuoteBlockCopyWithImpl<$Res>
    implements $HadithQuoteBlockCopyWith<$Res> {
  _$HadithQuoteBlockCopyWithImpl(this._self, this._then);

  final HadithQuoteBlock _self;
  final $Res Function(HadithQuoteBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? textStatus = null,Object? reliability = null,Object? citations = null,Object? text = freezed,Object? summary = freezed,}) {
  return _then(HadithQuoteBlock(
textStatus: null == textStatus ? _self.textStatus : textStatus // ignore: cast_nullable_to_non_nullable
as TextStatus,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class ReportQuoteBlock implements ContentBlock {
  const ReportQuoteBlock({required this.textStatus, required this.reliability, required final  List<Citation> citations, this.text, this.summary}): _citations = citations;
  

 final  TextStatus textStatus;
 final  Reliability reliability;
 final  List<Citation> _citations;
 List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

 final  LocalizedText? text;
 final  LocalizedText? summary;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportQuoteBlockCopyWith<ReportQuoteBlock> get copyWith => _$ReportQuoteBlockCopyWithImpl<ReportQuoteBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportQuoteBlock&&(identical(other.textStatus, textStatus) || other.textStatus == textStatus)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.text, text) || other.text == text)&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode => Object.hash(runtimeType,textStatus,reliability,const DeepCollectionEquality().hash(_citations),text,summary);

@override
String toString() {
  return 'ContentBlock.reportQuote(textStatus: $textStatus, reliability: $reliability, citations: $citations, text: $text, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ReportQuoteBlockCopyWith<$Res> implements $ContentBlockCopyWith<$Res> {
  factory $ReportQuoteBlockCopyWith(ReportQuoteBlock value, $Res Function(ReportQuoteBlock) _then) = _$ReportQuoteBlockCopyWithImpl;
@useResult
$Res call({
 TextStatus textStatus, Reliability reliability, List<Citation> citations, LocalizedText? text, LocalizedText? summary
});


$LocalizedTextCopyWith<$Res>? get text;$LocalizedTextCopyWith<$Res>? get summary;

}
/// @nodoc
class _$ReportQuoteBlockCopyWithImpl<$Res>
    implements $ReportQuoteBlockCopyWith<$Res> {
  _$ReportQuoteBlockCopyWithImpl(this._self, this._then);

  final ReportQuoteBlock _self;
  final $Res Function(ReportQuoteBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? textStatus = null,Object? reliability = null,Object? citations = null,Object? text = freezed,Object? summary = freezed,}) {
  return _then(ReportQuoteBlock(
textStatus: null == textStatus ? _self.textStatus : textStatus // ignore: cast_nullable_to_non_nullable
as TextStatus,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc


class DisputeNoteBlock implements ContentBlock {
  const DisputeNoteBlock({required this.text, required final  List<Opinion> opinions}): _opinions = opinions;
  

 final  LocalizedText text;
 final  List<Opinion> _opinions;
 List<Opinion> get opinions {
  if (_opinions is EqualUnmodifiableListView) return _opinions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opinions);
}


/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeNoteBlockCopyWith<DisputeNoteBlock> get copyWith => _$DisputeNoteBlockCopyWithImpl<DisputeNoteBlock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeNoteBlock&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._opinions, _opinions));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_opinions));

@override
String toString() {
  return 'ContentBlock.disputeNote(text: $text, opinions: $opinions)';
}


}

/// @nodoc
abstract mixin class $DisputeNoteBlockCopyWith<$Res> implements $ContentBlockCopyWith<$Res> {
  factory $DisputeNoteBlockCopyWith(DisputeNoteBlock value, $Res Function(DisputeNoteBlock) _then) = _$DisputeNoteBlockCopyWithImpl;
@useResult
$Res call({
 LocalizedText text, List<Opinion> opinions
});


$LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class _$DisputeNoteBlockCopyWithImpl<$Res>
    implements $DisputeNoteBlockCopyWith<$Res> {
  _$DisputeNoteBlockCopyWithImpl(this._self, this._then);

  final DisputeNoteBlock _self;
  final $Res Function(DisputeNoteBlock) _then;

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? opinions = null,}) {
  return _then(DisputeNoteBlock(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,opinions: null == opinions ? _self._opinions : opinions // ignore: cast_nullable_to_non_nullable
as List<Opinion>,
  ));
}

/// Create a copy of ContentBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get text {
  
  return $LocalizedTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

// dart format on
