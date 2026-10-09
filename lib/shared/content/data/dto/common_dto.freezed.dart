// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalizedTextDto {

 String get ar; String? get en;
/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<LocalizedTextDto> get copyWith => _$LocalizedTextDtoCopyWithImpl<LocalizedTextDto>(this as LocalizedTextDto, _$identity);

  /// Serializes this LocalizedTextDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalizedTextDto&&(identical(other.ar, ar) || other.ar == ar)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ar,en);

@override
String toString() {
  return 'LocalizedTextDto(ar: $ar, en: $en)';
}


}

/// @nodoc
abstract mixin class $LocalizedTextDtoCopyWith<$Res>  {
  factory $LocalizedTextDtoCopyWith(LocalizedTextDto value, $Res Function(LocalizedTextDto) _then) = _$LocalizedTextDtoCopyWithImpl;
@useResult
$Res call({
 String ar, String? en
});




}
/// @nodoc
class _$LocalizedTextDtoCopyWithImpl<$Res>
    implements $LocalizedTextDtoCopyWith<$Res> {
  _$LocalizedTextDtoCopyWithImpl(this._self, this._then);

  final LocalizedTextDto _self;
  final $Res Function(LocalizedTextDto) _then;

/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ar = null,Object? en = freezed,}) {
  return _then(_self.copyWith(
ar: null == ar ? _self.ar : ar // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalizedTextDto].
extension LocalizedTextDtoPatterns on LocalizedTextDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalizedTextDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalizedTextDto value)  $default,){
final _that = this;
switch (_that) {
case _LocalizedTextDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalizedTextDto value)?  $default,){
final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ar,  String? en)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
return $default(_that.ar,_that.en);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ar,  String? en)  $default,) {final _that = this;
switch (_that) {
case _LocalizedTextDto():
return $default(_that.ar,_that.en);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ar,  String? en)?  $default,) {final _that = this;
switch (_that) {
case _LocalizedTextDto() when $default != null:
return $default(_that.ar,_that.en);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalizedTextDto implements LocalizedTextDto {
  const _LocalizedTextDto({required this.ar, this.en});
  factory _LocalizedTextDto.fromJson(Map<String, dynamic> json) => _$LocalizedTextDtoFromJson(json);

@override final  String ar;
@override final  String? en;

/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalizedTextDtoCopyWith<_LocalizedTextDto> get copyWith => __$LocalizedTextDtoCopyWithImpl<_LocalizedTextDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalizedTextDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalizedTextDto&&(identical(other.ar, ar) || other.ar == ar)&&(identical(other.en, en) || other.en == en));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ar,en);

@override
String toString() {
  return 'LocalizedTextDto(ar: $ar, en: $en)';
}


}

/// @nodoc
abstract mixin class _$LocalizedTextDtoCopyWith<$Res> implements $LocalizedTextDtoCopyWith<$Res> {
  factory _$LocalizedTextDtoCopyWith(_LocalizedTextDto value, $Res Function(_LocalizedTextDto) _then) = __$LocalizedTextDtoCopyWithImpl;
@override @useResult
$Res call({
 String ar, String? en
});




}
/// @nodoc
class __$LocalizedTextDtoCopyWithImpl<$Res>
    implements _$LocalizedTextDtoCopyWith<$Res> {
  __$LocalizedTextDtoCopyWithImpl(this._self, this._then);

  final _LocalizedTextDto _self;
  final $Res Function(_LocalizedTextDto) _then;

/// Create a copy of LocalizedTextDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ar = null,Object? en = freezed,}) {
  return _then(_LocalizedTextDto(
ar: null == ar ? _self.ar : ar // ignore: cast_nullable_to_non_nullable
as String,en: freezed == en ? _self.en : en // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HistoricalDateDto {

 DatePrecision get precision; HijriEra get era; int? get hijriYear; int? get hijriMonth; int? get hijriDay; int? get gregorianYear; HijriEra? get endEra; int? get hijriYearEnd; int? get gregorianYearEnd;
/// Create a copy of HistoricalDateDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<HistoricalDateDto> get copyWith => _$HistoricalDateDtoCopyWithImpl<HistoricalDateDto>(this as HistoricalDateDto, _$identity);

  /// Serializes this HistoricalDateDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalDateDto&&(identical(other.precision, precision) || other.precision == precision)&&(identical(other.era, era) || other.era == era)&&(identical(other.hijriYear, hijriYear) || other.hijriYear == hijriYear)&&(identical(other.hijriMonth, hijriMonth) || other.hijriMonth == hijriMonth)&&(identical(other.hijriDay, hijriDay) || other.hijriDay == hijriDay)&&(identical(other.gregorianYear, gregorianYear) || other.gregorianYear == gregorianYear)&&(identical(other.endEra, endEra) || other.endEra == endEra)&&(identical(other.hijriYearEnd, hijriYearEnd) || other.hijriYearEnd == hijriYearEnd)&&(identical(other.gregorianYearEnd, gregorianYearEnd) || other.gregorianYearEnd == gregorianYearEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,precision,era,hijriYear,hijriMonth,hijriDay,gregorianYear,endEra,hijriYearEnd,gregorianYearEnd);

@override
String toString() {
  return 'HistoricalDateDto(precision: $precision, era: $era, hijriYear: $hijriYear, hijriMonth: $hijriMonth, hijriDay: $hijriDay, gregorianYear: $gregorianYear, endEra: $endEra, hijriYearEnd: $hijriYearEnd, gregorianYearEnd: $gregorianYearEnd)';
}


}

/// @nodoc
abstract mixin class $HistoricalDateDtoCopyWith<$Res>  {
  factory $HistoricalDateDtoCopyWith(HistoricalDateDto value, $Res Function(HistoricalDateDto) _then) = _$HistoricalDateDtoCopyWithImpl;
@useResult
$Res call({
 DatePrecision precision, HijriEra era, int? hijriYear, int? hijriMonth, int? hijriDay, int? gregorianYear, HijriEra? endEra, int? hijriYearEnd, int? gregorianYearEnd
});




}
/// @nodoc
class _$HistoricalDateDtoCopyWithImpl<$Res>
    implements $HistoricalDateDtoCopyWith<$Res> {
  _$HistoricalDateDtoCopyWithImpl(this._self, this._then);

  final HistoricalDateDto _self;
  final $Res Function(HistoricalDateDto) _then;

/// Create a copy of HistoricalDateDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? precision = null,Object? era = null,Object? hijriYear = freezed,Object? hijriMonth = freezed,Object? hijriDay = freezed,Object? gregorianYear = freezed,Object? endEra = freezed,Object? hijriYearEnd = freezed,Object? gregorianYearEnd = freezed,}) {
  return _then(_self.copyWith(
precision: null == precision ? _self.precision : precision // ignore: cast_nullable_to_non_nullable
as DatePrecision,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as HijriEra,hijriYear: freezed == hijriYear ? _self.hijriYear : hijriYear // ignore: cast_nullable_to_non_nullable
as int?,hijriMonth: freezed == hijriMonth ? _self.hijriMonth : hijriMonth // ignore: cast_nullable_to_non_nullable
as int?,hijriDay: freezed == hijriDay ? _self.hijriDay : hijriDay // ignore: cast_nullable_to_non_nullable
as int?,gregorianYear: freezed == gregorianYear ? _self.gregorianYear : gregorianYear // ignore: cast_nullable_to_non_nullable
as int?,endEra: freezed == endEra ? _self.endEra : endEra // ignore: cast_nullable_to_non_nullable
as HijriEra?,hijriYearEnd: freezed == hijriYearEnd ? _self.hijriYearEnd : hijriYearEnd // ignore: cast_nullable_to_non_nullable
as int?,gregorianYearEnd: freezed == gregorianYearEnd ? _self.gregorianYearEnd : gregorianYearEnd // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoricalDateDto].
extension HistoricalDateDtoPatterns on HistoricalDateDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalDateDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalDateDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalDateDto value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalDateDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalDateDto value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalDateDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DatePrecision precision,  HijriEra era,  int? hijriYear,  int? hijriMonth,  int? hijriDay,  int? gregorianYear,  HijriEra? endEra,  int? hijriYearEnd,  int? gregorianYearEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalDateDto() when $default != null:
return $default(_that.precision,_that.era,_that.hijriYear,_that.hijriMonth,_that.hijriDay,_that.gregorianYear,_that.endEra,_that.hijriYearEnd,_that.gregorianYearEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DatePrecision precision,  HijriEra era,  int? hijriYear,  int? hijriMonth,  int? hijriDay,  int? gregorianYear,  HijriEra? endEra,  int? hijriYearEnd,  int? gregorianYearEnd)  $default,) {final _that = this;
switch (_that) {
case _HistoricalDateDto():
return $default(_that.precision,_that.era,_that.hijriYear,_that.hijriMonth,_that.hijriDay,_that.gregorianYear,_that.endEra,_that.hijriYearEnd,_that.gregorianYearEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DatePrecision precision,  HijriEra era,  int? hijriYear,  int? hijriMonth,  int? hijriDay,  int? gregorianYear,  HijriEra? endEra,  int? hijriYearEnd,  int? gregorianYearEnd)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalDateDto() when $default != null:
return $default(_that.precision,_that.era,_that.hijriYear,_that.hijriMonth,_that.hijriDay,_that.gregorianYear,_that.endEra,_that.hijriYearEnd,_that.gregorianYearEnd);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoricalDateDto implements HistoricalDateDto {
  const _HistoricalDateDto({required this.precision, this.era = HijriEra.afterHijra, this.hijriYear, this.hijriMonth, this.hijriDay, this.gregorianYear, this.endEra, this.hijriYearEnd, this.gregorianYearEnd});
  factory _HistoricalDateDto.fromJson(Map<String, dynamic> json) => _$HistoricalDateDtoFromJson(json);

@override final  DatePrecision precision;
@override@JsonKey() final  HijriEra era;
@override final  int? hijriYear;
@override final  int? hijriMonth;
@override final  int? hijriDay;
@override final  int? gregorianYear;
@override final  HijriEra? endEra;
@override final  int? hijriYearEnd;
@override final  int? gregorianYearEnd;

/// Create a copy of HistoricalDateDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalDateDtoCopyWith<_HistoricalDateDto> get copyWith => __$HistoricalDateDtoCopyWithImpl<_HistoricalDateDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoricalDateDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalDateDto&&(identical(other.precision, precision) || other.precision == precision)&&(identical(other.era, era) || other.era == era)&&(identical(other.hijriYear, hijriYear) || other.hijriYear == hijriYear)&&(identical(other.hijriMonth, hijriMonth) || other.hijriMonth == hijriMonth)&&(identical(other.hijriDay, hijriDay) || other.hijriDay == hijriDay)&&(identical(other.gregorianYear, gregorianYear) || other.gregorianYear == gregorianYear)&&(identical(other.endEra, endEra) || other.endEra == endEra)&&(identical(other.hijriYearEnd, hijriYearEnd) || other.hijriYearEnd == hijriYearEnd)&&(identical(other.gregorianYearEnd, gregorianYearEnd) || other.gregorianYearEnd == gregorianYearEnd));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,precision,era,hijriYear,hijriMonth,hijriDay,gregorianYear,endEra,hijriYearEnd,gregorianYearEnd);

@override
String toString() {
  return 'HistoricalDateDto(precision: $precision, era: $era, hijriYear: $hijriYear, hijriMonth: $hijriMonth, hijriDay: $hijriDay, gregorianYear: $gregorianYear, endEra: $endEra, hijriYearEnd: $hijriYearEnd, gregorianYearEnd: $gregorianYearEnd)';
}


}

/// @nodoc
abstract mixin class _$HistoricalDateDtoCopyWith<$Res> implements $HistoricalDateDtoCopyWith<$Res> {
  factory _$HistoricalDateDtoCopyWith(_HistoricalDateDto value, $Res Function(_HistoricalDateDto) _then) = __$HistoricalDateDtoCopyWithImpl;
@override @useResult
$Res call({
 DatePrecision precision, HijriEra era, int? hijriYear, int? hijriMonth, int? hijriDay, int? gregorianYear, HijriEra? endEra, int? hijriYearEnd, int? gregorianYearEnd
});




}
/// @nodoc
class __$HistoricalDateDtoCopyWithImpl<$Res>
    implements _$HistoricalDateDtoCopyWith<$Res> {
  __$HistoricalDateDtoCopyWithImpl(this._self, this._then);

  final _HistoricalDateDto _self;
  final $Res Function(_HistoricalDateDto) _then;

/// Create a copy of HistoricalDateDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? precision = null,Object? era = null,Object? hijriYear = freezed,Object? hijriMonth = freezed,Object? hijriDay = freezed,Object? gregorianYear = freezed,Object? endEra = freezed,Object? hijriYearEnd = freezed,Object? gregorianYearEnd = freezed,}) {
  return _then(_HistoricalDateDto(
precision: null == precision ? _self.precision : precision // ignore: cast_nullable_to_non_nullable
as DatePrecision,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as HijriEra,hijriYear: freezed == hijriYear ? _self.hijriYear : hijriYear // ignore: cast_nullable_to_non_nullable
as int?,hijriMonth: freezed == hijriMonth ? _self.hijriMonth : hijriMonth // ignore: cast_nullable_to_non_nullable
as int?,hijriDay: freezed == hijriDay ? _self.hijriDay : hijriDay // ignore: cast_nullable_to_non_nullable
as int?,gregorianYear: freezed == gregorianYear ? _self.gregorianYear : gregorianYear // ignore: cast_nullable_to_non_nullable
as int?,endEra: freezed == endEra ? _self.endEra : endEra // ignore: cast_nullable_to_non_nullable
as HijriEra?,hijriYearEnd: freezed == hijriYearEnd ? _self.hijriYearEnd : hijriYearEnd // ignore: cast_nullable_to_non_nullable
as int?,gregorianYearEnd: freezed == gregorianYearEnd ? _self.gregorianYearEnd : gregorianYearEnd // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$QuranRefDto {

 int get surah; int get ayahFrom; int? get ayahTo;
/// Create a copy of QuranRefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranRefDtoCopyWith<QuranRefDto> get copyWith => _$QuranRefDtoCopyWithImpl<QuranRefDto>(this as QuranRefDto, _$identity);

  /// Serializes this QuranRefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranRefDto&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.ayahFrom, ayahFrom) || other.ayahFrom == ayahFrom)&&(identical(other.ayahTo, ayahTo) || other.ayahTo == ayahTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surah,ayahFrom,ayahTo);

@override
String toString() {
  return 'QuranRefDto(surah: $surah, ayahFrom: $ayahFrom, ayahTo: $ayahTo)';
}


}

/// @nodoc
abstract mixin class $QuranRefDtoCopyWith<$Res>  {
  factory $QuranRefDtoCopyWith(QuranRefDto value, $Res Function(QuranRefDto) _then) = _$QuranRefDtoCopyWithImpl;
@useResult
$Res call({
 int surah, int ayahFrom, int? ayahTo
});




}
/// @nodoc
class _$QuranRefDtoCopyWithImpl<$Res>
    implements $QuranRefDtoCopyWith<$Res> {
  _$QuranRefDtoCopyWithImpl(this._self, this._then);

  final QuranRefDto _self;
  final $Res Function(QuranRefDto) _then;

/// Create a copy of QuranRefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surah = null,Object? ayahFrom = null,Object? ayahTo = freezed,}) {
  return _then(_self.copyWith(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as int,ayahFrom: null == ayahFrom ? _self.ayahFrom : ayahFrom // ignore: cast_nullable_to_non_nullable
as int,ayahTo: freezed == ayahTo ? _self.ayahTo : ayahTo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranRefDto].
extension QuranRefDtoPatterns on QuranRefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranRefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranRefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranRefDto value)  $default,){
final _that = this;
switch (_that) {
case _QuranRefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranRefDto value)?  $default,){
final _that = this;
switch (_that) {
case _QuranRefDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int surah,  int ayahFrom,  int? ayahTo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranRefDto() when $default != null:
return $default(_that.surah,_that.ayahFrom,_that.ayahTo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int surah,  int ayahFrom,  int? ayahTo)  $default,) {final _that = this;
switch (_that) {
case _QuranRefDto():
return $default(_that.surah,_that.ayahFrom,_that.ayahTo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int surah,  int ayahFrom,  int? ayahTo)?  $default,) {final _that = this;
switch (_that) {
case _QuranRefDto() when $default != null:
return $default(_that.surah,_that.ayahFrom,_that.ayahTo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuranRefDto implements QuranRefDto {
  const _QuranRefDto({required this.surah, required this.ayahFrom, this.ayahTo});
  factory _QuranRefDto.fromJson(Map<String, dynamic> json) => _$QuranRefDtoFromJson(json);

@override final  int surah;
@override final  int ayahFrom;
@override final  int? ayahTo;

/// Create a copy of QuranRefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranRefDtoCopyWith<_QuranRefDto> get copyWith => __$QuranRefDtoCopyWithImpl<_QuranRefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuranRefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranRefDto&&(identical(other.surah, surah) || other.surah == surah)&&(identical(other.ayahFrom, ayahFrom) || other.ayahFrom == ayahFrom)&&(identical(other.ayahTo, ayahTo) || other.ayahTo == ayahTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surah,ayahFrom,ayahTo);

@override
String toString() {
  return 'QuranRefDto(surah: $surah, ayahFrom: $ayahFrom, ayahTo: $ayahTo)';
}


}

/// @nodoc
abstract mixin class _$QuranRefDtoCopyWith<$Res> implements $QuranRefDtoCopyWith<$Res> {
  factory _$QuranRefDtoCopyWith(_QuranRefDto value, $Res Function(_QuranRefDto) _then) = __$QuranRefDtoCopyWithImpl;
@override @useResult
$Res call({
 int surah, int ayahFrom, int? ayahTo
});




}
/// @nodoc
class __$QuranRefDtoCopyWithImpl<$Res>
    implements _$QuranRefDtoCopyWith<$Res> {
  __$QuranRefDtoCopyWithImpl(this._self, this._then);

  final _QuranRefDto _self;
  final $Res Function(_QuranRefDto) _then;

/// Create a copy of QuranRefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surah = null,Object? ayahFrom = null,Object? ayahTo = freezed,}) {
  return _then(_QuranRefDto(
surah: null == surah ? _self.surah : surah // ignore: cast_nullable_to_non_nullable
as int,ayahFrom: null == ayahFrom ? _self.ayahFrom : ayahFrom // ignore: cast_nullable_to_non_nullable
as int,ayahTo: freezed == ayahTo ? _self.ayahTo : ayahTo // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$GradingDto {

 HadithGrade get grade; LocalizedTextDto get gradedBy;
/// Create a copy of GradingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradingDtoCopyWith<GradingDto> get copyWith => _$GradingDtoCopyWithImpl<GradingDto>(this as GradingDto, _$identity);

  /// Serializes this GradingDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradingDto&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.gradedBy, gradedBy) || other.gradedBy == gradedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grade,gradedBy);

@override
String toString() {
  return 'GradingDto(grade: $grade, gradedBy: $gradedBy)';
}


}

/// @nodoc
abstract mixin class $GradingDtoCopyWith<$Res>  {
  factory $GradingDtoCopyWith(GradingDto value, $Res Function(GradingDto) _then) = _$GradingDtoCopyWithImpl;
@useResult
$Res call({
 HadithGrade grade, LocalizedTextDto gradedBy
});


$LocalizedTextDtoCopyWith<$Res> get gradedBy;

}
/// @nodoc
class _$GradingDtoCopyWithImpl<$Res>
    implements $GradingDtoCopyWith<$Res> {
  _$GradingDtoCopyWithImpl(this._self, this._then);

  final GradingDto _self;
  final $Res Function(GradingDto) _then;

/// Create a copy of GradingDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grade = null,Object? gradedBy = null,}) {
  return _then(_self.copyWith(
grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as HadithGrade,gradedBy: null == gradedBy ? _self.gradedBy : gradedBy // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,
  ));
}
/// Create a copy of GradingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get gradedBy {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.gradedBy, (value) {
    return _then(_self.copyWith(gradedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [GradingDto].
extension GradingDtoPatterns on GradingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradingDto value)  $default,){
final _that = this;
switch (_that) {
case _GradingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradingDto value)?  $default,){
final _that = this;
switch (_that) {
case _GradingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HadithGrade grade,  LocalizedTextDto gradedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradingDto() when $default != null:
return $default(_that.grade,_that.gradedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HadithGrade grade,  LocalizedTextDto gradedBy)  $default,) {final _that = this;
switch (_that) {
case _GradingDto():
return $default(_that.grade,_that.gradedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HadithGrade grade,  LocalizedTextDto gradedBy)?  $default,) {final _that = this;
switch (_that) {
case _GradingDto() when $default != null:
return $default(_that.grade,_that.gradedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradingDto implements GradingDto {
  const _GradingDto({required this.grade, required this.gradedBy});
  factory _GradingDto.fromJson(Map<String, dynamic> json) => _$GradingDtoFromJson(json);

@override final  HadithGrade grade;
@override final  LocalizedTextDto gradedBy;

/// Create a copy of GradingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradingDtoCopyWith<_GradingDto> get copyWith => __$GradingDtoCopyWithImpl<_GradingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradingDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradingDto&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.gradedBy, gradedBy) || other.gradedBy == gradedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,grade,gradedBy);

@override
String toString() {
  return 'GradingDto(grade: $grade, gradedBy: $gradedBy)';
}


}

/// @nodoc
abstract mixin class _$GradingDtoCopyWith<$Res> implements $GradingDtoCopyWith<$Res> {
  factory _$GradingDtoCopyWith(_GradingDto value, $Res Function(_GradingDto) _then) = __$GradingDtoCopyWithImpl;
@override @useResult
$Res call({
 HadithGrade grade, LocalizedTextDto gradedBy
});


@override $LocalizedTextDtoCopyWith<$Res> get gradedBy;

}
/// @nodoc
class __$GradingDtoCopyWithImpl<$Res>
    implements _$GradingDtoCopyWith<$Res> {
  __$GradingDtoCopyWithImpl(this._self, this._then);

  final _GradingDto _self;
  final $Res Function(_GradingDto) _then;

/// Create a copy of GradingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grade = null,Object? gradedBy = null,}) {
  return _then(_GradingDto(
grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as HadithGrade,gradedBy: null == gradedBy ? _self.gradedBy : gradedBy // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,
  ));
}

/// Create a copy of GradingDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get gradedBy {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.gradedBy, (value) {
    return _then(_self.copyWith(gradedBy: value));
  });
}
}


/// @nodoc
mixin _$CitationDto {

 String get sourceId; LocatorStatus get locatorStatus; int? get volume; String? get page; String? get hadithNumber; LocalizedTextDto? get chapterTitle; QuranRefDto? get quranRef; GradingDto? get grading; LocalizedTextDto? get note;
/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CitationDtoCopyWith<CitationDto> get copyWith => _$CitationDtoCopyWithImpl<CitationDto>(this as CitationDto, _$identity);

  /// Serializes this CitationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CitationDto&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.locatorStatus, locatorStatus) || other.locatorStatus == locatorStatus)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.page, page) || other.page == page)&&(identical(other.hadithNumber, hadithNumber) || other.hadithNumber == hadithNumber)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.quranRef, quranRef) || other.quranRef == quranRef)&&(identical(other.grading, grading) || other.grading == grading)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceId,locatorStatus,volume,page,hadithNumber,chapterTitle,quranRef,grading,note);

@override
String toString() {
  return 'CitationDto(sourceId: $sourceId, locatorStatus: $locatorStatus, volume: $volume, page: $page, hadithNumber: $hadithNumber, chapterTitle: $chapterTitle, quranRef: $quranRef, grading: $grading, note: $note)';
}


}

/// @nodoc
abstract mixin class $CitationDtoCopyWith<$Res>  {
  factory $CitationDtoCopyWith(CitationDto value, $Res Function(CitationDto) _then) = _$CitationDtoCopyWithImpl;
@useResult
$Res call({
 String sourceId, LocatorStatus locatorStatus, int? volume, String? page, String? hadithNumber, LocalizedTextDto? chapterTitle, QuranRefDto? quranRef, GradingDto? grading, LocalizedTextDto? note
});


$LocalizedTextDtoCopyWith<$Res>? get chapterTitle;$QuranRefDtoCopyWith<$Res>? get quranRef;$GradingDtoCopyWith<$Res>? get grading;$LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class _$CitationDtoCopyWithImpl<$Res>
    implements $CitationDtoCopyWith<$Res> {
  _$CitationDtoCopyWithImpl(this._self, this._then);

  final CitationDto _self;
  final $Res Function(CitationDto) _then;

/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceId = null,Object? locatorStatus = null,Object? volume = freezed,Object? page = freezed,Object? hadithNumber = freezed,Object? chapterTitle = freezed,Object? quranRef = freezed,Object? grading = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,locatorStatus: null == locatorStatus ? _self.locatorStatus : locatorStatus // ignore: cast_nullable_to_non_nullable
as LocatorStatus,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String?,hadithNumber: freezed == hadithNumber ? _self.hadithNumber : hadithNumber // ignore: cast_nullable_to_non_nullable
as String?,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,quranRef: freezed == quranRef ? _self.quranRef : quranRef // ignore: cast_nullable_to_non_nullable
as QuranRefDto?,grading: freezed == grading ? _self.grading : grading // ignore: cast_nullable_to_non_nullable
as GradingDto?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get chapterTitle {
    if (_self.chapterTitle == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.chapterTitle!, (value) {
    return _then(_self.copyWith(chapterTitle: value));
  });
}/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuranRefDtoCopyWith<$Res>? get quranRef {
    if (_self.quranRef == null) {
    return null;
  }

  return $QuranRefDtoCopyWith<$Res>(_self.quranRef!, (value) {
    return _then(_self.copyWith(quranRef: value));
  });
}/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradingDtoCopyWith<$Res>? get grading {
    if (_self.grading == null) {
    return null;
  }

  return $GradingDtoCopyWith<$Res>(_self.grading!, (value) {
    return _then(_self.copyWith(grading: value));
  });
}/// Create a copy of CitationDto
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


/// Adds pattern-matching-related methods to [CitationDto].
extension CitationDtoPatterns on CitationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CitationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CitationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CitationDto value)  $default,){
final _that = this;
switch (_that) {
case _CitationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CitationDto value)?  $default,){
final _that = this;
switch (_that) {
case _CitationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceId,  LocatorStatus locatorStatus,  int? volume,  String? page,  String? hadithNumber,  LocalizedTextDto? chapterTitle,  QuranRefDto? quranRef,  GradingDto? grading,  LocalizedTextDto? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CitationDto() when $default != null:
return $default(_that.sourceId,_that.locatorStatus,_that.volume,_that.page,_that.hadithNumber,_that.chapterTitle,_that.quranRef,_that.grading,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceId,  LocatorStatus locatorStatus,  int? volume,  String? page,  String? hadithNumber,  LocalizedTextDto? chapterTitle,  QuranRefDto? quranRef,  GradingDto? grading,  LocalizedTextDto? note)  $default,) {final _that = this;
switch (_that) {
case _CitationDto():
return $default(_that.sourceId,_that.locatorStatus,_that.volume,_that.page,_that.hadithNumber,_that.chapterTitle,_that.quranRef,_that.grading,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceId,  LocatorStatus locatorStatus,  int? volume,  String? page,  String? hadithNumber,  LocalizedTextDto? chapterTitle,  QuranRefDto? quranRef,  GradingDto? grading,  LocalizedTextDto? note)?  $default,) {final _that = this;
switch (_that) {
case _CitationDto() when $default != null:
return $default(_that.sourceId,_that.locatorStatus,_that.volume,_that.page,_that.hadithNumber,_that.chapterTitle,_that.quranRef,_that.grading,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CitationDto implements CitationDto {
  const _CitationDto({required this.sourceId, required this.locatorStatus, this.volume, this.page, this.hadithNumber, this.chapterTitle, this.quranRef, this.grading, this.note});
  factory _CitationDto.fromJson(Map<String, dynamic> json) => _$CitationDtoFromJson(json);

@override final  String sourceId;
@override final  LocatorStatus locatorStatus;
@override final  int? volume;
@override final  String? page;
@override final  String? hadithNumber;
@override final  LocalizedTextDto? chapterTitle;
@override final  QuranRefDto? quranRef;
@override final  GradingDto? grading;
@override final  LocalizedTextDto? note;

/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CitationDtoCopyWith<_CitationDto> get copyWith => __$CitationDtoCopyWithImpl<_CitationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CitationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CitationDto&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.locatorStatus, locatorStatus) || other.locatorStatus == locatorStatus)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.page, page) || other.page == page)&&(identical(other.hadithNumber, hadithNumber) || other.hadithNumber == hadithNumber)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.quranRef, quranRef) || other.quranRef == quranRef)&&(identical(other.grading, grading) || other.grading == grading)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceId,locatorStatus,volume,page,hadithNumber,chapterTitle,quranRef,grading,note);

@override
String toString() {
  return 'CitationDto(sourceId: $sourceId, locatorStatus: $locatorStatus, volume: $volume, page: $page, hadithNumber: $hadithNumber, chapterTitle: $chapterTitle, quranRef: $quranRef, grading: $grading, note: $note)';
}


}

/// @nodoc
abstract mixin class _$CitationDtoCopyWith<$Res> implements $CitationDtoCopyWith<$Res> {
  factory _$CitationDtoCopyWith(_CitationDto value, $Res Function(_CitationDto) _then) = __$CitationDtoCopyWithImpl;
@override @useResult
$Res call({
 String sourceId, LocatorStatus locatorStatus, int? volume, String? page, String? hadithNumber, LocalizedTextDto? chapterTitle, QuranRefDto? quranRef, GradingDto? grading, LocalizedTextDto? note
});


@override $LocalizedTextDtoCopyWith<$Res>? get chapterTitle;@override $QuranRefDtoCopyWith<$Res>? get quranRef;@override $GradingDtoCopyWith<$Res>? get grading;@override $LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class __$CitationDtoCopyWithImpl<$Res>
    implements _$CitationDtoCopyWith<$Res> {
  __$CitationDtoCopyWithImpl(this._self, this._then);

  final _CitationDto _self;
  final $Res Function(_CitationDto) _then;

/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceId = null,Object? locatorStatus = null,Object? volume = freezed,Object? page = freezed,Object? hadithNumber = freezed,Object? chapterTitle = freezed,Object? quranRef = freezed,Object? grading = freezed,Object? note = freezed,}) {
  return _then(_CitationDto(
sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,locatorStatus: null == locatorStatus ? _self.locatorStatus : locatorStatus // ignore: cast_nullable_to_non_nullable
as LocatorStatus,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String?,hadithNumber: freezed == hadithNumber ? _self.hadithNumber : hadithNumber // ignore: cast_nullable_to_non_nullable
as String?,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,quranRef: freezed == quranRef ? _self.quranRef : quranRef // ignore: cast_nullable_to_non_nullable
as QuranRefDto?,grading: freezed == grading ? _self.grading : grading // ignore: cast_nullable_to_non_nullable
as GradingDto?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get chapterTitle {
    if (_self.chapterTitle == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.chapterTitle!, (value) {
    return _then(_self.copyWith(chapterTitle: value));
  });
}/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuranRefDtoCopyWith<$Res>? get quranRef {
    if (_self.quranRef == null) {
    return null;
  }

  return $QuranRefDtoCopyWith<$Res>(_self.quranRef!, (value) {
    return _then(_self.copyWith(quranRef: value));
  });
}/// Create a copy of CitationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradingDtoCopyWith<$Res>? get grading {
    if (_self.grading == null) {
    return null;
  }

  return $GradingDtoCopyWith<$Res>(_self.grading!, (value) {
    return _then(_self.copyWith(grading: value));
  });
}/// Create a copy of CitationDto
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
mixin _$DatedClaimDto {

 HistoricalDateDto get date; Reliability get reliability; List<CitationDto> get citations; LocalizedTextDto? get note;
/// Create a copy of DatedClaimDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatedClaimDtoCopyWith<DatedClaimDto> get copyWith => _$DatedClaimDtoCopyWithImpl<DatedClaimDto>(this as DatedClaimDto, _$identity);

  /// Serializes this DatedClaimDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatedClaimDto&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'DatedClaimDto(date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $DatedClaimDtoCopyWith<$Res>  {
  factory $DatedClaimDtoCopyWith(DatedClaimDto value, $Res Function(DatedClaimDto) _then) = _$DatedClaimDtoCopyWithImpl;
@useResult
$Res call({
 HistoricalDateDto date, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


$HistoricalDateDtoCopyWith<$Res> get date;$LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class _$DatedClaimDtoCopyWithImpl<$Res>
    implements $DatedClaimDtoCopyWith<$Res> {
  _$DatedClaimDtoCopyWithImpl(this._self, this._then);

  final DatedClaimDto _self;
  final $Res Function(DatedClaimDto) _then;

/// Create a copy of DatedClaimDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of DatedClaimDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of DatedClaimDto
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


/// Adds pattern-matching-related methods to [DatedClaimDto].
extension DatedClaimDtoPatterns on DatedClaimDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DatedClaimDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DatedClaimDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DatedClaimDto value)  $default,){
final _that = this;
switch (_that) {
case _DatedClaimDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DatedClaimDto value)?  $default,){
final _that = this;
switch (_that) {
case _DatedClaimDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HistoricalDateDto date,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DatedClaimDto() when $default != null:
return $default(_that.date,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HistoricalDateDto date,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)  $default,) {final _that = this;
switch (_that) {
case _DatedClaimDto():
return $default(_that.date,_that.reliability,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HistoricalDateDto date,  Reliability reliability,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,) {final _that = this;
switch (_that) {
case _DatedClaimDto() when $default != null:
return $default(_that.date,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DatedClaimDto implements DatedClaimDto {
  const _DatedClaimDto({required this.date, required this.reliability, final  List<CitationDto> citations = const <CitationDto>[], this.note}): _citations = citations;
  factory _DatedClaimDto.fromJson(Map<String, dynamic> json) => _$DatedClaimDtoFromJson(json);

@override final  HistoricalDateDto date;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override@JsonKey() List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedTextDto? note;

/// Create a copy of DatedClaimDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatedClaimDtoCopyWith<_DatedClaimDto> get copyWith => __$DatedClaimDtoCopyWithImpl<_DatedClaimDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DatedClaimDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DatedClaimDto&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'DatedClaimDto(date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$DatedClaimDtoCopyWith<$Res> implements $DatedClaimDtoCopyWith<$Res> {
  factory _$DatedClaimDtoCopyWith(_DatedClaimDto value, $Res Function(_DatedClaimDto) _then) = __$DatedClaimDtoCopyWithImpl;
@override @useResult
$Res call({
 HistoricalDateDto date, Reliability reliability, List<CitationDto> citations, LocalizedTextDto? note
});


@override $HistoricalDateDtoCopyWith<$Res> get date;@override $LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class __$DatedClaimDtoCopyWithImpl<$Res>
    implements _$DatedClaimDtoCopyWith<$Res> {
  __$DatedClaimDtoCopyWithImpl(this._self, this._then);

  final _DatedClaimDto _self;
  final $Res Function(_DatedClaimDto) _then;

/// Create a copy of DatedClaimDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_DatedClaimDto(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of DatedClaimDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of DatedClaimDto
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
mixin _$FactDto {

 LocalizedTextDto get label; Reliability get reliability; LocalizedTextDto? get text; HistoricalDateDto? get date; List<CitationDto> get citations;
/// Create a copy of FactDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FactDtoCopyWith<FactDto> get copyWith => _$FactDtoCopyWithImpl<FactDto>(this as FactDto, _$identity);

  /// Serializes this FactDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FactDto&&(identical(other.label, label) || other.label == label)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.text, text) || other.text == text)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.citations, citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,reliability,text,date,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'FactDto(label: $label, reliability: $reliability, text: $text, date: $date, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $FactDtoCopyWith<$Res>  {
  factory $FactDtoCopyWith(FactDto value, $Res Function(FactDto) _then) = _$FactDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto label, Reliability reliability, LocalizedTextDto? text, HistoricalDateDto? date, List<CitationDto> citations
});


$LocalizedTextDtoCopyWith<$Res> get label;$LocalizedTextDtoCopyWith<$Res>? get text;$HistoricalDateDtoCopyWith<$Res>? get date;

}
/// @nodoc
class _$FactDtoCopyWithImpl<$Res>
    implements $FactDtoCopyWith<$Res> {
  _$FactDtoCopyWithImpl(this._self, this._then);

  final FactDto _self;
  final $Res Function(FactDto) _then;

/// Create a copy of FactDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? reliability = null,Object? text = freezed,Object? date = freezed,Object? citations = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto?,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}
/// Create a copy of FactDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get label {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of FactDto
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
}/// Create a copy of FactDto
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


/// Adds pattern-matching-related methods to [FactDto].
extension FactDtoPatterns on FactDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FactDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FactDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FactDto value)  $default,){
final _that = this;
switch (_that) {
case _FactDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FactDto value)?  $default,){
final _that = this;
switch (_that) {
case _FactDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedTextDto label,  Reliability reliability,  LocalizedTextDto? text,  HistoricalDateDto? date,  List<CitationDto> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FactDto() when $default != null:
return $default(_that.label,_that.reliability,_that.text,_that.date,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedTextDto label,  Reliability reliability,  LocalizedTextDto? text,  HistoricalDateDto? date,  List<CitationDto> citations)  $default,) {final _that = this;
switch (_that) {
case _FactDto():
return $default(_that.label,_that.reliability,_that.text,_that.date,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedTextDto label,  Reliability reliability,  LocalizedTextDto? text,  HistoricalDateDto? date,  List<CitationDto> citations)?  $default,) {final _that = this;
switch (_that) {
case _FactDto() when $default != null:
return $default(_that.label,_that.reliability,_that.text,_that.date,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FactDto implements FactDto {
  const _FactDto({required this.label, required this.reliability, this.text, this.date, final  List<CitationDto> citations = const <CitationDto>[]}): _citations = citations;
  factory _FactDto.fromJson(Map<String, dynamic> json) => _$FactDtoFromJson(json);

@override final  LocalizedTextDto label;
@override final  Reliability reliability;
@override final  LocalizedTextDto? text;
@override final  HistoricalDateDto? date;
 final  List<CitationDto> _citations;
@override@JsonKey() List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of FactDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FactDtoCopyWith<_FactDto> get copyWith => __$FactDtoCopyWithImpl<_FactDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FactDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FactDto&&(identical(other.label, label) || other.label == label)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.text, text) || other.text == text)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,reliability,text,date,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'FactDto(label: $label, reliability: $reliability, text: $text, date: $date, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$FactDtoCopyWith<$Res> implements $FactDtoCopyWith<$Res> {
  factory _$FactDtoCopyWith(_FactDto value, $Res Function(_FactDto) _then) = __$FactDtoCopyWithImpl;
@override @useResult
$Res call({
 LocalizedTextDto label, Reliability reliability, LocalizedTextDto? text, HistoricalDateDto? date, List<CitationDto> citations
});


@override $LocalizedTextDtoCopyWith<$Res> get label;@override $LocalizedTextDtoCopyWith<$Res>? get text;@override $HistoricalDateDtoCopyWith<$Res>? get date;

}
/// @nodoc
class __$FactDtoCopyWithImpl<$Res>
    implements _$FactDtoCopyWith<$Res> {
  __$FactDtoCopyWithImpl(this._self, this._then);

  final _FactDto _self;
  final $Res Function(_FactDto) _then;

/// Create a copy of FactDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? reliability = null,Object? text = freezed,Object? date = freezed,Object? citations = null,}) {
  return _then(_FactDto(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto?,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}

/// Create a copy of FactDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get label {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of FactDto
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
}/// Create a copy of FactDto
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
mixin _$ReviewDto {

 ReviewStatus get status; List<EditorialFlag> get editorialFlags; Coverage? get coverage;/// Who drafted it (team member or "sample-content"); not shipped to UI.
 String? get authoredBy;
/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<ReviewDto> get copyWith => _$ReviewDtoCopyWithImpl<ReviewDto>(this as ReviewDto, _$identity);

  /// Serializes this ReviewDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewDto&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.editorialFlags, editorialFlags)&&(identical(other.coverage, coverage) || other.coverage == coverage)&&(identical(other.authoredBy, authoredBy) || other.authoredBy == authoredBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(editorialFlags),coverage,authoredBy);

@override
String toString() {
  return 'ReviewDto(status: $status, editorialFlags: $editorialFlags, coverage: $coverage, authoredBy: $authoredBy)';
}


}

/// @nodoc
abstract mixin class $ReviewDtoCopyWith<$Res>  {
  factory $ReviewDtoCopyWith(ReviewDto value, $Res Function(ReviewDto) _then) = _$ReviewDtoCopyWithImpl;
@useResult
$Res call({
 ReviewStatus status, List<EditorialFlag> editorialFlags, Coverage? coverage, String? authoredBy
});




}
/// @nodoc
class _$ReviewDtoCopyWithImpl<$Res>
    implements $ReviewDtoCopyWith<$Res> {
  _$ReviewDtoCopyWithImpl(this._self, this._then);

  final ReviewDto _self;
  final $Res Function(ReviewDto) _then;

/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? editorialFlags = null,Object? coverage = freezed,Object? authoredBy = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,editorialFlags: null == editorialFlags ? _self.editorialFlags : editorialFlags // ignore: cast_nullable_to_non_nullable
as List<EditorialFlag>,coverage: freezed == coverage ? _self.coverage : coverage // ignore: cast_nullable_to_non_nullable
as Coverage?,authoredBy: freezed == authoredBy ? _self.authoredBy : authoredBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewDto].
extension ReviewDtoPatterns on ReviewDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewDto value)  $default,){
final _that = this;
switch (_that) {
case _ReviewDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReviewStatus status,  List<EditorialFlag> editorialFlags,  Coverage? coverage,  String? authoredBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
return $default(_that.status,_that.editorialFlags,_that.coverage,_that.authoredBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReviewStatus status,  List<EditorialFlag> editorialFlags,  Coverage? coverage,  String? authoredBy)  $default,) {final _that = this;
switch (_that) {
case _ReviewDto():
return $default(_that.status,_that.editorialFlags,_that.coverage,_that.authoredBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReviewStatus status,  List<EditorialFlag> editorialFlags,  Coverage? coverage,  String? authoredBy)?  $default,) {final _that = this;
switch (_that) {
case _ReviewDto() when $default != null:
return $default(_that.status,_that.editorialFlags,_that.coverage,_that.authoredBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewDto implements ReviewDto {
  const _ReviewDto({required this.status, final  List<EditorialFlag> editorialFlags = const <EditorialFlag>[], this.coverage, this.authoredBy}): _editorialFlags = editorialFlags;
  factory _ReviewDto.fromJson(Map<String, dynamic> json) => _$ReviewDtoFromJson(json);

@override final  ReviewStatus status;
 final  List<EditorialFlag> _editorialFlags;
@override@JsonKey() List<EditorialFlag> get editorialFlags {
  if (_editorialFlags is EqualUnmodifiableListView) return _editorialFlags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_editorialFlags);
}

@override final  Coverage? coverage;
/// Who drafted it (team member or "sample-content"); not shipped to UI.
@override final  String? authoredBy;

/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewDtoCopyWith<_ReviewDto> get copyWith => __$ReviewDtoCopyWithImpl<_ReviewDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewDto&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._editorialFlags, _editorialFlags)&&(identical(other.coverage, coverage) || other.coverage == coverage)&&(identical(other.authoredBy, authoredBy) || other.authoredBy == authoredBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_editorialFlags),coverage,authoredBy);

@override
String toString() {
  return 'ReviewDto(status: $status, editorialFlags: $editorialFlags, coverage: $coverage, authoredBy: $authoredBy)';
}


}

/// @nodoc
abstract mixin class _$ReviewDtoCopyWith<$Res> implements $ReviewDtoCopyWith<$Res> {
  factory _$ReviewDtoCopyWith(_ReviewDto value, $Res Function(_ReviewDto) _then) = __$ReviewDtoCopyWithImpl;
@override @useResult
$Res call({
 ReviewStatus status, List<EditorialFlag> editorialFlags, Coverage? coverage, String? authoredBy
});




}
/// @nodoc
class __$ReviewDtoCopyWithImpl<$Res>
    implements _$ReviewDtoCopyWith<$Res> {
  __$ReviewDtoCopyWithImpl(this._self, this._then);

  final _ReviewDto _self;
  final $Res Function(_ReviewDto) _then;

/// Create a copy of ReviewDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? editorialFlags = null,Object? coverage = freezed,Object? authoredBy = freezed,}) {
  return _then(_ReviewDto(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,editorialFlags: null == editorialFlags ? _self._editorialFlags : editorialFlags // ignore: cast_nullable_to_non_nullable
as List<EditorialFlag>,coverage: freezed == coverage ? _self.coverage : coverage // ignore: cast_nullable_to_non_nullable
as Coverage?,authoredBy: freezed == authoredBy ? _self.authoredBy : authoredBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PersonRefDto {

 LocalizedTextDto get displayName; String? get companionId; String? get personId;
/// Create a copy of PersonRefDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonRefDtoCopyWith<PersonRefDto> get copyWith => _$PersonRefDtoCopyWithImpl<PersonRefDto>(this as PersonRefDto, _$identity);

  /// Serializes this PersonRefDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonRefDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.companionId, companionId) || other.companionId == companionId)&&(identical(other.personId, personId) || other.personId == personId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,companionId,personId);

@override
String toString() {
  return 'PersonRefDto(displayName: $displayName, companionId: $companionId, personId: $personId)';
}


}

/// @nodoc
abstract mixin class $PersonRefDtoCopyWith<$Res>  {
  factory $PersonRefDtoCopyWith(PersonRefDto value, $Res Function(PersonRefDto) _then) = _$PersonRefDtoCopyWithImpl;
@useResult
$Res call({
 LocalizedTextDto displayName, String? companionId, String? personId
});


$LocalizedTextDtoCopyWith<$Res> get displayName;

}
/// @nodoc
class _$PersonRefDtoCopyWithImpl<$Res>
    implements $PersonRefDtoCopyWith<$Res> {
  _$PersonRefDtoCopyWithImpl(this._self, this._then);

  final PersonRefDto _self;
  final $Res Function(PersonRefDto) _then;

/// Create a copy of PersonRefDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? companionId = freezed,Object? personId = freezed,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,companionId: freezed == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String?,personId: freezed == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PersonRefDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get displayName {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.displayName, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonRefDto].
extension PersonRefDtoPatterns on PersonRefDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonRefDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonRefDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonRefDto value)  $default,){
final _that = this;
switch (_that) {
case _PersonRefDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonRefDto value)?  $default,){
final _that = this;
switch (_that) {
case _PersonRefDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedTextDto displayName,  String? companionId,  String? personId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonRefDto() when $default != null:
return $default(_that.displayName,_that.companionId,_that.personId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedTextDto displayName,  String? companionId,  String? personId)  $default,) {final _that = this;
switch (_that) {
case _PersonRefDto():
return $default(_that.displayName,_that.companionId,_that.personId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedTextDto displayName,  String? companionId,  String? personId)?  $default,) {final _that = this;
switch (_that) {
case _PersonRefDto() when $default != null:
return $default(_that.displayName,_that.companionId,_that.personId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonRefDto implements PersonRefDto {
  const _PersonRefDto({required this.displayName, this.companionId, this.personId});
  factory _PersonRefDto.fromJson(Map<String, dynamic> json) => _$PersonRefDtoFromJson(json);

@override final  LocalizedTextDto displayName;
@override final  String? companionId;
@override final  String? personId;

/// Create a copy of PersonRefDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonRefDtoCopyWith<_PersonRefDto> get copyWith => __$PersonRefDtoCopyWithImpl<_PersonRefDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonRefDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonRefDto&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.companionId, companionId) || other.companionId == companionId)&&(identical(other.personId, personId) || other.personId == personId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,companionId,personId);

@override
String toString() {
  return 'PersonRefDto(displayName: $displayName, companionId: $companionId, personId: $personId)';
}


}

/// @nodoc
abstract mixin class _$PersonRefDtoCopyWith<$Res> implements $PersonRefDtoCopyWith<$Res> {
  factory _$PersonRefDtoCopyWith(_PersonRefDto value, $Res Function(_PersonRefDto) _then) = __$PersonRefDtoCopyWithImpl;
@override @useResult
$Res call({
 LocalizedTextDto displayName, String? companionId, String? personId
});


@override $LocalizedTextDtoCopyWith<$Res> get displayName;

}
/// @nodoc
class __$PersonRefDtoCopyWithImpl<$Res>
    implements _$PersonRefDtoCopyWith<$Res> {
  __$PersonRefDtoCopyWithImpl(this._self, this._then);

  final _PersonRefDto _self;
  final $Res Function(_PersonRefDto) _then;

/// Create a copy of PersonRefDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? companionId = freezed,Object? personId = freezed,}) {
  return _then(_PersonRefDto(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,companionId: freezed == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String?,personId: freezed == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PersonRefDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get displayName {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.displayName, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}
}


/// @nodoc
mixin _$RelationDto {

 RelationType get type; PersonRefDto get person; List<CitationDto> get citations;
/// Create a copy of RelationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationDtoCopyWith<RelationDto> get copyWith => _$RelationDtoCopyWithImpl<RelationDto>(this as RelationDto, _$identity);

  /// Serializes this RelationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelationDto&&(identical(other.type, type) || other.type == type)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other.citations, citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,person,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'RelationDto(type: $type, person: $person, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $RelationDtoCopyWith<$Res>  {
  factory $RelationDtoCopyWith(RelationDto value, $Res Function(RelationDto) _then) = _$RelationDtoCopyWithImpl;
@useResult
$Res call({
 RelationType type, PersonRefDto person, List<CitationDto> citations
});


$PersonRefDtoCopyWith<$Res> get person;

}
/// @nodoc
class _$RelationDtoCopyWithImpl<$Res>
    implements $RelationDtoCopyWith<$Res> {
  _$RelationDtoCopyWithImpl(this._self, this._then);

  final RelationDto _self;
  final $Res Function(RelationDto) _then;

/// Create a copy of RelationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? person = null,Object? citations = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as PersonRefDto,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}
/// Create a copy of RelationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefDtoCopyWith<$Res> get person {
  
  return $PersonRefDtoCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}


/// Adds pattern-matching-related methods to [RelationDto].
extension RelationDtoPatterns on RelationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelationDto value)  $default,){
final _that = this;
switch (_that) {
case _RelationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelationDto value)?  $default,){
final _that = this;
switch (_that) {
case _RelationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RelationType type,  PersonRefDto person,  List<CitationDto> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelationDto() when $default != null:
return $default(_that.type,_that.person,_that.citations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RelationType type,  PersonRefDto person,  List<CitationDto> citations)  $default,) {final _that = this;
switch (_that) {
case _RelationDto():
return $default(_that.type,_that.person,_that.citations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RelationType type,  PersonRefDto person,  List<CitationDto> citations)?  $default,) {final _that = this;
switch (_that) {
case _RelationDto() when $default != null:
return $default(_that.type,_that.person,_that.citations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RelationDto implements RelationDto {
  const _RelationDto({required this.type, required this.person, final  List<CitationDto> citations = const <CitationDto>[]}): _citations = citations;
  factory _RelationDto.fromJson(Map<String, dynamic> json) => _$RelationDtoFromJson(json);

@override final  RelationType type;
@override final  PersonRefDto person;
 final  List<CitationDto> _citations;
@override@JsonKey() List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of RelationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationDtoCopyWith<_RelationDto> get copyWith => __$RelationDtoCopyWithImpl<_RelationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RelationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelationDto&&(identical(other.type, type) || other.type == type)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other._citations, _citations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,person,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'RelationDto(type: $type, person: $person, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$RelationDtoCopyWith<$Res> implements $RelationDtoCopyWith<$Res> {
  factory _$RelationDtoCopyWith(_RelationDto value, $Res Function(_RelationDto) _then) = __$RelationDtoCopyWithImpl;
@override @useResult
$Res call({
 RelationType type, PersonRefDto person, List<CitationDto> citations
});


@override $PersonRefDtoCopyWith<$Res> get person;

}
/// @nodoc
class __$RelationDtoCopyWithImpl<$Res>
    implements _$RelationDtoCopyWith<$Res> {
  __$RelationDtoCopyWithImpl(this._self, this._then);

  final _RelationDto _self;
  final $Res Function(_RelationDto) _then;

/// Create a copy of RelationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? person = null,Object? citations = null,}) {
  return _then(_RelationDto(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as PersonRefDto,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,
  ));
}

/// Create a copy of RelationDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefDtoCopyWith<$Res> get person {
  
  return $PersonRefDtoCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}


/// @nodoc
mixin _$MembershipDto {

 String get categoryId; List<CitationDto> get citations; LocalizedTextDto? get note;
/// Create a copy of MembershipDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipDtoCopyWith<MembershipDto> get copyWith => _$MembershipDtoCopyWithImpl<MembershipDto>(this as MembershipDto, _$identity);

  /// Serializes this MembershipDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MembershipDto&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'MembershipDto(categoryId: $categoryId, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $MembershipDtoCopyWith<$Res>  {
  factory $MembershipDtoCopyWith(MembershipDto value, $Res Function(MembershipDto) _then) = _$MembershipDtoCopyWithImpl;
@useResult
$Res call({
 String categoryId, List<CitationDto> citations, LocalizedTextDto? note
});


$LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class _$MembershipDtoCopyWithImpl<$Res>
    implements $MembershipDtoCopyWith<$Res> {
  _$MembershipDtoCopyWithImpl(this._self, this._then);

  final MembershipDto _self;
  final $Res Function(MembershipDto) _then;

/// Create a copy of MembershipDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of MembershipDto
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


/// Adds pattern-matching-related methods to [MembershipDto].
extension MembershipDtoPatterns on MembershipDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MembershipDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MembershipDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MembershipDto value)  $default,){
final _that = this;
switch (_that) {
case _MembershipDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MembershipDto value)?  $default,){
final _that = this;
switch (_that) {
case _MembershipDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MembershipDto() when $default != null:
return $default(_that.categoryId,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  List<CitationDto> citations,  LocalizedTextDto? note)  $default,) {final _that = this;
switch (_that) {
case _MembershipDto():
return $default(_that.categoryId,_that.citations,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  List<CitationDto> citations,  LocalizedTextDto? note)?  $default,) {final _that = this;
switch (_that) {
case _MembershipDto() when $default != null:
return $default(_that.categoryId,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MembershipDto implements MembershipDto {
  const _MembershipDto({required this.categoryId, required final  List<CitationDto> citations, this.note}): _citations = citations;
  factory _MembershipDto.fromJson(Map<String, dynamic> json) => _$MembershipDtoFromJson(json);

@override final  String categoryId;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedTextDto? note;

/// Create a copy of MembershipDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipDtoCopyWith<_MembershipDto> get copyWith => __$MembershipDtoCopyWithImpl<_MembershipDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MembershipDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MembershipDto&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,categoryId,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'MembershipDto(categoryId: $categoryId, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$MembershipDtoCopyWith<$Res> implements $MembershipDtoCopyWith<$Res> {
  factory _$MembershipDtoCopyWith(_MembershipDto value, $Res Function(_MembershipDto) _then) = __$MembershipDtoCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, List<CitationDto> citations, LocalizedTextDto? note
});


@override $LocalizedTextDtoCopyWith<$Res>? get note;

}
/// @nodoc
class __$MembershipDtoCopyWithImpl<$Res>
    implements _$MembershipDtoCopyWith<$Res> {
  __$MembershipDtoCopyWithImpl(this._self, this._then);

  final _MembershipDto _self;
  final $Res Function(_MembershipDto) _then;

/// Create a copy of MembershipDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_MembershipDto(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of MembershipDto
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

// dart format on
