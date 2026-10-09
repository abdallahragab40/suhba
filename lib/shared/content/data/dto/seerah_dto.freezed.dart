// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seerah_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeerahEraDto {

 String get id; LocalizedTextDto get name; HistoricalDateDto get date; LocalizedTextDto get summary; Reliability get reliability; List<CitationDto> get citations; List<String> get chapterIds;
/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahEraDtoCopyWith<SeerahEraDto> get copyWith => _$SeerahEraDtoCopyWithImpl<SeerahEraDto>(this as SeerahEraDto, _$identity);

  /// Serializes this SeerahEraDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahEraDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&const DeepCollectionEquality().equals(other.chapterIds, chapterIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,date,summary,reliability,const DeepCollectionEquality().hash(citations),const DeepCollectionEquality().hash(chapterIds));

@override
String toString() {
  return 'SeerahEraDto(id: $id, name: $name, date: $date, summary: $summary, reliability: $reliability, citations: $citations, chapterIds: $chapterIds)';
}


}

/// @nodoc
abstract mixin class $SeerahEraDtoCopyWith<$Res>  {
  factory $SeerahEraDtoCopyWith(SeerahEraDto value, $Res Function(SeerahEraDto) _then) = _$SeerahEraDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto name, HistoricalDateDto date, LocalizedTextDto summary, Reliability reliability, List<CitationDto> citations, List<String> chapterIds
});


$LocalizedTextDtoCopyWith<$Res> get name;$HistoricalDateDtoCopyWith<$Res> get date;$LocalizedTextDtoCopyWith<$Res> get summary;

}
/// @nodoc
class _$SeerahEraDtoCopyWithImpl<$Res>
    implements $SeerahEraDtoCopyWith<$Res> {
  _$SeerahEraDtoCopyWithImpl(this._self, this._then);

  final SeerahEraDto _self;
  final $Res Function(SeerahEraDto) _then;

/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? chapterIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,chapterIds: null == chapterIds ? _self.chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahEraDto].
extension SeerahEraDtoPatterns on SeerahEraDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahEraDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahEraDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahEraDto value)  $default,){
final _that = this;
switch (_that) {
case _SeerahEraDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahEraDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahEraDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  HistoricalDateDto date,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  List<String> chapterIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahEraDto() when $default != null:
return $default(_that.id,_that.name,_that.date,_that.summary,_that.reliability,_that.citations,_that.chapterIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  HistoricalDateDto date,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  List<String> chapterIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahEraDto():
return $default(_that.id,_that.name,_that.date,_that.summary,_that.reliability,_that.citations,_that.chapterIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto name,  HistoricalDateDto date,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  List<String> chapterIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahEraDto() when $default != null:
return $default(_that.id,_that.name,_that.date,_that.summary,_that.reliability,_that.citations,_that.chapterIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeerahEraDto implements SeerahEraDto {
  const _SeerahEraDto({required this.id, required this.name, required this.date, required this.summary, required this.reliability, required final  List<CitationDto> citations, required final  List<String> chapterIds}): _citations = citations,_chapterIds = chapterIds;
  factory _SeerahEraDto.fromJson(Map<String, dynamic> json) => _$SeerahEraDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto name;
@override final  HistoricalDateDto date;
@override final  LocalizedTextDto summary;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

 final  List<String> _chapterIds;
@override List<String> get chapterIds {
  if (_chapterIds is EqualUnmodifiableListView) return _chapterIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapterIds);
}


/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahEraDtoCopyWith<_SeerahEraDto> get copyWith => __$SeerahEraDtoCopyWithImpl<_SeerahEraDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeerahEraDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahEraDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&const DeepCollectionEquality().equals(other._chapterIds, _chapterIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,date,summary,reliability,const DeepCollectionEquality().hash(_citations),const DeepCollectionEquality().hash(_chapterIds));

@override
String toString() {
  return 'SeerahEraDto(id: $id, name: $name, date: $date, summary: $summary, reliability: $reliability, citations: $citations, chapterIds: $chapterIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahEraDtoCopyWith<$Res> implements $SeerahEraDtoCopyWith<$Res> {
  factory _$SeerahEraDtoCopyWith(_SeerahEraDto value, $Res Function(_SeerahEraDto) _then) = __$SeerahEraDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto name, HistoricalDateDto date, LocalizedTextDto summary, Reliability reliability, List<CitationDto> citations, List<String> chapterIds
});


@override $LocalizedTextDtoCopyWith<$Res> get name;@override $HistoricalDateDtoCopyWith<$Res> get date;@override $LocalizedTextDtoCopyWith<$Res> get summary;

}
/// @nodoc
class __$SeerahEraDtoCopyWithImpl<$Res>
    implements _$SeerahEraDtoCopyWith<$Res> {
  __$SeerahEraDtoCopyWithImpl(this._self, this._then);

  final _SeerahEraDto _self;
  final $Res Function(_SeerahEraDto) _then;

/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? chapterIds = null,}) {
  return _then(_SeerahEraDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,chapterIds: null == chapterIds ? _self._chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of SeerahEraDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// @nodoc
mixin _$SeerahDto {

 int get schemaVersion; LocalizedTextDto get title; LocalizedTextDto get subtitle; List<ContentBlockDto> get introduction; List<SeerahEraDto> get eras; List<String> get chapterIds; List<String> get topicIds; LocalizedTextDto get methodology; List<String> get references; ReviewDto get review; List<String> get featuredEventIds; List<String> get featuredPlaceIds; List<String> get companionIds; List<String> get visualIds;
/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahDtoCopyWith<SeerahDto> get copyWith => _$SeerahDtoCopyWithImpl<SeerahDto>(this as SeerahDto, _$identity);

  /// Serializes this SeerahDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other.introduction, introduction)&&const DeepCollectionEquality().equals(other.eras, eras)&&const DeepCollectionEquality().equals(other.chapterIds, chapterIds)&&const DeepCollectionEquality().equals(other.topicIds, topicIds)&&(identical(other.methodology, methodology) || other.methodology == methodology)&&const DeepCollectionEquality().equals(other.references, references)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.featuredEventIds, featuredEventIds)&&const DeepCollectionEquality().equals(other.featuredPlaceIds, featuredPlaceIds)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&const DeepCollectionEquality().equals(other.visualIds, visualIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,title,subtitle,const DeepCollectionEquality().hash(introduction),const DeepCollectionEquality().hash(eras),const DeepCollectionEquality().hash(chapterIds),const DeepCollectionEquality().hash(topicIds),methodology,const DeepCollectionEquality().hash(references),review,const DeepCollectionEquality().hash(featuredEventIds),const DeepCollectionEquality().hash(featuredPlaceIds),const DeepCollectionEquality().hash(companionIds),const DeepCollectionEquality().hash(visualIds));

@override
String toString() {
  return 'SeerahDto(schemaVersion: $schemaVersion, title: $title, subtitle: $subtitle, introduction: $introduction, eras: $eras, chapterIds: $chapterIds, topicIds: $topicIds, methodology: $methodology, references: $references, review: $review, featuredEventIds: $featuredEventIds, featuredPlaceIds: $featuredPlaceIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class $SeerahDtoCopyWith<$Res>  {
  factory $SeerahDtoCopyWith(SeerahDto value, $Res Function(SeerahDto) _then) = _$SeerahDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, LocalizedTextDto title, LocalizedTextDto subtitle, List<ContentBlockDto> introduction, List<SeerahEraDto> eras, List<String> chapterIds, List<String> topicIds, LocalizedTextDto methodology, List<String> references, ReviewDto review, List<String> featuredEventIds, List<String> featuredPlaceIds, List<String> companionIds, List<String> visualIds
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get subtitle;$LocalizedTextDtoCopyWith<$Res> get methodology;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahDtoCopyWithImpl<$Res>
    implements $SeerahDtoCopyWith<$Res> {
  _$SeerahDtoCopyWithImpl(this._self, this._then);

  final SeerahDto _self;
  final $Res Function(SeerahDto) _then;

/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? title = null,Object? subtitle = null,Object? introduction = null,Object? eras = null,Object? chapterIds = null,Object? topicIds = null,Object? methodology = null,Object? references = null,Object? review = null,Object? featuredEventIds = null,Object? featuredPlaceIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,introduction: null == introduction ? _self.introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,eras: null == eras ? _self.eras : eras // ignore: cast_nullable_to_non_nullable
as List<SeerahEraDto>,chapterIds: null == chapterIds ? _self.chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,topicIds: null == topicIds ? _self.topicIds : topicIds // ignore: cast_nullable_to_non_nullable
as List<String>,methodology: null == methodology ? _self.methodology : methodology // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,featuredEventIds: null == featuredEventIds ? _self.featuredEventIds : featuredEventIds // ignore: cast_nullable_to_non_nullable
as List<String>,featuredPlaceIds: null == featuredPlaceIds ? _self.featuredPlaceIds : featuredPlaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self.visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get subtitle {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.subtitle, (value) {
    return _then(_self.copyWith(subtitle: value));
  });
}/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get methodology {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.methodology, (value) {
    return _then(_self.copyWith(methodology: value));
  });
}/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahDto].
extension SeerahDtoPatterns on SeerahDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahDto value)  $default,){
final _that = this;
switch (_that) {
case _SeerahDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  LocalizedTextDto title,  LocalizedTextDto subtitle,  List<ContentBlockDto> introduction,  List<SeerahEraDto> eras,  List<String> chapterIds,  List<String> topicIds,  LocalizedTextDto methodology,  List<String> references,  ReviewDto review,  List<String> featuredEventIds,  List<String> featuredPlaceIds,  List<String> companionIds,  List<String> visualIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahDto() when $default != null:
return $default(_that.schemaVersion,_that.title,_that.subtitle,_that.introduction,_that.eras,_that.chapterIds,_that.topicIds,_that.methodology,_that.references,_that.review,_that.featuredEventIds,_that.featuredPlaceIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  LocalizedTextDto title,  LocalizedTextDto subtitle,  List<ContentBlockDto> introduction,  List<SeerahEraDto> eras,  List<String> chapterIds,  List<String> topicIds,  LocalizedTextDto methodology,  List<String> references,  ReviewDto review,  List<String> featuredEventIds,  List<String> featuredPlaceIds,  List<String> companionIds,  List<String> visualIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahDto():
return $default(_that.schemaVersion,_that.title,_that.subtitle,_that.introduction,_that.eras,_that.chapterIds,_that.topicIds,_that.methodology,_that.references,_that.review,_that.featuredEventIds,_that.featuredPlaceIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  LocalizedTextDto title,  LocalizedTextDto subtitle,  List<ContentBlockDto> introduction,  List<SeerahEraDto> eras,  List<String> chapterIds,  List<String> topicIds,  LocalizedTextDto methodology,  List<String> references,  ReviewDto review,  List<String> featuredEventIds,  List<String> featuredPlaceIds,  List<String> companionIds,  List<String> visualIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahDto() when $default != null:
return $default(_that.schemaVersion,_that.title,_that.subtitle,_that.introduction,_that.eras,_that.chapterIds,_that.topicIds,_that.methodology,_that.references,_that.review,_that.featuredEventIds,_that.featuredPlaceIds,_that.companionIds,_that.visualIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeerahDto implements SeerahDto {
  const _SeerahDto({required this.schemaVersion, required this.title, required this.subtitle, required final  List<ContentBlockDto> introduction, required final  List<SeerahEraDto> eras, required final  List<String> chapterIds, required final  List<String> topicIds, required this.methodology, required final  List<String> references, required this.review, final  List<String> featuredEventIds = const <String>[], final  List<String> featuredPlaceIds = const <String>[], final  List<String> companionIds = const <String>[], final  List<String> visualIds = const <String>[]}): _introduction = introduction,_eras = eras,_chapterIds = chapterIds,_topicIds = topicIds,_references = references,_featuredEventIds = featuredEventIds,_featuredPlaceIds = featuredPlaceIds,_companionIds = companionIds,_visualIds = visualIds;
  factory _SeerahDto.fromJson(Map<String, dynamic> json) => _$SeerahDtoFromJson(json);

@override final  int schemaVersion;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto subtitle;
 final  List<ContentBlockDto> _introduction;
@override List<ContentBlockDto> get introduction {
  if (_introduction is EqualUnmodifiableListView) return _introduction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_introduction);
}

 final  List<SeerahEraDto> _eras;
@override List<SeerahEraDto> get eras {
  if (_eras is EqualUnmodifiableListView) return _eras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eras);
}

 final  List<String> _chapterIds;
@override List<String> get chapterIds {
  if (_chapterIds is EqualUnmodifiableListView) return _chapterIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapterIds);
}

 final  List<String> _topicIds;
@override List<String> get topicIds {
  if (_topicIds is EqualUnmodifiableListView) return _topicIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topicIds);
}

@override final  LocalizedTextDto methodology;
 final  List<String> _references;
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

@override final  ReviewDto review;
 final  List<String> _featuredEventIds;
@override@JsonKey() List<String> get featuredEventIds {
  if (_featuredEventIds is EqualUnmodifiableListView) return _featuredEventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredEventIds);
}

 final  List<String> _featuredPlaceIds;
@override@JsonKey() List<String> get featuredPlaceIds {
  if (_featuredPlaceIds is EqualUnmodifiableListView) return _featuredPlaceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_featuredPlaceIds);
}

 final  List<String> _companionIds;
@override@JsonKey() List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}

 final  List<String> _visualIds;
@override@JsonKey() List<String> get visualIds {
  if (_visualIds is EqualUnmodifiableListView) return _visualIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visualIds);
}


/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahDtoCopyWith<_SeerahDto> get copyWith => __$SeerahDtoCopyWithImpl<_SeerahDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeerahDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other._introduction, _introduction)&&const DeepCollectionEquality().equals(other._eras, _eras)&&const DeepCollectionEquality().equals(other._chapterIds, _chapterIds)&&const DeepCollectionEquality().equals(other._topicIds, _topicIds)&&(identical(other.methodology, methodology) || other.methodology == methodology)&&const DeepCollectionEquality().equals(other._references, _references)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._featuredEventIds, _featuredEventIds)&&const DeepCollectionEquality().equals(other._featuredPlaceIds, _featuredPlaceIds)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&const DeepCollectionEquality().equals(other._visualIds, _visualIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,title,subtitle,const DeepCollectionEquality().hash(_introduction),const DeepCollectionEquality().hash(_eras),const DeepCollectionEquality().hash(_chapterIds),const DeepCollectionEquality().hash(_topicIds),methodology,const DeepCollectionEquality().hash(_references),review,const DeepCollectionEquality().hash(_featuredEventIds),const DeepCollectionEquality().hash(_featuredPlaceIds),const DeepCollectionEquality().hash(_companionIds),const DeepCollectionEquality().hash(_visualIds));

@override
String toString() {
  return 'SeerahDto(schemaVersion: $schemaVersion, title: $title, subtitle: $subtitle, introduction: $introduction, eras: $eras, chapterIds: $chapterIds, topicIds: $topicIds, methodology: $methodology, references: $references, review: $review, featuredEventIds: $featuredEventIds, featuredPlaceIds: $featuredPlaceIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahDtoCopyWith<$Res> implements $SeerahDtoCopyWith<$Res> {
  factory _$SeerahDtoCopyWith(_SeerahDto value, $Res Function(_SeerahDto) _then) = __$SeerahDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, LocalizedTextDto title, LocalizedTextDto subtitle, List<ContentBlockDto> introduction, List<SeerahEraDto> eras, List<String> chapterIds, List<String> topicIds, LocalizedTextDto methodology, List<String> references, ReviewDto review, List<String> featuredEventIds, List<String> featuredPlaceIds, List<String> companionIds, List<String> visualIds
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get subtitle;@override $LocalizedTextDtoCopyWith<$Res> get methodology;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahDtoCopyWithImpl<$Res>
    implements _$SeerahDtoCopyWith<$Res> {
  __$SeerahDtoCopyWithImpl(this._self, this._then);

  final _SeerahDto _self;
  final $Res Function(_SeerahDto) _then;

/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? title = null,Object? subtitle = null,Object? introduction = null,Object? eras = null,Object? chapterIds = null,Object? topicIds = null,Object? methodology = null,Object? references = null,Object? review = null,Object? featuredEventIds = null,Object? featuredPlaceIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_SeerahDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,introduction: null == introduction ? _self._introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,eras: null == eras ? _self._eras : eras // ignore: cast_nullable_to_non_nullable
as List<SeerahEraDto>,chapterIds: null == chapterIds ? _self._chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,topicIds: null == topicIds ? _self._topicIds : topicIds // ignore: cast_nullable_to_non_nullable
as List<String>,methodology: null == methodology ? _self.methodology : methodology // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,featuredEventIds: null == featuredEventIds ? _self._featuredEventIds : featuredEventIds // ignore: cast_nullable_to_non_nullable
as List<String>,featuredPlaceIds: null == featuredPlaceIds ? _self._featuredPlaceIds : featuredPlaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self._visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get subtitle {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.subtitle, (value) {
    return _then(_self.copyWith(subtitle: value));
  });
}/// Create a copy of SeerahDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get methodology {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.methodology, (value) {
    return _then(_self.copyWith(methodology: value));
  });
}/// Create a copy of SeerahDto
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
mixin _$SeerahChapterDto {

 int get schemaVersion; String get id; LocalizedTextDto get title; LocalizedTextDto get abstract; SeerahEra get era; HistoricalDateDto get date; List<String> get references; List<ContentBlockDto> get blocks; ReviewDto get review; List<String> get eventIds; List<String> get placeIds; List<String> get companionIds; List<String> get visualIds;
/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahChapterDtoCopyWith<SeerahChapterDto> get copyWith => _$SeerahChapterDtoCopyWithImpl<SeerahChapterDto>(this as SeerahChapterDto, _$identity);

  /// Serializes this SeerahChapterDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahChapterDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.references, references)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.eventIds, eventIds)&&const DeepCollectionEquality().equals(other.placeIds, placeIds)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&const DeepCollectionEquality().equals(other.visualIds, visualIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,abstract,era,date,const DeepCollectionEquality().hash(references),const DeepCollectionEquality().hash(blocks),review,const DeepCollectionEquality().hash(eventIds),const DeepCollectionEquality().hash(placeIds),const DeepCollectionEquality().hash(companionIds),const DeepCollectionEquality().hash(visualIds));

@override
String toString() {
  return 'SeerahChapterDto(schemaVersion: $schemaVersion, id: $id, title: $title, abstract: $abstract, era: $era, date: $date, references: $references, blocks: $blocks, review: $review, eventIds: $eventIds, placeIds: $placeIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class $SeerahChapterDtoCopyWith<$Res>  {
  factory $SeerahChapterDtoCopyWith(SeerahChapterDto value, $Res Function(SeerahChapterDto) _then) = _$SeerahChapterDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto abstract, SeerahEra era, HistoricalDateDto date, List<String> references, List<ContentBlockDto> blocks, ReviewDto review, List<String> eventIds, List<String> placeIds, List<String> companionIds, List<String> visualIds
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get abstract;$HistoricalDateDtoCopyWith<$Res> get date;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahChapterDtoCopyWithImpl<$Res>
    implements $SeerahChapterDtoCopyWith<$Res> {
  _$SeerahChapterDtoCopyWithImpl(this._self, this._then);

  final SeerahChapterDto _self;
  final $Res Function(SeerahChapterDto) _then;

/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? references = null,Object? blocks = null,Object? review = null,Object? eventIds = null,Object? placeIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,placeIds: null == placeIds ? _self.placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self.visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahChapterDto].
extension SeerahChapterDtoPatterns on SeerahChapterDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahChapterDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahChapterDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahChapterDto value)  $default,){
final _that = this;
switch (_that) {
case _SeerahChapterDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahChapterDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahChapterDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  SeerahEra era,  HistoricalDateDto date,  List<String> references,  List<ContentBlockDto> blocks,  ReviewDto review,  List<String> eventIds,  List<String> placeIds,  List<String> companionIds,  List<String> visualIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahChapterDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.abstract,_that.era,_that.date,_that.references,_that.blocks,_that.review,_that.eventIds,_that.placeIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  SeerahEra era,  HistoricalDateDto date,  List<String> references,  List<ContentBlockDto> blocks,  ReviewDto review,  List<String> eventIds,  List<String> placeIds,  List<String> companionIds,  List<String> visualIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahChapterDto():
return $default(_that.schemaVersion,_that.id,_that.title,_that.abstract,_that.era,_that.date,_that.references,_that.blocks,_that.review,_that.eventIds,_that.placeIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  SeerahEra era,  HistoricalDateDto date,  List<String> references,  List<ContentBlockDto> blocks,  ReviewDto review,  List<String> eventIds,  List<String> placeIds,  List<String> companionIds,  List<String> visualIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahChapterDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.abstract,_that.era,_that.date,_that.references,_that.blocks,_that.review,_that.eventIds,_that.placeIds,_that.companionIds,_that.visualIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeerahChapterDto implements SeerahChapterDto {
  const _SeerahChapterDto({required this.schemaVersion, required this.id, required this.title, required this.abstract, required this.era, required this.date, required final  List<String> references, required final  List<ContentBlockDto> blocks, required this.review, final  List<String> eventIds = const <String>[], final  List<String> placeIds = const <String>[], final  List<String> companionIds = const <String>[], final  List<String> visualIds = const <String>[]}): _references = references,_blocks = blocks,_eventIds = eventIds,_placeIds = placeIds,_companionIds = companionIds,_visualIds = visualIds;
  factory _SeerahChapterDto.fromJson(Map<String, dynamic> json) => _$SeerahChapterDtoFromJson(json);

@override final  int schemaVersion;
@override final  String id;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto abstract;
@override final  SeerahEra era;
@override final  HistoricalDateDto date;
 final  List<String> _references;
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

 final  List<ContentBlockDto> _blocks;
@override List<ContentBlockDto> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

@override final  ReviewDto review;
 final  List<String> _eventIds;
@override@JsonKey() List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}

 final  List<String> _placeIds;
@override@JsonKey() List<String> get placeIds {
  if (_placeIds is EqualUnmodifiableListView) return _placeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placeIds);
}

 final  List<String> _companionIds;
@override@JsonKey() List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}

 final  List<String> _visualIds;
@override@JsonKey() List<String> get visualIds {
  if (_visualIds is EqualUnmodifiableListView) return _visualIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visualIds);
}


/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahChapterDtoCopyWith<_SeerahChapterDto> get copyWith => __$SeerahChapterDtoCopyWithImpl<_SeerahChapterDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeerahChapterDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahChapterDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._references, _references)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds)&&const DeepCollectionEquality().equals(other._placeIds, _placeIds)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&const DeepCollectionEquality().equals(other._visualIds, _visualIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,abstract,era,date,const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_blocks),review,const DeepCollectionEquality().hash(_eventIds),const DeepCollectionEquality().hash(_placeIds),const DeepCollectionEquality().hash(_companionIds),const DeepCollectionEquality().hash(_visualIds));

@override
String toString() {
  return 'SeerahChapterDto(schemaVersion: $schemaVersion, id: $id, title: $title, abstract: $abstract, era: $era, date: $date, references: $references, blocks: $blocks, review: $review, eventIds: $eventIds, placeIds: $placeIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahChapterDtoCopyWith<$Res> implements $SeerahChapterDtoCopyWith<$Res> {
  factory _$SeerahChapterDtoCopyWith(_SeerahChapterDto value, $Res Function(_SeerahChapterDto) _then) = __$SeerahChapterDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto abstract, SeerahEra era, HistoricalDateDto date, List<String> references, List<ContentBlockDto> blocks, ReviewDto review, List<String> eventIds, List<String> placeIds, List<String> companionIds, List<String> visualIds
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get abstract;@override $HistoricalDateDtoCopyWith<$Res> get date;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahChapterDtoCopyWithImpl<$Res>
    implements _$SeerahChapterDtoCopyWith<$Res> {
  __$SeerahChapterDtoCopyWithImpl(this._self, this._then);

  final _SeerahChapterDto _self;
  final $Res Function(_SeerahChapterDto) _then;

/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? references = null,Object? blocks = null,Object? review = null,Object? eventIds = null,Object? placeIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_SeerahChapterDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,placeIds: null == placeIds ? _self._placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self._visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapterDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of SeerahChapterDto
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
mixin _$SeerahTopicDto {

 int get schemaVersion; String get id; LocalizedTextDto get title; LocalizedTextDto get abstract; List<String> get references; List<ContentBlockDto> get blocks; ReviewDto get review; List<String> get chapterIds; List<String> get companionIds;
/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahTopicDtoCopyWith<SeerahTopicDto> get copyWith => _$SeerahTopicDtoCopyWithImpl<SeerahTopicDto>(this as SeerahTopicDto, _$identity);

  /// Serializes this SeerahTopicDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahTopicDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&const DeepCollectionEquality().equals(other.references, references)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.chapterIds, chapterIds)&&const DeepCollectionEquality().equals(other.companionIds, companionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,abstract,const DeepCollectionEquality().hash(references),const DeepCollectionEquality().hash(blocks),review,const DeepCollectionEquality().hash(chapterIds),const DeepCollectionEquality().hash(companionIds));

@override
String toString() {
  return 'SeerahTopicDto(schemaVersion: $schemaVersion, id: $id, title: $title, abstract: $abstract, references: $references, blocks: $blocks, review: $review, chapterIds: $chapterIds, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class $SeerahTopicDtoCopyWith<$Res>  {
  factory $SeerahTopicDtoCopyWith(SeerahTopicDto value, $Res Function(SeerahTopicDto) _then) = _$SeerahTopicDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto abstract, List<String> references, List<ContentBlockDto> blocks, ReviewDto review, List<String> chapterIds, List<String> companionIds
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get abstract;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahTopicDtoCopyWithImpl<$Res>
    implements $SeerahTopicDtoCopyWith<$Res> {
  _$SeerahTopicDtoCopyWithImpl(this._self, this._then);

  final SeerahTopicDto _self;
  final $Res Function(SeerahTopicDto) _then;

/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? abstract = null,Object? references = null,Object? blocks = null,Object? review = null,Object? chapterIds = null,Object? companionIds = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,chapterIds: null == chapterIds ? _self.chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahTopicDto].
extension SeerahTopicDtoPatterns on SeerahTopicDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahTopicDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahTopicDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahTopicDto value)  $default,){
final _that = this;
switch (_that) {
case _SeerahTopicDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahTopicDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahTopicDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  List<String> references,  List<ContentBlockDto> blocks,  ReviewDto review,  List<String> chapterIds,  List<String> companionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahTopicDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.abstract,_that.references,_that.blocks,_that.review,_that.chapterIds,_that.companionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  List<String> references,  List<ContentBlockDto> blocks,  ReviewDto review,  List<String> chapterIds,  List<String> companionIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahTopicDto():
return $default(_that.schemaVersion,_that.id,_that.title,_that.abstract,_that.references,_that.blocks,_that.review,_that.chapterIds,_that.companionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  List<String> references,  List<ContentBlockDto> blocks,  ReviewDto review,  List<String> chapterIds,  List<String> companionIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahTopicDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.title,_that.abstract,_that.references,_that.blocks,_that.review,_that.chapterIds,_that.companionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeerahTopicDto implements SeerahTopicDto {
  const _SeerahTopicDto({required this.schemaVersion, required this.id, required this.title, required this.abstract, required final  List<String> references, required final  List<ContentBlockDto> blocks, required this.review, final  List<String> chapterIds = const <String>[], final  List<String> companionIds = const <String>[]}): _references = references,_blocks = blocks,_chapterIds = chapterIds,_companionIds = companionIds;
  factory _SeerahTopicDto.fromJson(Map<String, dynamic> json) => _$SeerahTopicDtoFromJson(json);

@override final  int schemaVersion;
@override final  String id;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto abstract;
 final  List<String> _references;
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

 final  List<ContentBlockDto> _blocks;
@override List<ContentBlockDto> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

@override final  ReviewDto review;
 final  List<String> _chapterIds;
@override@JsonKey() List<String> get chapterIds {
  if (_chapterIds is EqualUnmodifiableListView) return _chapterIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapterIds);
}

 final  List<String> _companionIds;
@override@JsonKey() List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}


/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahTopicDtoCopyWith<_SeerahTopicDto> get copyWith => __$SeerahTopicDtoCopyWithImpl<_SeerahTopicDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeerahTopicDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahTopicDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&const DeepCollectionEquality().equals(other._references, _references)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._chapterIds, _chapterIds)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,title,abstract,const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_blocks),review,const DeepCollectionEquality().hash(_chapterIds),const DeepCollectionEquality().hash(_companionIds));

@override
String toString() {
  return 'SeerahTopicDto(schemaVersion: $schemaVersion, id: $id, title: $title, abstract: $abstract, references: $references, blocks: $blocks, review: $review, chapterIds: $chapterIds, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahTopicDtoCopyWith<$Res> implements $SeerahTopicDtoCopyWith<$Res> {
  factory _$SeerahTopicDtoCopyWith(_SeerahTopicDto value, $Res Function(_SeerahTopicDto) _then) = __$SeerahTopicDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String id, LocalizedTextDto title, LocalizedTextDto abstract, List<String> references, List<ContentBlockDto> blocks, ReviewDto review, List<String> chapterIds, List<String> companionIds
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get abstract;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahTopicDtoCopyWithImpl<$Res>
    implements _$SeerahTopicDtoCopyWith<$Res> {
  __$SeerahTopicDtoCopyWithImpl(this._self, this._then);

  final _SeerahTopicDto _self;
  final $Res Function(_SeerahTopicDto) _then;

/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? id = null,Object? title = null,Object? abstract = null,Object? references = null,Object? blocks = null,Object? review = null,Object? chapterIds = null,Object? companionIds = null,}) {
  return _then(_SeerahTopicDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlockDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,chapterIds: null == chapterIds ? _self._chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopicDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopicDto
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
mixin _$SeerahChapterSummaryDto {

 String get id; LocalizedTextDto get title; LocalizedTextDto get abstract; SeerahEra get era; HistoricalDateDto get date; ReviewDto get review; int get wordCount; List<String> get visualIds;
/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahChapterSummaryDtoCopyWith<SeerahChapterSummaryDto> get copyWith => _$SeerahChapterSummaryDtoCopyWithImpl<SeerahChapterSummaryDto>(this as SeerahChapterSummaryDto, _$identity);

  /// Serializes this SeerahChapterSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahChapterSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&const DeepCollectionEquality().equals(other.visualIds, visualIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,abstract,era,date,review,wordCount,const DeepCollectionEquality().hash(visualIds));

@override
String toString() {
  return 'SeerahChapterSummaryDto(id: $id, title: $title, abstract: $abstract, era: $era, date: $date, review: $review, wordCount: $wordCount, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class $SeerahChapterSummaryDtoCopyWith<$Res>  {
  factory $SeerahChapterSummaryDtoCopyWith(SeerahChapterSummaryDto value, $Res Function(SeerahChapterSummaryDto) _then) = _$SeerahChapterSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto title, LocalizedTextDto abstract, SeerahEra era, HistoricalDateDto date, ReviewDto review, int wordCount, List<String> visualIds
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get abstract;$HistoricalDateDtoCopyWith<$Res> get date;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahChapterSummaryDtoCopyWithImpl<$Res>
    implements $SeerahChapterSummaryDtoCopyWith<$Res> {
  _$SeerahChapterSummaryDtoCopyWithImpl(this._self, this._then);

  final SeerahChapterSummaryDto _self;
  final $Res Function(SeerahChapterSummaryDto) _then;

/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? review = null,Object? wordCount = null,Object? visualIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,visualIds: null == visualIds ? _self.visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahChapterSummaryDto].
extension SeerahChapterSummaryDtoPatterns on SeerahChapterSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahChapterSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahChapterSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahChapterSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _SeerahChapterSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahChapterSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahChapterSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  SeerahEra era,  HistoricalDateDto date,  ReviewDto review,  int wordCount,  List<String> visualIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahChapterSummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.abstract,_that.era,_that.date,_that.review,_that.wordCount,_that.visualIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  SeerahEra era,  HistoricalDateDto date,  ReviewDto review,  int wordCount,  List<String> visualIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahChapterSummaryDto():
return $default(_that.id,_that.title,_that.abstract,_that.era,_that.date,_that.review,_that.wordCount,_that.visualIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  SeerahEra era,  HistoricalDateDto date,  ReviewDto review,  int wordCount,  List<String> visualIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahChapterSummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.abstract,_that.era,_that.date,_that.review,_that.wordCount,_that.visualIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeerahChapterSummaryDto implements SeerahChapterSummaryDto {
  const _SeerahChapterSummaryDto({required this.id, required this.title, required this.abstract, required this.era, required this.date, required this.review, required this.wordCount, final  List<String> visualIds = const <String>[]}): _visualIds = visualIds;
  factory _SeerahChapterSummaryDto.fromJson(Map<String, dynamic> json) => _$SeerahChapterSummaryDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto abstract;
@override final  SeerahEra era;
@override final  HistoricalDateDto date;
@override final  ReviewDto review;
@override final  int wordCount;
 final  List<String> _visualIds;
@override@JsonKey() List<String> get visualIds {
  if (_visualIds is EqualUnmodifiableListView) return _visualIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visualIds);
}


/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahChapterSummaryDtoCopyWith<_SeerahChapterSummaryDto> get copyWith => __$SeerahChapterSummaryDtoCopyWithImpl<_SeerahChapterSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeerahChapterSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahChapterSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&const DeepCollectionEquality().equals(other._visualIds, _visualIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,abstract,era,date,review,wordCount,const DeepCollectionEquality().hash(_visualIds));

@override
String toString() {
  return 'SeerahChapterSummaryDto(id: $id, title: $title, abstract: $abstract, era: $era, date: $date, review: $review, wordCount: $wordCount, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahChapterSummaryDtoCopyWith<$Res> implements $SeerahChapterSummaryDtoCopyWith<$Res> {
  factory _$SeerahChapterSummaryDtoCopyWith(_SeerahChapterSummaryDto value, $Res Function(_SeerahChapterSummaryDto) _then) = __$SeerahChapterSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto title, LocalizedTextDto abstract, SeerahEra era, HistoricalDateDto date, ReviewDto review, int wordCount, List<String> visualIds
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get abstract;@override $HistoricalDateDtoCopyWith<$Res> get date;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahChapterSummaryDtoCopyWithImpl<$Res>
    implements _$SeerahChapterSummaryDtoCopyWith<$Res> {
  __$SeerahChapterSummaryDtoCopyWithImpl(this._self, this._then);

  final _SeerahChapterSummaryDto _self;
  final $Res Function(_SeerahChapterSummaryDto) _then;

/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? review = null,Object? wordCount = null,Object? visualIds = null,}) {
  return _then(_SeerahChapterSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,visualIds: null == visualIds ? _self._visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapterSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of SeerahChapterSummaryDto
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
mixin _$SeerahTopicSummaryDto {

 String get id; LocalizedTextDto get title; LocalizedTextDto get abstract; ReviewDto get review; int get wordCount;
/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahTopicSummaryDtoCopyWith<SeerahTopicSummaryDto> get copyWith => _$SeerahTopicSummaryDtoCopyWithImpl<SeerahTopicSummaryDto>(this as SeerahTopicSummaryDto, _$identity);

  /// Serializes this SeerahTopicSummaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahTopicSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,abstract,review,wordCount);

@override
String toString() {
  return 'SeerahTopicSummaryDto(id: $id, title: $title, abstract: $abstract, review: $review, wordCount: $wordCount)';
}


}

/// @nodoc
abstract mixin class $SeerahTopicSummaryDtoCopyWith<$Res>  {
  factory $SeerahTopicSummaryDtoCopyWith(SeerahTopicSummaryDto value, $Res Function(SeerahTopicSummaryDto) _then) = _$SeerahTopicSummaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto title, LocalizedTextDto abstract, ReviewDto review, int wordCount
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get abstract;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahTopicSummaryDtoCopyWithImpl<$Res>
    implements $SeerahTopicSummaryDtoCopyWith<$Res> {
  _$SeerahTopicSummaryDtoCopyWithImpl(this._self, this._then);

  final SeerahTopicSummaryDto _self;
  final $Res Function(SeerahTopicSummaryDto) _then;

/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? abstract = null,Object? review = null,Object? wordCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahTopicSummaryDto].
extension SeerahTopicSummaryDtoPatterns on SeerahTopicSummaryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahTopicSummaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahTopicSummaryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahTopicSummaryDto value)  $default,){
final _that = this;
switch (_that) {
case _SeerahTopicSummaryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahTopicSummaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahTopicSummaryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  ReviewDto review,  int wordCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahTopicSummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.abstract,_that.review,_that.wordCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  ReviewDto review,  int wordCount)  $default,) {final _that = this;
switch (_that) {
case _SeerahTopicSummaryDto():
return $default(_that.id,_that.title,_that.abstract,_that.review,_that.wordCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto title,  LocalizedTextDto abstract,  ReviewDto review,  int wordCount)?  $default,) {final _that = this;
switch (_that) {
case _SeerahTopicSummaryDto() when $default != null:
return $default(_that.id,_that.title,_that.abstract,_that.review,_that.wordCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeerahTopicSummaryDto implements SeerahTopicSummaryDto {
  const _SeerahTopicSummaryDto({required this.id, required this.title, required this.abstract, required this.review, required this.wordCount});
  factory _SeerahTopicSummaryDto.fromJson(Map<String, dynamic> json) => _$SeerahTopicSummaryDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto abstract;
@override final  ReviewDto review;
@override final  int wordCount;

/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahTopicSummaryDtoCopyWith<_SeerahTopicSummaryDto> get copyWith => __$SeerahTopicSummaryDtoCopyWithImpl<_SeerahTopicSummaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeerahTopicSummaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahTopicSummaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,abstract,review,wordCount);

@override
String toString() {
  return 'SeerahTopicSummaryDto(id: $id, title: $title, abstract: $abstract, review: $review, wordCount: $wordCount)';
}


}

/// @nodoc
abstract mixin class _$SeerahTopicSummaryDtoCopyWith<$Res> implements $SeerahTopicSummaryDtoCopyWith<$Res> {
  factory _$SeerahTopicSummaryDtoCopyWith(_SeerahTopicSummaryDto value, $Res Function(_SeerahTopicSummaryDto) _then) = __$SeerahTopicSummaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto title, LocalizedTextDto abstract, ReviewDto review, int wordCount
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get abstract;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahTopicSummaryDtoCopyWithImpl<$Res>
    implements _$SeerahTopicSummaryDtoCopyWith<$Res> {
  __$SeerahTopicSummaryDtoCopyWithImpl(this._self, this._then);

  final _SeerahTopicSummaryDto _self;
  final $Res Function(_SeerahTopicSummaryDto) _then;

/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? abstract = null,Object? review = null,Object? wordCount = null,}) {
  return _then(_SeerahTopicSummaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopicSummaryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get abstract {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopicSummaryDto
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
mixin _$SeerahIndexDto {

 int get schemaVersion; SeerahDto get seerah; List<SeerahChapterSummaryDto> get chapters; List<SeerahTopicSummaryDto> get topics;
/// Create a copy of SeerahIndexDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahIndexDtoCopyWith<SeerahIndexDto> get copyWith => _$SeerahIndexDtoCopyWithImpl<SeerahIndexDto>(this as SeerahIndexDto, _$identity);

  /// Serializes this SeerahIndexDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahIndexDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.seerah, seerah) || other.seerah == seerah)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&const DeepCollectionEquality().equals(other.topics, topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,seerah,const DeepCollectionEquality().hash(chapters),const DeepCollectionEquality().hash(topics));

@override
String toString() {
  return 'SeerahIndexDto(schemaVersion: $schemaVersion, seerah: $seerah, chapters: $chapters, topics: $topics)';
}


}

/// @nodoc
abstract mixin class $SeerahIndexDtoCopyWith<$Res>  {
  factory $SeerahIndexDtoCopyWith(SeerahIndexDto value, $Res Function(SeerahIndexDto) _then) = _$SeerahIndexDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, SeerahDto seerah, List<SeerahChapterSummaryDto> chapters, List<SeerahTopicSummaryDto> topics
});


$SeerahDtoCopyWith<$Res> get seerah;

}
/// @nodoc
class _$SeerahIndexDtoCopyWithImpl<$Res>
    implements $SeerahIndexDtoCopyWith<$Res> {
  _$SeerahIndexDtoCopyWithImpl(this._self, this._then);

  final SeerahIndexDto _self;
  final $Res Function(SeerahIndexDto) _then;

/// Create a copy of SeerahIndexDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? seerah = null,Object? chapters = null,Object? topics = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,seerah: null == seerah ? _self.seerah : seerah // ignore: cast_nullable_to_non_nullable
as SeerahDto,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<SeerahChapterSummaryDto>,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<SeerahTopicSummaryDto>,
  ));
}
/// Create a copy of SeerahIndexDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeerahDtoCopyWith<$Res> get seerah {
  
  return $SeerahDtoCopyWith<$Res>(_self.seerah, (value) {
    return _then(_self.copyWith(seerah: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahIndexDto].
extension SeerahIndexDtoPatterns on SeerahIndexDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahIndexDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahIndexDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahIndexDto value)  $default,){
final _that = this;
switch (_that) {
case _SeerahIndexDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahIndexDto value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahIndexDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  SeerahDto seerah,  List<SeerahChapterSummaryDto> chapters,  List<SeerahTopicSummaryDto> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahIndexDto() when $default != null:
return $default(_that.schemaVersion,_that.seerah,_that.chapters,_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  SeerahDto seerah,  List<SeerahChapterSummaryDto> chapters,  List<SeerahTopicSummaryDto> topics)  $default,) {final _that = this;
switch (_that) {
case _SeerahIndexDto():
return $default(_that.schemaVersion,_that.seerah,_that.chapters,_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  SeerahDto seerah,  List<SeerahChapterSummaryDto> chapters,  List<SeerahTopicSummaryDto> topics)?  $default,) {final _that = this;
switch (_that) {
case _SeerahIndexDto() when $default != null:
return $default(_that.schemaVersion,_that.seerah,_that.chapters,_that.topics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeerahIndexDto implements SeerahIndexDto {
  const _SeerahIndexDto({required this.schemaVersion, required this.seerah, required final  List<SeerahChapterSummaryDto> chapters, required final  List<SeerahTopicSummaryDto> topics}): _chapters = chapters,_topics = topics;
  factory _SeerahIndexDto.fromJson(Map<String, dynamic> json) => _$SeerahIndexDtoFromJson(json);

@override final  int schemaVersion;
@override final  SeerahDto seerah;
 final  List<SeerahChapterSummaryDto> _chapters;
@override List<SeerahChapterSummaryDto> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

 final  List<SeerahTopicSummaryDto> _topics;
@override List<SeerahTopicSummaryDto> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}


/// Create a copy of SeerahIndexDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahIndexDtoCopyWith<_SeerahIndexDto> get copyWith => __$SeerahIndexDtoCopyWithImpl<_SeerahIndexDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeerahIndexDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahIndexDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.seerah, seerah) || other.seerah == seerah)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&const DeepCollectionEquality().equals(other._topics, _topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,seerah,const DeepCollectionEquality().hash(_chapters),const DeepCollectionEquality().hash(_topics));

@override
String toString() {
  return 'SeerahIndexDto(schemaVersion: $schemaVersion, seerah: $seerah, chapters: $chapters, topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$SeerahIndexDtoCopyWith<$Res> implements $SeerahIndexDtoCopyWith<$Res> {
  factory _$SeerahIndexDtoCopyWith(_SeerahIndexDto value, $Res Function(_SeerahIndexDto) _then) = __$SeerahIndexDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, SeerahDto seerah, List<SeerahChapterSummaryDto> chapters, List<SeerahTopicSummaryDto> topics
});


@override $SeerahDtoCopyWith<$Res> get seerah;

}
/// @nodoc
class __$SeerahIndexDtoCopyWithImpl<$Res>
    implements _$SeerahIndexDtoCopyWith<$Res> {
  __$SeerahIndexDtoCopyWithImpl(this._self, this._then);

  final _SeerahIndexDto _self;
  final $Res Function(_SeerahIndexDto) _then;

/// Create a copy of SeerahIndexDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? seerah = null,Object? chapters = null,Object? topics = null,}) {
  return _then(_SeerahIndexDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,seerah: null == seerah ? _self.seerah : seerah // ignore: cast_nullable_to_non_nullable
as SeerahDto,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<SeerahChapterSummaryDto>,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<SeerahTopicSummaryDto>,
  ));
}

/// Create a copy of SeerahIndexDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeerahDtoCopyWith<$Res> get seerah {
  
  return $SeerahDtoCopyWith<$Res>(_self.seerah, (value) {
    return _then(_self.copyWith(seerah: value));
  });
}
}

// dart format on
