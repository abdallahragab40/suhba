// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atlas_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeoPointDto {

 double get lat; double get lon; GeoPrecision get precision;
/// Create a copy of GeoPointDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoPointDtoCopyWith<GeoPointDto> get copyWith => _$GeoPointDtoCopyWithImpl<GeoPointDto>(this as GeoPointDto, _$identity);

  /// Serializes this GeoPointDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoPointDto&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.precision, precision) || other.precision == precision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon,precision);

@override
String toString() {
  return 'GeoPointDto(lat: $lat, lon: $lon, precision: $precision)';
}


}

/// @nodoc
abstract mixin class $GeoPointDtoCopyWith<$Res>  {
  factory $GeoPointDtoCopyWith(GeoPointDto value, $Res Function(GeoPointDto) _then) = _$GeoPointDtoCopyWithImpl;
@useResult
$Res call({
 double lat, double lon, GeoPrecision precision
});




}
/// @nodoc
class _$GeoPointDtoCopyWithImpl<$Res>
    implements $GeoPointDtoCopyWith<$Res> {
  _$GeoPointDtoCopyWithImpl(this._self, this._then);

  final GeoPointDto _self;
  final $Res Function(GeoPointDto) _then;

/// Create a copy of GeoPointDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lon = null,Object? precision = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,precision: null == precision ? _self.precision : precision // ignore: cast_nullable_to_non_nullable
as GeoPrecision,
  ));
}

}


/// Adds pattern-matching-related methods to [GeoPointDto].
extension GeoPointDtoPatterns on GeoPointDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeoPointDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeoPointDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeoPointDto value)  $default,){
final _that = this;
switch (_that) {
case _GeoPointDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeoPointDto value)?  $default,){
final _that = this;
switch (_that) {
case _GeoPointDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lon,  GeoPrecision precision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeoPointDto() when $default != null:
return $default(_that.lat,_that.lon,_that.precision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lon,  GeoPrecision precision)  $default,) {final _that = this;
switch (_that) {
case _GeoPointDto():
return $default(_that.lat,_that.lon,_that.precision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lon,  GeoPrecision precision)?  $default,) {final _that = this;
switch (_that) {
case _GeoPointDto() when $default != null:
return $default(_that.lat,_that.lon,_that.precision);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeoPointDto implements GeoPointDto {
  const _GeoPointDto({required this.lat, required this.lon, required this.precision});
  factory _GeoPointDto.fromJson(Map<String, dynamic> json) => _$GeoPointDtoFromJson(json);

@override final  double lat;
@override final  double lon;
@override final  GeoPrecision precision;

/// Create a copy of GeoPointDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoPointDtoCopyWith<_GeoPointDto> get copyWith => __$GeoPointDtoCopyWithImpl<_GeoPointDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeoPointDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoPointDto&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.precision, precision) || other.precision == precision));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lat,lon,precision);

@override
String toString() {
  return 'GeoPointDto(lat: $lat, lon: $lon, precision: $precision)';
}


}

/// @nodoc
abstract mixin class _$GeoPointDtoCopyWith<$Res> implements $GeoPointDtoCopyWith<$Res> {
  factory _$GeoPointDtoCopyWith(_GeoPointDto value, $Res Function(_GeoPointDto) _then) = __$GeoPointDtoCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lon, GeoPrecision precision
});




}
/// @nodoc
class __$GeoPointDtoCopyWithImpl<$Res>
    implements _$GeoPointDtoCopyWith<$Res> {
  __$GeoPointDtoCopyWithImpl(this._self, this._then);

  final _GeoPointDto _self;
  final $Res Function(_GeoPointDto) _then;

/// Create a copy of GeoPointDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lon = null,Object? precision = null,}) {
  return _then(_GeoPointDto(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,precision: null == precision ? _self.precision : precision // ignore: cast_nullable_to_non_nullable
as GeoPrecision,
  ));
}


}


/// @nodoc
mixin _$PlaceDto {

 String get id; LocalizedTextDto get name; PlaceKind get kind; GeoPointDto get location; LocalizedTextDto get summary; Reliability get reliability; List<CitationDto> get citations; ReviewDto get review; LocalizedTextDto? get modernName; LocalizedTextDto? get contemporaryNote; List<String> get companionIds;
/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDtoCopyWith<PlaceDto> get copyWith => _$PlaceDtoCopyWithImpl<PlaceDto>(this as PlaceDto, _$identity);

  /// Serializes this PlaceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.location, location) || other.location == location)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.modernName, modernName) || other.modernName == modernName)&&(identical(other.contemporaryNote, contemporaryNote) || other.contemporaryNote == contemporaryNote)&&const DeepCollectionEquality().equals(other.companionIds, companionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,location,summary,reliability,const DeepCollectionEquality().hash(citations),review,modernName,contemporaryNote,const DeepCollectionEquality().hash(companionIds));

@override
String toString() {
  return 'PlaceDto(id: $id, name: $name, kind: $kind, location: $location, summary: $summary, reliability: $reliability, citations: $citations, review: $review, modernName: $modernName, contemporaryNote: $contemporaryNote, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class $PlaceDtoCopyWith<$Res>  {
  factory $PlaceDtoCopyWith(PlaceDto value, $Res Function(PlaceDto) _then) = _$PlaceDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto name, PlaceKind kind, GeoPointDto location, LocalizedTextDto summary, Reliability reliability, List<CitationDto> citations, ReviewDto review, LocalizedTextDto? modernName, LocalizedTextDto? contemporaryNote, List<String> companionIds
});


$LocalizedTextDtoCopyWith<$Res> get name;$GeoPointDtoCopyWith<$Res> get location;$LocalizedTextDtoCopyWith<$Res> get summary;$ReviewDtoCopyWith<$Res> get review;$LocalizedTextDtoCopyWith<$Res>? get modernName;$LocalizedTextDtoCopyWith<$Res>? get contemporaryNote;

}
/// @nodoc
class _$PlaceDtoCopyWithImpl<$Res>
    implements $PlaceDtoCopyWith<$Res> {
  _$PlaceDtoCopyWithImpl(this._self, this._then);

  final PlaceDto _self;
  final $Res Function(PlaceDto) _then;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? location = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? modernName = freezed,Object? contemporaryNote = freezed,Object? companionIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlaceKind,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPointDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,modernName: freezed == modernName ? _self.modernName : modernName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,contemporaryNote: freezed == contemporaryNote ? _self.contemporaryNote : contemporaryNote // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointDtoCopyWith<$Res> get location {
  
  return $GeoPointDtoCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get modernName {
    if (_self.modernName == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.modernName!, (value) {
    return _then(_self.copyWith(modernName: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get contemporaryNote {
    if (_self.contemporaryNote == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.contemporaryNote!, (value) {
    return _then(_self.copyWith(contemporaryNote: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceDto].
extension PlaceDtoPatterns on PlaceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDto value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  PlaceKind kind,  GeoPointDto location,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review,  LocalizedTextDto? modernName,  LocalizedTextDto? contemporaryNote,  List<String> companionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.location,_that.summary,_that.reliability,_that.citations,_that.review,_that.modernName,_that.contemporaryNote,_that.companionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  PlaceKind kind,  GeoPointDto location,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review,  LocalizedTextDto? modernName,  LocalizedTextDto? contemporaryNote,  List<String> companionIds)  $default,) {final _that = this;
switch (_that) {
case _PlaceDto():
return $default(_that.id,_that.name,_that.kind,_that.location,_that.summary,_that.reliability,_that.citations,_that.review,_that.modernName,_that.contemporaryNote,_that.companionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto name,  PlaceKind kind,  GeoPointDto location,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review,  LocalizedTextDto? modernName,  LocalizedTextDto? contemporaryNote,  List<String> companionIds)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDto() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.location,_that.summary,_that.reliability,_that.citations,_that.review,_that.modernName,_that.contemporaryNote,_that.companionIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDto implements PlaceDto {
  const _PlaceDto({required this.id, required this.name, required this.kind, required this.location, required this.summary, required this.reliability, required final  List<CitationDto> citations, required this.review, this.modernName, this.contemporaryNote, final  List<String> companionIds = const <String>[]}): _citations = citations,_companionIds = companionIds;
  factory _PlaceDto.fromJson(Map<String, dynamic> json) => _$PlaceDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto name;
@override final  PlaceKind kind;
@override final  GeoPointDto location;
@override final  LocalizedTextDto summary;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  ReviewDto review;
@override final  LocalizedTextDto? modernName;
@override final  LocalizedTextDto? contemporaryNote;
 final  List<String> _companionIds;
@override@JsonKey() List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}


/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDtoCopyWith<_PlaceDto> get copyWith => __$PlaceDtoCopyWithImpl<_PlaceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.location, location) || other.location == location)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.modernName, modernName) || other.modernName == modernName)&&(identical(other.contemporaryNote, contemporaryNote) || other.contemporaryNote == contemporaryNote)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,location,summary,reliability,const DeepCollectionEquality().hash(_citations),review,modernName,contemporaryNote,const DeepCollectionEquality().hash(_companionIds));

@override
String toString() {
  return 'PlaceDto(id: $id, name: $name, kind: $kind, location: $location, summary: $summary, reliability: $reliability, citations: $citations, review: $review, modernName: $modernName, contemporaryNote: $contemporaryNote, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class _$PlaceDtoCopyWith<$Res> implements $PlaceDtoCopyWith<$Res> {
  factory _$PlaceDtoCopyWith(_PlaceDto value, $Res Function(_PlaceDto) _then) = __$PlaceDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto name, PlaceKind kind, GeoPointDto location, LocalizedTextDto summary, Reliability reliability, List<CitationDto> citations, ReviewDto review, LocalizedTextDto? modernName, LocalizedTextDto? contemporaryNote, List<String> companionIds
});


@override $LocalizedTextDtoCopyWith<$Res> get name;@override $GeoPointDtoCopyWith<$Res> get location;@override $LocalizedTextDtoCopyWith<$Res> get summary;@override $ReviewDtoCopyWith<$Res> get review;@override $LocalizedTextDtoCopyWith<$Res>? get modernName;@override $LocalizedTextDtoCopyWith<$Res>? get contemporaryNote;

}
/// @nodoc
class __$PlaceDtoCopyWithImpl<$Res>
    implements _$PlaceDtoCopyWith<$Res> {
  __$PlaceDtoCopyWithImpl(this._self, this._then);

  final _PlaceDto _self;
  final $Res Function(_PlaceDto) _then;

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? location = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? modernName = freezed,Object? contemporaryNote = freezed,Object? companionIds = null,}) {
  return _then(_PlaceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlaceKind,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPointDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,modernName: freezed == modernName ? _self.modernName : modernName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,contemporaryNote: freezed == contemporaryNote ? _self.contemporaryNote : contemporaryNote // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointDtoCopyWith<$Res> get location {
  
  return $GeoPointDtoCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get modernName {
    if (_self.modernName == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.modernName!, (value) {
    return _then(_self.copyWith(modernName: value));
  });
}/// Create a copy of PlaceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get contemporaryNote {
    if (_self.contemporaryNote == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.contemporaryNote!, (value) {
    return _then(_self.copyWith(contemporaryNote: value));
  });
}
}


/// @nodoc
mixin _$PlacesFileDto {

 int get schemaVersion; List<PlaceDto> get places;
/// Create a copy of PlacesFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacesFileDtoCopyWith<PlacesFileDto> get copyWith => _$PlacesFileDtoCopyWithImpl<PlacesFileDto>(this as PlacesFileDto, _$identity);

  /// Serializes this PlacesFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacesFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.places, places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(places));

@override
String toString() {
  return 'PlacesFileDto(schemaVersion: $schemaVersion, places: $places)';
}


}

/// @nodoc
abstract mixin class $PlacesFileDtoCopyWith<$Res>  {
  factory $PlacesFileDtoCopyWith(PlacesFileDto value, $Res Function(PlacesFileDto) _then) = _$PlacesFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<PlaceDto> places
});




}
/// @nodoc
class _$PlacesFileDtoCopyWithImpl<$Res>
    implements $PlacesFileDtoCopyWith<$Res> {
  _$PlacesFileDtoCopyWithImpl(this._self, this._then);

  final PlacesFileDto _self;
  final $Res Function(PlacesFileDto) _then;

/// Create a copy of PlacesFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? places = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlacesFileDto].
extension PlacesFileDtoPatterns on PlacesFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacesFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacesFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacesFileDto value)  $default,){
final _that = this;
switch (_that) {
case _PlacesFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacesFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlacesFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<PlaceDto> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacesFileDto() when $default != null:
return $default(_that.schemaVersion,_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<PlaceDto> places)  $default,) {final _that = this;
switch (_that) {
case _PlacesFileDto():
return $default(_that.schemaVersion,_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<PlaceDto> places)?  $default,) {final _that = this;
switch (_that) {
case _PlacesFileDto() when $default != null:
return $default(_that.schemaVersion,_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacesFileDto implements PlacesFileDto {
  const _PlacesFileDto({required this.schemaVersion, required final  List<PlaceDto> places}): _places = places;
  factory _PlacesFileDto.fromJson(Map<String, dynamic> json) => _$PlacesFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<PlaceDto> _places;
@override List<PlaceDto> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of PlacesFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacesFileDtoCopyWith<_PlacesFileDto> get copyWith => __$PlacesFileDtoCopyWithImpl<_PlacesFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacesFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacesFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_places));

@override
String toString() {
  return 'PlacesFileDto(schemaVersion: $schemaVersion, places: $places)';
}


}

/// @nodoc
abstract mixin class _$PlacesFileDtoCopyWith<$Res> implements $PlacesFileDtoCopyWith<$Res> {
  factory _$PlacesFileDtoCopyWith(_PlacesFileDto value, $Res Function(_PlacesFileDto) _then) = __$PlacesFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<PlaceDto> places
});




}
/// @nodoc
class __$PlacesFileDtoCopyWithImpl<$Res>
    implements _$PlacesFileDtoCopyWith<$Res> {
  __$PlacesFileDtoCopyWithImpl(this._self, this._then);

  final _PlacesFileDto _self;
  final $Res Function(_PlacesFileDto) _then;

/// Create a copy of PlacesFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? places = null,}) {
  return _then(_PlacesFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<PlaceDto>,
  ));
}


}


/// @nodoc
mixin _$RouteLegDto {

 String get from; String get to; bool get approximate; Reliability get reliability; List<CitationDto> get citations; LocalizedTextDto? get note;
/// Create a copy of RouteLegDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteLegDtoCopyWith<RouteLegDto> get copyWith => _$RouteLegDtoCopyWithImpl<RouteLegDto>(this as RouteLegDto, _$identity);

  /// Serializes this RouteLegDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteLegDto&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.approximate, approximate) || other.approximate == approximate)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,approximate,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'RouteLegDto(from: $from, to: $to, approximate: $approximate, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $RouteLegDtoCopyWith<$Res>  {
  factory $RouteLegDtoCopyWith(RouteLegDto value, $Res Function(RouteLegDto) _then) = _$RouteLegDtoCopyWithImpl;
@useResult
$Res call({
 String from, String to, bool approximate, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


$LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class _$RouteLegDtoCopyWithImpl<$Res>
    implements $RouteLegDtoCopyWith<$Res> {
  _$RouteLegDtoCopyWithImpl(this._self, this._then);

  final RouteLegDto _self;
  final $Res Function(RouteLegDto) _then;

/// Create a copy of RouteLegDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? approximate = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,approximate: null == approximate ? _self.approximate : approximate // ignore: cast_nullable_to_non_nullable
as bool,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of RouteLegDto
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


/// Adds pattern-matching-related methods to [RouteLegDto].
extension RouteLegDtoPatterns on RouteLegDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteLegDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteLegDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteLegDto value)  $default,){
final _that = this;
switch (_that) {
case _RouteLegDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteLegDto value)?  $default,){
final _that = this;
switch (_that) {
case _RouteLegDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String from,  String to,  bool approximate,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteLegDto() when $default != null:
return $default(_that.from,_that.to,_that.approximate,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String from,  String to,  bool approximate,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)  $default,) {final _that = this;
switch (_that) {
case _RouteLegDto():
return $default(_that.from,_that.to,_that.approximate,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String from,  String to,  bool approximate,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,) {final _that = this;
switch (_that) {
case _RouteLegDto() when $default != null:
return $default(_that.from,_that.to,_that.approximate,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RouteLegDto implements RouteLegDto {
  const _RouteLegDto({required this.from, required this.to, required this.approximate, required this.reliability, required final  List<CitationDto> citations, this.note}): _citations = citations;
  factory _RouteLegDto.fromJson(Map<String, dynamic> json) => _$RouteLegDtoFromJson(json);

@override final  String from;
@override final  String to;
@override final  bool approximate;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedTextDto? note;

/// Create a copy of RouteLegDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteLegDtoCopyWith<_RouteLegDto> get copyWith => __$RouteLegDtoCopyWithImpl<_RouteLegDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RouteLegDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteLegDto&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.approximate, approximate) || other.approximate == approximate)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,approximate,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'RouteLegDto(from: $from, to: $to, approximate: $approximate, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$RouteLegDtoCopyWith<$Res> implements $RouteLegDtoCopyWith<$Res> {
  factory _$RouteLegDtoCopyWith(_RouteLegDto value, $Res Function(_RouteLegDto) _then) = __$RouteLegDtoCopyWithImpl;
@override @useResult
$Res call({
 String from, String to, bool approximate, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


@override $LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class __$RouteLegDtoCopyWithImpl<$Res>
    implements _$RouteLegDtoCopyWith<$Res> {
  __$RouteLegDtoCopyWithImpl(this._self, this._then);

  final _RouteLegDto _self;
  final $Res Function(_RouteLegDto) _then;

/// Create a copy of RouteLegDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? approximate = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_RouteLegDto(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,approximate: null == approximate ? _self.approximate : approximate // ignore: cast_nullable_to_non_nullable
as bool,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of RouteLegDto
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
mixin _$RelationEdgeDto {

 PersonRefDto get from; PersonRefDto get to; RelationType get type; Reliability get reliability; List<CitationDto> get citations; LocalizedTextDto? get note;
/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationEdgeDtoCopyWith<RelationEdgeDto> get copyWith => _$RelationEdgeDtoCopyWithImpl<RelationEdgeDto>(this as RelationEdgeDto, _$identity);

  /// Serializes this RelationEdgeDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationEdgeDto&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.type, type) || other.type == type)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,type,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'RelationEdgeDto(from: $from, to: $to, type: $type, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $RelationEdgeDtoCopyWith<$Res>  {
  factory $RelationEdgeDtoCopyWith(RelationEdgeDto value, $Res Function(RelationEdgeDto) _then) = _$RelationEdgeDtoCopyWithImpl;
@useResult
$Res call({
 PersonRefDto from, PersonRefDto to, RelationType type, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


$PersonRefDtoCopyWith<$Res> get from;$PersonRefDtoCopyWith<$Res> get to;$LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class _$RelationEdgeDtoCopyWithImpl<$Res>
    implements $RelationEdgeDtoCopyWith<$Res> {
  _$RelationEdgeDtoCopyWithImpl(this._self, this._then);

  final RelationEdgeDto _self;
  final $Res Function(RelationEdgeDto) _then;

/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? type = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as PersonRefDto,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as PersonRefDto,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefDtoCopyWith<$Res> get from {
  
  return $PersonRefDtoCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefDtoCopyWith<$Res> get to {
  
  return $PersonRefDtoCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}/// Create a copy of RelationEdgeDto
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


/// Adds pattern-matching-related methods to [RelationEdgeDto].
extension RelationEdgeDtoPatterns on RelationEdgeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationEdgeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationEdgeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationEdgeDto value)  $default,){
final _that = this;
switch (_that) {
case _RelationEdgeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationEdgeDto value)?  $default,){
final _that = this;
switch (_that) {
case _RelationEdgeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PersonRefDto from,  PersonRefDto to,  RelationType type,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationEdgeDto() when $default != null:
return $default(_that.from,_that.to,_that.type,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PersonRefDto from,  PersonRefDto to,  RelationType type,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)  $default,) {final _that = this;
switch (_that) {
case _RelationEdgeDto():
return $default(_that.from,_that.to,_that.type,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PersonRefDto from,  PersonRefDto to,  RelationType type,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,) {final _that = this;
switch (_that) {
case _RelationEdgeDto() when $default != null:
return $default(_that.from,_that.to,_that.type,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RelationEdgeDto implements RelationEdgeDto {
  const _RelationEdgeDto({required this.from, required this.to, required this.type, required this.reliability, required final  List<CitationDto> citations, this.note}): _citations = citations;
  factory _RelationEdgeDto.fromJson(Map<String, dynamic> json) => _$RelationEdgeDtoFromJson(json);

@override final  PersonRefDto from;
@override final  PersonRefDto to;
@override final  RelationType type;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedTextDto? note;

/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationEdgeDtoCopyWith<_RelationEdgeDto> get copyWith => __$RelationEdgeDtoCopyWithImpl<_RelationEdgeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RelationEdgeDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationEdgeDto&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.type, type) || other.type == type)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,type,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'RelationEdgeDto(from: $from, to: $to, type: $type, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$RelationEdgeDtoCopyWith<$Res> implements $RelationEdgeDtoCopyWith<$Res> {
  factory _$RelationEdgeDtoCopyWith(_RelationEdgeDto value, $Res Function(_RelationEdgeDto) _then) = __$RelationEdgeDtoCopyWithImpl;
@override @useResult
$Res call({
 PersonRefDto from, PersonRefDto to, RelationType type, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


@override $PersonRefDtoCopyWith<$Res> get from;@override $PersonRefDtoCopyWith<$Res> get to;@override $LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class __$RelationEdgeDtoCopyWithImpl<$Res>
    implements _$RelationEdgeDtoCopyWith<$Res> {
  __$RelationEdgeDtoCopyWithImpl(this._self, this._then);

  final _RelationEdgeDto _self;
  final $Res Function(_RelationEdgeDto) _then;

/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? type = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_RelationEdgeDto(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as PersonRefDto,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as PersonRefDto,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefDtoCopyWith<$Res> get from {
  
  return $PersonRefDtoCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of RelationEdgeDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefDtoCopyWith<$Res> get to {
  
  return $PersonRefDtoCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}/// Create a copy of RelationEdgeDto
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
mixin _$SequenceStepDto {

 LocalizedTextDto get title; LocalizedTextDto get text; Reliability get reliability; List<CitationDto> get citations; String? get placeId; HistoricalDateDto? get date; bool get orderUncertain;
/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SequenceStepDtoCopyWith<SequenceStepDto> get copyWith => _$SequenceStepDtoCopyWithImpl<SequenceStepDto>(this as SequenceStepDto, _$identity);

  /// Serializes this SequenceStepDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SequenceStepDto&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.date, date) || other.date == date)&&(identical(other.orderUncertain, orderUncertain) || other.orderUncertain == orderUncertain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,text,reliability,const DeepCollectionEquality().hash(citations),placeId,date,orderUncertain);

@override
String toString() {
  return 'SequenceStepDto(title: $title, text: $text, reliability: $reliability, citations: $citations, placeId: $placeId, date: $date, orderUncertain: $orderUncertain)';
}


}

/// @nodoc
abstract mixin class $SequenceStepDtoCopyWith<$Res>  {
  factory $SequenceStepDtoCopyWith(SequenceStepDto value, $Res Function(SequenceStepDto) _then) = _$SequenceStepDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto title, LocalizedTextDto text, Reliability reliability, List<CitationDto> citations, String? placeId, HistoricalDateDto? date, bool orderUncertain
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get text;$HistoricalDateDtoCopyWith<$Res>? get date;

}
/// @nodoc
class _$SequenceStepDtoCopyWithImpl<$Res>
    implements $SequenceStepDtoCopyWith<$Res> {
  _$SequenceStepDtoCopyWithImpl(this._self, this._then);

  final SequenceStepDto _self;
  final $Res Function(SequenceStepDto) _then;

/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? text = null,Object? reliability = null,Object? citations = null,Object? placeId = freezed,Object? date = freezed,Object? orderUncertain = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto?,orderUncertain: null == orderUncertain ? _self.orderUncertain : orderUncertain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res>? get date {
    if (_self.date == null) {
    return null;
  }

  return $HistoricalDateDtoCopyWith<$Res>(_self.date!, (value) {
    return _then(_self.copyWith(date: value));
  });
}
}


/// Adds pattern-matching-related methods to [SequenceStepDto].
extension SequenceStepDtoPatterns on SequenceStepDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SequenceStepDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SequenceStepDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SequenceStepDto value)  $default,){
final _that = this;
switch (_that) {
case _SequenceStepDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SequenceStepDto value)?  $default,){
final _that = this;
switch (_that) {
case _SequenceStepDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedTextDto title,  LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations,  String? placeId,  HistoricalDateDto? date,  bool orderUncertain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SequenceStepDto() when $default != null:
return $default(_that.title,_that.text,_that.reliability,_that.citations,_that.placeId,_that.date,_that.orderUncertain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedTextDto title,  LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations,  String? placeId,  HistoricalDateDto? date,  bool orderUncertain)  $default,) {final _that = this;
switch (_that) {
case _SequenceStepDto():
return $default(_that.title,_that.text,_that.reliability,_that.citations,_that.placeId,_that.date,_that.orderUncertain);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedTextDto title,  LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations,  String? placeId,  HistoricalDateDto? date,  bool orderUncertain)?  $default,) {final _that = this;
switch (_that) {
case _SequenceStepDto() when $default != null:
return $default(_that.title,_that.text,_that.reliability,_that.citations,_that.placeId,_that.date,_that.orderUncertain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SequenceStepDto implements SequenceStepDto {
  const _SequenceStepDto({required this.title, required this.text, required this.reliability, required final  List<CitationDto> citations, this.placeId, this.date, this.orderUncertain = false}): _citations = citations;
  factory _SequenceStepDto.fromJson(Map<String, dynamic> json) => _$SequenceStepDtoFromJson(json);

@override final  LocalizedTextDto title;
@override final  LocalizedTextDto text;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  String? placeId;
@override final  HistoricalDateDto? date;
@override@JsonKey() final  bool orderUncertain;

/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SequenceStepDtoCopyWith<_SequenceStepDto> get copyWith => __$SequenceStepDtoCopyWithImpl<_SequenceStepDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SequenceStepDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SequenceStepDto&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.date, date) || other.date == date)&&(identical(other.orderUncertain, orderUncertain) || other.orderUncertain == orderUncertain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,text,reliability,const DeepCollectionEquality().hash(_citations),placeId,date,orderUncertain);

@override
String toString() {
  return 'SequenceStepDto(title: $title, text: $text, reliability: $reliability, citations: $citations, placeId: $placeId, date: $date, orderUncertain: $orderUncertain)';
}


}

/// @nodoc
abstract mixin class _$SequenceStepDtoCopyWith<$Res> implements $SequenceStepDtoCopyWith<$Res> {
  factory _$SequenceStepDtoCopyWith(_SequenceStepDto value, $Res Function(_SequenceStepDto) _then) = __$SequenceStepDtoCopyWithImpl;
@override @useResult
$Res call({
 LocalizedTextDto title, LocalizedTextDto text, Reliability reliability, List<CitationDto> citations, String? placeId, HistoricalDateDto? date, bool orderUncertain
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get text;@override $HistoricalDateDtoCopyWith<$Res>? get date;

}
/// @nodoc
class __$SequenceStepDtoCopyWithImpl<$Res>
    implements _$SequenceStepDtoCopyWith<$Res> {
  __$SequenceStepDtoCopyWithImpl(this._self, this._then);

  final _SequenceStepDto _self;
  final $Res Function(_SequenceStepDto) _then;

/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? text = null,Object? reliability = null,Object? citations = null,Object? placeId = freezed,Object? date = freezed,Object? orderUncertain = null,}) {
  return _then(_SequenceStepDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto?,orderUncertain: null == orderUncertain ? _self.orderUncertain : orderUncertain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of SequenceStepDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res>? get date {
    if (_self.date == null) {
    return null;
  }

  return $HistoricalDateDtoCopyWith<$Res>(_self.date!, (value) {
    return _then(_self.copyWith(date: value));
  });
}
}


/// @nodoc
mixin _$PeriodBandDto {

 LocalizedTextDto get label; HistoricalDateDto get date; Reliability get reliability; List<CitationDto> get citations; LocalizedTextDto? get note;
/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodBandDtoCopyWith<PeriodBandDto> get copyWith => _$PeriodBandDtoCopyWithImpl<PeriodBandDto>(this as PeriodBandDto, _$identity);

  /// Serializes this PeriodBandDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodBandDto&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,date,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'PeriodBandDto(label: $label, date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $PeriodBandDtoCopyWith<$Res>  {
  factory $PeriodBandDtoCopyWith(PeriodBandDto value, $Res Function(PeriodBandDto) _then) = _$PeriodBandDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto label, HistoricalDateDto date, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


$LocalizedTextDtoCopyWith<$Res> get label;$HistoricalDateDtoCopyWith<$Res> get date;$LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class _$PeriodBandDtoCopyWithImpl<$Res>
    implements $PeriodBandDtoCopyWith<$Res> {
  _$PeriodBandDtoCopyWithImpl(this._self, this._then);

  final PeriodBandDto _self;
  final $Res Function(PeriodBandDto) _then;

/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get label {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of PeriodBandDto
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


/// Adds pattern-matching-related methods to [PeriodBandDto].
extension PeriodBandDtoPatterns on PeriodBandDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodBandDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodBandDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodBandDto value)  $default,){
final _that = this;
switch (_that) {
case _PeriodBandDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodBandDto value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodBandDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedTextDto label,  HistoricalDateDto date,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodBandDto() when $default != null:
return $default(_that.label,_that.date,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedTextDto label,  HistoricalDateDto date,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)  $default,) {final _that = this;
switch (_that) {
case _PeriodBandDto():
return $default(_that.label,_that.date,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedTextDto label,  HistoricalDateDto date,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,) {final _that = this;
switch (_that) {
case _PeriodBandDto() when $default != null:
return $default(_that.label,_that.date,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeriodBandDto implements PeriodBandDto {
  const _PeriodBandDto({required this.label, required this.date, required this.reliability, required final  List<CitationDto> citations, this.note}): _citations = citations;
  factory _PeriodBandDto.fromJson(Map<String, dynamic> json) => _$PeriodBandDtoFromJson(json);

@override final  LocalizedTextDto label;
@override final  HistoricalDateDto date;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedTextDto? note;

/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodBandDtoCopyWith<_PeriodBandDto> get copyWith => __$PeriodBandDtoCopyWithImpl<_PeriodBandDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodBandDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodBandDto&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,date,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'PeriodBandDto(label: $label, date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$PeriodBandDtoCopyWith<$Res> implements $PeriodBandDtoCopyWith<$Res> {
  factory _$PeriodBandDtoCopyWith(_PeriodBandDto value, $Res Function(_PeriodBandDto) _then) = __$PeriodBandDtoCopyWithImpl;
@override @useResult
$Res call({
 LocalizedTextDto label, HistoricalDateDto date, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


@override $LocalizedTextDtoCopyWith<$Res> get label;@override $HistoricalDateDtoCopyWith<$Res> get date;@override $LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class __$PeriodBandDtoCopyWithImpl<$Res>
    implements _$PeriodBandDtoCopyWith<$Res> {
  __$PeriodBandDtoCopyWithImpl(this._self, this._then);

  final _PeriodBandDto _self;
  final $Res Function(_PeriodBandDto) _then;

/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_PeriodBandDto(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get label {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PeriodBandDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of PeriodBandDto
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
mixin _$PlaceCalloutDto {

 LocalizedTextDto get label; LocalizedTextDto get text; Reliability get reliability; List<CitationDto> get citations;
/// Create a copy of PlaceCalloutDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCalloutDtoCopyWith<PlaceCalloutDto> get copyWith => _$PlaceCalloutDtoCopyWithImpl<PlaceCalloutDto>(this as PlaceCalloutDto, _$identity);

  /// Serializes this PlaceCalloutDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceCalloutDto&&(identical(other.label, label) || other.label == label)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,text,reliability,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'PlaceCalloutDto(label: $label, text: $text, reliability: $reliability, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $PlaceCalloutDtoCopyWith<$Res>  {
  factory $PlaceCalloutDtoCopyWith(PlaceCalloutDto value, $Res Function(PlaceCalloutDto) _then) = _$PlaceCalloutDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto label, LocalizedTextDto text, Reliability reliability, List<CitationDto> citations
});


$LocalizedTextDtoCopyWith<$Res> get label;$LocalizedTextDtoCopyWith<$Res> get text;

}
/// @nodoc
class _$PlaceCalloutDtoCopyWithImpl<$Res>
    implements $PlaceCalloutDtoCopyWith<$Res> {
  _$PlaceCalloutDtoCopyWithImpl(this._self, this._then);

  final PlaceCalloutDto _self;
  final $Res Function(PlaceCalloutDto) _then;

/// Create a copy of PlaceCalloutDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? text = null,Object? reliability = null,Object? citations = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}
/// Create a copy of PlaceCalloutDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get label {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PlaceCalloutDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get text {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceCalloutDto].
extension PlaceCalloutDtoPatterns on PlaceCalloutDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceCalloutDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceCalloutDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceCalloutDto value)  $default,){
final _that = this;
switch (_that) {
case _PlaceCalloutDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceCalloutDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceCalloutDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedTextDto label,  LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceCalloutDto() when $default != null:
return $default(_that.label,_that.text,_that.reliability,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedTextDto label,  LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations)  $default,) {final _that = this;
switch (_that) {
case _PlaceCalloutDto():
return $default(_that.label,_that.text,_that.reliability,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedTextDto label,  LocalizedTextDto text,  Reliability reliability,  List<CitationDto> citations)?  $default,) {final _that = this;
switch (_that) {
case _PlaceCalloutDto() when $default != null:
return $default(_that.label,_that.text,_that.reliability,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceCalloutDto implements PlaceCalloutDto {
  const _PlaceCalloutDto({required this.label, required this.text, required this.reliability, required final  List<CitationDto> citations}): _citations = citations;
  factory _PlaceCalloutDto.fromJson(Map<String, dynamic> json) => _$PlaceCalloutDtoFromJson(json);

@override final  LocalizedTextDto label;
@override final  LocalizedTextDto text;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of PlaceCalloutDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCalloutDtoCopyWith<_PlaceCalloutDto> get copyWith => __$PlaceCalloutDtoCopyWithImpl<_PlaceCalloutDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceCalloutDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceCalloutDto&&(identical(other.label, label) || other.label == label)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,text,reliability,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'PlaceCalloutDto(label: $label, text: $text, reliability: $reliability, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$PlaceCalloutDtoCopyWith<$Res> implements $PlaceCalloutDtoCopyWith<$Res> {
  factory _$PlaceCalloutDtoCopyWith(_PlaceCalloutDto value, $Res Function(_PlaceCalloutDto) _then) = __$PlaceCalloutDtoCopyWithImpl;
@override @useResult
$Res call({
 LocalizedTextDto label, LocalizedTextDto text, Reliability reliability, List<CitationDto> citations
});


@override $LocalizedTextDtoCopyWith<$Res> get label;@override $LocalizedTextDtoCopyWith<$Res> get text;

}
/// @nodoc
class __$PlaceCalloutDtoCopyWithImpl<$Res>
    implements _$PlaceCalloutDtoCopyWith<$Res> {
  __$PlaceCalloutDtoCopyWithImpl(this._self, this._then);

  final _PlaceCalloutDto _self;
  final $Res Function(_PlaceCalloutDto) _then;

/// Create a copy of PlaceCalloutDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? text = null,Object? reliability = null,Object? citations = null,}) {
  return _then(_PlaceCalloutDto(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}

/// Create a copy of PlaceCalloutDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get label {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PlaceCalloutDto
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
mixin _$VisualDto {

 int get schemaVersion; String get id; InfographicType get type; LocalizedTextDto get title; LocalizedTextDto get takeaway; ReviewDto get review; List<LocalizedTextDto> get notes; String? get companionId; List<String> get eventIds; List<String> get placeIds; List<RouteLegDto> get route; List<RelationEdgeDto> get edges; List<SequenceStepDto> get steps; List<PeriodBandDto> get bands; String? get placeId; List<PlaceCalloutDto> get callouts;
/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisualDtoCopyWith<VisualDto> get copyWith => _$VisualDtoCopyWithImpl<VisualDto>(this as VisualDto, _$identity);

  /// Serializes this VisualDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisualDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.takeaway, takeaway) || other.takeaway == takeaway)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.companionId, companionId) || other.companionId == companionId)&&const DeepCollectionEquality().equals(other.eventIds, eventIds)&&const DeepCollectionEquality().equals(other.placeIds, placeIds)&&const DeepCollectionEquality().equals(other.route, route)&&const DeepCollectionEquality().equals(other.edges, edges)&&const DeepCollectionEquality().equals(other.steps, steps)&&const DeepCollectionEquality().equals(other.bands, bands)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&const DeepCollectionEquality().equals(other.callouts, callouts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,type,title,takeaway,review,const DeepCollectionEquality().hash(notes),companionId,const DeepCollectionEquality().hash(eventIds),const DeepCollectionEquality().hash(placeIds),const DeepCollectionEquality().hash(route),const DeepCollectionEquality().hash(edges),const DeepCollectionEquality().hash(steps),const DeepCollectionEquality().hash(bands),placeId,const DeepCollectionEquality().hash(callouts));

@override
String toString() {
  return 'VisualDto(schemaVersion: $schemaVersion, id: $id, type: $type, title: $title, takeaway: $takeaway, review: $review, notes: $notes, companionId: $companionId, eventIds: $eventIds, placeIds: $placeIds, route: $route, edges: $edges, steps: $steps, bands: $bands, placeId: $placeId, callouts: $callouts)';
}


}

/// @nodoc
abstract mixin class $VisualDtoCopyWith<$Res>  {
  factory $VisualDtoCopyWith(VisualDto value, $Res Function(VisualDto) _then) = _$VisualDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String id, InfographicType type, LocalizedTextDto title, LocalizedTextDto takeaway, ReviewDto review, List<LocalizedTextDto> notes, String? companionId, List<String> eventIds, List<String> placeIds, List<RouteLegDto> route, List<RelationEdgeDto> edges, List<SequenceStepDto> steps, List<PeriodBandDto> bands, String? placeId, List<PlaceCalloutDto> callouts
});


$LocalizedTextDtoCopyWith<$Res> get title;$LocalizedTextDtoCopyWith<$Res> get takeaway;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$VisualDtoCopyWithImpl<$Res>
    implements $VisualDtoCopyWith<$Res> {
  _$VisualDtoCopyWithImpl(this._self, this._then);

  final VisualDto _self;
  final $Res Function(VisualDto) _then;

/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? id = null,Object? type = null,Object? title = null,Object? takeaway = null,Object? review = null,Object? notes = null,Object? companionId = freezed,Object? eventIds = null,Object? placeIds = null,Object? route = null,Object? edges = null,Object? steps = null,Object? bands = null,Object? placeId = freezed,Object? callouts = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InfographicType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,takeaway: null == takeaway ? _self.takeaway : takeaway // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<LocalizedTextDto>,companionId: freezed == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String?,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,placeIds: null == placeIds ? _self.placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as List<RouteLegDto>,edges: null == edges ? _self.edges : edges // ignore: cast_nullable_to_non_nullable
as List<RelationEdgeDto>,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<SequenceStepDto>,bands: null == bands ? _self.bands : bands // ignore: cast_nullable_to_non_nullable
as List<PeriodBandDto>,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,callouts: null == callouts ? _self.callouts : callouts // ignore: cast_nullable_to_non_nullable
as List<PlaceCalloutDto>,
  ));
}
/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get takeaway {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.takeaway, (value) {
    return _then(_self.copyWith(takeaway: value));
  });
}/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [VisualDto].
extension VisualDtoPatterns on VisualDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisualDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisualDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisualDto value)  $default,){
final _that = this;
switch (_that) {
case _VisualDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisualDto value)?  $default,){
final _that = this;
switch (_that) {
case _VisualDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  InfographicType type,  LocalizedTextDto title,  LocalizedTextDto takeaway,  ReviewDto review,  List<LocalizedTextDto> notes,  String? companionId,  List<String> eventIds,  List<String> placeIds,  List<RouteLegDto> route,  List<RelationEdgeDto> edges,  List<SequenceStepDto> steps,  List<PeriodBandDto> bands,  String? placeId,  List<PlaceCalloutDto> callouts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisualDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.type,_that.title,_that.takeaway,_that.review,_that.notes,_that.companionId,_that.eventIds,_that.placeIds,_that.route,_that.edges,_that.steps,_that.bands,_that.placeId,_that.callouts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String id,  InfographicType type,  LocalizedTextDto title,  LocalizedTextDto takeaway,  ReviewDto review,  List<LocalizedTextDto> notes,  String? companionId,  List<String> eventIds,  List<String> placeIds,  List<RouteLegDto> route,  List<RelationEdgeDto> edges,  List<SequenceStepDto> steps,  List<PeriodBandDto> bands,  String? placeId,  List<PlaceCalloutDto> callouts)  $default,) {final _that = this;
switch (_that) {
case _VisualDto():
return $default(_that.schemaVersion,_that.id,_that.type,_that.title,_that.takeaway,_that.review,_that.notes,_that.companionId,_that.eventIds,_that.placeIds,_that.route,_that.edges,_that.steps,_that.bands,_that.placeId,_that.callouts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String id,  InfographicType type,  LocalizedTextDto title,  LocalizedTextDto takeaway,  ReviewDto review,  List<LocalizedTextDto> notes,  String? companionId,  List<String> eventIds,  List<String> placeIds,  List<RouteLegDto> route,  List<RelationEdgeDto> edges,  List<SequenceStepDto> steps,  List<PeriodBandDto> bands,  String? placeId,  List<PlaceCalloutDto> callouts)?  $default,) {final _that = this;
switch (_that) {
case _VisualDto() when $default != null:
return $default(_that.schemaVersion,_that.id,_that.type,_that.title,_that.takeaway,_that.review,_that.notes,_that.companionId,_that.eventIds,_that.placeIds,_that.route,_that.edges,_that.steps,_that.bands,_that.placeId,_that.callouts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisualDto implements VisualDto {
  const _VisualDto({required this.schemaVersion, required this.id, required this.type, required this.title, required this.takeaway, required this.review, final  List<LocalizedTextDto> notes = const <LocalizedTextDto>[], this.companionId, final  List<String> eventIds = const <String>[], final  List<String> placeIds = const <String>[], final  List<RouteLegDto> route = const <RouteLegDto>[], final  List<RelationEdgeDto> edges = const <RelationEdgeDto>[], final  List<SequenceStepDto> steps = const <SequenceStepDto>[], final  List<PeriodBandDto> bands = const <PeriodBandDto>[], this.placeId, final  List<PlaceCalloutDto> callouts = const <PlaceCalloutDto>[]}): _notes = notes,_eventIds = eventIds,_placeIds = placeIds,_route = route,_edges = edges,_steps = steps,_bands = bands,_callouts = callouts;
  factory _VisualDto.fromJson(Map<String, dynamic> json) => _$VisualDtoFromJson(json);

@override final  int schemaVersion;
@override final  String id;
@override final  InfographicType type;
@override final  LocalizedTextDto title;
@override final  LocalizedTextDto takeaway;
@override final  ReviewDto review;
 final  List<LocalizedTextDto> _notes;
@override@JsonKey() List<LocalizedTextDto> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override final  String? companionId;
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

 final  List<RouteLegDto> _route;
@override@JsonKey() List<RouteLegDto> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}

 final  List<RelationEdgeDto> _edges;
@override@JsonKey() List<RelationEdgeDto> get edges {
  if (_edges is EqualUnmodifiableListView) return _edges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_edges);
}

 final  List<SequenceStepDto> _steps;
@override@JsonKey() List<SequenceStepDto> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<PeriodBandDto> _bands;
@override@JsonKey() List<PeriodBandDto> get bands {
  if (_bands is EqualUnmodifiableListView) return _bands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bands);
}

@override final  String? placeId;
 final  List<PlaceCalloutDto> _callouts;
@override@JsonKey() List<PlaceCalloutDto> get callouts {
  if (_callouts is EqualUnmodifiableListView) return _callouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_callouts);
}


/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisualDtoCopyWith<_VisualDto> get copyWith => __$VisualDtoCopyWithImpl<_VisualDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisualDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisualDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.takeaway, takeaway) || other.takeaway == takeaway)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.companionId, companionId) || other.companionId == companionId)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds)&&const DeepCollectionEquality().equals(other._placeIds, _placeIds)&&const DeepCollectionEquality().equals(other._route, _route)&&const DeepCollectionEquality().equals(other._edges, _edges)&&const DeepCollectionEquality().equals(other._steps, _steps)&&const DeepCollectionEquality().equals(other._bands, _bands)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&const DeepCollectionEquality().equals(other._callouts, _callouts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,id,type,title,takeaway,review,const DeepCollectionEquality().hash(_notes),companionId,const DeepCollectionEquality().hash(_eventIds),const DeepCollectionEquality().hash(_placeIds),const DeepCollectionEquality().hash(_route),const DeepCollectionEquality().hash(_edges),const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_bands),placeId,const DeepCollectionEquality().hash(_callouts));

@override
String toString() {
  return 'VisualDto(schemaVersion: $schemaVersion, id: $id, type: $type, title: $title, takeaway: $takeaway, review: $review, notes: $notes, companionId: $companionId, eventIds: $eventIds, placeIds: $placeIds, route: $route, edges: $edges, steps: $steps, bands: $bands, placeId: $placeId, callouts: $callouts)';
}


}

/// @nodoc
abstract mixin class _$VisualDtoCopyWith<$Res> implements $VisualDtoCopyWith<$Res> {
  factory _$VisualDtoCopyWith(_VisualDto value, $Res Function(_VisualDto) _then) = __$VisualDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String id, InfographicType type, LocalizedTextDto title, LocalizedTextDto takeaway, ReviewDto review, List<LocalizedTextDto> notes, String? companionId, List<String> eventIds, List<String> placeIds, List<RouteLegDto> route, List<RelationEdgeDto> edges, List<SequenceStepDto> steps, List<PeriodBandDto> bands, String? placeId, List<PlaceCalloutDto> callouts
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $LocalizedTextDtoCopyWith<$Res> get takeaway;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$VisualDtoCopyWithImpl<$Res>
    implements _$VisualDtoCopyWith<$Res> {
  __$VisualDtoCopyWithImpl(this._self, this._then);

  final _VisualDto _self;
  final $Res Function(_VisualDto) _then;

/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? id = null,Object? type = null,Object? title = null,Object? takeaway = null,Object? review = null,Object? notes = null,Object? companionId = freezed,Object? eventIds = null,Object? placeIds = null,Object? route = null,Object? edges = null,Object? steps = null,Object? bands = null,Object? placeId = freezed,Object? callouts = null,}) {
  return _then(_VisualDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InfographicType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,takeaway: null == takeaway ? _self.takeaway : takeaway // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<LocalizedTextDto>,companionId: freezed == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String?,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,placeIds: null == placeIds ? _self._placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<RouteLegDto>,edges: null == edges ? _self._edges : edges // ignore: cast_nullable_to_non_nullable
as List<RelationEdgeDto>,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<SequenceStepDto>,bands: null == bands ? _self._bands : bands // ignore: cast_nullable_to_non_nullable
as List<PeriodBandDto>,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,callouts: null == callouts ? _self._callouts : callouts // ignore: cast_nullable_to_non_nullable
as List<PlaceCalloutDto>,
  ));
}

/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of VisualDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get takeaway {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.takeaway, (value) {
    return _then(_self.copyWith(takeaway: value));
  });
}/// Create a copy of VisualDto
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
mixin _$VisualsFileDto {

 int get schemaVersion; List<VisualDto> get visuals;
/// Create a copy of VisualsFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VisualsFileDtoCopyWith<VisualsFileDto> get copyWith => _$VisualsFileDtoCopyWithImpl<VisualsFileDto>(this as VisualsFileDto, _$identity);

  /// Serializes this VisualsFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VisualsFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.visuals, visuals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(visuals));

@override
String toString() {
  return 'VisualsFileDto(schemaVersion: $schemaVersion, visuals: $visuals)';
}


}

/// @nodoc
abstract mixin class $VisualsFileDtoCopyWith<$Res>  {
  factory $VisualsFileDtoCopyWith(VisualsFileDto value, $Res Function(VisualsFileDto) _then) = _$VisualsFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<VisualDto> visuals
});




}
/// @nodoc
class _$VisualsFileDtoCopyWithImpl<$Res>
    implements $VisualsFileDtoCopyWith<$Res> {
  _$VisualsFileDtoCopyWithImpl(this._self, this._then);

  final VisualsFileDto _self;
  final $Res Function(VisualsFileDto) _then;

/// Create a copy of VisualsFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? visuals = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,visuals: null == visuals ? _self.visuals : visuals // ignore: cast_nullable_to_non_nullable
as List<VisualDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [VisualsFileDto].
extension VisualsFileDtoPatterns on VisualsFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VisualsFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VisualsFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VisualsFileDto value)  $default,){
final _that = this;
switch (_that) {
case _VisualsFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VisualsFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _VisualsFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<VisualDto> visuals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VisualsFileDto() when $default != null:
return $default(_that.schemaVersion,_that.visuals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<VisualDto> visuals)  $default,) {final _that = this;
switch (_that) {
case _VisualsFileDto():
return $default(_that.schemaVersion,_that.visuals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<VisualDto> visuals)?  $default,) {final _that = this;
switch (_that) {
case _VisualsFileDto() when $default != null:
return $default(_that.schemaVersion,_that.visuals);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VisualsFileDto implements VisualsFileDto {
  const _VisualsFileDto({required this.schemaVersion, required final  List<VisualDto> visuals}): _visuals = visuals;
  factory _VisualsFileDto.fromJson(Map<String, dynamic> json) => _$VisualsFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<VisualDto> _visuals;
@override List<VisualDto> get visuals {
  if (_visuals is EqualUnmodifiableListView) return _visuals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visuals);
}


/// Create a copy of VisualsFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VisualsFileDtoCopyWith<_VisualsFileDto> get copyWith => __$VisualsFileDtoCopyWithImpl<_VisualsFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VisualsFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VisualsFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._visuals, _visuals));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_visuals));

@override
String toString() {
  return 'VisualsFileDto(schemaVersion: $schemaVersion, visuals: $visuals)';
}


}

/// @nodoc
abstract mixin class _$VisualsFileDtoCopyWith<$Res> implements $VisualsFileDtoCopyWith<$Res> {
  factory _$VisualsFileDtoCopyWith(_VisualsFileDto value, $Res Function(_VisualsFileDto) _then) = __$VisualsFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<VisualDto> visuals
});




}
/// @nodoc
class __$VisualsFileDtoCopyWithImpl<$Res>
    implements _$VisualsFileDtoCopyWith<$Res> {
  __$VisualsFileDtoCopyWithImpl(this._self, this._then);

  final _VisualsFileDto _self;
  final $Res Function(_VisualsFileDto) _then;

/// Create a copy of VisualsFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? visuals = null,}) {
  return _then(_VisualsFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,visuals: null == visuals ? _self._visuals : visuals // ignore: cast_nullable_to_non_nullable
as List<VisualDto>,
  ));
}


}

// dart format on
