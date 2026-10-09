// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'block_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OpinionDto {

 LocalizedTextDto get text; List<CitationDto> get citations;
/// Create a copy of OpinionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpinionDtoCopyWith<OpinionDto> get copyWith => _$OpinionDtoCopyWithImpl<OpinionDto>(this as OpinionDto, _$identity);

  /// Serializes this OpinionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpinionDto&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.citations, citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'OpinionDto(text: $text, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $OpinionDtoCopyWith<$Res>  {
  factory $OpinionDtoCopyWith(OpinionDto value, $Res Function(OpinionDto) _then) = _$OpinionDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto text, List<CitationDto> citations
});


$LocalizedTextDtoCopyWith<$Res> get text;

}
/// @nodoc
class _$OpinionDtoCopyWithImpl<$Res>
    implements $OpinionDtoCopyWith<$Res> {
  _$OpinionDtoCopyWithImpl(this._self, this._then);

  final OpinionDto _self;
  final $Res Function(OpinionDto) _then;

/// Create a copy of OpinionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? citations = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}
/// Create a copy of OpinionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}


/// Adds pattern-matching-related methods to [OpinionDto].
extension OpinionDtoPatterns on OpinionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpinionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpinionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpinionDto value)  $default,){
final _that = this;
switch (_that) {
case _OpinionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpinionDto value)?  $default,){
final _that = this;
switch (_that) {
case _OpinionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedTextDto text,  List<CitationDto> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpinionDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedTextDto text,  List<CitationDto> citations)  $default,) {final _that = this;
switch (_that) {
case _OpinionDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedTextDto text,  List<CitationDto> citations)?  $default,) {final _that = this;
switch (_that) {
case _OpinionDto() when $default != null:
return $default(_that.text,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpinionDto implements OpinionDto {
  const _OpinionDto({required this.text, required final  List<CitationDto> citations}): _citations = citations;
  factory _OpinionDto.fromJson(Map<String, dynamic> json) => _$OpinionDtoFromJson(json);

@override final  LocalizedTextDto text;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of OpinionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpinionDtoCopyWith<_OpinionDto> get copyWith => __$OpinionDtoCopyWithImpl<_OpinionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpinionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpinionDto&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'OpinionDto(text: $text, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$OpinionDtoCopyWith<$Res> implements $OpinionDtoCopyWith<$Res> {
  factory _$OpinionDtoCopyWith(_OpinionDto value, $Res Function(_OpinionDto) _then) = __$OpinionDtoCopyWithImpl;
@override @useResult
$Res call({
 LocalizedTextDto text, List<CitationDto> citations
});


@override $LocalizedTextDtoCopyWith<$Res> get text;

}
/// @nodoc
class __$OpinionDtoCopyWithImpl<$Res>
    implements _$OpinionDtoCopyWith<$Res> {
  __$OpinionDtoCopyWithImpl(this._self, this._then);

  final _OpinionDto _self;
  final $Res Function(_OpinionDto) _then;

/// Create a copy of OpinionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? citations = null,}) {
  return _then(_OpinionDto(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}

/// Create a copy of OpinionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

ContentBlockDto _$ContentBlockDtoFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'paragraph':
          return ParagraphBlockDto.fromJson(
            json
          );
                case 'lesson':
          return LessonBlockDto.fromJson(
            json
          );
                case 'quranQuote':
          return QuranQuoteBlockDto.fromJson(
            json
          );
                case 'hadithQuote':
          return HadithQuoteBlockDto.fromJson(
            json
          );
                case 'reportQuote':
          return ReportQuoteBlockDto.fromJson(
            json
          );
                case 'disputeNote':
          return DisputeNoteBlockDto.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ContentBlockDto',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ContentBlockDto {



  /// Serializes this ContentBlockDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentBlockDto);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ContentBlockDto()';
}


}

/// @nodoc
class $ContentBlockDtoCopyWith<$Res>  {
$ContentBlockDtoCopyWith(ContentBlockDto _, $Res Function(ContentBlockDto) __);
}


/// Adds pattern-matching-related methods to [ContentBlockDto].
extension ContentBlockDtoPatterns on ContentBlockDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ParagraphBlockDto value)?  paragraph,TResult Function( LessonBlockDto value)?  lesson,TResult Function( QuranQuoteBlockDto value)?  quranQuote,TResult Function( HadithQuoteBlockDto value)?  hadithQuote,TResult Function( ReportQuoteBlockDto value)?  reportQuote,TResult Function( DisputeNoteBlockDto value)?  disputeNote,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ParagraphBlockDto() when paragraph != null:
return paragraph(_that);case LessonBlockDto() when lesson != null:
return lesson(_that);case QuranQuoteBlockDto() when quranQuote != null:
return quranQuote(_that);case HadithQuoteBlockDto() when hadithQuote != null:
return hadithQuote(_that);case ReportQuoteBlockDto() when reportQuote != null:
return reportQuote(_that);case DisputeNoteBlockDto() when disputeNote != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ParagraphBlockDto value)  paragraph,required TResult Function( LessonBlockDto value)  lesson,required TResult Function( QuranQuoteBlockDto value)  quranQuote,required TResult Function( HadithQuoteBlockDto value)  hadithQuote,required TResult Function( ReportQuoteBlockDto value)  reportQuote,required TResult Function( DisputeNoteBlockDto value)  disputeNote,}){
final _that = this;
switch (_that) {
case ParagraphBlockDto():
return paragraph(_that);case LessonBlockDto():
return lesson(_that);case QuranQuoteBlockDto():
return quranQuote(_that);case HadithQuoteBlockDto():
return hadithQuote(_that);case ReportQuoteBlockDto():
return reportQuote(_that);case DisputeNoteBlockDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ParagraphBlockDto value)?  paragraph,TResult? Function( LessonBlockDto value)?  lesson,TResult? Function( QuranQuoteBlockDto value)?  quranQuote,TResult? Function( HadithQuoteBlockDto value)?  hadithQuote,TResult? Function( ReportQuoteBlockDto value)?  reportQuote,TResult? Function( DisputeNoteBlockDto value)?  disputeNote,}){
final _that = this;
switch (_that) {
case ParagraphBlockDto() when paragraph != null:
return paragraph(_that);case LessonBlockDto() when lesson != null:
return lesson(_that);case QuranQuoteBlockDto() when quranQuote != null:
return quranQuote(_that);case HadithQuoteBlockDto() when hadithQuote != null:
return hadithQuote(_that);case ReportQuoteBlockDto() when reportQuote != null:
return reportQuote(_that);case DisputeNoteBlockDto() when disputeNote != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations)?  paragraph,TResult Function( LocalizedTextDto text)?  lesson,TResult Function( QuranRefDto ref,  LocalizedTextDto? note)?  quranQuote,TResult Function( TextStatus textStatus,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? text,  LocalizedTextDto? summary)?  hadithQuote,TResult Function( TextStatus textStatus,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? text,  LocalizedTextDto? summary)?  reportQuote,TResult Function( LocalizedTextDto text,  List<OpinionDto> opinions)?  disputeNote,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ParagraphBlockDto() when paragraph != null:
return paragraph(_that.text,_that.reliability,_that.citations);case LessonBlockDto() when lesson != null:
return lesson(_that.text);case QuranQuoteBlockDto() when quranQuote != null:
return quranQuote(_that.ref,_that.note);case HadithQuoteBlockDto() when hadithQuote != null:
return hadithQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case ReportQuoteBlockDto() when reportQuote != null:
return reportQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case DisputeNoteBlockDto() when disputeNote != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations)  paragraph,required TResult Function( LocalizedTextDto text)  lesson,required TResult Function( QuranRefDto ref,  LocalizedTextDto? note)  quranQuote,required TResult Function( TextStatus textStatus,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? text,  LocalizedTextDto? summary)  hadithQuote,required TResult Function( TextStatus textStatus,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? text,  LocalizedTextDto? summary)  reportQuote,required TResult Function( LocalizedTextDto text,  List<OpinionDto> opinions)  disputeNote,}) {final _that = this;
switch (_that) {
case ParagraphBlockDto():
return paragraph(_that.text,_that.reliability,_that.citations);case LessonBlockDto():
return lesson(_that.text);case QuranQuoteBlockDto():
return quranQuote(_that.ref,_that.note);case HadithQuoteBlockDto():
return hadithQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case ReportQuoteBlockDto():
return reportQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case DisputeNoteBlockDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations)?  paragraph,TResult? Function( LocalizedTextDto text)?  lesson,TResult? Function( QuranRefDto ref,  LocalizedTextDto? note)?  quranQuote,TResult? Function( TextStatus textStatus,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? text,  LocalizedTextDto? summary)?  hadithQuote,TResult? Function( TextStatus textStatus,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? text,  LocalizedTextDto? summary)?  reportQuote,TResult? Function( LocalizedTextDto text,  List<OpinionDto> opinions)?  disputeNote,}) {final _that = this;
switch (_that) {
case ParagraphBlockDto() when paragraph != null:
return paragraph(_that.text,_that.reliability,_that.citations);case LessonBlockDto() when lesson != null:
return lesson(_that.text);case QuranQuoteBlockDto() when quranQuote != null:
return quranQuote(_that.ref,_that.note);case HadithQuoteBlockDto() when hadithQuote != null:
return hadithQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case ReportQuoteBlockDto() when reportQuote != null:
return reportQuote(_that.textStatus,_that.reliability,_that.citations,_that.text,_that.summary);case DisputeNoteBlockDto() when disputeNote != null:
return disputeNote(_that.text,_that.opinions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ParagraphBlockDto implements ContentBlockDto {
  const ParagraphBlockDto({required this.text, required this.reliability, required final  List<CitationDto> citations, final  String? $type}): _citations = citations,$type = $type ?? 'paragraph';
  factory ParagraphBlockDto.fromJson(Map<String, dynamic> json) => _$ParagraphBlockDtoFromJson(json);

 final  LocalizedTextDto text;
 final  Reliability reliability;
 final  List<CitationDto> _citations;
 List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParagraphBlockDtoCopyWith<ParagraphBlockDto> get copyWith => _$ParagraphBlockDtoCopyWithImpl<ParagraphBlockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ParagraphBlockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParagraphBlockDto&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,reliability,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'ContentBlockDto.paragraph(text: $text, reliability: $reliability, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $ParagraphBlockDtoCopyWith<$Res> implements $ContentBlockDtoCopyWith<$Res> {
  factory $ParagraphBlockDtoCopyWith(ParagraphBlockDto value, $Res Function(ParagraphBlockDto) _then) = _$ParagraphBlockDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto text, Reliability reliability, List<CitationDto> citations
});


$LocalizedTextDtoCopyWith<$Res> get text;

}
/// @nodoc
class _$ParagraphBlockDtoCopyWithImpl<$Res>
    implements $ParagraphBlockDtoCopyWith<$Res> {
  _$ParagraphBlockDtoCopyWithImpl(this._self, this._then);

  final ParagraphBlockDto _self;
  final $Res Function(ParagraphBlockDto) _then;

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? reliability = null,Object? citations = null,}) {
  return _then(ParagraphBlockDto(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class LessonBlockDto implements ContentBlockDto {
  const LessonBlockDto({required this.text, final  String? $type}): $type = $type ?? 'lesson';
  factory LessonBlockDto.fromJson(Map<String, dynamic> json) => _$LessonBlockDtoFromJson(json);

 final  LocalizedTextDto text;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LessonBlockDtoCopyWith<LessonBlockDto> get copyWith => _$LessonBlockDtoCopyWithImpl<LessonBlockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LessonBlockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LessonBlockDto&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'ContentBlockDto.lesson(text: $text)';
}


}

/// @nodoc
abstract mixin class $LessonBlockDtoCopyWith<$Res> implements $ContentBlockDtoCopyWith<$Res> {
  factory $LessonBlockDtoCopyWith(LessonBlockDto value, $Res Function(LessonBlockDto) _then) = _$LessonBlockDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto text
});


$LocalizedTextDtoCopyWith<$Res> get text;

}
/// @nodoc
class _$LessonBlockDtoCopyWithImpl<$Res>
    implements $LessonBlockDtoCopyWith<$Res> {
  _$LessonBlockDtoCopyWithImpl(this._self, this._then);

  final LessonBlockDto _self;
  final $Res Function(LessonBlockDto) _then;

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(LessonBlockDto(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,
  ));
}

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class QuranQuoteBlockDto implements ContentBlockDto {
  const QuranQuoteBlockDto({required this.ref, this.note, final  String? $type}): $type = $type ?? 'quranQuote';
  factory QuranQuoteBlockDto.fromJson(Map<String, dynamic> json) => _$QuranQuoteBlockDtoFromJson(json);

 final  QuranRefDto ref;
 final  LocalizedTextDto? note;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranQuoteBlockDtoCopyWith<QuranQuoteBlockDto> get copyWith => _$QuranQuoteBlockDtoCopyWithImpl<QuranQuoteBlockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuranQuoteBlockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranQuoteBlockDto&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ref,note);

@override
String toString() {
  return 'ContentBlockDto.quranQuote(ref: $ref, note: $note)';
}


}

/// @nodoc
abstract mixin class $QuranQuoteBlockDtoCopyWith<$Res> implements $ContentBlockDtoCopyWith<$Res> {
  factory $QuranQuoteBlockDtoCopyWith(QuranQuoteBlockDto value, $Res Function(QuranQuoteBlockDto) _then) = _$QuranQuoteBlockDtoCopyWithImpl;
@useResult
$Res call({
 QuranRefDto ref, LocalizedTextDto? note
});


$QuranRefDtoCopyWith<$Res> get ref;$LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class _$QuranQuoteBlockDtoCopyWithImpl<$Res>
    implements $QuranQuoteBlockDtoCopyWith<$Res> {
  _$QuranQuoteBlockDtoCopyWithImpl(this._self, this._then);

  final QuranQuoteBlockDto _self;
  final $Res Function(QuranQuoteBlockDto) _then;

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ref = null,Object? note = freezed,}) {
  return _then(QuranQuoteBlockDto(
ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as QuranRefDto,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuranRefDtoCopyWith<$Res> get ref {
  
  return $QuranRefDtoCopyWith<$Res>(_self.ref, (value) {
    return _then(_self.copyWith(ref: value));
  });
}/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get note {
    if (_self.note == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.note!, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class HadithQuoteBlockDto implements ContentBlockDto {
  const HadithQuoteBlockDto({required this.textStatus, required this.reliability, required final  List<CitationDto> citations, this.text, this.summary, final  String? $type}): _citations = citations,$type = $type ?? 'hadithQuote';
  factory HadithQuoteBlockDto.fromJson(Map<String, dynamic> json) => _$HadithQuoteBlockDtoFromJson(json);

 final  TextStatus textStatus;
 final  Reliability reliability;
 final  List<CitationDto> _citations;
 List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

 final  LocalizedTextDto? text;
 final  LocalizedTextDto? summary;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HadithQuoteBlockDtoCopyWith<HadithQuoteBlockDto> get copyWith => _$HadithQuoteBlockDtoCopyWithImpl<HadithQuoteBlockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HadithQuoteBlockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HadithQuoteBlockDto&&(identical(other.textStatus, textStatus) || other.textStatus == textStatus)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.text, text) || other.text == text)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textStatus,reliability,const DeepCollectionEquality().hash(_citations),text,summary);

@override
String toString() {
  return 'ContentBlockDto.hadithQuote(textStatus: $textStatus, reliability: $reliability, citations: $citations, text: $text, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $HadithQuoteBlockDtoCopyWith<$Res> implements $ContentBlockDtoCopyWith<$Res> {
  factory $HadithQuoteBlockDtoCopyWith(HadithQuoteBlockDto value, $Res Function(HadithQuoteBlockDto) _then) = _$HadithQuoteBlockDtoCopyWithImpl;
@useResult
$Res call({
 TextStatus textStatus, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? text, LocalizedTextDto? summary
});


$LocalizedTextDtoCopyWith<$Res>? get text;$LocalizedTextDtoCopyWith<$Res>? get summary;

}
/// @nodoc
class _$HadithQuoteBlockDtoCopyWithImpl<$Res>
    implements $HadithQuoteBlockDtoCopyWith<$Res> {
  _$HadithQuoteBlockDtoCopyWithImpl(this._self, this._then);

  final HadithQuoteBlockDto _self;
  final $Res Function(HadithQuoteBlockDto) _then;

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? textStatus = null,Object? reliability = null,Object? citations = null,Object? text = freezed,Object? summary = freezed,}) {
  return _then(HadithQuoteBlockDto(
textStatus: null == textStatus ? _self.textStatus : textStatus // ignore: cast_nullable_to_non_nullable
as TextStatus,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ReportQuoteBlockDto implements ContentBlockDto {
  const ReportQuoteBlockDto({required this.textStatus, required this.reliability, required final  List<CitationDto> citations, this.text, this.summary, final  String? $type}): _citations = citations,$type = $type ?? 'reportQuote';
  factory ReportQuoteBlockDto.fromJson(Map<String, dynamic> json) => _$ReportQuoteBlockDtoFromJson(json);

 final  TextStatus textStatus;
 final  Reliability reliability;
 final  List<CitationDto> _citations;
 List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

 final  LocalizedTextDto? text;
 final  LocalizedTextDto? summary;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportQuoteBlockDtoCopyWith<ReportQuoteBlockDto> get copyWith => _$ReportQuoteBlockDtoCopyWithImpl<ReportQuoteBlockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportQuoteBlockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportQuoteBlockDto&&(identical(other.textStatus, textStatus) || other.textStatus == textStatus)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.text, text) || other.text == text)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textStatus,reliability,const DeepCollectionEquality().hash(_citations),text,summary);

@override
String toString() {
  return 'ContentBlockDto.reportQuote(textStatus: $textStatus, reliability: $reliability, citations: $citations, text: $text, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ReportQuoteBlockDtoCopyWith<$Res> implements $ContentBlockDtoCopyWith<$Res> {
  factory $ReportQuoteBlockDtoCopyWith(ReportQuoteBlockDto value, $Res Function(ReportQuoteBlockDto) _then) = _$ReportQuoteBlockDtoCopyWithImpl;
@useResult
$Res call({
 TextStatus textStatus, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? text, LocalizedTextDto? summary
});


$LocalizedTextDtoCopyWith<$Res>? get text;$LocalizedTextDtoCopyWith<$Res>? get summary;

}
/// @nodoc
class _$ReportQuoteBlockDtoCopyWithImpl<$Res>
    implements $ReportQuoteBlockDtoCopyWith<$Res> {
  _$ReportQuoteBlockDtoCopyWithImpl(this._self, this._then);

  final ReportQuoteBlockDto _self;
  final $Res Function(ReportQuoteBlockDto) _then;

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? textStatus = null,Object? reliability = null,Object? citations = null,Object? text = freezed,Object? summary = freezed,}) {
  return _then(ReportQuoteBlockDto(
textStatus: null == textStatus ? _self.textStatus : textStatus // ignore: cast_nullable_to_non_nullable
as TextStatus,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class DisputeNoteBlockDto implements ContentBlockDto {
  const DisputeNoteBlockDto({required this.text, required final  List<OpinionDto> opinions, final  String? $type}): _opinions = opinions,$type = $type ?? 'disputeNote';
  factory DisputeNoteBlockDto.fromJson(Map<String, dynamic> json) => _$DisputeNoteBlockDtoFromJson(json);

 final  LocalizedTextDto text;
 final  List<OpinionDto> _opinions;
 List<OpinionDto> get opinions {
  if (_opinions is EqualUnmodifiableListView) return _opinions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_opinions);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DisputeNoteBlockDtoCopyWith<DisputeNoteBlockDto> get copyWith => _$DisputeNoteBlockDtoCopyWithImpl<DisputeNoteBlockDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DisputeNoteBlockDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DisputeNoteBlockDto&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._opinions, _opinions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_opinions));

@override
String toString() {
  return 'ContentBlockDto.disputeNote(text: $text, opinions: $opinions)';
}


}

/// @nodoc
abstract mixin class $DisputeNoteBlockDtoCopyWith<$Res> implements $ContentBlockDtoCopyWith<$Res> {
  factory $DisputeNoteBlockDtoCopyWith(DisputeNoteBlockDto value, $Res Function(DisputeNoteBlockDto) _then) = _$DisputeNoteBlockDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto text, List<OpinionDto> opinions
});


$LocalizedTextDtoCopyWith<$Res> get text;

}
/// @nodoc
class _$DisputeNoteBlockDtoCopyWithImpl<$Res>
    implements $DisputeNoteBlockDtoCopyWith<$Res> {
  _$DisputeNoteBlockDtoCopyWithImpl(this._self, this._then);

  final DisputeNoteBlockDto _self;
  final $Res Function(DisputeNoteBlockDto) _then;

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? opinions = null,}) {
  return _then(DisputeNoteBlockDto(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,opinions: null == opinions ? _self._opinions : opinions // ignore: cast_nullable_to_non_nullable
as List<OpinionDto>,
  ));
}

/// Create a copy of ContentBlockDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

// dart format on
