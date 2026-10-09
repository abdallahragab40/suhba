// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'companion_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiographySectionDto {

 String get id; SectionKind get kind; LocalizedTextDto get title; List<ContentBlockDto> get blocks;
/// Create a copy of BiographySectionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiographySectionDtoCopyWith<BiographySectionDto> get copyWith => _$BiographySectionDtoCopyWithImpl<BiographySectionDto>(this as BiographySectionDto, _$identity);

  /// Serializes this BiographySectionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiographySectionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.blocks, blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,title,const DeepCollectionEquality().hash(blocks));

@override
String toString() {
  return 'BiographySectionDto(id: $id, kind: $kind, title: $title, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $BiographySectionDtoCopyWith<$Res>  {
  factory $BiographySectionDtoCopyWith(BiographySectionDto value, $Res Function(BiographySectionDto) _then) = _$BiographySectionDtoCopyWithImpl;
@useResult
$Res call({
 String id, SectionKind kind, LocalizedTextDto title, List<ContentBlockDto> blocks
});


$LocalizedTextDtoCopyWith<$Res> get title;

}
/// @nodoc
class _$BiographySectionDtoCopyWithImpl<$Res>
    implements $BiographySectionDtoCopyWith<$Res> {
  _$BiographySectionDtoCopyWithImpl(this._self, this._then);

  final BiographySectionDto _self;
  final $Res Function(BiographySectionDto) _then;

/// Create a copy of BiographySectionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? blocks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SectionKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,
  ));
}
/// Create a copy of BiographySectionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [BiographySectionDto].
extension BiographySectionDtoPatterns on BiographySectionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiographySectionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiographySectionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiographySectionDto value)  $default,){
final _that = this;
switch (_that) {
case _BiographySectionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiographySectionDto value)?  $default,){
final _that = this;
switch (_that) {
case _BiographySectionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SectionKind kind,  LocalizedTextDto title,  List<ContentBlockDto> blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiographySectionDto() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SectionKind kind,  LocalizedTextDto title,  List<ContentBlockDto> blocks)  $default,) {final _that = this;
switch (_that) {
case _BiographySectionDto():
return $default(_that.id,_that.kind,_that.title,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SectionKind kind,  LocalizedTextDto title,  List<ContentBlockDto> blocks)?  $default,) {final _that = this;
switch (_that) {
case _BiographySectionDto() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BiographySectionDto implements BiographySectionDto {
  const _BiographySectionDto({required this.id, required this.kind, required this.title, required final  List<ContentBlockDto> blocks}): _blocks = blocks;
  factory _BiographySectionDto.fromJson(Map<String, dynamic> json) => _$BiographySectionDtoFromJson(json);

@override final  String id;
@override final  SectionKind kind;
@override final  LocalizedTextDto title;
 final  List<ContentBlockDto> _blocks;
@override List<ContentBlockDto> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}


/// Create a copy of BiographySectionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiographySectionDtoCopyWith<_BiographySectionDto> get copyWith => __$BiographySectionDtoCopyWithImpl<_BiographySectionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BiographySectionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiographySectionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._blocks, _blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,title,const DeepCollectionEquality().hash(_blocks));

@override
String toString() {
  return 'BiographySectionDto(id: $id, kind: $kind, title: $title, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$BiographySectionDtoCopyWith<$Res> implements $BiographySectionDtoCopyWith<$Res> {
  factory _$BiographySectionDtoCopyWith(_BiographySectionDto value, $Res Function(_BiographySectionDto) _then) = __$BiographySectionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, SectionKind kind, LocalizedTextDto title, List<ContentBlockDto> blocks
});


@override $LocalizedTextDtoCopyWith<$Res> get title;

}
/// @nodoc
class __$BiographySectionDtoCopyWithImpl<$Res>
    implements _$BiographySectionDtoCopyWith<$Res> {
  __$BiographySectionDtoCopyWithImpl(this._self, this._then);

  final _BiographySectionDto _self;
  final $Res Function(_BiographySectionDto) _then;

/// Create a copy of BiographySectionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? blocks = null,}) {
  return _then(_BiographySectionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SectionKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,
  ));
}

/// Create a copy of BiographySectionDto
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
mixin _$TimelineEventDto {

 String get id; TimelineEra get era; HistoricalDateDto get date; LocalizedTextDto get title; Reliability get reliability; List<CitationDto> get citations; LocalizedTextDto? get summary; String? get eventId; String? get sectionId;
/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineEventDtoCopyWith<TimelineEventDto> get copyWith => _$TimelineEventDtoCopyWithImpl<TimelineEventDto>(this as TimelineEventDto, _$identity);

  /// Serializes this TimelineEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,era,date,title,reliability,const DeepCollectionEquality().hash(citations),summary,eventId,sectionId);

@override
String toString() {
  return 'TimelineEventDto(id: $id, era: $era, date: $date, title: $title, reliability: $reliability, citations: $citations, summary: $summary, eventId: $eventId, sectionId: $sectionId)';
}


}

/// @nodoc
abstract mixin class $TimelineEventDtoCopyWith<$Res>  {
  factory $TimelineEventDtoCopyWith(TimelineEventDto value, $Res Function(TimelineEventDto) _then) = _$TimelineEventDtoCopyWithImpl;
@useResult
$Res call({
 String id, TimelineEra era, HistoricalDateDto date, LocalizedTextDto title, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? summary, String? eventId, String? sectionId
});


$HistoricalDateDtoCopyWith<$Res> get date;$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res>? get summary;

}
/// @nodoc
class _$TimelineEventDtoCopyWithImpl<$Res>
    implements $TimelineEventDtoCopyWith<$Res> {
  _$TimelineEventDtoCopyWithImpl(this._self, this._then);

  final TimelineEventDto _self;
  final $Res Function(TimelineEventDto) _then;

/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? era = null,Object? date = null,Object? title = null,Object? reliability = null,Object? citations = null,Object? summary = freezed,Object? eventId = freezed,Object? sectionId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as TimelineEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TimelineEventDto
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


/// Adds pattern-matching-related methods to [TimelineEventDto].
extension TimelineEventDtoPatterns on TimelineEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineEventDto value)  $default,){
final _that = this;
switch (_that) {
case _TimelineEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TimelineEra era,  HistoricalDateDto date,  LocalizedTextDto title,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? summary,  String? eventId,  String? sectionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineEventDto() when $default != null:
return $default(_that.id,_that.era,_that.date,_that.title,_that.reliability,_that.citations,_that.summary,_that.eventId,_that.sectionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TimelineEra era,  HistoricalDateDto date,  LocalizedTextDto title,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? summary,  String? eventId,  String? sectionId)  $default,) {final _that = this;
switch (_that) {
case _TimelineEventDto():
return $default(_that.id,_that.era,_that.date,_that.title,_that.reliability,_that.citations,_that.summary,_that.eventId,_that.sectionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TimelineEra era,  HistoricalDateDto date,  LocalizedTextDto title,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? summary,  String? eventId,  String? sectionId)?  $default,) {final _that = this;
switch (_that) {
case _TimelineEventDto() when $default != null:
return $default(_that.id,_that.era,_that.date,_that.title,_that.reliability,_that.citations,_that.summary,_that.eventId,_that.sectionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TimelineEventDto implements TimelineEventDto {
  const _TimelineEventDto({required this.id, required this.era, required this.date, required this.title, required this.reliability, required final  List<CitationDto> citations, this.summary, this.eventId, this.sectionId}): _citations = citations;
  factory _TimelineEventDto.fromJson(Map<String, dynamic> json) => _$TimelineEventDtoFromJson(json);

@override final  String id;
@override final  TimelineEra era;
@override final  HistoricalDateDto date;
@override final  LocalizedTextDto title;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedTextDto? summary;
@override final  String? eventId;
@override final  String? sectionId;

/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineEventDtoCopyWith<_TimelineEventDto> get copyWith => __$TimelineEventDtoCopyWithImpl<_TimelineEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimelineEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,era,date,title,reliability,const DeepCollectionEquality().hash(_citations),summary,eventId,sectionId);

@override
String toString() {
  return 'TimelineEventDto(id: $id, era: $era, date: $date, title: $title, reliability: $reliability, citations: $citations, summary: $summary, eventId: $eventId, sectionId: $sectionId)';
}


}

/// @nodoc
abstract mixin class _$TimelineEventDtoCopyWith<$Res> implements $TimelineEventDtoCopyWith<$Res> {
  factory _$TimelineEventDtoCopyWith(_TimelineEventDto value, $Res Function(_TimelineEventDto) _then) = __$TimelineEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, TimelineEra era, HistoricalDateDto date, LocalizedTextDto title, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? summary, String? eventId, String? sectionId
});


@override $HistoricalDateDtoCopyWith<$Res> get date;@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res>? get summary;

}
/// @nodoc
class __$TimelineEventDtoCopyWithImpl<$Res>
    implements _$TimelineEventDtoCopyWith<$Res> {
  __$TimelineEventDtoCopyWithImpl(this._self, this._then);

  final _TimelineEventDto _self;
  final $Res Function(_TimelineEventDto) _then;

/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? era = null,Object? date = null,Object? title = null,Object? reliability = null,Object? citations = null,Object? summary = freezed,Object? eventId = freezed,Object? sectionId = freezed,}) {
  return _then(_TimelineEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as TimelineEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of TimelineEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TimelineEventDto
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
mixin _$CompanionDto {

 int get schemaVersion; String get id; Gender get gender; LocalizedTextDto get name; LocalizedTextDto get fullName; LocalizedTextDto get summary; ReviewDto get review; List<String> get references; int? get order; LocalizedTextDto? get lineage; LocalizedTextDto? get kunya; List<LocalizedTextDto> get titles; List<String> get aliases; DatedClaimDto? get birth; DatedClaimDto? get death; LocalizedTextDto? get deathPlace; List<FactDto> get atAGlance; List<MembershipDto> get memberships; List<RelationDto> get relations; List<BiographySectionDto> get sections; List<String> get storyIds; List<TimelineEventDto> get timeline;
/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanionDtoCopyWith<CompanionDto> get copyWith => _$CompanionDtoCopyWithImpl<CompanionDto>(this as CompanionDto, _$identity);

  /// Serializes this CompanionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanionDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.references, references)&&(identical(other.order, order) || other.order == order)&&(identical(other.lineage, lineage) || other.lineage == lineage)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other.titles, titles)&&const DeepCollectionEquality().equals(other.aliases, aliases)&&(identical(other.birth, birth) || other.birth == birth)&&(identical(other.death, death) || other.death == death)&&(identical(other.deathPlace, deathPlace) || other.deathPlace == deathPlace)&&const DeepCollectionEquality().equals(other.atAGlance, atAGlance)&&const DeepCollectionEquality().equals(other.memberships, memberships)&&const DeepCollectionEquality().equals(other.relations, relations)&&const DeepCollectionEquality().equals(other.sections, sections)&&const DeepCollectionEquality().equals(other.storyIds, storyIds)&&const DeepCollectionEquality().equals(other.timeline, timeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,schemaVersion,id,gender,name,fullName,summary,review,const DeepCollectionEquality().hash(references),order,lineage,kunya,const DeepCollectionEquality().hash(titles),const DeepCollectionEquality().hash(aliases),birth,death,deathPlace,const DeepCollectionEquality().hash(atAGlance),const DeepCollectionEquality().hash(memberships),const DeepCollectionEquality().hash(relations),const DeepCollectionEquality().hash(sections),const DeepCollectionEquality().hash(storyIds),const DeepCollectionEquality().hash(timeline)]);

@override
String toString() {
  return 'CompanionDto(schemaVersion: $schemaVersion, id: $id, gender: $gender, name: $name, fullName: $fullName, summary: $summary, review: $review, references: $references, order: $order, lineage: $lineage, kunya: $kunya, titles: $titles, aliases: $aliases, birth: $birth, death: $death, deathPlace: $deathPlace, atAGlance: $atAGlance, memberships: $memberships, relations: $relations, sections: $sections, storyIds: $storyIds, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class $CompanionDtoCopyWith<$Res>  {
  factory $CompanionDtoCopyWith(CompanionDto value, $Res Function(CompanionDto) _then) = _$CompanionDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String id, Gender gender, LocalizedTextDto name, LocalizedTextDto fullName, LocalizedTextDto summary, ReviewDto review, List<String> references, int? order, LocalizedTextDto? lineage, LocalizedTextDto? kunya, List<LocalizedTextDto> titles, List<String> aliases, DatedClaimDto? birth, DatedClaimDto? death, LocalizedTextDto? deathPlace, List<FactDto> atAGlance, List<MembershipDto> memberships, List<RelationDto> relations, List<BiographySectionDto> sections, List<String> storyIds, List<TimelineEventDto> timeline
});


$LocalizedTextDtoCopyWith<$Res> get name;$LocalizedTextDtoCopyWith<$Res> get fullName;$LocalizedTextDtoCopyWith<$Res> get summary;$ReviewDtoCopyWith<$Res> get review;$LocalizedTextDtoCopyWith<$Res>? get lineage;$LocalizedTextDtoCopyWith<$Res>? get kunya;$DatedClaimDtoCopyWith<$Res>? get birth;$DatedClaimDtoCopyWith<$Res>? get death;$LocalizedTextDtoCopyWith<$Res>? get deathPlace;

}
/// @nodoc
class _$CompanionDtoCopyWithImpl<$Res>
    implements $CompanionDtoCopyWith<$Res> {
  _$CompanionDtoCopyWithImpl(this._self, this._then);

  final CompanionDto _self;
  final $Res Function(CompanionDto) _then;

/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? id = null,Object? gender = null,Object? name = null,Object? fullName = null,Object? summary = null,Object? review = null,Object? references = null,Object? order = freezed,Object? lineage = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? birth = freezed,Object? death = freezed,Object? deathPlace = freezed,Object? atAGlance = null,Object? memberships = null,Object? relations = null,Object? sections = null,Object? storyIds = null,Object? timeline = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,lineage: freezed == lineage ? _self.lineage : lineage // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedTextDto>,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,birth: freezed == birth ? _self.birth : birth // ignore: cast_nullable_to_non_nullable
as DatedClaimDto?,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as DatedClaimDto?,deathPlace: freezed == deathPlace ? _self.deathPlace : deathPlace // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,atAGlance: null == atAGlance ? _self.atAGlance : atAGlance // ignore: cast_nullable_to_non_nullable
as List<FactDto>,memberships: null == memberships ? _self.memberships : memberships // ignore: cast_nullable_to_non_nullable
as List<MembershipDto>,relations: null == relations ? _self.relations : relations // ignore: cast_nullable_to_non_nullable
as List<RelationDto>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<BiographySectionDto>,storyIds: null == storyIds ? _self.storyIds : storyIds // ignore: cast_nullable_to_non_nullable
as List<String>,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineEventDto>,
  ));
}
/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get fullName {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get lineage {
    if (_self.lineage == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.lineage!, (value) {
    return _then(_self.copyWith(lineage: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimDtoCopyWith<$Res>? get birth {
    if (_self.birth == null) {
    return null;
  }

  return $DatedClaimDtoCopyWith<$Res>(_self.birth!, (value) {
    return _then(_self.copyWith(birth: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimDtoCopyWith<$Res>? get death {
    if (_self.death == null) {
    return null;
  }

  return $DatedClaimDtoCopyWith<$Res>(_self.death!, (value) {
    return _then(_self.copyWith(death: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get deathPlace {
    if (_self.deathPlace == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.deathPlace!, (value) {
    return _then(_self.copyWith(deathPlace: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompanionDto].
extension CompanionDtoPatterns on CompanionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanionDto value)  $default,){
final _that = this;
switch (_that) {
case _CompanionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanionDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompanionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  Gender gender,  LocalizedTextDto name,  LocalizedTextDto fullName,  LocalizedTextDto summary,  ReviewDto review,  List<String> references,  int? order,  LocalizedTextDto? lineage,  LocalizedTextDto? kunya,  List<LocalizedTextDto> titles,  List<String> aliases,  DatedClaimDto? birth,  DatedClaimDto? death,  LocalizedTextDto? deathPlace,  List<FactDto> atAGlance,  List<MembershipDto> memberships,  List<RelationDto> relations,  List<BiographySectionDto> sections,  List<String> storyIds,  List<TimelineEventDto> timeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanionDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.gender,_that.name,_that.fullName,_that.summary,_that.review,_that.references,_that.order,_that.lineage,_that.kunya,_that.titles,_that.aliases,_that.birth,_that.death,_that.deathPlace,_that.atAGlance,_that.memberships,_that.relations,_that.sections,_that.storyIds,_that.timeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  Gender gender,  LocalizedTextDto name,  LocalizedTextDto fullName,  LocalizedTextDto summary,  ReviewDto review,  List<String> references,  int? order,  LocalizedTextDto? lineage,  LocalizedTextDto? kunya,  List<LocalizedTextDto> titles,  List<String> aliases,  DatedClaimDto? birth,  DatedClaimDto? death,  LocalizedTextDto? deathPlace,  List<FactDto> atAGlance,  List<MembershipDto> memberships,  List<RelationDto> relations,  List<BiographySectionDto> sections,  List<String> storyIds,  List<TimelineEventDto> timeline)  $default,) {final _that = this;
switch (_that) {
case _CompanionDto():
return $default(_that.schemaVersion,_that.id,_that.gender,_that.name,_that.fullName,_that.summary,_that.review,_that.references,_that.order,_that.lineage,_that.kunya,_that.titles,_that.aliases,_that.birth,_that.death,_that.deathPlace,_that.atAGlance,_that.memberships,_that.relations,_that.sections,_that.storyIds,_that.timeline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String id,  Gender gender,  LocalizedTextDto name,  LocalizedTextDto fullName,  LocalizedTextDto summary,  ReviewDto review,  List<String> references,  int? order,  LocalizedTextDto? lineage,  LocalizedTextDto? kunya,  List<LocalizedTextDto> titles,  List<String> aliases,  DatedClaimDto? birth,  DatedClaimDto? death,  LocalizedTextDto? deathPlace,  List<FactDto> atAGlance,  List<MembershipDto> memberships,  List<RelationDto> relations,  List<BiographySectionDto> sections,  List<String> storyIds,  List<TimelineEventDto> timeline)?  $default,) {final _that = this;
switch (_that) {
case _CompanionDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.gender,_that.name,_that.fullName,_that.summary,_that.review,_that.references,_that.order,_that.lineage,_that.kunya,_that.titles,_that.aliases,_that.birth,_that.death,_that.deathPlace,_that.atAGlance,_that.memberships,_that.relations,_that.sections,_that.storyIds,_that.timeline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanionDto implements CompanionDto {
  const _CompanionDto({required this.schemaVersion, required this.id, required this.gender, required this.name, required this.fullName, required this.summary, required this.review, required final  List<String> references, this.order, this.lineage, this.kunya, final  List<LocalizedTextDto> titles = const <LocalizedTextDto>[], final  List<String> aliases = const <String>[], this.birth, this.death, this.deathPlace, final  List<FactDto> atAGlance = const <FactDto>[], final  List<MembershipDto> memberships = const <MembershipDto>[], final  List<RelationDto> relations = const <RelationDto>[], final  List<BiographySectionDto> sections = const <BiographySectionDto>[], final  List<String> storyIds = const <String>[], final  List<TimelineEventDto> timeline = const <TimelineEventDto>[]}): _references = references,_titles = titles,_aliases = aliases,_atAGlance = atAGlance,_memberships = memberships,_relations = relations,_sections = sections,_storyIds = storyIds,_timeline = timeline;
  factory _CompanionDto.fromJson(Map<String, dynamic> json) => _$CompanionDtoFromJson(json);

@override final  int schemaVersion;
@override final  String id;
@override final  Gender gender;
@override final  LocalizedTextDto name;
@override final  LocalizedTextDto fullName;
@override final  LocalizedTextDto summary;
@override final  ReviewDto review;
 final  List<String> _references;
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

@override final  int? order;
@override final  LocalizedTextDto? lineage;
@override final  LocalizedTextDto? kunya;
 final  List<LocalizedTextDto> _titles;
@override@JsonKey() List<LocalizedTextDto> get titles {
  if (_titles is EqualUnmodifiableListView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_titles);
}

 final  List<String> _aliases;
@override@JsonKey() List<String> get aliases {
  if (_aliases is EqualUnmodifiableListView) return _aliases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aliases);
}

@override final  DatedClaimDto? birth;
@override final  DatedClaimDto? death;
@override final  LocalizedTextDto? deathPlace;
 final  List<FactDto> _atAGlance;
@override@JsonKey() List<FactDto> get atAGlance {
  if (_atAGlance is EqualUnmodifiableListView) return _atAGlance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_atAGlance);
}

 final  List<MembershipDto> _memberships;
@override@JsonKey() List<MembershipDto> get memberships {
  if (_memberships is EqualUnmodifiableListView) return _memberships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberships);
}

 final  List<RelationDto> _relations;
@override@JsonKey() List<RelationDto> get relations {
  if (_relations is EqualUnmodifiableListView) return _relations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relations);
}

 final  List<BiographySectionDto> _sections;
@override@JsonKey() List<BiographySectionDto> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

 final  List<String> _storyIds;
@override@JsonKey() List<String> get storyIds {
  if (_storyIds is EqualUnmodifiableListView) return _storyIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_storyIds);
}

 final  List<TimelineEventDto> _timeline;
@override@JsonKey() List<TimelineEventDto> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}


/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanionDtoCopyWith<_CompanionDto> get copyWith => __$CompanionDtoCopyWithImpl<_CompanionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanionDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._references, _references)&&(identical(other.order, order) || other.order == order)&&(identical(other.lineage, lineage) || other.lineage == lineage)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other._titles, _titles)&&const DeepCollectionEquality().equals(other._aliases, _aliases)&&(identical(other.birth, birth) || other.birth == birth)&&(identical(other.death, death) || other.death == death)&&(identical(other.deathPlace, deathPlace) || other.deathPlace == deathPlace)&&const DeepCollectionEquality().equals(other._atAGlance, _atAGlance)&&const DeepCollectionEquality().equals(other._memberships, _memberships)&&const DeepCollectionEquality().equals(other._relations, _relations)&&const DeepCollectionEquality().equals(other._sections, _sections)&&const DeepCollectionEquality().equals(other._storyIds, _storyIds)&&const DeepCollectionEquality().equals(other._timeline, _timeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,schemaVersion,id,gender,name,fullName,summary,review,const DeepCollectionEquality().hash(_references),order,lineage,kunya,const DeepCollectionEquality().hash(_titles),const DeepCollectionEquality().hash(_aliases),birth,death,deathPlace,const DeepCollectionEquality().hash(_atAGlance),const DeepCollectionEquality().hash(_memberships),const DeepCollectionEquality().hash(_relations),const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_storyIds),const DeepCollectionEquality().hash(_timeline)]);

@override
String toString() {
  return 'CompanionDto(schemaVersion: $schemaVersion, id: $id, gender: $gender, name: $name, fullName: $fullName, summary: $summary, review: $review, references: $references, order: $order, lineage: $lineage, kunya: $kunya, titles: $titles, aliases: $aliases, birth: $birth, death: $death, deathPlace: $deathPlace, atAGlance: $atAGlance, memberships: $memberships, relations: $relations, sections: $sections, storyIds: $storyIds, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class _$CompanionDtoCopyWith<$Res> implements $CompanionDtoCopyWith<$Res> {
  factory _$CompanionDtoCopyWith(_CompanionDto value, $Res Function(_CompanionDto) _then) = __$CompanionDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String id, Gender gender, LocalizedTextDto name, LocalizedTextDto fullName, LocalizedTextDto summary, ReviewDto review, List<String> references, int? order, LocalizedTextDto? lineage, LocalizedTextDto? kunya, List<LocalizedTextDto> titles, List<String> aliases, DatedClaimDto? birth, DatedClaimDto? death, LocalizedTextDto? deathPlace, List<FactDto> atAGlance, List<MembershipDto> memberships, List<RelationDto> relations, List<BiographySectionDto> sections, List<String> storyIds, List<TimelineEventDto> timeline
});


@override $LocalizedTextDtoCopyWith<$Res> get name;@override $LocalizedTextDtoCopyWith<$Res> get fullName;@override $LocalizedTextDtoCopyWith<$Res> get summary;@override $ReviewDtoCopyWith<$Res> get review;@override $LocalizedTextDtoCopyWith<$Res>? get lineage;@override $LocalizedTextDtoCopyWith<$Res>? get kunya;@override $DatedClaimDtoCopyWith<$Res>? get birth;@override $DatedClaimDtoCopyWith<$Res>? get death;@override $LocalizedTextDtoCopyWith<$Res>? get deathPlace;

}
/// @nodoc
class __$CompanionDtoCopyWithImpl<$Res>
    implements _$CompanionDtoCopyWith<$Res> {
  __$CompanionDtoCopyWithImpl(this._self, this._then);

  final _CompanionDto _self;
  final $Res Function(_CompanionDto) _then;

/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? id = null,Object? gender = null,Object? name = null,Object? fullName = null,Object? summary = null,Object? review = null,Object? references = null,Object? order = freezed,Object? lineage = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? birth = freezed,Object? death = freezed,Object? deathPlace = freezed,Object? atAGlance = null,Object? memberships = null,Object? relations = null,Object? sections = null,Object? storyIds = null,Object? timeline = null,}) {
  return _then(_CompanionDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,lineage: freezed == lineage ? _self.lineage : lineage // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedTextDto>,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,birth: freezed == birth ? _self.birth : birth // ignore: cast_nullable_to_non_nullable
as DatedClaimDto?,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as DatedClaimDto?,deathPlace: freezed == deathPlace ? _self.deathPlace : deathPlace // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,atAGlance: null == atAGlance ? _self._atAGlance : atAGlance // ignore: cast_nullable_to_non_nullable
as List<FactDto>,memberships: null == memberships ? _self._memberships : memberships // ignore: cast_nullable_to_non_nullable
as List<MembershipDto>,relations: null == relations ? _self._relations : relations // ignore: cast_nullable_to_non_nullable
as List<RelationDto>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<BiographySectionDto>,storyIds: null == storyIds ? _self._storyIds : storyIds // ignore: cast_nullable_to_non_nullable
as List<String>,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineEventDto>,
  ));
}

/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get fullName {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get lineage {
    if (_self.lineage == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.lineage!, (value) {
    return _then(_self.copyWith(lineage: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimDtoCopyWith<$Res>? get birth {
    if (_self.birth == null) {
    return null;
  }

  return $DatedClaimDtoCopyWith<$Res>(_self.birth!, (value) {
    return _then(_self.copyWith(birth: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimDtoCopyWith<$Res>? get death {
    if (_self.death == null) {
    return null;
  }

  return $DatedClaimDtoCopyWith<$Res>(_self.death!, (value) {
    return _then(_self.copyWith(death: value));
  });
}/// Create a copy of CompanionDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get deathPlace {
    if (_self.deathPlace == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.deathPlace!, (value) {
    return _then(_self.copyWith(deathPlace: value));
  });
}
}


/// @nodoc
mixin _$CompanionSummaryDto {

 String get id; Gender get gender; LocalizedTextDto get name; LocalizedTextDto get summary; ReviewDto get review; int? get order; LocalizedTextDto? get kunya; List<LocalizedTextDto> get titles; List<String> get aliases; List<String> get categoryIds; HistoricalDateDto? get death;
/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanionSummaryDtoCopyWith<CompanionSummaryDto> get copyWith => _$CompanionSummaryDtoCopyWithImpl<CompanionSummaryDto>(this as CompanionSummaryDto, _$identity);

  /// Serializes this CompanionSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanionSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&(identical(other.order, order) || other.order == order)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other.titles, titles)&&const DeepCollectionEquality().equals(other.aliases, aliases)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&(identical(other.death, death) || other.death == death));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gender,name,summary,review,order,kunya,const DeepCollectionEquality().hash(titles),const DeepCollectionEquality().hash(aliases),const DeepCollectionEquality().hash(categoryIds),death);

@override
String toString() {
  return 'CompanionSummaryDto(id: $id, gender: $gender, name: $name, summary: $summary, review: $review, order: $order, kunya: $kunya, titles: $titles, aliases: $aliases, categoryIds: $categoryIds, death: $death)';
}


}

/// @nodoc
abstract mixin class $CompanionSummaryDtoCopyWith<$Res>  {
  factory $CompanionSummaryDtoCopyWith(CompanionSummaryDto value, $Res Function(CompanionSummaryDto) _then) = _$CompanionSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, Gender gender, LocalizedTextDto name, LocalizedTextDto summary, ReviewDto review, int? order, LocalizedTextDto? kunya, List<LocalizedTextDto> titles, List<String> aliases, List<String> categoryIds, HistoricalDateDto? death
});


$LocalizedTextDtoCopyWith<$Res> get name;$LocalizedTextDtoCopyWith<$Res> get summary;$ReviewDtoCopyWith<$Res> get review;$LocalizedTextDtoCopyWith<$Res>? get kunya;$HistoricalDateDtoCopyWith<$Res>? get death;

}
/// @nodoc
class _$CompanionSummaryDtoCopyWithImpl<$Res>
    implements $CompanionSummaryDtoCopyWith<$Res> {
  _$CompanionSummaryDtoCopyWithImpl(this._self, this._then);

  final CompanionSummaryDto _self;
  final $Res Function(CompanionSummaryDto) _then;

/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? gender = null,Object? name = null,Object? summary = null,Object? review = null,Object? order = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? categoryIds = null,Object? death = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedTextDto>,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto?,
  ));
}
/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res>? get death {
    if (_self.death == null) {
    return null;
  }

  return $HistoricalDateDtoCopyWith<$Res>(_self.death!, (value) {
    return _then(_self.copyWith(death: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompanionSummaryDto].
extension CompanionSummaryDtoPatterns on CompanionSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanionSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanionSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanionSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _CompanionSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanionSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompanionSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Gender gender,  LocalizedTextDto name,  LocalizedTextDto summary,  ReviewDto review,  int? order,  LocalizedTextDto? kunya,  List<LocalizedTextDto> titles,  List<String> aliases,  List<String> categoryIds,  HistoricalDateDto? death)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanionSummaryDto() when $default != null:
return $default(_that.id,_that.gender,_that.name,_that.summary,_that.review,_that.order,_that.kunya,_that.titles,_that.aliases,_that.categoryIds,_that.death);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Gender gender,  LocalizedTextDto name,  LocalizedTextDto summary,  ReviewDto review,  int? order,  LocalizedTextDto? kunya,  List<LocalizedTextDto> titles,  List<String> aliases,  List<String> categoryIds,  HistoricalDateDto? death)  $default,) {final _that = this;
switch (_that) {
case _CompanionSummaryDto():
return $default(_that.id,_that.gender,_that.name,_that.summary,_that.review,_that.order,_that.kunya,_that.titles,_that.aliases,_that.categoryIds,_that.death);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Gender gender,  LocalizedTextDto name,  LocalizedTextDto summary,  ReviewDto review,  int? order,  LocalizedTextDto? kunya,  List<LocalizedTextDto> titles,  List<String> aliases,  List<String> categoryIds,  HistoricalDateDto? death)?  $default,) {final _that = this;
switch (_that) {
case _CompanionSummaryDto() when $default != null:
return $default(_that.id,_that.gender,_that.name,_that.summary,_that.review,_that.order,_that.kunya,_that.titles,_that.aliases,_that.categoryIds,_that.death);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanionSummaryDto implements CompanionSummaryDto {
  const _CompanionSummaryDto({required this.id, required this.gender, required this.name, required this.summary, required this.review, this.order, this.kunya, final  List<LocalizedTextDto> titles = const <LocalizedTextDto>[], final  List<String> aliases = const <String>[], final  List<String> categoryIds = const <String>[], this.death}): _titles = titles,_aliases = aliases,_categoryIds = categoryIds;
  factory _CompanionSummaryDto.fromJson(Map<String, dynamic> json) => _$CompanionSummaryDtoFromJson(json);

@override final  String id;
@override final  Gender gender;
@override final  LocalizedTextDto name;
@override final  LocalizedTextDto summary;
@override final  ReviewDto review;
@override final  int? order;
@override final  LocalizedTextDto? kunya;
 final  List<LocalizedTextDto> _titles;
@override@JsonKey() List<LocalizedTextDto> get titles {
  if (_titles is EqualUnmodifiableListView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_titles);
}

 final  List<String> _aliases;
@override@JsonKey() List<String> get aliases {
  if (_aliases is EqualUnmodifiableListView) return _aliases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aliases);
}

 final  List<String> _categoryIds;
@override@JsonKey() List<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categoryIds);
}

@override final  HistoricalDateDto? death;

/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanionSummaryDtoCopyWith<_CompanionSummaryDto> get copyWith => __$CompanionSummaryDtoCopyWithImpl<_CompanionSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanionSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanionSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&(identical(other.order, order) || other.order == order)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other._titles, _titles)&&const DeepCollectionEquality().equals(other._aliases, _aliases)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&(identical(other.death, death) || other.death == death));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gender,name,summary,review,order,kunya,const DeepCollectionEquality().hash(_titles),const DeepCollectionEquality().hash(_aliases),const DeepCollectionEquality().hash(_categoryIds),death);

@override
String toString() {
  return 'CompanionSummaryDto(id: $id, gender: $gender, name: $name, summary: $summary, review: $review, order: $order, kunya: $kunya, titles: $titles, aliases: $aliases, categoryIds: $categoryIds, death: $death)';
}


}

/// @nodoc
abstract mixin class _$CompanionSummaryDtoCopyWith<$Res> implements $CompanionSummaryDtoCopyWith<$Res> {
  factory _$CompanionSummaryDtoCopyWith(_CompanionSummaryDto value, $Res Function(_CompanionSummaryDto) _then) = __$CompanionSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, Gender gender, LocalizedTextDto name, LocalizedTextDto summary, ReviewDto review, int? order, LocalizedTextDto? kunya, List<LocalizedTextDto> titles, List<String> aliases, List<String> categoryIds, HistoricalDateDto? death
});


@override $LocalizedTextDtoCopyWith<$Res> get name;@override $LocalizedTextDtoCopyWith<$Res> get summary;@override $ReviewDtoCopyWith<$Res> get review;@override $LocalizedTextDtoCopyWith<$Res>? get kunya;@override $HistoricalDateDtoCopyWith<$Res>? get death;

}
/// @nodoc
class __$CompanionSummaryDtoCopyWithImpl<$Res>
    implements _$CompanionSummaryDtoCopyWith<$Res> {
  __$CompanionSummaryDtoCopyWithImpl(this._self, this._then);

  final _CompanionSummaryDto _self;
  final $Res Function(_CompanionSummaryDto) _then;

/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? gender = null,Object? name = null,Object? summary = null,Object? review = null,Object? order = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? categoryIds = null,Object? death = freezed,}) {
  return _then(_CompanionSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedTextDto>,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto?,
  ));
}

/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}/// Create a copy of CompanionSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res>? get death {
    if (_self.death == null) {
    return null;
  }

  return $HistoricalDateDtoCopyWith<$Res>(_self.death!, (value) {
    return _then(_self.copyWith(death: value));
  });
}
}


/// @nodoc
mixin _$CompanionIndexDto {

 int get schemaVersion; List<CompanionSummaryDto> get companions;
/// Create a copy of CompanionIndexDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanionIndexDtoCopyWith<CompanionIndexDto> get copyWith => _$CompanionIndexDtoCopyWithImpl<CompanionIndexDto>(this as CompanionIndexDto, _$identity);

  /// Serializes this CompanionIndexDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanionIndexDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.companions, companions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(companions));

@override
String toString() {
  return 'CompanionIndexDto(schemaVersion: $schemaVersion, companions: $companions)';
}


}

/// @nodoc
abstract mixin class $CompanionIndexDtoCopyWith<$Res>  {
  factory $CompanionIndexDtoCopyWith(CompanionIndexDto value, $Res Function(CompanionIndexDto) _then) = _$CompanionIndexDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<CompanionSummaryDto> companions
});




}
/// @nodoc
class _$CompanionIndexDtoCopyWithImpl<$Res>
    implements $CompanionIndexDtoCopyWith<$Res> {
  _$CompanionIndexDtoCopyWithImpl(this._self, this._then);

  final CompanionIndexDto _self;
  final $Res Function(CompanionIndexDto) _then;

/// Create a copy of CompanionIndexDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? companions = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,companions: null == companions ? _self.companions : companions // ignore: cast_nullable_to_non_nullable
as List<CompanionSummaryDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanionIndexDto].
extension CompanionIndexDtoPatterns on CompanionIndexDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanionIndexDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanionIndexDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanionIndexDto value)  $default,){
final _that = this;
switch (_that) {
case _CompanionIndexDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanionIndexDto value)?  $default,){
final _that = this;
switch (_that) {
case _CompanionIndexDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<CompanionSummaryDto> companions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanionIndexDto() when $default != null:
return $default(_that.schemaVersion,_that.companions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<CompanionSummaryDto> companions)  $default,) {final _that = this;
switch (_that) {
case _CompanionIndexDto():
return $default(_that.schemaVersion,_that.companions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<CompanionSummaryDto> companions)?  $default,) {final _that = this;
switch (_that) {
case _CompanionIndexDto() when $default != null:
return $default(_that.schemaVersion,_that.companions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanionIndexDto implements CompanionIndexDto {
  const _CompanionIndexDto({required this.schemaVersion, required final  List<CompanionSummaryDto> companions}): _companions = companions;
  factory _CompanionIndexDto.fromJson(Map<String, dynamic> json) => _$CompanionIndexDtoFromJson(json);

@override final  int schemaVersion;
 final  List<CompanionSummaryDto> _companions;
@override List<CompanionSummaryDto> get companions {
  if (_companions is EqualUnmodifiableListView) return _companions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companions);
}


/// Create a copy of CompanionIndexDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanionIndexDtoCopyWith<_CompanionIndexDto> get copyWith => __$CompanionIndexDtoCopyWithImpl<_CompanionIndexDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanionIndexDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanionIndexDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._companions, _companions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_companions));

@override
String toString() {
  return 'CompanionIndexDto(schemaVersion: $schemaVersion, companions: $companions)';
}


}

/// @nodoc
abstract mixin class _$CompanionIndexDtoCopyWith<$Res> implements $CompanionIndexDtoCopyWith<$Res> {
  factory _$CompanionIndexDtoCopyWith(_CompanionIndexDto value, $Res Function(_CompanionIndexDto) _then) = __$CompanionIndexDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<CompanionSummaryDto> companions
});




}
/// @nodoc
class __$CompanionIndexDtoCopyWithImpl<$Res>
    implements _$CompanionIndexDtoCopyWith<$Res> {
  __$CompanionIndexDtoCopyWithImpl(this._self, this._then);

  final _CompanionIndexDto _self;
  final $Res Function(_CompanionIndexDto) _then;

/// Create a copy of CompanionIndexDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? companions = null,}) {
  return _then(_CompanionIndexDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,companions: null == companions ? _self._companions : companions // ignore: cast_nullable_to_non_nullable
as List<CompanionSummaryDto>,
  ));
}


}

// dart format on
