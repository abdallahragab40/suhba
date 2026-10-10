// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quran_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuranFileDto {

 int get schemaVersion; QuranSourceDto get source;/// The basmala as written at the head of each quoted surah opening, by
/// surah number.
 Map<String, String> get basmalas;/// Ayah text by `surah:ayah`.
 Map<String, String> get ayahs;
/// Create a copy of QuranFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranFileDtoCopyWith<QuranFileDto> get copyWith => _$QuranFileDtoCopyWithImpl<QuranFileDto>(this as QuranFileDto, _$identity);

  /// Serializes this QuranFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.basmalas, basmalas)&&const DeepCollectionEquality().equals(other.ayahs, ayahs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,source,const DeepCollectionEquality().hash(basmalas),const DeepCollectionEquality().hash(ayahs));

@override
String toString() {
  return 'QuranFileDto(schemaVersion: $schemaVersion, source: $source, basmalas: $basmalas, ayahs: $ayahs)';
}


}

/// @nodoc
abstract mixin class $QuranFileDtoCopyWith<$Res>  {
  factory $QuranFileDtoCopyWith(QuranFileDto value, $Res Function(QuranFileDto) _then) = _$QuranFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, QuranSourceDto source, Map<String, String> basmalas, Map<String, String> ayahs
});


$QuranSourceDtoCopyWith<$Res> get source;

}
/// @nodoc
class _$QuranFileDtoCopyWithImpl<$Res>
    implements $QuranFileDtoCopyWith<$Res> {
  _$QuranFileDtoCopyWithImpl(this._self, this._then);

  final QuranFileDto _self;
  final $Res Function(QuranFileDto) _then;

/// Create a copy of QuranFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? source = null,Object? basmalas = null,Object? ayahs = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as QuranSourceDto,basmalas: null == basmalas ? _self.basmalas : basmalas // ignore: cast_nullable_to_non_nullable
as Map<String, String>,ayahs: null == ayahs ? _self.ayahs : ayahs // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}
/// Create a copy of QuranFileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuranSourceDtoCopyWith<$Res> get source {
  
  return $QuranSourceDtoCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuranFileDto].
extension QuranFileDtoPatterns on QuranFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranFileDto value)  $default,){
final _that = this;
switch (_that) {
case _QuranFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuranFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  QuranSourceDto source,  Map<String, String> basmalas,  Map<String, String> ayahs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranFileDto() when $default != null:
return $default(_that.schemaVersion,_that.source,_that.basmalas,_that.ayahs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  QuranSourceDto source,  Map<String, String> basmalas,  Map<String, String> ayahs)  $default,) {final _that = this;
switch (_that) {
case _QuranFileDto():
return $default(_that.schemaVersion,_that.source,_that.basmalas,_that.ayahs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  QuranSourceDto source,  Map<String, String> basmalas,  Map<String, String> ayahs)?  $default,) {final _that = this;
switch (_that) {
case _QuranFileDto() when $default != null:
return $default(_that.schemaVersion,_that.source,_that.basmalas,_that.ayahs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuranFileDto implements QuranFileDto {
  const _QuranFileDto({required this.schemaVersion, required this.source, required final  Map<String, String> basmalas, required final  Map<String, String> ayahs}): _basmalas = basmalas,_ayahs = ayahs;
  factory _QuranFileDto.fromJson(Map<String, dynamic> json) => _$QuranFileDtoFromJson(json);

@override final  int schemaVersion;
@override final  QuranSourceDto source;
/// The basmala as written at the head of each quoted surah opening, by
/// surah number.
 final  Map<String, String> _basmalas;
/// The basmala as written at the head of each quoted surah opening, by
/// surah number.
@override Map<String, String> get basmalas {
  if (_basmalas is EqualUnmodifiableMapView) return _basmalas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_basmalas);
}

/// Ayah text by `surah:ayah`.
 final  Map<String, String> _ayahs;
/// Ayah text by `surah:ayah`.
@override Map<String, String> get ayahs {
  if (_ayahs is EqualUnmodifiableMapView) return _ayahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ayahs);
}


/// Create a copy of QuranFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranFileDtoCopyWith<_QuranFileDto> get copyWith => __$QuranFileDtoCopyWithImpl<_QuranFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuranFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._basmalas, _basmalas)&&const DeepCollectionEquality().equals(other._ayahs, _ayahs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,source,const DeepCollectionEquality().hash(_basmalas),const DeepCollectionEquality().hash(_ayahs));

@override
String toString() {
  return 'QuranFileDto(schemaVersion: $schemaVersion, source: $source, basmalas: $basmalas, ayahs: $ayahs)';
}


}

/// @nodoc
abstract mixin class _$QuranFileDtoCopyWith<$Res> implements $QuranFileDtoCopyWith<$Res> {
  factory _$QuranFileDtoCopyWith(_QuranFileDto value, $Res Function(_QuranFileDto) _then) = __$QuranFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, QuranSourceDto source, Map<String, String> basmalas, Map<String, String> ayahs
});


@override $QuranSourceDtoCopyWith<$Res> get source;

}
/// @nodoc
class __$QuranFileDtoCopyWithImpl<$Res>
    implements _$QuranFileDtoCopyWith<$Res> {
  __$QuranFileDtoCopyWithImpl(this._self, this._then);

  final _QuranFileDto _self;
  final $Res Function(_QuranFileDto) _then;

/// Create a copy of QuranFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? source = null,Object? basmalas = null,Object? ayahs = null,}) {
  return _then(_QuranFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as QuranSourceDto,basmalas: null == basmalas ? _self._basmalas : basmalas // ignore: cast_nullable_to_non_nullable
as Map<String, String>,ayahs: null == ayahs ? _self._ayahs : ayahs // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

/// Create a copy of QuranFileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuranSourceDtoCopyWith<$Res> get source {
  
  return $QuranSourceDtoCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// @nodoc
mixin _$QuranSourceDto {

 String get name; String get url; String get notice;
/// Create a copy of QuranSourceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranSourceDtoCopyWith<QuranSourceDto> get copyWith => _$QuranSourceDtoCopyWithImpl<QuranSourceDto>(this as QuranSourceDto, _$identity);

  /// Serializes this QuranSourceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranSourceDto&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.notice, notice) || other.notice == notice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url,notice);

@override
String toString() {
  return 'QuranSourceDto(name: $name, url: $url, notice: $notice)';
}


}

/// @nodoc
abstract mixin class $QuranSourceDtoCopyWith<$Res>  {
  factory $QuranSourceDtoCopyWith(QuranSourceDto value, $Res Function(QuranSourceDto) _then) = _$QuranSourceDtoCopyWithImpl;
@useResult
$Res call({
 String name, String url, String notice
});




}
/// @nodoc
class _$QuranSourceDtoCopyWithImpl<$Res>
    implements $QuranSourceDtoCopyWith<$Res> {
  _$QuranSourceDtoCopyWithImpl(this._self, this._then);

  final QuranSourceDto _self;
  final $Res Function(QuranSourceDto) _then;

/// Create a copy of QuranSourceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,Object? notice = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,notice: null == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranSourceDto].
extension QuranSourceDtoPatterns on QuranSourceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranSourceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranSourceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranSourceDto value)  $default,){
final _that = this;
switch (_that) {
case _QuranSourceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranSourceDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuranSourceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url,  String notice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranSourceDto() when $default != null:
return $default(_that.name,_that.url,_that.notice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url,  String notice)  $default,) {final _that = this;
switch (_that) {
case _QuranSourceDto():
return $default(_that.name,_that.url,_that.notice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url,  String notice)?  $default,) {final _that = this;
switch (_that) {
case _QuranSourceDto() when $default != null:
return $default(_that.name,_that.url,_that.notice);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuranSourceDto implements QuranSourceDto {
  const _QuranSourceDto({required this.name, required this.url, required this.notice});
  factory _QuranSourceDto.fromJson(Map<String, dynamic> json) => _$QuranSourceDtoFromJson(json);

@override final  String name;
@override final  String url;
@override final  String notice;

/// Create a copy of QuranSourceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranSourceDtoCopyWith<_QuranSourceDto> get copyWith => __$QuranSourceDtoCopyWithImpl<_QuranSourceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuranSourceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranSourceDto&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&(identical(other.notice, notice) || other.notice == notice));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url,notice);

@override
String toString() {
  return 'QuranSourceDto(name: $name, url: $url, notice: $notice)';
}


}

/// @nodoc
abstract mixin class _$QuranSourceDtoCopyWith<$Res> implements $QuranSourceDtoCopyWith<$Res> {
  factory _$QuranSourceDtoCopyWith(_QuranSourceDto value, $Res Function(_QuranSourceDto) _then) = __$QuranSourceDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String url, String notice
});




}
/// @nodoc
class __$QuranSourceDtoCopyWithImpl<$Res>
    implements _$QuranSourceDtoCopyWith<$Res> {
  __$QuranSourceDtoCopyWithImpl(this._self, this._then);

  final _QuranSourceDto _self;
  final $Res Function(_QuranSourceDto) _then;

/// Create a copy of QuranSourceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,Object? notice = null,}) {
  return _then(_QuranSourceDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,notice: null == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
