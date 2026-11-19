// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'glossary_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GlossaryTermDto {

 String get id; LocalizedTextDto get term;/// The spellings linked in passages (without tashkeel), the term
/// itself included.
 List<String> get forms; LocalizedTextDto get definition; Reliability get reliability; List<CitationDto> get citations; ReviewDto get review;
/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryTermDtoCopyWith<GlossaryTermDto> get copyWith => _$GlossaryTermDtoCopyWithImpl<GlossaryTermDto>(this as GlossaryTermDto, _$identity);

  /// Serializes this GlossaryTermDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryTermDto&&(identical(other.id, id) || other.id == id)&&(identical(other.term, term) || other.term == term)&&const DeepCollectionEquality().equals(other.forms, forms)&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,term,const DeepCollectionEquality().hash(forms),definition,reliability,const DeepCollectionEquality().hash(citations),review);

@override
String toString() {
  return 'GlossaryTermDto(id: $id, term: $term, forms: $forms, definition: $definition, reliability: $reliability, citations: $citations, review: $review)';
}


}

/// @nodoc
abstract mixin class $GlossaryTermDtoCopyWith<$Res>  {
  factory $GlossaryTermDtoCopyWith(GlossaryTermDto value, $Res Function(GlossaryTermDto) _then) = _$GlossaryTermDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto term, List<String> forms, LocalizedTextDto definition, Reliability reliability, List<CitationDto> citations, ReviewDto review
});


$LocalizedTextDtoCopyWith<$Res> get term;$LocalizedTextDtoCopyWith<$Res> get definition;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$GlossaryTermDtoCopyWithImpl<$Res>
    implements $GlossaryTermDtoCopyWith<$Res> {
  _$GlossaryTermDtoCopyWithImpl(this._self, this._then);

  final GlossaryTermDto _self;
  final $Res Function(GlossaryTermDto) _then;

/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? term = null,Object? forms = null,Object? definition = null,Object? reliability = null,Object? citations = null,Object? review = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,forms: null == forms ? _self.forms : forms // ignore: cast_nullable_to_non_nullable
as List<String>,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,
  ));
}
/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get term {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.term, (value) {
    return _then(_self.copyWith(term: value));
  });
}/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get definition {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [GlossaryTermDto].
extension GlossaryTermDtoPatterns on GlossaryTermDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlossaryTermDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlossaryTermDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlossaryTermDto value)  $default,){
final _that = this;
switch (_that) {
case _GlossaryTermDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlossaryTermDto value)?  $default,){
final _that = this;
switch (_that) {
case _GlossaryTermDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto term,  List<String> forms,  LocalizedTextDto definition,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlossaryTermDto() when $default != null:
return $default(_that.id,_that.term,_that.forms,_that.definition,_that.reliability,_that.citations,_that.review);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto term,  List<String> forms,  LocalizedTextDto definition,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review)  $default,) {final _that = this;
switch (_that) {
case _GlossaryTermDto():
return $default(_that.id,_that.term,_that.forms,_that.definition,_that.reliability,_that.citations,_that.review);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto term,  List<String> forms,  LocalizedTextDto definition,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review)?  $default,) {final _that = this;
switch (_that) {
case _GlossaryTermDto() when $default != null:
return $default(_that.id,_that.term,_that.forms,_that.definition,_that.reliability,_that.citations,_that.review);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GlossaryTermDto implements GlossaryTermDto {
  const _GlossaryTermDto({required this.id, required this.term, required final  List<String> forms, required this.definition, required this.reliability, required final  List<CitationDto> citations, required this.review}): _forms = forms,_citations = citations;
  factory _GlossaryTermDto.fromJson(Map<String, dynamic> json) => _$GlossaryTermDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto term;
/// The spellings linked in passages (without tashkeel), the term
/// itself included.
 final  List<String> _forms;
/// The spellings linked in passages (without tashkeel), the term
/// itself included.
@override List<String> get forms {
  if (_forms is EqualUnmodifiableListView) return _forms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_forms);
}

@override final  LocalizedTextDto definition;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  ReviewDto review;

/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryTermDtoCopyWith<_GlossaryTermDto> get copyWith => __$GlossaryTermDtoCopyWithImpl<_GlossaryTermDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GlossaryTermDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryTermDto&&(identical(other.id, id) || other.id == id)&&(identical(other.term, term) || other.term == term)&&const DeepCollectionEquality().equals(other._forms, _forms)&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.review, review) || other.review == review));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,term,const DeepCollectionEquality().hash(_forms),definition,reliability,const DeepCollectionEquality().hash(_citations),review);

@override
String toString() {
  return 'GlossaryTermDto(id: $id, term: $term, forms: $forms, definition: $definition, reliability: $reliability, citations: $citations, review: $review)';
}


}

/// @nodoc
abstract mixin class _$GlossaryTermDtoCopyWith<$Res> implements $GlossaryTermDtoCopyWith<$Res> {
  factory _$GlossaryTermDtoCopyWith(_GlossaryTermDto value, $Res Function(_GlossaryTermDto) _then) = __$GlossaryTermDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto term, List<String> forms, LocalizedTextDto definition, Reliability reliability, List<CitationDto> citations, ReviewDto review
});


@override $LocalizedTextDtoCopyWith<$Res> get term;@override $LocalizedTextDtoCopyWith<$Res> get definition;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$GlossaryTermDtoCopyWithImpl<$Res>
    implements _$GlossaryTermDtoCopyWith<$Res> {
  __$GlossaryTermDtoCopyWithImpl(this._self, this._then);

  final _GlossaryTermDto _self;
  final $Res Function(_GlossaryTermDto) _then;

/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? term = null,Object? forms = null,Object? definition = null,Object? reliability = null,Object? citations = null,Object? review = null,}) {
  return _then(_GlossaryTermDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,forms: null == forms ? _self._forms : forms // ignore: cast_nullable_to_non_nullable
as List<String>,definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,
  ));
}

/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get term {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.term, (value) {
    return _then(_self.copyWith(term: value));
  });
}/// Create a copy of GlossaryTermDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get definition {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.definition, (value) {
    return _then(_self.copyWith(definition: value));
  });
}/// Create a copy of GlossaryTermDto
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
mixin _$GlossaryFileDto {

 int get schemaVersion; List<GlossaryTermDto> get terms;
/// Create a copy of GlossaryFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GlossaryFileDtoCopyWith<GlossaryFileDto> get copyWith => _$GlossaryFileDtoCopyWithImpl<GlossaryFileDto>(this as GlossaryFileDto, _$identity);

  /// Serializes this GlossaryFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GlossaryFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.terms, terms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(terms));

@override
String toString() {
  return 'GlossaryFileDto(schemaVersion: $schemaVersion, terms: $terms)';
}


}

/// @nodoc
abstract mixin class $GlossaryFileDtoCopyWith<$Res>  {
  factory $GlossaryFileDtoCopyWith(GlossaryFileDto value, $Res Function(GlossaryFileDto) _then) = _$GlossaryFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<GlossaryTermDto> terms
});




}
/// @nodoc
class _$GlossaryFileDtoCopyWithImpl<$Res>
    implements $GlossaryFileDtoCopyWith<$Res> {
  _$GlossaryFileDtoCopyWithImpl(this._self, this._then);

  final GlossaryFileDto _self;
  final $Res Function(GlossaryFileDto) _then;

/// Create a copy of GlossaryFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? terms = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,terms: null == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as List<GlossaryTermDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [GlossaryFileDto].
extension GlossaryFileDtoPatterns on GlossaryFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GlossaryFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GlossaryFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GlossaryFileDto value)  $default,){
final _that = this;
switch (_that) {
case _GlossaryFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GlossaryFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _GlossaryFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<GlossaryTermDto> terms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GlossaryFileDto() when $default != null:
return $default(_that.schemaVersion,_that.terms);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<GlossaryTermDto> terms)  $default,) {final _that = this;
switch (_that) {
case _GlossaryFileDto():
return $default(_that.schemaVersion,_that.terms);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<GlossaryTermDto> terms)?  $default,) {final _that = this;
switch (_that) {
case _GlossaryFileDto() when $default != null:
return $default(_that.schemaVersion,_that.terms);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GlossaryFileDto implements GlossaryFileDto {
  const _GlossaryFileDto({required this.schemaVersion, required final  List<GlossaryTermDto> terms}): _terms = terms;
  factory _GlossaryFileDto.fromJson(Map<String, dynamic> json) => _$GlossaryFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<GlossaryTermDto> _terms;
@override List<GlossaryTermDto> get terms {
  if (_terms is EqualUnmodifiableListView) return _terms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_terms);
}


/// Create a copy of GlossaryFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GlossaryFileDtoCopyWith<_GlossaryFileDto> get copyWith => __$GlossaryFileDtoCopyWithImpl<_GlossaryFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GlossaryFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GlossaryFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._terms, _terms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_terms));

@override
String toString() {
  return 'GlossaryFileDto(schemaVersion: $schemaVersion, terms: $terms)';
}


}

/// @nodoc
abstract mixin class _$GlossaryFileDtoCopyWith<$Res> implements $GlossaryFileDtoCopyWith<$Res> {
  factory _$GlossaryFileDtoCopyWith(_GlossaryFileDto value, $Res Function(_GlossaryFileDto) _then) = __$GlossaryFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<GlossaryTermDto> terms
});




}
/// @nodoc
class __$GlossaryFileDtoCopyWithImpl<$Res>
    implements _$GlossaryFileDtoCopyWith<$Res> {
  __$GlossaryFileDtoCopyWithImpl(this._self, this._then);

  final _GlossaryFileDto _self;
  final $Res Function(_GlossaryFileDto) _then;

/// Create a copy of GlossaryFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? terms = null,}) {
  return _then(_GlossaryFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,terms: null == terms ? _self._terms : terms // ignore: cast_nullable_to_non_nullable
as List<GlossaryTermDto>,
  ));
}


}

// dart format on
