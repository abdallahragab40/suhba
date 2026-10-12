// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'atlas.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeoPoint {

 double get lat; double get lon; GeoPrecision get precision;
/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoPointCopyWith<GeoPoint> get copyWith => _$GeoPointCopyWithImpl<GeoPoint>(this as GeoPoint, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoPoint&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.precision, precision) || other.precision == precision));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lon,precision);

@override
String toString() {
  return 'GeoPoint(lat: $lat, lon: $lon, precision: $precision)';
}


}

/// @nodoc
abstract mixin class $GeoPointCopyWith<$Res>  {
  factory $GeoPointCopyWith(GeoPoint value, $Res Function(GeoPoint) _then) = _$GeoPointCopyWithImpl;
@useResult
$Res call({
 double lat, double lon, GeoPrecision precision
});




}
/// @nodoc
class _$GeoPointCopyWithImpl<$Res>
    implements $GeoPointCopyWith<$Res> {
  _$GeoPointCopyWithImpl(this._self, this._then);

  final GeoPoint _self;
  final $Res Function(GeoPoint) _then;

/// Create a copy of GeoPoint
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


/// Adds pattern-matching-related methods to [GeoPoint].
extension GeoPointPatterns on GeoPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeoPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeoPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeoPoint value)  $default,){
final _that = this;
switch (_that) {
case _GeoPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeoPoint value)?  $default,){
final _that = this;
switch (_that) {
case _GeoPoint() when $default != null:
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
case _GeoPoint() when $default != null:
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
case _GeoPoint():
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
case _GeoPoint() when $default != null:
return $default(_that.lat,_that.lon,_that.precision);case _:
  return null;

}
}

}

/// @nodoc


class _GeoPoint implements GeoPoint {
  const _GeoPoint({required this.lat, required this.lon, required this.precision});
  

@override final  double lat;
@override final  double lon;
@override final  GeoPrecision precision;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoPointCopyWith<_GeoPoint> get copyWith => __$GeoPointCopyWithImpl<_GeoPoint>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoPoint&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lon, lon) || other.lon == lon)&&(identical(other.precision, precision) || other.precision == precision));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lon,precision);

@override
String toString() {
  return 'GeoPoint(lat: $lat, lon: $lon, precision: $precision)';
}


}

/// @nodoc
abstract mixin class _$GeoPointCopyWith<$Res> implements $GeoPointCopyWith<$Res> {
  factory _$GeoPointCopyWith(_GeoPoint value, $Res Function(_GeoPoint) _then) = __$GeoPointCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lon, GeoPrecision precision
});




}
/// @nodoc
class __$GeoPointCopyWithImpl<$Res>
    implements _$GeoPointCopyWith<$Res> {
  __$GeoPointCopyWithImpl(this._self, this._then);

  final _GeoPoint _self;
  final $Res Function(_GeoPoint) _then;

/// Create a copy of GeoPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lon = null,Object? precision = null,}) {
  return _then(_GeoPoint(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lon: null == lon ? _self.lon : lon // ignore: cast_nullable_to_non_nullable
as double,precision: null == precision ? _self.precision : precision // ignore: cast_nullable_to_non_nullable
as GeoPrecision,
  ));
}


}

/// @nodoc
mixin _$HistoricalPlace {

 String get id; LocalizedText get name; PlaceKind get kind; GeoPoint get location; LocalizedText get summary; Reliability get reliability; List<Citation> get citations; ReviewInfo get review; LocalizedText? get modernName;/// A note on what stands there today, so present-day buildings are
/// never taken for the historical setting.
 LocalizedText? get contemporaryNote;/// Companions tied to this place, such as those buried there.
 List<String> get companionIds;
/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalPlaceCopyWith<HistoricalPlace> get copyWith => _$HistoricalPlaceCopyWithImpl<HistoricalPlace>(this as HistoricalPlace, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.location, location) || other.location == location)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.modernName, modernName) || other.modernName == modernName)&&(identical(other.contemporaryNote, contemporaryNote) || other.contemporaryNote == contemporaryNote)&&const DeepCollectionEquality().equals(other.companionIds, companionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,kind,location,summary,reliability,const DeepCollectionEquality().hash(citations),review,modernName,contemporaryNote,const DeepCollectionEquality().hash(companionIds));

@override
String toString() {
  return 'HistoricalPlace(id: $id, name: $name, kind: $kind, location: $location, summary: $summary, reliability: $reliability, citations: $citations, review: $review, modernName: $modernName, contemporaryNote: $contemporaryNote, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class $HistoricalPlaceCopyWith<$Res>  {
  factory $HistoricalPlaceCopyWith(HistoricalPlace value, $Res Function(HistoricalPlace) _then) = _$HistoricalPlaceCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, PlaceKind kind, GeoPoint location, LocalizedText summary, Reliability reliability, List<Citation> citations, ReviewInfo review, LocalizedText? modernName, LocalizedText? contemporaryNote, List<String> companionIds
});


$LocalizedTextCopyWith<$Res> get name;$GeoPointCopyWith<$Res> get location;$LocalizedTextCopyWith<$Res> get summary;$ReviewInfoCopyWith<$Res> get review;$LocalizedTextCopyWith<$Res>? get modernName;$LocalizedTextCopyWith<$Res>? get contemporaryNote;

}
/// @nodoc
class _$HistoricalPlaceCopyWithImpl<$Res>
    implements $HistoricalPlaceCopyWith<$Res> {
  _$HistoricalPlaceCopyWithImpl(this._self, this._then);

  final HistoricalPlace _self;
  final $Res Function(HistoricalPlace) _then;

/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? location = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? modernName = freezed,Object? contemporaryNote = freezed,Object? companionIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlaceKind,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,modernName: freezed == modernName ? _self.modernName : modernName // ignore: cast_nullable_to_non_nullable
as LocalizedText?,contemporaryNote: freezed == contemporaryNote ? _self.contemporaryNote : contemporaryNote // ignore: cast_nullable_to_non_nullable
as LocalizedText?,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get modernName {
    if (_self.modernName == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.modernName!, (value) {
    return _then(_self.copyWith(modernName: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get contemporaryNote {
    if (_self.contemporaryNote == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.contemporaryNote!, (value) {
    return _then(_self.copyWith(contemporaryNote: value));
  });
}
}


/// Adds pattern-matching-related methods to [HistoricalPlace].
extension HistoricalPlacePatterns on HistoricalPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalPlace value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalPlace value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  PlaceKind kind,  GeoPoint location,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  ReviewInfo review,  LocalizedText? modernName,  LocalizedText? contemporaryNote,  List<String> companionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalPlace() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  PlaceKind kind,  GeoPoint location,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  ReviewInfo review,  LocalizedText? modernName,  LocalizedText? contemporaryNote,  List<String> companionIds)  $default,) {final _that = this;
switch (_that) {
case _HistoricalPlace():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText name,  PlaceKind kind,  GeoPoint location,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  ReviewInfo review,  LocalizedText? modernName,  LocalizedText? contemporaryNote,  List<String> companionIds)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalPlace() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.location,_that.summary,_that.reliability,_that.citations,_that.review,_that.modernName,_that.contemporaryNote,_that.companionIds);case _:
  return null;

}
}

}

/// @nodoc


class _HistoricalPlace implements HistoricalPlace {
  const _HistoricalPlace({required this.id, required this.name, required this.kind, required this.location, required this.summary, required this.reliability, required final  List<Citation> citations, required this.review, this.modernName, this.contemporaryNote, final  List<String> companionIds = const <String>[]}): _citations = citations,_companionIds = companionIds;
  

@override final  String id;
@override final  LocalizedText name;
@override final  PlaceKind kind;
@override final  GeoPoint location;
@override final  LocalizedText summary;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  ReviewInfo review;
@override final  LocalizedText? modernName;
/// A note on what stands there today, so present-day buildings are
/// never taken for the historical setting.
@override final  LocalizedText? contemporaryNote;
/// Companions tied to this place, such as those buried there.
 final  List<String> _companionIds;
/// Companions tied to this place, such as those buried there.
@override@JsonKey() List<String> get companionIds {
  if (_companionIds is EqualUnmodifiableListView) return _companionIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_companionIds);
}


/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalPlaceCopyWith<_HistoricalPlace> get copyWith => __$HistoricalPlaceCopyWithImpl<_HistoricalPlace>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.location, location) || other.location == location)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.modernName, modernName) || other.modernName == modernName)&&(identical(other.contemporaryNote, contemporaryNote) || other.contemporaryNote == contemporaryNote)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,kind,location,summary,reliability,const DeepCollectionEquality().hash(_citations),review,modernName,contemporaryNote,const DeepCollectionEquality().hash(_companionIds));

@override
String toString() {
  return 'HistoricalPlace(id: $id, name: $name, kind: $kind, location: $location, summary: $summary, reliability: $reliability, citations: $citations, review: $review, modernName: $modernName, contemporaryNote: $contemporaryNote, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class _$HistoricalPlaceCopyWith<$Res> implements $HistoricalPlaceCopyWith<$Res> {
  factory _$HistoricalPlaceCopyWith(_HistoricalPlace value, $Res Function(_HistoricalPlace) _then) = __$HistoricalPlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, PlaceKind kind, GeoPoint location, LocalizedText summary, Reliability reliability, List<Citation> citations, ReviewInfo review, LocalizedText? modernName, LocalizedText? contemporaryNote, List<String> companionIds
});


@override $LocalizedTextCopyWith<$Res> get name;@override $GeoPointCopyWith<$Res> get location;@override $LocalizedTextCopyWith<$Res> get summary;@override $ReviewInfoCopyWith<$Res> get review;@override $LocalizedTextCopyWith<$Res>? get modernName;@override $LocalizedTextCopyWith<$Res>? get contemporaryNote;

}
/// @nodoc
class __$HistoricalPlaceCopyWithImpl<$Res>
    implements _$HistoricalPlaceCopyWith<$Res> {
  __$HistoricalPlaceCopyWithImpl(this._self, this._then);

  final _HistoricalPlace _self;
  final $Res Function(_HistoricalPlace) _then;

/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? location = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? modernName = freezed,Object? contemporaryNote = freezed,Object? companionIds = null,}) {
  return _then(_HistoricalPlace(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PlaceKind,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GeoPoint,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,modernName: freezed == modernName ? _self.modernName : modernName // ignore: cast_nullable_to_non_nullable
as LocalizedText?,contemporaryNote: freezed == contemporaryNote ? _self.contemporaryNote : contemporaryNote // ignore: cast_nullable_to_non_nullable
as LocalizedText?,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeoPointCopyWith<$Res> get location {
  
  return $GeoPointCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get modernName {
    if (_self.modernName == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.modernName!, (value) {
    return _then(_self.copyWith(modernName: value));
  });
}/// Create a copy of HistoricalPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get contemporaryNote {
    if (_self.contemporaryNote == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.contemporaryNote!, (value) {
    return _then(_self.copyWith(contemporaryNote: value));
  });
}
}

/// @nodoc
mixin _$RouteLeg {

 String get fromPlaceId; String get toPlaceId;/// The path between the two is not known; drawn dashed and labelled
/// approximate.
 bool get approximate; Reliability get reliability; List<Citation> get citations; LocalizedText? get note;
/// Create a copy of RouteLeg
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteLegCopyWith<RouteLeg> get copyWith => _$RouteLegCopyWithImpl<RouteLeg>(this as RouteLeg, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteLeg&&(identical(other.fromPlaceId, fromPlaceId) || other.fromPlaceId == fromPlaceId)&&(identical(other.toPlaceId, toPlaceId) || other.toPlaceId == toPlaceId)&&(identical(other.approximate, approximate) || other.approximate == approximate)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,fromPlaceId,toPlaceId,approximate,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'RouteLeg(fromPlaceId: $fromPlaceId, toPlaceId: $toPlaceId, approximate: $approximate, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $RouteLegCopyWith<$Res>  {
  factory $RouteLegCopyWith(RouteLeg value, $Res Function(RouteLeg) _then) = _$RouteLegCopyWithImpl;
@useResult
$Res call({
 String fromPlaceId, String toPlaceId, bool approximate, Reliability reliability, List<Citation> citations, LocalizedText? note
});


$LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class _$RouteLegCopyWithImpl<$Res>
    implements $RouteLegCopyWith<$Res> {
  _$RouteLegCopyWithImpl(this._self, this._then);

  final RouteLeg _self;
  final $Res Function(RouteLeg) _then;

/// Create a copy of RouteLeg
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromPlaceId = null,Object? toPlaceId = null,Object? approximate = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
fromPlaceId: null == fromPlaceId ? _self.fromPlaceId : fromPlaceId // ignore: cast_nullable_to_non_nullable
as String,toPlaceId: null == toPlaceId ? _self.toPlaceId : toPlaceId // ignore: cast_nullable_to_non_nullable
as String,approximate: null == approximate ? _self.approximate : approximate // ignore: cast_nullable_to_non_nullable
as bool,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of RouteLeg
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


/// Adds pattern-matching-related methods to [RouteLeg].
extension RouteLegPatterns on RouteLeg {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteLeg value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteLeg() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteLeg value)  $default,){
final _that = this;
switch (_that) {
case _RouteLeg():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteLeg value)?  $default,){
final _that = this;
switch (_that) {
case _RouteLeg() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fromPlaceId,  String toPlaceId,  bool approximate,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteLeg() when $default != null:
return $default(_that.fromPlaceId,_that.toPlaceId,_that.approximate,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fromPlaceId,  String toPlaceId,  bool approximate,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)  $default,) {final _that = this;
switch (_that) {
case _RouteLeg():
return $default(_that.fromPlaceId,_that.toPlaceId,_that.approximate,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fromPlaceId,  String toPlaceId,  bool approximate,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,) {final _that = this;
switch (_that) {
case _RouteLeg() when $default != null:
return $default(_that.fromPlaceId,_that.toPlaceId,_that.approximate,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _RouteLeg implements RouteLeg {
  const _RouteLeg({required this.fromPlaceId, required this.toPlaceId, required this.approximate, required this.reliability, required final  List<Citation> citations, this.note}): _citations = citations;
  

@override final  String fromPlaceId;
@override final  String toPlaceId;
/// The path between the two is not known; drawn dashed and labelled
/// approximate.
@override final  bool approximate;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedText? note;

/// Create a copy of RouteLeg
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteLegCopyWith<_RouteLeg> get copyWith => __$RouteLegCopyWithImpl<_RouteLeg>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteLeg&&(identical(other.fromPlaceId, fromPlaceId) || other.fromPlaceId == fromPlaceId)&&(identical(other.toPlaceId, toPlaceId) || other.toPlaceId == toPlaceId)&&(identical(other.approximate, approximate) || other.approximate == approximate)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,fromPlaceId,toPlaceId,approximate,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'RouteLeg(fromPlaceId: $fromPlaceId, toPlaceId: $toPlaceId, approximate: $approximate, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$RouteLegCopyWith<$Res> implements $RouteLegCopyWith<$Res> {
  factory _$RouteLegCopyWith(_RouteLeg value, $Res Function(_RouteLeg) _then) = __$RouteLegCopyWithImpl;
@override @useResult
$Res call({
 String fromPlaceId, String toPlaceId, bool approximate, Reliability reliability, List<Citation> citations, LocalizedText? note
});


@override $LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class __$RouteLegCopyWithImpl<$Res>
    implements _$RouteLegCopyWith<$Res> {
  __$RouteLegCopyWithImpl(this._self, this._then);

  final _RouteLeg _self;
  final $Res Function(_RouteLeg) _then;

/// Create a copy of RouteLeg
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromPlaceId = null,Object? toPlaceId = null,Object? approximate = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_RouteLeg(
fromPlaceId: null == fromPlaceId ? _self.fromPlaceId : fromPlaceId // ignore: cast_nullable_to_non_nullable
as String,toPlaceId: null == toPlaceId ? _self.toPlaceId : toPlaceId // ignore: cast_nullable_to_non_nullable
as String,approximate: null == approximate ? _self.approximate : approximate // ignore: cast_nullable_to_non_nullable
as bool,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of RouteLeg
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
mixin _$RelationEdge {

 PersonRef get from; PersonRef get to; RelationType get type; Reliability get reliability; List<Citation> get citations; LocalizedText? get note;
/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationEdgeCopyWith<RelationEdge> get copyWith => _$RelationEdgeCopyWithImpl<RelationEdge>(this as RelationEdge, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationEdge&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.type, type) || other.type == type)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,type,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'RelationEdge(from: $from, to: $to, type: $type, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $RelationEdgeCopyWith<$Res>  {
  factory $RelationEdgeCopyWith(RelationEdge value, $Res Function(RelationEdge) _then) = _$RelationEdgeCopyWithImpl;
@useResult
$Res call({
 PersonRef from, PersonRef to, RelationType type, Reliability reliability, List<Citation> citations, LocalizedText? note
});


$PersonRefCopyWith<$Res> get from;$PersonRefCopyWith<$Res> get to;$LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class _$RelationEdgeCopyWithImpl<$Res>
    implements $RelationEdgeCopyWith<$Res> {
  _$RelationEdgeCopyWithImpl(this._self, this._then);

  final RelationEdge _self;
  final $Res Function(RelationEdge) _then;

/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? type = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as PersonRef,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as PersonRef,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefCopyWith<$Res> get from {
  
  return $PersonRefCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefCopyWith<$Res> get to {
  
  return $PersonRefCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}/// Create a copy of RelationEdge
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


/// Adds pattern-matching-related methods to [RelationEdge].
extension RelationEdgePatterns on RelationEdge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationEdge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationEdge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationEdge value)  $default,){
final _that = this;
switch (_that) {
case _RelationEdge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationEdge value)?  $default,){
final _that = this;
switch (_that) {
case _RelationEdge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PersonRef from,  PersonRef to,  RelationType type,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationEdge() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PersonRef from,  PersonRef to,  RelationType type,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)  $default,) {final _that = this;
switch (_that) {
case _RelationEdge():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PersonRef from,  PersonRef to,  RelationType type,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,) {final _that = this;
switch (_that) {
case _RelationEdge() when $default != null:
return $default(_that.from,_that.to,_that.type,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _RelationEdge implements RelationEdge {
  const _RelationEdge({required this.from, required this.to, required this.type, required this.reliability, required final  List<Citation> citations, this.note}): _citations = citations;
  

@override final  PersonRef from;
@override final  PersonRef to;
@override final  RelationType type;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedText? note;

/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationEdgeCopyWith<_RelationEdge> get copyWith => __$RelationEdgeCopyWithImpl<_RelationEdge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationEdge&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.type, type) || other.type == type)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,from,to,type,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'RelationEdge(from: $from, to: $to, type: $type, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$RelationEdgeCopyWith<$Res> implements $RelationEdgeCopyWith<$Res> {
  factory _$RelationEdgeCopyWith(_RelationEdge value, $Res Function(_RelationEdge) _then) = __$RelationEdgeCopyWithImpl;
@override @useResult
$Res call({
 PersonRef from, PersonRef to, RelationType type, Reliability reliability, List<Citation> citations, LocalizedText? note
});


@override $PersonRefCopyWith<$Res> get from;@override $PersonRefCopyWith<$Res> get to;@override $LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class __$RelationEdgeCopyWithImpl<$Res>
    implements _$RelationEdgeCopyWith<$Res> {
  __$RelationEdgeCopyWithImpl(this._self, this._then);

  final _RelationEdge _self;
  final $Res Function(_RelationEdge) _then;

/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? type = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_RelationEdge(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as PersonRef,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as PersonRef,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefCopyWith<$Res> get from {
  
  return $PersonRefCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of RelationEdge
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefCopyWith<$Res> get to {
  
  return $PersonRefCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}/// Create a copy of RelationEdge
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
mixin _$SequenceStep {

 LocalizedText get title; LocalizedText get text; Reliability get reliability; List<Citation> get citations; String? get placeId; HistoricalDate? get date;/// The sources do not settle where this step falls in the order.
 bool get orderUncertain;
/// Create a copy of SequenceStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SequenceStepCopyWith<SequenceStep> get copyWith => _$SequenceStepCopyWithImpl<SequenceStep>(this as SequenceStep, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SequenceStep&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.date, date) || other.date == date)&&(identical(other.orderUncertain, orderUncertain) || other.orderUncertain == orderUncertain));
}


@override
int get hashCode => Object.hash(runtimeType,title,text,reliability,const DeepCollectionEquality().hash(citations),placeId,date,orderUncertain);

@override
String toString() {
  return 'SequenceStep(title: $title, text: $text, reliability: $reliability, citations: $citations, placeId: $placeId, date: $date, orderUncertain: $orderUncertain)';
}


}

/// @nodoc
abstract mixin class $SequenceStepCopyWith<$Res>  {
  factory $SequenceStepCopyWith(SequenceStep value, $Res Function(SequenceStep) _then) = _$SequenceStepCopyWithImpl;
@useResult
$Res call({
 LocalizedText title, LocalizedText text, Reliability reliability, List<Citation> citations, String? placeId, HistoricalDate? date, bool orderUncertain
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class _$SequenceStepCopyWithImpl<$Res>
    implements $SequenceStepCopyWith<$Res> {
  _$SequenceStepCopyWithImpl(this._self, this._then);

  final SequenceStep _self;
  final $Res Function(SequenceStep) _then;

/// Create a copy of SequenceStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? text = null,Object? reliability = null,Object? citations = null,Object? placeId = freezed,Object? date = freezed,Object? orderUncertain = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate?,orderUncertain: null == orderUncertain ? _self.orderUncertain : orderUncertain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SequenceStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SequenceStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get text {
  
  return $LocalizedTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}


/// Adds pattern-matching-related methods to [SequenceStep].
extension SequenceStepPatterns on SequenceStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SequenceStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SequenceStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SequenceStep value)  $default,){
final _that = this;
switch (_that) {
case _SequenceStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SequenceStep value)?  $default,){
final _that = this;
switch (_that) {
case _SequenceStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedText title,  LocalizedText text,  Reliability reliability,  List<Citation> citations,  String? placeId,  HistoricalDate? date,  bool orderUncertain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SequenceStep() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedText title,  LocalizedText text,  Reliability reliability,  List<Citation> citations,  String? placeId,  HistoricalDate? date,  bool orderUncertain)  $default,) {final _that = this;
switch (_that) {
case _SequenceStep():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedText title,  LocalizedText text,  Reliability reliability,  List<Citation> citations,  String? placeId,  HistoricalDate? date,  bool orderUncertain)?  $default,) {final _that = this;
switch (_that) {
case _SequenceStep() when $default != null:
return $default(_that.title,_that.text,_that.reliability,_that.citations,_that.placeId,_that.date,_that.orderUncertain);case _:
  return null;

}
}

}

/// @nodoc


class _SequenceStep implements SequenceStep {
  const _SequenceStep({required this.title, required this.text, required this.reliability, required final  List<Citation> citations, this.placeId, this.date, this.orderUncertain = false}): _citations = citations;
  

@override final  LocalizedText title;
@override final  LocalizedText text;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  String? placeId;
@override final  HistoricalDate? date;
/// The sources do not settle where this step falls in the order.
@override@JsonKey() final  bool orderUncertain;

/// Create a copy of SequenceStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SequenceStepCopyWith<_SequenceStep> get copyWith => __$SequenceStepCopyWithImpl<_SequenceStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SequenceStep&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.date, date) || other.date == date)&&(identical(other.orderUncertain, orderUncertain) || other.orderUncertain == orderUncertain));
}


@override
int get hashCode => Object.hash(runtimeType,title,text,reliability,const DeepCollectionEquality().hash(_citations),placeId,date,orderUncertain);

@override
String toString() {
  return 'SequenceStep(title: $title, text: $text, reliability: $reliability, citations: $citations, placeId: $placeId, date: $date, orderUncertain: $orderUncertain)';
}


}

/// @nodoc
abstract mixin class _$SequenceStepCopyWith<$Res> implements $SequenceStepCopyWith<$Res> {
  factory _$SequenceStepCopyWith(_SequenceStep value, $Res Function(_SequenceStep) _then) = __$SequenceStepCopyWithImpl;
@override @useResult
$Res call({
 LocalizedText title, LocalizedText text, Reliability reliability, List<Citation> citations, String? placeId, HistoricalDate? date, bool orderUncertain
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class __$SequenceStepCopyWithImpl<$Res>
    implements _$SequenceStepCopyWith<$Res> {
  __$SequenceStepCopyWithImpl(this._self, this._then);

  final _SequenceStep _self;
  final $Res Function(_SequenceStep) _then;

/// Create a copy of SequenceStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? text = null,Object? reliability = null,Object? citations = null,Object? placeId = freezed,Object? date = freezed,Object? orderUncertain = null,}) {
  return _then(_SequenceStep(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate?,orderUncertain: null == orderUncertain ? _self.orderUncertain : orderUncertain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SequenceStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SequenceStep
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
mixin _$PeriodBand {

 LocalizedText get label; HistoricalDate get date; Reliability get reliability; List<Citation> get citations; LocalizedText? get note;
/// Create a copy of PeriodBand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodBandCopyWith<PeriodBand> get copyWith => _$PeriodBandCopyWithImpl<PeriodBand>(this as PeriodBand, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodBand&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,label,date,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'PeriodBand(label: $label, date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $PeriodBandCopyWith<$Res>  {
  factory $PeriodBandCopyWith(PeriodBand value, $Res Function(PeriodBand) _then) = _$PeriodBandCopyWithImpl;
@useResult
$Res call({
 LocalizedText label, HistoricalDate date, Reliability reliability, List<Citation> citations, LocalizedText? note
});


$LocalizedTextCopyWith<$Res> get label;$LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class _$PeriodBandCopyWithImpl<$Res>
    implements $PeriodBandCopyWith<$Res> {
  _$PeriodBandCopyWithImpl(this._self, this._then);

  final PeriodBand _self;
  final $Res Function(PeriodBand) _then;

/// Create a copy of PeriodBand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of PeriodBand
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PeriodBand
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


/// Adds pattern-matching-related methods to [PeriodBand].
extension PeriodBandPatterns on PeriodBand {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodBand value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodBand() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodBand value)  $default,){
final _that = this;
switch (_that) {
case _PeriodBand():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodBand value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodBand() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedText label,  HistoricalDate date,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodBand() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedText label,  HistoricalDate date,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)  $default,) {final _that = this;
switch (_that) {
case _PeriodBand():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedText label,  HistoricalDate date,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,) {final _that = this;
switch (_that) {
case _PeriodBand() when $default != null:
return $default(_that.label,_that.date,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodBand implements PeriodBand {
  const _PeriodBand({required this.label, required this.date, required this.reliability, required final  List<Citation> citations, this.note}): _citations = citations;
  

@override final  LocalizedText label;
@override final  HistoricalDate date;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedText? note;

/// Create a copy of PeriodBand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodBandCopyWith<_PeriodBand> get copyWith => __$PeriodBandCopyWithImpl<_PeriodBand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodBand&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,label,date,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'PeriodBand(label: $label, date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$PeriodBandCopyWith<$Res> implements $PeriodBandCopyWith<$Res> {
  factory _$PeriodBandCopyWith(_PeriodBand value, $Res Function(_PeriodBand) _then) = __$PeriodBandCopyWithImpl;
@override @useResult
$Res call({
 LocalizedText label, HistoricalDate date, Reliability reliability, List<Citation> citations, LocalizedText? note
});


@override $LocalizedTextCopyWith<$Res> get label;@override $LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class __$PeriodBandCopyWithImpl<$Res>
    implements _$PeriodBandCopyWith<$Res> {
  __$PeriodBandCopyWithImpl(this._self, this._then);

  final _PeriodBand _self;
  final $Res Function(_PeriodBand) _then;

/// Create a copy of PeriodBand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_PeriodBand(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of PeriodBand
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PeriodBand
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
mixin _$PlaceCallout {

 LocalizedText get label; LocalizedText get text; Reliability get reliability; List<Citation> get citations;
/// Create a copy of PlaceCallout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCalloutCopyWith<PlaceCallout> get copyWith => _$PlaceCalloutCopyWithImpl<PlaceCallout>(this as PlaceCallout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceCallout&&(identical(other.label, label) || other.label == label)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations));
}


@override
int get hashCode => Object.hash(runtimeType,label,text,reliability,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'PlaceCallout(label: $label, text: $text, reliability: $reliability, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $PlaceCalloutCopyWith<$Res>  {
  factory $PlaceCalloutCopyWith(PlaceCallout value, $Res Function(PlaceCallout) _then) = _$PlaceCalloutCopyWithImpl;
@useResult
$Res call({
 LocalizedText label, LocalizedText text, Reliability reliability, List<Citation> citations
});


$LocalizedTextCopyWith<$Res> get label;$LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class _$PlaceCalloutCopyWithImpl<$Res>
    implements $PlaceCalloutCopyWith<$Res> {
  _$PlaceCalloutCopyWithImpl(this._self, this._then);

  final PlaceCallout _self;
  final $Res Function(PlaceCallout) _then;

/// Create a copy of PlaceCallout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? text = null,Object? reliability = null,Object? citations = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}
/// Create a copy of PlaceCallout
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PlaceCallout
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get text {
  
  return $LocalizedTextCopyWith<$Res>(_self.text, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceCallout].
extension PlaceCalloutPatterns on PlaceCallout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceCallout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceCallout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceCallout value)  $default,){
final _that = this;
switch (_that) {
case _PlaceCallout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceCallout value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceCallout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedText label,  LocalizedText text,  Reliability reliability,  List<Citation> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceCallout() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedText label,  LocalizedText text,  Reliability reliability,  List<Citation> citations)  $default,) {final _that = this;
switch (_that) {
case _PlaceCallout():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedText label,  LocalizedText text,  Reliability reliability,  List<Citation> citations)?  $default,) {final _that = this;
switch (_that) {
case _PlaceCallout() when $default != null:
return $default(_that.label,_that.text,_that.reliability,_that.citations);case _:
  return null;

}
}

}

/// @nodoc


class _PlaceCallout implements PlaceCallout {
  const _PlaceCallout({required this.label, required this.text, required this.reliability, required final  List<Citation> citations}): _citations = citations;
  

@override final  LocalizedText label;
@override final  LocalizedText text;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of PlaceCallout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCalloutCopyWith<_PlaceCallout> get copyWith => __$PlaceCalloutCopyWithImpl<_PlaceCallout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceCallout&&(identical(other.label, label) || other.label == label)&&(identical(other.text, text) || other.text == text)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations));
}


@override
int get hashCode => Object.hash(runtimeType,label,text,reliability,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'PlaceCallout(label: $label, text: $text, reliability: $reliability, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$PlaceCalloutCopyWith<$Res> implements $PlaceCalloutCopyWith<$Res> {
  factory _$PlaceCalloutCopyWith(_PlaceCallout value, $Res Function(_PlaceCallout) _then) = __$PlaceCalloutCopyWithImpl;
@override @useResult
$Res call({
 LocalizedText label, LocalizedText text, Reliability reliability, List<Citation> citations
});


@override $LocalizedTextCopyWith<$Res> get label;@override $LocalizedTextCopyWith<$Res> get text;

}
/// @nodoc
class __$PlaceCalloutCopyWithImpl<$Res>
    implements _$PlaceCalloutCopyWith<$Res> {
  __$PlaceCalloutCopyWithImpl(this._self, this._then);

  final _PlaceCallout _self;
  final $Res Function(_PlaceCallout) _then;

/// Create a copy of PlaceCallout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? text = null,Object? reliability = null,Object? citations = null,}) {
  return _then(_PlaceCallout(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}

/// Create a copy of PlaceCallout
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of PlaceCallout
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
mixin _$InfographicData {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InfographicData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InfographicData()';
}


}

/// @nodoc
class $InfographicDataCopyWith<$Res>  {
$InfographicDataCopyWith(InfographicData _, $Res Function(InfographicData) __);
}


/// Adds pattern-matching-related methods to [InfographicData].
extension InfographicDataPatterns on InfographicData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TimelineData value)?  timeline,TResult Function( MapData value)?  map,TResult Function( RelationshipsData value)?  relationships,TResult Function( SequenceData value)?  sequence,TResult Function( PeriodsData value)?  periods,TResult Function( PlacePanelData value)?  placePanel,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TimelineData() when timeline != null:
return timeline(_that);case MapData() when map != null:
return map(_that);case RelationshipsData() when relationships != null:
return relationships(_that);case SequenceData() when sequence != null:
return sequence(_that);case PeriodsData() when periods != null:
return periods(_that);case PlacePanelData() when placePanel != null:
return placePanel(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TimelineData value)  timeline,required TResult Function( MapData value)  map,required TResult Function( RelationshipsData value)  relationships,required TResult Function( SequenceData value)  sequence,required TResult Function( PeriodsData value)  periods,required TResult Function( PlacePanelData value)  placePanel,}){
final _that = this;
switch (_that) {
case TimelineData():
return timeline(_that);case MapData():
return map(_that);case RelationshipsData():
return relationships(_that);case SequenceData():
return sequence(_that);case PeriodsData():
return periods(_that);case PlacePanelData():
return placePanel(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TimelineData value)?  timeline,TResult? Function( MapData value)?  map,TResult? Function( RelationshipsData value)?  relationships,TResult? Function( SequenceData value)?  sequence,TResult? Function( PeriodsData value)?  periods,TResult? Function( PlacePanelData value)?  placePanel,}){
final _that = this;
switch (_that) {
case TimelineData() when timeline != null:
return timeline(_that);case MapData() when map != null:
return map(_that);case RelationshipsData() when relationships != null:
return relationships(_that);case SequenceData() when sequence != null:
return sequence(_that);case PeriodsData() when periods != null:
return periods(_that);case PlacePanelData() when placePanel != null:
return placePanel(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? companionId,  List<String> eventIds)?  timeline,TResult Function( List<String> placeIds,  List<RouteLeg> route)?  map,TResult Function( List<RelationEdge> edges)?  relationships,TResult Function( List<SequenceStep> steps,  List<String> eventIds)?  sequence,TResult Function( List<PeriodBand> bands)?  periods,TResult Function( String placeId,  List<PlaceCallout> callouts)?  placePanel,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TimelineData() when timeline != null:
return timeline(_that.companionId,_that.eventIds);case MapData() when map != null:
return map(_that.placeIds,_that.route);case RelationshipsData() when relationships != null:
return relationships(_that.edges);case SequenceData() when sequence != null:
return sequence(_that.steps,_that.eventIds);case PeriodsData() when periods != null:
return periods(_that.bands);case PlacePanelData() when placePanel != null:
return placePanel(_that.placeId,_that.callouts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? companionId,  List<String> eventIds)  timeline,required TResult Function( List<String> placeIds,  List<RouteLeg> route)  map,required TResult Function( List<RelationEdge> edges)  relationships,required TResult Function( List<SequenceStep> steps,  List<String> eventIds)  sequence,required TResult Function( List<PeriodBand> bands)  periods,required TResult Function( String placeId,  List<PlaceCallout> callouts)  placePanel,}) {final _that = this;
switch (_that) {
case TimelineData():
return timeline(_that.companionId,_that.eventIds);case MapData():
return map(_that.placeIds,_that.route);case RelationshipsData():
return relationships(_that.edges);case SequenceData():
return sequence(_that.steps,_that.eventIds);case PeriodsData():
return periods(_that.bands);case PlacePanelData():
return placePanel(_that.placeId,_that.callouts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? companionId,  List<String> eventIds)?  timeline,TResult? Function( List<String> placeIds,  List<RouteLeg> route)?  map,TResult? Function( List<RelationEdge> edges)?  relationships,TResult? Function( List<SequenceStep> steps,  List<String> eventIds)?  sequence,TResult? Function( List<PeriodBand> bands)?  periods,TResult? Function( String placeId,  List<PlaceCallout> callouts)?  placePanel,}) {final _that = this;
switch (_that) {
case TimelineData() when timeline != null:
return timeline(_that.companionId,_that.eventIds);case MapData() when map != null:
return map(_that.placeIds,_that.route);case RelationshipsData() when relationships != null:
return relationships(_that.edges);case SequenceData() when sequence != null:
return sequence(_that.steps,_that.eventIds);case PeriodsData() when periods != null:
return periods(_that.bands);case PlacePanelData() when placePanel != null:
return placePanel(_that.placeId,_that.callouts);case _:
  return null;

}
}

}

/// @nodoc


class TimelineData implements InfographicData {
  const TimelineData({this.companionId, final  List<String> eventIds = const <String>[]}): _eventIds = eventIds;
  

 final  String? companionId;
 final  List<String> _eventIds;
@JsonKey() List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}


/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineDataCopyWith<TimelineData> get copyWith => _$TimelineDataCopyWithImpl<TimelineData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineData&&(identical(other.companionId, companionId) || other.companionId == companionId)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds));
}


@override
int get hashCode => Object.hash(runtimeType,companionId,const DeepCollectionEquality().hash(_eventIds));

@override
String toString() {
  return 'InfographicData.timeline(companionId: $companionId, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class $TimelineDataCopyWith<$Res> implements $InfographicDataCopyWith<$Res> {
  factory $TimelineDataCopyWith(TimelineData value, $Res Function(TimelineData) _then) = _$TimelineDataCopyWithImpl;
@useResult
$Res call({
 String? companionId, List<String> eventIds
});




}
/// @nodoc
class _$TimelineDataCopyWithImpl<$Res>
    implements $TimelineDataCopyWith<$Res> {
  _$TimelineDataCopyWithImpl(this._self, this._then);

  final TimelineData _self;
  final $Res Function(TimelineData) _then;

/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? companionId = freezed,Object? eventIds = null,}) {
  return _then(TimelineData(
companionId: freezed == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String?,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class MapData implements InfographicData {
  const MapData({required final  List<String> placeIds, final  List<RouteLeg> route = const <RouteLeg>[]}): _placeIds = placeIds,_route = route;
  

 final  List<String> _placeIds;
 List<String> get placeIds {
  if (_placeIds is EqualUnmodifiableListView) return _placeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placeIds);
}

 final  List<RouteLeg> _route;
@JsonKey() List<RouteLeg> get route {
  if (_route is EqualUnmodifiableListView) return _route;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_route);
}


/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapDataCopyWith<MapData> get copyWith => _$MapDataCopyWithImpl<MapData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapData&&const DeepCollectionEquality().equals(other._placeIds, _placeIds)&&const DeepCollectionEquality().equals(other._route, _route));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_placeIds),const DeepCollectionEquality().hash(_route));

@override
String toString() {
  return 'InfographicData.map(placeIds: $placeIds, route: $route)';
}


}

/// @nodoc
abstract mixin class $MapDataCopyWith<$Res> implements $InfographicDataCopyWith<$Res> {
  factory $MapDataCopyWith(MapData value, $Res Function(MapData) _then) = _$MapDataCopyWithImpl;
@useResult
$Res call({
 List<String> placeIds, List<RouteLeg> route
});




}
/// @nodoc
class _$MapDataCopyWithImpl<$Res>
    implements $MapDataCopyWith<$Res> {
  _$MapDataCopyWithImpl(this._self, this._then);

  final MapData _self;
  final $Res Function(MapData) _then;

/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? placeIds = null,Object? route = null,}) {
  return _then(MapData(
placeIds: null == placeIds ? _self._placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,route: null == route ? _self._route : route // ignore: cast_nullable_to_non_nullable
as List<RouteLeg>,
  ));
}


}

/// @nodoc


class RelationshipsData implements InfographicData {
  const RelationshipsData({required final  List<RelationEdge> edges}): _edges = edges;
  

 final  List<RelationEdge> _edges;
 List<RelationEdge> get edges {
  if (_edges is EqualUnmodifiableListView) return _edges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_edges);
}


/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationshipsDataCopyWith<RelationshipsData> get copyWith => _$RelationshipsDataCopyWithImpl<RelationshipsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationshipsData&&const DeepCollectionEquality().equals(other._edges, _edges));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_edges));

@override
String toString() {
  return 'InfographicData.relationships(edges: $edges)';
}


}

/// @nodoc
abstract mixin class $RelationshipsDataCopyWith<$Res> implements $InfographicDataCopyWith<$Res> {
  factory $RelationshipsDataCopyWith(RelationshipsData value, $Res Function(RelationshipsData) _then) = _$RelationshipsDataCopyWithImpl;
@useResult
$Res call({
 List<RelationEdge> edges
});




}
/// @nodoc
class _$RelationshipsDataCopyWithImpl<$Res>
    implements $RelationshipsDataCopyWith<$Res> {
  _$RelationshipsDataCopyWithImpl(this._self, this._then);

  final RelationshipsData _self;
  final $Res Function(RelationshipsData) _then;

/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? edges = null,}) {
  return _then(RelationshipsData(
edges: null == edges ? _self._edges : edges // ignore: cast_nullable_to_non_nullable
as List<RelationEdge>,
  ));
}


}

/// @nodoc


class SequenceData implements InfographicData {
  const SequenceData({required final  List<SequenceStep> steps, final  List<String> eventIds = const <String>[]}): _steps = steps,_eventIds = eventIds;
  

 final  List<SequenceStep> _steps;
 List<SequenceStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

 final  List<String> _eventIds;
@JsonKey() List<String> get eventIds {
  if (_eventIds is EqualUnmodifiableListView) return _eventIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eventIds);
}


/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SequenceDataCopyWith<SequenceData> get copyWith => _$SequenceDataCopyWithImpl<SequenceData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SequenceData&&const DeepCollectionEquality().equals(other._steps, _steps)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_eventIds));

@override
String toString() {
  return 'InfographicData.sequence(steps: $steps, eventIds: $eventIds)';
}


}

/// @nodoc
abstract mixin class $SequenceDataCopyWith<$Res> implements $InfographicDataCopyWith<$Res> {
  factory $SequenceDataCopyWith(SequenceData value, $Res Function(SequenceData) _then) = _$SequenceDataCopyWithImpl;
@useResult
$Res call({
 List<SequenceStep> steps, List<String> eventIds
});




}
/// @nodoc
class _$SequenceDataCopyWithImpl<$Res>
    implements $SequenceDataCopyWith<$Res> {
  _$SequenceDataCopyWithImpl(this._self, this._then);

  final SequenceData _self;
  final $Res Function(SequenceData) _then;

/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? steps = null,Object? eventIds = null,}) {
  return _then(SequenceData(
steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<SequenceStep>,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc


class PeriodsData implements InfographicData {
  const PeriodsData({required final  List<PeriodBand> bands}): _bands = bands;
  

 final  List<PeriodBand> _bands;
 List<PeriodBand> get bands {
  if (_bands is EqualUnmodifiableListView) return _bands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bands);
}


/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodsDataCopyWith<PeriodsData> get copyWith => _$PeriodsDataCopyWithImpl<PeriodsData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodsData&&const DeepCollectionEquality().equals(other._bands, _bands));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_bands));

@override
String toString() {
  return 'InfographicData.periods(bands: $bands)';
}


}

/// @nodoc
abstract mixin class $PeriodsDataCopyWith<$Res> implements $InfographicDataCopyWith<$Res> {
  factory $PeriodsDataCopyWith(PeriodsData value, $Res Function(PeriodsData) _then) = _$PeriodsDataCopyWithImpl;
@useResult
$Res call({
 List<PeriodBand> bands
});




}
/// @nodoc
class _$PeriodsDataCopyWithImpl<$Res>
    implements $PeriodsDataCopyWith<$Res> {
  _$PeriodsDataCopyWithImpl(this._self, this._then);

  final PeriodsData _self;
  final $Res Function(PeriodsData) _then;

/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bands = null,}) {
  return _then(PeriodsData(
bands: null == bands ? _self._bands : bands // ignore: cast_nullable_to_non_nullable
as List<PeriodBand>,
  ));
}


}

/// @nodoc


class PlacePanelData implements InfographicData {
  const PlacePanelData({required this.placeId, required final  List<PlaceCallout> callouts}): _callouts = callouts;
  

 final  String placeId;
 final  List<PlaceCallout> _callouts;
 List<PlaceCallout> get callouts {
  if (_callouts is EqualUnmodifiableListView) return _callouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_callouts);
}


/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePanelDataCopyWith<PlacePanelData> get copyWith => _$PlacePanelDataCopyWithImpl<PlacePanelData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePanelData&&(identical(other.placeId, placeId) || other.placeId == placeId)&&const DeepCollectionEquality().equals(other._callouts, _callouts));
}


@override
int get hashCode => Object.hash(runtimeType,placeId,const DeepCollectionEquality().hash(_callouts));

@override
String toString() {
  return 'InfographicData.placePanel(placeId: $placeId, callouts: $callouts)';
}


}

/// @nodoc
abstract mixin class $PlacePanelDataCopyWith<$Res> implements $InfographicDataCopyWith<$Res> {
  factory $PlacePanelDataCopyWith(PlacePanelData value, $Res Function(PlacePanelData) _then) = _$PlacePanelDataCopyWithImpl;
@useResult
$Res call({
 String placeId, List<PlaceCallout> callouts
});




}
/// @nodoc
class _$PlacePanelDataCopyWithImpl<$Res>
    implements $PlacePanelDataCopyWith<$Res> {
  _$PlacePanelDataCopyWithImpl(this._self, this._then);

  final PlacePanelData _self;
  final $Res Function(PlacePanelData) _then;

/// Create a copy of InfographicData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? callouts = null,}) {
  return _then(PlacePanelData(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,callouts: null == callouts ? _self._callouts : callouts // ignore: cast_nullable_to_non_nullable
as List<PlaceCallout>,
  ));
}


}

/// @nodoc
mixin _$Infographic {

 String get id; InfographicType get type; LocalizedText get title; LocalizedText get takeaway; ReviewInfo get review; InfographicData get data; List<LocalizedText> get notes;
/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InfographicCopyWith<Infographic> get copyWith => _$InfographicCopyWithImpl<Infographic>(this as Infographic, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Infographic&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.takeaway, takeaway) || other.takeaway == takeaway)&&(identical(other.review, review) || other.review == review)&&(identical(other.data, data) || other.data == data)&&const DeepCollectionEquality().equals(other.notes, notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,takeaway,review,data,const DeepCollectionEquality().hash(notes));

@override
String toString() {
  return 'Infographic(id: $id, type: $type, title: $title, takeaway: $takeaway, review: $review, data: $data, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $InfographicCopyWith<$Res>  {
  factory $InfographicCopyWith(Infographic value, $Res Function(Infographic) _then) = _$InfographicCopyWithImpl;
@useResult
$Res call({
 String id, InfographicType type, LocalizedText title, LocalizedText takeaway, ReviewInfo review, InfographicData data, List<LocalizedText> notes
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get takeaway;$ReviewInfoCopyWith<$Res> get review;$InfographicDataCopyWith<$Res> get data;

}
/// @nodoc
class _$InfographicCopyWithImpl<$Res>
    implements $InfographicCopyWith<$Res> {
  _$InfographicCopyWithImpl(this._self, this._then);

  final Infographic _self;
  final $Res Function(Infographic) _then;

/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? takeaway = null,Object? review = null,Object? data = null,Object? notes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InfographicType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,takeaway: null == takeaway ? _self.takeaway : takeaway // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as InfographicData,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,
  ));
}
/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get takeaway {
  
  return $LocalizedTextCopyWith<$Res>(_self.takeaway, (value) {
    return _then(_self.copyWith(takeaway: value));
  });
}/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfographicDataCopyWith<$Res> get data {
  
  return $InfographicDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [Infographic].
extension InfographicPatterns on Infographic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Infographic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Infographic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Infographic value)  $default,){
final _that = this;
switch (_that) {
case _Infographic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Infographic value)?  $default,){
final _that = this;
switch (_that) {
case _Infographic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  InfographicType type,  LocalizedText title,  LocalizedText takeaway,  ReviewInfo review,  InfographicData data,  List<LocalizedText> notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Infographic() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.takeaway,_that.review,_that.data,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  InfographicType type,  LocalizedText title,  LocalizedText takeaway,  ReviewInfo review,  InfographicData data,  List<LocalizedText> notes)  $default,) {final _that = this;
switch (_that) {
case _Infographic():
return $default(_that.id,_that.type,_that.title,_that.takeaway,_that.review,_that.data,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  InfographicType type,  LocalizedText title,  LocalizedText takeaway,  ReviewInfo review,  InfographicData data,  List<LocalizedText> notes)?  $default,) {final _that = this;
switch (_that) {
case _Infographic() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.takeaway,_that.review,_that.data,_that.notes);case _:
  return null;

}
}

}

/// @nodoc


class _Infographic implements Infographic {
  const _Infographic({required this.id, required this.type, required this.title, required this.takeaway, required this.review, required this.data, final  List<LocalizedText> notes = const <LocalizedText>[]}): _notes = notes;
  

@override final  String id;
@override final  InfographicType type;
@override final  LocalizedText title;
@override final  LocalizedText takeaway;
@override final  ReviewInfo review;
@override final  InfographicData data;
 final  List<LocalizedText> _notes;
@override@JsonKey() List<LocalizedText> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}


/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InfographicCopyWith<_Infographic> get copyWith => __$InfographicCopyWithImpl<_Infographic>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Infographic&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.takeaway, takeaway) || other.takeaway == takeaway)&&(identical(other.review, review) || other.review == review)&&(identical(other.data, data) || other.data == data)&&const DeepCollectionEquality().equals(other._notes, _notes));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,takeaway,review,data,const DeepCollectionEquality().hash(_notes));

@override
String toString() {
  return 'Infographic(id: $id, type: $type, title: $title, takeaway: $takeaway, review: $review, data: $data, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$InfographicCopyWith<$Res> implements $InfographicCopyWith<$Res> {
  factory _$InfographicCopyWith(_Infographic value, $Res Function(_Infographic) _then) = __$InfographicCopyWithImpl;
@override @useResult
$Res call({
 String id, InfographicType type, LocalizedText title, LocalizedText takeaway, ReviewInfo review, InfographicData data, List<LocalizedText> notes
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get takeaway;@override $ReviewInfoCopyWith<$Res> get review;@override $InfographicDataCopyWith<$Res> get data;

}
/// @nodoc
class __$InfographicCopyWithImpl<$Res>
    implements _$InfographicCopyWith<$Res> {
  __$InfographicCopyWithImpl(this._self, this._then);

  final _Infographic _self;
  final $Res Function(_Infographic) _then;

/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? takeaway = null,Object? review = null,Object? data = null,Object? notes = null,}) {
  return _then(_Infographic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InfographicType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,takeaway: null == takeaway ? _self.takeaway : takeaway // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as InfographicData,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,
  ));
}

/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get takeaway {
  
  return $LocalizedTextCopyWith<$Res>(_self.takeaway, (value) {
    return _then(_self.copyWith(takeaway: value));
  });
}/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of Infographic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InfographicDataCopyWith<$Res> get data {
  
  return $InfographicDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
