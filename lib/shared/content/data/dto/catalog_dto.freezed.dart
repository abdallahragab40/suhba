// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CategoryDto {

 String get id; LocalizedTextDto get name; int get order; ReviewDto get review; LocalizedTextDto? get description; ContentBlockDto? get basis;
/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryDtoCopyWith<CategoryDto> get copyWith => _$CategoryDtoCopyWithImpl<CategoryDto>(this as CategoryDto, _$identity);

  /// Serializes this CategoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.review, review) || other.review == review)&&(identical(other.description, description) || other.description == description)&&(identical(other.basis, basis) || other.basis == basis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,order,review,description,basis);

@override
String toString() {
  return 'CategoryDto(id: $id, name: $name, order: $order, review: $review, description: $description, basis: $basis)';
}


}

/// @nodoc
abstract mixin class $CategoryDtoCopyWith<$Res>  {
  factory $CategoryDtoCopyWith(CategoryDto value, $Res Function(CategoryDto) _then) = _$CategoryDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto name, int order, ReviewDto review, LocalizedTextDto? description, ContentBlockDto? basis
});


$LocalizedTextDtoCopyWith<$Res> get name;$ReviewDtoCopyWith<$Res> get review;$LocalizedTextDtoCopyWith<$Res>? get description;$ContentBlockDtoCopyWith<$Res>? get basis;

}
/// @nodoc
class _$CategoryDtoCopyWithImpl<$Res>
    implements $CategoryDtoCopyWith<$Res> {
  _$CategoryDtoCopyWithImpl(this._self, this._then);

  final CategoryDto _self;
  final $Res Function(CategoryDto) _then;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? order = null,Object? review = null,Object? description = freezed,Object? basis = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,basis: freezed == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as ContentBlockDto?,
  ));
}
/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentBlockDtoCopyWith<$Res>? get basis {
    if (_self.basis == null) {
    return null;
  }

  return $ContentBlockDtoCopyWith<$Res>(_self.basis!, (value) {
    return _then(_self.copyWith(basis: value));
  });
}
}


/// Adds pattern-matching-related methods to [CategoryDto].
extension CategoryDtoPatterns on CategoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryDto value)  $default,){
final _that = this;
switch (_that) {
case _CategoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  int order,  ReviewDto review,  LocalizedTextDto? description,  ContentBlockDto? basis)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
return $default(_that.id,_that.name,_that.order,_that.review,_that.description,_that.basis);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  int order,  ReviewDto review,  LocalizedTextDto? description,  ContentBlockDto? basis)  $default,) {final _that = this;
switch (_that) {
case _CategoryDto():
return $default(_that.id,_that.name,_that.order,_that.review,_that.description,_that.basis);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto name,  int order,  ReviewDto review,  LocalizedTextDto? description,  ContentBlockDto? basis)?  $default,) {final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
return $default(_that.id,_that.name,_that.order,_that.review,_that.description,_that.basis);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryDto implements CategoryDto {
  const _CategoryDto({required this.id, required this.name, required this.order, required this.review, this.description, this.basis});
  factory _CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto name;
@override final  int order;
@override final  ReviewDto review;
@override final  LocalizedTextDto? description;
@override final  ContentBlockDto? basis;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryDtoCopyWith<_CategoryDto> get copyWith => __$CategoryDtoCopyWithImpl<_CategoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.review, review) || other.review == review)&&(identical(other.description, description) || other.description == description)&&(identical(other.basis, basis) || other.basis == basis));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,order,review,description,basis);

@override
String toString() {
  return 'CategoryDto(id: $id, name: $name, order: $order, review: $review, description: $description, basis: $basis)';
}


}

/// @nodoc
abstract mixin class _$CategoryDtoCopyWith<$Res> implements $CategoryDtoCopyWith<$Res> {
  factory _$CategoryDtoCopyWith(_CategoryDto value, $Res Function(_CategoryDto) _then) = __$CategoryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto name, int order, ReviewDto review, LocalizedTextDto? description, ContentBlockDto? basis
});


@override $LocalizedTextDtoCopyWith<$Res> get name;@override $ReviewDtoCopyWith<$Res> get review;@override $LocalizedTextDtoCopyWith<$Res>? get description;@override $ContentBlockDtoCopyWith<$Res>? get basis;

}
/// @nodoc
class __$CategoryDtoCopyWithImpl<$Res>
    implements _$CategoryDtoCopyWith<$Res> {
  __$CategoryDtoCopyWithImpl(this._self, this._then);

  final _CategoryDto _self;
  final $Res Function(_CategoryDto) _then;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? order = null,Object? review = null,Object? description = freezed,Object? basis = freezed,}) {
  return _then(_CategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,basis: freezed == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as ContentBlockDto?,
  ));
}

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentBlockDtoCopyWith<$Res>? get basis {
    if (_self.basis == null) {
    return null;
  }

  return $ContentBlockDtoCopyWith<$Res>(_self.basis!, (value) {
    return _then(_self.copyWith(basis: value));
  });
}
}


/// @nodoc
mixin _$HistoricalEventDto {

 String get id; LocalizedTextDto get name; EventType get type; HistoricalDateDto get date; LocalizedTextDto get summary; Reliability get reliability; List<CitationDto> get citations; ReviewDto get review; LocalizedTextDto? get place; List<PersonRefDto> get participants;
/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalEventDtoCopyWith<HistoricalEventDto> get copyWith => _$HistoricalEventDtoCopyWithImpl<HistoricalEventDto>(this as HistoricalEventDto, _$identity);

  /// Serializes this HistoricalEventDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other.participants, participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,date,summary,reliability,const DeepCollectionEquality().hash(citations),review,place,const DeepCollectionEquality().hash(participants));

@override
String toString() {
  return 'HistoricalEventDto(id: $id, name: $name, type: $type, date: $date, summary: $summary, reliability: $reliability, citations: $citations, review: $review, place: $place, participants: $participants)';
}


}

/// @nodoc
abstract mixin class $HistoricalEventDtoCopyWith<$Res>  {
  factory $HistoricalEventDtoCopyWith(HistoricalEventDto value, $Res Function(HistoricalEventDto) _then) = _$HistoricalEventDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto name, EventType type, HistoricalDateDto date, LocalizedTextDto summary, Reliability reliability, List<CitationDto> citations, ReviewDto review, LocalizedTextDto? place, List<PersonRefDto> participants
});


$LocalizedTextDtoCopyWith<$Res> get name;$HistoricalDateDtoCopyWith<$Res> get date;$LocalizedTextDtoCopyWith<$Res> get summary;$ReviewDtoCopyWith<$Res> get review;$LocalizedTextDtoCopyWith<$Res>? get place;

}
/// @nodoc
class _$HistoricalEventDtoCopyWithImpl<$Res>
    implements $HistoricalEventDtoCopyWith<$Res> {
  _$HistoricalEventDtoCopyWithImpl(this._self, this._then);

  final HistoricalEventDto _self;
  final $Res Function(HistoricalEventDto) _then;

/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? place = freezed,Object? participants = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<PersonRefDto>,
  ));
}
/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// Adds pattern-matching-related methods to [HistoricalEventDto].
extension HistoricalEventDtoPatterns on HistoricalEventDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalEventDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalEventDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalEventDto value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalEventDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalEventDto value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalEventDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  EventType type,  HistoricalDateDto date,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review,  LocalizedTextDto? place,  List<PersonRefDto> participants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalEventDto() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.date,_that.summary,_that.reliability,_that.citations,_that.review,_that.place,_that.participants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  EventType type,  HistoricalDateDto date,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review,  LocalizedTextDto? place,  List<PersonRefDto> participants)  $default,) {final _that = this;
switch (_that) {
case _HistoricalEventDto():
return $default(_that.id,_that.name,_that.type,_that.date,_that.summary,_that.reliability,_that.citations,_that.review,_that.place,_that.participants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto name,  EventType type,  HistoricalDateDto date,  LocalizedTextDto summary,  Reliability reliability,  List<CitationDto> citations,  ReviewDto review,  LocalizedTextDto? place,  List<PersonRefDto> participants)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalEventDto() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.date,_that.summary,_that.reliability,_that.citations,_that.review,_that.place,_that.participants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoricalEventDto implements HistoricalEventDto {
  const _HistoricalEventDto({required this.id, required this.name, required this.type, required this.date, required this.summary, required this.reliability, required final  List<CitationDto> citations, required this.review, this.place, final  List<PersonRefDto> participants = const <PersonRefDto>[]}): _citations = citations,_participants = participants;
  factory _HistoricalEventDto.fromJson(Map<String, dynamic> json) => _$HistoricalEventDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto name;
@override final  EventType type;
@override final  HistoricalDateDto date;
@override final  LocalizedTextDto summary;
@override final  Reliability reliability;
 final  List<CitationDto> _citations;
@override List<CitationDto> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  ReviewDto review;
@override final  LocalizedTextDto? place;
 final  List<PersonRefDto> _participants;
@override@JsonKey() List<PersonRefDto> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}


/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalEventDtoCopyWith<_HistoricalEventDto> get copyWith => __$HistoricalEventDtoCopyWithImpl<_HistoricalEventDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoricalEventDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalEventDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other._participants, _participants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,date,summary,reliability,const DeepCollectionEquality().hash(_citations),review,place,const DeepCollectionEquality().hash(_participants));

@override
String toString() {
  return 'HistoricalEventDto(id: $id, name: $name, type: $type, date: $date, summary: $summary, reliability: $reliability, citations: $citations, review: $review, place: $place, participants: $participants)';
}


}

/// @nodoc
abstract mixin class _$HistoricalEventDtoCopyWith<$Res> implements $HistoricalEventDtoCopyWith<$Res> {
  factory _$HistoricalEventDtoCopyWith(_HistoricalEventDto value, $Res Function(_HistoricalEventDto) _then) = __$HistoricalEventDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto name, EventType type, HistoricalDateDto date, LocalizedTextDto summary, Reliability reliability, List<CitationDto> citations, ReviewDto review, LocalizedTextDto? place, List<PersonRefDto> participants
});


@override $LocalizedTextDtoCopyWith<$Res> get name;@override $HistoricalDateDtoCopyWith<$Res> get date;@override $LocalizedTextDtoCopyWith<$Res> get summary;@override $ReviewDtoCopyWith<$Res> get review;@override $LocalizedTextDtoCopyWith<$Res>? get place;

}
/// @nodoc
class __$HistoricalEventDtoCopyWithImpl<$Res>
    implements _$HistoricalEventDtoCopyWith<$Res> {
  __$HistoricalEventDtoCopyWithImpl(this._self, this._then);

  final _HistoricalEventDto _self;
  final $Res Function(_HistoricalEventDto) _then;

/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? place = freezed,Object? participants = null,}) {
  return _then(_HistoricalEventDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDateDto,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<CitationDto>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<PersonRefDto>,
  ));
}

/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HistoricalDateDtoCopyWith<$Res> get date {
  
  return $HistoricalDateDtoCopyWith<$Res>(_self.date, (value) {
    return _then(_self.copyWith(date: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get summary {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of HistoricalEventDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}
}


/// @nodoc
mixin _$SourceReferenceDto {

 String get id; SourceType get type; LocalizedTextDto get title; ReviewDto get review; LocalizedTextDto? get author; int? get authorDeathAH; LocalizedTextDto? get edition; LocalizedTextDto? get publisher; LocalizedTextDto? get numberingScheme;
/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceReferenceDtoCopyWith<SourceReferenceDto> get copyWith => _$SourceReferenceDtoCopyWithImpl<SourceReferenceDto>(this as SourceReferenceDto, _$identity);

  /// Serializes this SourceReferenceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceReferenceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.review, review) || other.review == review)&&(identical(other.author, author) || other.author == author)&&(identical(other.authorDeathAH, authorDeathAH) || other.authorDeathAH == authorDeathAH)&&(identical(other.edition, edition) || other.edition == edition)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.numberingScheme, numberingScheme) || other.numberingScheme == numberingScheme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,review,author,authorDeathAH,edition,publisher,numberingScheme);

@override
String toString() {
  return 'SourceReferenceDto(id: $id, type: $type, title: $title, review: $review, author: $author, authorDeathAH: $authorDeathAH, edition: $edition, publisher: $publisher, numberingScheme: $numberingScheme)';
}


}

/// @nodoc
abstract mixin class $SourceReferenceDtoCopyWith<$Res>  {
  factory $SourceReferenceDtoCopyWith(SourceReferenceDto value, $Res Function(SourceReferenceDto) _then) = _$SourceReferenceDtoCopyWithImpl;
@useResult
$Res call({
 String id, SourceType type, LocalizedTextDto title, ReviewDto review, LocalizedTextDto? author, int? authorDeathAH, LocalizedTextDto? edition, LocalizedTextDto? publisher, LocalizedTextDto? numberingScheme
});


$LocalizedTextDtoCopyWith<$Res> get title;$ReviewDtoCopyWith<$Res> get review;$LocalizedTextDtoCopyWith<$Res>? get author;$LocalizedTextDtoCopyWith<$Res>? get edition;$LocalizedTextDtoCopyWith<$Res>? get publisher;$LocalizedTextDtoCopyWith<$Res>? get numberingScheme;

}
/// @nodoc
class _$SourceReferenceDtoCopyWithImpl<$Res>
    implements $SourceReferenceDtoCopyWith<$Res> {
  _$SourceReferenceDtoCopyWithImpl(this._self, this._then);

  final SourceReferenceDto _self;
  final $Res Function(SourceReferenceDto) _then;

/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? review = null,Object? author = freezed,Object? authorDeathAH = freezed,Object? edition = freezed,Object? publisher = freezed,Object? numberingScheme = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,authorDeathAH: freezed == authorDeathAH ? _self.authorDeathAH : authorDeathAH // ignore: cast_nullable_to_non_nullable
as int?,edition: freezed == edition ? _self.edition : edition // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,numberingScheme: freezed == numberingScheme ? _self.numberingScheme : numberingScheme // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}
/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get edition {
    if (_self.edition == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.edition!, (value) {
    return _then(_self.copyWith(edition: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get publisher {
    if (_self.publisher == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.publisher!, (value) {
    return _then(_self.copyWith(publisher: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get numberingScheme {
    if (_self.numberingScheme == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.numberingScheme!, (value) {
    return _then(_self.copyWith(numberingScheme: value));
  });
}
}


/// Adds pattern-matching-related methods to [SourceReferenceDto].
extension SourceReferenceDtoPatterns on SourceReferenceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SourceReferenceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SourceReferenceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SourceReferenceDto value)  $default,){
final _that = this;
switch (_that) {
case _SourceReferenceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SourceReferenceDto value)?  $default,){
final _that = this;
switch (_that) {
case _SourceReferenceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SourceType type,  LocalizedTextDto title,  ReviewDto review,  LocalizedTextDto? author,  int? authorDeathAH,  LocalizedTextDto? edition,  LocalizedTextDto? publisher,  LocalizedTextDto? numberingScheme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SourceReferenceDto() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.review,_that.author,_that.authorDeathAH,_that.edition,_that.publisher,_that.numberingScheme);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SourceType type,  LocalizedTextDto title,  ReviewDto review,  LocalizedTextDto? author,  int? authorDeathAH,  LocalizedTextDto? edition,  LocalizedTextDto? publisher,  LocalizedTextDto? numberingScheme)  $default,) {final _that = this;
switch (_that) {
case _SourceReferenceDto():
return $default(_that.id,_that.type,_that.title,_that.review,_that.author,_that.authorDeathAH,_that.edition,_that.publisher,_that.numberingScheme);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SourceType type,  LocalizedTextDto title,  ReviewDto review,  LocalizedTextDto? author,  int? authorDeathAH,  LocalizedTextDto? edition,  LocalizedTextDto? publisher,  LocalizedTextDto? numberingScheme)?  $default,) {final _that = this;
switch (_that) {
case _SourceReferenceDto() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.review,_that.author,_that.authorDeathAH,_that.edition,_that.publisher,_that.numberingScheme);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SourceReferenceDto implements SourceReferenceDto {
  const _SourceReferenceDto({required this.id, required this.type, required this.title, required this.review, this.author, this.authorDeathAH, this.edition, this.publisher, this.numberingScheme});
  factory _SourceReferenceDto.fromJson(Map<String, dynamic> json) => _$SourceReferenceDtoFromJson(json);

@override final  String id;
@override final  SourceType type;
@override final  LocalizedTextDto title;
@override final  ReviewDto review;
@override final  LocalizedTextDto? author;
@override final  int? authorDeathAH;
@override final  LocalizedTextDto? edition;
@override final  LocalizedTextDto? publisher;
@override final  LocalizedTextDto? numberingScheme;

/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceReferenceDtoCopyWith<_SourceReferenceDto> get copyWith => __$SourceReferenceDtoCopyWithImpl<_SourceReferenceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourceReferenceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceReferenceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.review, review) || other.review == review)&&(identical(other.author, author) || other.author == author)&&(identical(other.authorDeathAH, authorDeathAH) || other.authorDeathAH == authorDeathAH)&&(identical(other.edition, edition) || other.edition == edition)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.numberingScheme, numberingScheme) || other.numberingScheme == numberingScheme));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,review,author,authorDeathAH,edition,publisher,numberingScheme);

@override
String toString() {
  return 'SourceReferenceDto(id: $id, type: $type, title: $title, review: $review, author: $author, authorDeathAH: $authorDeathAH, edition: $edition, publisher: $publisher, numberingScheme: $numberingScheme)';
}


}

/// @nodoc
abstract mixin class _$SourceReferenceDtoCopyWith<$Res> implements $SourceReferenceDtoCopyWith<$Res> {
  factory _$SourceReferenceDtoCopyWith(_SourceReferenceDto value, $Res Function(_SourceReferenceDto) _then) = __$SourceReferenceDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, SourceType type, LocalizedTextDto title, ReviewDto review, LocalizedTextDto? author, int? authorDeathAH, LocalizedTextDto? edition, LocalizedTextDto? publisher, LocalizedTextDto? numberingScheme
});


@override $LocalizedTextDtoCopyWith<$Res> get title;@override $ReviewDtoCopyWith<$Res> get review;@override $LocalizedTextDtoCopyWith<$Res>? get author;@override $LocalizedTextDtoCopyWith<$Res>? get edition;@override $LocalizedTextDtoCopyWith<$Res>? get publisher;@override $LocalizedTextDtoCopyWith<$Res>? get numberingScheme;

}
/// @nodoc
class __$SourceReferenceDtoCopyWithImpl<$Res>
    implements _$SourceReferenceDtoCopyWith<$Res> {
  __$SourceReferenceDtoCopyWithImpl(this._self, this._then);

  final _SourceReferenceDto _self;
  final $Res Function(_SourceReferenceDto) _then;

/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? review = null,Object? author = freezed,Object? authorDeathAH = freezed,Object? edition = freezed,Object? publisher = freezed,Object? numberingScheme = freezed,}) {
  return _then(_SourceReferenceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,authorDeathAH: freezed == authorDeathAH ? _self.authorDeathAH : authorDeathAH // ignore: cast_nullable_to_non_nullable
as int?,edition: freezed == edition ? _self.edition : edition // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,numberingScheme: freezed == numberingScheme ? _self.numberingScheme : numberingScheme // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto?,
  ));
}

/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get title {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get edition {
    if (_self.edition == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.edition!, (value) {
    return _then(_self.copyWith(edition: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get publisher {
    if (_self.publisher == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.publisher!, (value) {
    return _then(_self.copyWith(publisher: value));
  });
}/// Create a copy of SourceReferenceDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res>? get numberingScheme {
    if (_self.numberingScheme == null) {
    return null;
  }

  return $LocalizedTextDtoCopyWith<$Res>(_self.numberingScheme!, (value) {
    return _then(_self.copyWith(numberingScheme: value));
  });
}
}


/// @nodoc
mixin _$PersonDto {

 String get id; LocalizedTextDto get name; PersonHonorific get honorific; ReviewDto get review; Gender? get gender;
/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonDtoCopyWith<PersonDto> get copyWith => _$PersonDtoCopyWithImpl<PersonDto>(this as PersonDto, _$identity);

  /// Serializes this PersonDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.honorific, honorific) || other.honorific == honorific)&&(identical(other.review, review) || other.review == review)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,honorific,review,gender);

@override
String toString() {
  return 'PersonDto(id: $id, name: $name, honorific: $honorific, review: $review, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $PersonDtoCopyWith<$Res>  {
  factory $PersonDtoCopyWith(PersonDto value, $Res Function(PersonDto) _then) = _$PersonDtoCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedTextDto name, PersonHonorific honorific, ReviewDto review, Gender? gender
});


$LocalizedTextDtoCopyWith<$Res> get name;$ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class _$PersonDtoCopyWithImpl<$Res>
    implements $PersonDtoCopyWith<$Res> {
  _$PersonDtoCopyWithImpl(this._self, this._then);

  final PersonDto _self;
  final $Res Function(PersonDto) _then;

/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? honorific = null,Object? review = null,Object? gender = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,honorific: null == honorific ? _self.honorific : honorific // ignore: cast_nullable_to_non_nullable
as PersonHonorific,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,
  ));
}
/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewDtoCopyWith<$Res> get review {
  
  return $ReviewDtoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonDto].
extension PersonDtoPatterns on PersonDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonDto value)  $default,){
final _that = this;
switch (_that) {
case _PersonDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonDto value)?  $default,){
final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  PersonHonorific honorific,  ReviewDto review,  Gender? gender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
return $default(_that.id,_that.name,_that.honorific,_that.review,_that.gender);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedTextDto name,  PersonHonorific honorific,  ReviewDto review,  Gender? gender)  $default,) {final _that = this;
switch (_that) {
case _PersonDto():
return $default(_that.id,_that.name,_that.honorific,_that.review,_that.gender);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedTextDto name,  PersonHonorific honorific,  ReviewDto review,  Gender? gender)?  $default,) {final _that = this;
switch (_that) {
case _PersonDto() when $default != null:
return $default(_that.id,_that.name,_that.honorific,_that.review,_that.gender);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonDto implements PersonDto {
  const _PersonDto({required this.id, required this.name, required this.honorific, required this.review, this.gender});
  factory _PersonDto.fromJson(Map<String, dynamic> json) => _$PersonDtoFromJson(json);

@override final  String id;
@override final  LocalizedTextDto name;
@override final  PersonHonorific honorific;
@override final  ReviewDto review;
@override final  Gender? gender;

/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonDtoCopyWith<_PersonDto> get copyWith => __$PersonDtoCopyWithImpl<_PersonDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.honorific, honorific) || other.honorific == honorific)&&(identical(other.review, review) || other.review == review)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,honorific,review,gender);

@override
String toString() {
  return 'PersonDto(id: $id, name: $name, honorific: $honorific, review: $review, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$PersonDtoCopyWith<$Res> implements $PersonDtoCopyWith<$Res> {
  factory _$PersonDtoCopyWith(_PersonDto value, $Res Function(_PersonDto) _then) = __$PersonDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedTextDto name, PersonHonorific honorific, ReviewDto review, Gender? gender
});


@override $LocalizedTextDtoCopyWith<$Res> get name;@override $ReviewDtoCopyWith<$Res> get review;

}
/// @nodoc
class __$PersonDtoCopyWithImpl<$Res>
    implements _$PersonDtoCopyWith<$Res> {
  __$PersonDtoCopyWithImpl(this._self, this._then);

  final _PersonDto _self;
  final $Res Function(_PersonDto) _then;

/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? honorific = null,Object? review = null,Object? gender = freezed,}) {
  return _then(_PersonDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedTextDto,honorific: null == honorific ? _self.honorific : honorific // ignore: cast_nullable_to_non_nullable
as PersonHonorific,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewDto,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,
  ));
}

/// Create a copy of PersonDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextDtoCopyWith<$Res> get name {
  
  return $LocalizedTextDtoCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of PersonDto
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
mixin _$CategoriesFileDto {

 int get schemaVersion; List<CategoryDto> get categories;
/// Create a copy of CategoriesFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesFileDtoCopyWith<CategoriesFileDto> get copyWith => _$CategoriesFileDtoCopyWithImpl<CategoriesFileDto>(this as CategoriesFileDto, _$identity);

  /// Serializes this CategoriesFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.categories, categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(categories));

@override
String toString() {
  return 'CategoriesFileDto(schemaVersion: $schemaVersion, categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoriesFileDtoCopyWith<$Res>  {
  factory $CategoriesFileDtoCopyWith(CategoriesFileDto value, $Res Function(CategoriesFileDto) _then) = _$CategoriesFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<CategoryDto> categories
});




}
/// @nodoc
class _$CategoriesFileDtoCopyWithImpl<$Res>
    implements $CategoriesFileDtoCopyWith<$Res> {
  _$CategoriesFileDtoCopyWithImpl(this._self, this._then);

  final CategoriesFileDto _self;
  final $Res Function(CategoriesFileDto) _then;

/// Create a copy of CategoriesFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? categories = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoriesFileDto].
extension CategoriesFileDtoPatterns on CategoriesFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoriesFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoriesFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoriesFileDto value)  $default,){
final _that = this;
switch (_that) {
case _CategoriesFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoriesFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _CategoriesFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<CategoryDto> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoriesFileDto() when $default != null:
return $default(_that.schemaVersion,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<CategoryDto> categories)  $default,) {final _that = this;
switch (_that) {
case _CategoriesFileDto():
return $default(_that.schemaVersion,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<CategoryDto> categories)?  $default,) {final _that = this;
switch (_that) {
case _CategoriesFileDto() when $default != null:
return $default(_that.schemaVersion,_that.categories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoriesFileDto implements CategoriesFileDto {
  const _CategoriesFileDto({required this.schemaVersion, required final  List<CategoryDto> categories}): _categories = categories;
  factory _CategoriesFileDto.fromJson(Map<String, dynamic> json) => _$CategoriesFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<CategoryDto> _categories;
@override List<CategoryDto> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategoriesFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoriesFileDtoCopyWith<_CategoriesFileDto> get copyWith => __$CategoriesFileDtoCopyWithImpl<_CategoriesFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoriesFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoriesFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._categories, _categories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategoriesFileDto(schemaVersion: $schemaVersion, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$CategoriesFileDtoCopyWith<$Res> implements $CategoriesFileDtoCopyWith<$Res> {
  factory _$CategoriesFileDtoCopyWith(_CategoriesFileDto value, $Res Function(_CategoriesFileDto) _then) = __$CategoriesFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<CategoryDto> categories
});




}
/// @nodoc
class __$CategoriesFileDtoCopyWithImpl<$Res>
    implements _$CategoriesFileDtoCopyWith<$Res> {
  __$CategoriesFileDtoCopyWithImpl(this._self, this._then);

  final _CategoriesFileDto _self;
  final $Res Function(_CategoriesFileDto) _then;

/// Create a copy of CategoriesFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? categories = null,}) {
  return _then(_CategoriesFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryDto>,
  ));
}


}


/// @nodoc
mixin _$EventsFileDto {

 int get schemaVersion; List<HistoricalEventDto> get events;
/// Create a copy of EventsFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventsFileDtoCopyWith<EventsFileDto> get copyWith => _$EventsFileDtoCopyWithImpl<EventsFileDto>(this as EventsFileDto, _$identity);

  /// Serializes this EventsFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventsFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.events, events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(events));

@override
String toString() {
  return 'EventsFileDto(schemaVersion: $schemaVersion, events: $events)';
}


}

/// @nodoc
abstract mixin class $EventsFileDtoCopyWith<$Res>  {
  factory $EventsFileDtoCopyWith(EventsFileDto value, $Res Function(EventsFileDto) _then) = _$EventsFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<HistoricalEventDto> events
});




}
/// @nodoc
class _$EventsFileDtoCopyWithImpl<$Res>
    implements $EventsFileDtoCopyWith<$Res> {
  _$EventsFileDtoCopyWithImpl(this._self, this._then);

  final EventsFileDto _self;
  final $Res Function(EventsFileDto) _then;

/// Create a copy of EventsFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? events = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<HistoricalEventDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventsFileDto].
extension EventsFileDtoPatterns on EventsFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventsFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventsFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventsFileDto value)  $default,){
final _that = this;
switch (_that) {
case _EventsFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventsFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _EventsFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<HistoricalEventDto> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventsFileDto() when $default != null:
return $default(_that.schemaVersion,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<HistoricalEventDto> events)  $default,) {final _that = this;
switch (_that) {
case _EventsFileDto():
return $default(_that.schemaVersion,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<HistoricalEventDto> events)?  $default,) {final _that = this;
switch (_that) {
case _EventsFileDto() when $default != null:
return $default(_that.schemaVersion,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventsFileDto implements EventsFileDto {
  const _EventsFileDto({required this.schemaVersion, required final  List<HistoricalEventDto> events}): _events = events;
  factory _EventsFileDto.fromJson(Map<String, dynamic> json) => _$EventsFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<HistoricalEventDto> _events;
@override List<HistoricalEventDto> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of EventsFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventsFileDtoCopyWith<_EventsFileDto> get copyWith => __$EventsFileDtoCopyWithImpl<_EventsFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventsFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventsFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_events));

@override
String toString() {
  return 'EventsFileDto(schemaVersion: $schemaVersion, events: $events)';
}


}

/// @nodoc
abstract mixin class _$EventsFileDtoCopyWith<$Res> implements $EventsFileDtoCopyWith<$Res> {
  factory _$EventsFileDtoCopyWith(_EventsFileDto value, $Res Function(_EventsFileDto) _then) = __$EventsFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<HistoricalEventDto> events
});




}
/// @nodoc
class __$EventsFileDtoCopyWithImpl<$Res>
    implements _$EventsFileDtoCopyWith<$Res> {
  __$EventsFileDtoCopyWithImpl(this._self, this._then);

  final _EventsFileDto _self;
  final $Res Function(_EventsFileDto) _then;

/// Create a copy of EventsFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? events = null,}) {
  return _then(_EventsFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<HistoricalEventDto>,
  ));
}


}


/// @nodoc
mixin _$SourcesFileDto {

 int get schemaVersion; List<SourceReferenceDto> get sources;
/// Create a copy of SourcesFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourcesFileDtoCopyWith<SourcesFileDto> get copyWith => _$SourcesFileDtoCopyWithImpl<SourcesFileDto>(this as SourcesFileDto, _$identity);

  /// Serializes this SourcesFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourcesFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.sources, sources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(sources));

@override
String toString() {
  return 'SourcesFileDto(schemaVersion: $schemaVersion, sources: $sources)';
}


}

/// @nodoc
abstract mixin class $SourcesFileDtoCopyWith<$Res>  {
  factory $SourcesFileDtoCopyWith(SourcesFileDto value, $Res Function(SourcesFileDto) _then) = _$SourcesFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<SourceReferenceDto> sources
});




}
/// @nodoc
class _$SourcesFileDtoCopyWithImpl<$Res>
    implements $SourcesFileDtoCopyWith<$Res> {
  _$SourcesFileDtoCopyWithImpl(this._self, this._then);

  final SourcesFileDto _self;
  final $Res Function(SourcesFileDto) _then;

/// Create a copy of SourcesFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? sources = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,sources: null == sources ? _self.sources : sources // ignore: cast_nullable_to_non_nullable
as List<SourceReferenceDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [SourcesFileDto].
extension SourcesFileDtoPatterns on SourcesFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SourcesFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SourcesFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SourcesFileDto value)  $default,){
final _that = this;
switch (_that) {
case _SourcesFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SourcesFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _SourcesFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<SourceReferenceDto> sources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SourcesFileDto() when $default != null:
return $default(_that.schemaVersion,_that.sources);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<SourceReferenceDto> sources)  $default,) {final _that = this;
switch (_that) {
case _SourcesFileDto():
return $default(_that.schemaVersion,_that.sources);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<SourceReferenceDto> sources)?  $default,) {final _that = this;
switch (_that) {
case _SourcesFileDto() when $default != null:
return $default(_that.schemaVersion,_that.sources);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SourcesFileDto implements SourcesFileDto {
  const _SourcesFileDto({required this.schemaVersion, required final  List<SourceReferenceDto> sources}): _sources = sources;
  factory _SourcesFileDto.fromJson(Map<String, dynamic> json) => _$SourcesFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<SourceReferenceDto> _sources;
@override List<SourceReferenceDto> get sources {
  if (_sources is EqualUnmodifiableListView) return _sources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sources);
}


/// Create a copy of SourcesFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourcesFileDtoCopyWith<_SourcesFileDto> get copyWith => __$SourcesFileDtoCopyWithImpl<_SourcesFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SourcesFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourcesFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._sources, _sources));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_sources));

@override
String toString() {
  return 'SourcesFileDto(schemaVersion: $schemaVersion, sources: $sources)';
}


}

/// @nodoc
abstract mixin class _$SourcesFileDtoCopyWith<$Res> implements $SourcesFileDtoCopyWith<$Res> {
  factory _$SourcesFileDtoCopyWith(_SourcesFileDto value, $Res Function(_SourcesFileDto) _then) = __$SourcesFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<SourceReferenceDto> sources
});




}
/// @nodoc
class __$SourcesFileDtoCopyWithImpl<$Res>
    implements _$SourcesFileDtoCopyWith<$Res> {
  __$SourcesFileDtoCopyWithImpl(this._self, this._then);

  final _SourcesFileDto _self;
  final $Res Function(_SourcesFileDto) _then;

/// Create a copy of SourcesFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? sources = null,}) {
  return _then(_SourcesFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,sources: null == sources ? _self._sources : sources // ignore: cast_nullable_to_non_nullable
as List<SourceReferenceDto>,
  ));
}


}


/// @nodoc
mixin _$PeopleFileDto {

 int get schemaVersion; List<PersonDto> get people;
/// Create a copy of PeopleFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeopleFileDtoCopyWith<PeopleFileDto> get copyWith => _$PeopleFileDtoCopyWithImpl<PeopleFileDto>(this as PeopleFileDto, _$identity);

  /// Serializes this PeopleFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeopleFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.people, people));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(people));

@override
String toString() {
  return 'PeopleFileDto(schemaVersion: $schemaVersion, people: $people)';
}


}

/// @nodoc
abstract mixin class $PeopleFileDtoCopyWith<$Res>  {
  factory $PeopleFileDtoCopyWith(PeopleFileDto value, $Res Function(PeopleFileDto) _then) = _$PeopleFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<PersonDto> people
});




}
/// @nodoc
class _$PeopleFileDtoCopyWithImpl<$Res>
    implements $PeopleFileDtoCopyWith<$Res> {
  _$PeopleFileDtoCopyWithImpl(this._self, this._then);

  final PeopleFileDto _self;
  final $Res Function(PeopleFileDto) _then;

/// Create a copy of PeopleFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? people = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as List<PersonDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [PeopleFileDto].
extension PeopleFileDtoPatterns on PeopleFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeopleFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeopleFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeopleFileDto value)  $default,){
final _that = this;
switch (_that) {
case _PeopleFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeopleFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _PeopleFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<PersonDto> people)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeopleFileDto() when $default != null:
return $default(_that.schemaVersion,_that.people);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<PersonDto> people)  $default,) {final _that = this;
switch (_that) {
case _PeopleFileDto():
return $default(_that.schemaVersion,_that.people);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<PersonDto> people)?  $default,) {final _that = this;
switch (_that) {
case _PeopleFileDto() when $default != null:
return $default(_that.schemaVersion,_that.people);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeopleFileDto implements PeopleFileDto {
  const _PeopleFileDto({required this.schemaVersion, required final  List<PersonDto> people}): _people = people;
  factory _PeopleFileDto.fromJson(Map<String, dynamic> json) => _$PeopleFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<PersonDto> _people;
@override List<PersonDto> get people {
  if (_people is EqualUnmodifiableListView) return _people;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_people);
}


/// Create a copy of PeopleFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeopleFileDtoCopyWith<_PeopleFileDto> get copyWith => __$PeopleFileDtoCopyWithImpl<_PeopleFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeopleFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeopleFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._people, _people));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_people));

@override
String toString() {
  return 'PeopleFileDto(schemaVersion: $schemaVersion, people: $people)';
}


}

/// @nodoc
abstract mixin class _$PeopleFileDtoCopyWith<$Res> implements $PeopleFileDtoCopyWith<$Res> {
  factory _$PeopleFileDtoCopyWith(_PeopleFileDto value, $Res Function(_PeopleFileDto) _then) = __$PeopleFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<PersonDto> people
});




}
/// @nodoc
class __$PeopleFileDtoCopyWithImpl<$Res>
    implements _$PeopleFileDtoCopyWith<$Res> {
  __$PeopleFileDtoCopyWithImpl(this._self, this._then);

  final _PeopleFileDto _self;
  final $Res Function(_PeopleFileDto) _then;

/// Create a copy of PeopleFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? people = null,}) {
  return _then(_PeopleFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self._people : people // ignore: cast_nullable_to_non_nullable
as List<PersonDto>,
  ));
}


}


/// @nodoc
mixin _$ContentMetaDto {

 int get schemaVersion; String get contentVersion;
/// Create a copy of ContentMetaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentMetaDtoCopyWith<ContentMetaDto> get copyWith => _$ContentMetaDtoCopyWithImpl<ContentMetaDto>(this as ContentMetaDto, _$identity);

  /// Serializes this ContentMetaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentMetaDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,contentVersion);

@override
String toString() {
  return 'ContentMetaDto(schemaVersion: $schemaVersion, contentVersion: $contentVersion)';
}


}

/// @nodoc
abstract mixin class $ContentMetaDtoCopyWith<$Res>  {
  factory $ContentMetaDtoCopyWith(ContentMetaDto value, $Res Function(ContentMetaDto) _then) = _$ContentMetaDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String contentVersion
});




}
/// @nodoc
class _$ContentMetaDtoCopyWithImpl<$Res>
    implements $ContentMetaDtoCopyWith<$Res> {
  _$ContentMetaDtoCopyWithImpl(this._self, this._then);

  final ContentMetaDto _self;
  final $Res Function(ContentMetaDto) _then;

/// Create a copy of ContentMetaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? contentVersion = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentMetaDto].
extension ContentMetaDtoPatterns on ContentMetaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentMetaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentMetaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentMetaDto value)  $default,){
final _that = this;
switch (_that) {
case _ContentMetaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentMetaDto value)?  $default,){
final _that = this;
switch (_that) {
case _ContentMetaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String contentVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentMetaDto() when $default != null:
return $default(_that.schemaVersion,_that.contentVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String contentVersion)  $default,) {final _that = this;
switch (_that) {
case _ContentMetaDto():
return $default(_that.schemaVersion,_that.contentVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String contentVersion)?  $default,) {final _that = this;
switch (_that) {
case _ContentMetaDto() when $default != null:
return $default(_that.schemaVersion,_that.contentVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentMetaDto implements ContentMetaDto {
  const _ContentMetaDto({required this.schemaVersion, required this.contentVersion});
  factory _ContentMetaDto.fromJson(Map<String, dynamic> json) => _$ContentMetaDtoFromJson(json);

@override final  int schemaVersion;
@override final  String contentVersion;

/// Create a copy of ContentMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentMetaDtoCopyWith<_ContentMetaDto> get copyWith => __$ContentMetaDtoCopyWithImpl<_ContentMetaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentMetaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentMetaDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,contentVersion);

@override
String toString() {
  return 'ContentMetaDto(schemaVersion: $schemaVersion, contentVersion: $contentVersion)';
}


}

/// @nodoc
abstract mixin class _$ContentMetaDtoCopyWith<$Res> implements $ContentMetaDtoCopyWith<$Res> {
  factory _$ContentMetaDtoCopyWith(_ContentMetaDto value, $Res Function(_ContentMetaDto) _then) = __$ContentMetaDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String contentVersion
});




}
/// @nodoc
class __$ContentMetaDtoCopyWithImpl<$Res>
    implements _$ContentMetaDtoCopyWith<$Res> {
  __$ContentMetaDtoCopyWithImpl(this._self, this._then);

  final _ContentMetaDto _self;
  final $Res Function(_ContentMetaDto) _then;

/// Create a copy of ContentMetaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? contentVersion = null,}) {
  return _then(_ContentMetaDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ManifestDto {

 int get schemaVersion; String get contentVersion; ContentChannel get channel; int get companionCount; int get storyCount; int get approvedCount; int get unapprovedCount;/// Published path → SHA-256 of its bytes.
 Map<String, String> get files;
/// Create a copy of ManifestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManifestDtoCopyWith<ManifestDto> get copyWith => _$ManifestDtoCopyWithImpl<ManifestDto>(this as ManifestDto, _$identity);

  /// Serializes this ManifestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManifestDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.companionCount, companionCount) || other.companionCount == companionCount)&&(identical(other.storyCount, storyCount) || other.storyCount == storyCount)&&(identical(other.approvedCount, approvedCount) || other.approvedCount == approvedCount)&&(identical(other.unapprovedCount, unapprovedCount) || other.unapprovedCount == unapprovedCount)&&const DeepCollectionEquality().equals(other.files, files));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,contentVersion,channel,companionCount,storyCount,approvedCount,unapprovedCount,const DeepCollectionEquality().hash(files));

@override
String toString() {
  return 'ManifestDto(schemaVersion: $schemaVersion, contentVersion: $contentVersion, channel: $channel, companionCount: $companionCount, storyCount: $storyCount, approvedCount: $approvedCount, unapprovedCount: $unapprovedCount, files: $files)';
}


}

/// @nodoc
abstract mixin class $ManifestDtoCopyWith<$Res>  {
  factory $ManifestDtoCopyWith(ManifestDto value, $Res Function(ManifestDto) _then) = _$ManifestDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, String contentVersion, ContentChannel channel, int companionCount, int storyCount, int approvedCount, int unapprovedCount, Map<String, String> files
});




}
/// @nodoc
class _$ManifestDtoCopyWithImpl<$Res>
    implements $ManifestDtoCopyWith<$Res> {
  _$ManifestDtoCopyWithImpl(this._self, this._then);

  final ManifestDto _self;
  final $Res Function(ManifestDto) _then;

/// Create a copy of ManifestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? contentVersion = null,Object? channel = null,Object? companionCount = null,Object? storyCount = null,Object? approvedCount = null,Object? unapprovedCount = null,Object? files = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ContentChannel,companionCount: null == companionCount ? _self.companionCount : companionCount // ignore: cast_nullable_to_non_nullable
as int,storyCount: null == storyCount ? _self.storyCount : storyCount // ignore: cast_nullable_to_non_nullable
as int,approvedCount: null == approvedCount ? _self.approvedCount : approvedCount // ignore: cast_nullable_to_non_nullable
as int,unapprovedCount: null == unapprovedCount ? _self.unapprovedCount : unapprovedCount // ignore: cast_nullable_to_non_nullable
as int,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ManifestDto].
extension ManifestDtoPatterns on ManifestDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManifestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManifestDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManifestDto value)  $default,){
final _that = this;
switch (_that) {
case _ManifestDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManifestDto value)?  $default,){
final _that = this;
switch (_that) {
case _ManifestDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String contentVersion,  ContentChannel channel,  int companionCount,  int storyCount,  int approvedCount,  int unapprovedCount,  Map<String, String> files)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManifestDto() when $default != null:
return $default(_that.schemaVersion,_that.contentVersion,_that.channel,_that.companionCount,_that.storyCount,_that.approvedCount,_that.unapprovedCount,_that.files);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String contentVersion,  ContentChannel channel,  int companionCount,  int storyCount,  int approvedCount,  int unapprovedCount,  Map<String, String> files)  $default,) {final _that = this;
switch (_that) {
case _ManifestDto():
return $default(_that.schemaVersion,_that.contentVersion,_that.channel,_that.companionCount,_that.storyCount,_that.approvedCount,_that.unapprovedCount,_that.files);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String contentVersion,  ContentChannel channel,  int companionCount,  int storyCount,  int approvedCount,  int unapprovedCount,  Map<String, String> files)?  $default,) {final _that = this;
switch (_that) {
case _ManifestDto() when $default != null:
return $default(_that.schemaVersion,_that.contentVersion,_that.channel,_that.companionCount,_that.storyCount,_that.approvedCount,_that.unapprovedCount,_that.files);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ManifestDto implements ManifestDto {
  const _ManifestDto({required this.schemaVersion, required this.contentVersion, required this.channel, required this.companionCount, required this.storyCount, required this.approvedCount, required this.unapprovedCount, required final  Map<String, String> files}): _files = files;
  factory _ManifestDto.fromJson(Map<String, dynamic> json) => _$ManifestDtoFromJson(json);

@override final  int schemaVersion;
@override final  String contentVersion;
@override final  ContentChannel channel;
@override final  int companionCount;
@override final  int storyCount;
@override final  int approvedCount;
@override final  int unapprovedCount;
/// Published path → SHA-256 of its bytes.
 final  Map<String, String> _files;
/// Published path → SHA-256 of its bytes.
@override Map<String, String> get files {
  if (_files is EqualUnmodifiableMapView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_files);
}


/// Create a copy of ManifestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManifestDtoCopyWith<_ManifestDto> get copyWith => __$ManifestDtoCopyWithImpl<_ManifestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManifestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManifestDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.contentVersion, contentVersion) || other.contentVersion == contentVersion)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.companionCount, companionCount) || other.companionCount == companionCount)&&(identical(other.storyCount, storyCount) || other.storyCount == storyCount)&&(identical(other.approvedCount, approvedCount) || other.approvedCount == approvedCount)&&(identical(other.unapprovedCount, unapprovedCount) || other.unapprovedCount == unapprovedCount)&&const DeepCollectionEquality().equals(other._files, _files));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,contentVersion,channel,companionCount,storyCount,approvedCount,unapprovedCount,const DeepCollectionEquality().hash(_files));

@override
String toString() {
  return 'ManifestDto(schemaVersion: $schemaVersion, contentVersion: $contentVersion, channel: $channel, companionCount: $companionCount, storyCount: $storyCount, approvedCount: $approvedCount, unapprovedCount: $unapprovedCount, files: $files)';
}


}

/// @nodoc
abstract mixin class _$ManifestDtoCopyWith<$Res> implements $ManifestDtoCopyWith<$Res> {
  factory _$ManifestDtoCopyWith(_ManifestDto value, $Res Function(_ManifestDto) _then) = __$ManifestDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, String contentVersion, ContentChannel channel, int companionCount, int storyCount, int approvedCount, int unapprovedCount, Map<String, String> files
});




}
/// @nodoc
class __$ManifestDtoCopyWithImpl<$Res>
    implements _$ManifestDtoCopyWith<$Res> {
  __$ManifestDtoCopyWithImpl(this._self, this._then);

  final _ManifestDto _self;
  final $Res Function(_ManifestDto) _then;

/// Create a copy of ManifestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? contentVersion = null,Object? channel = null,Object? companionCount = null,Object? storyCount = null,Object? approvedCount = null,Object? unapprovedCount = null,Object? files = null,}) {
  return _then(_ManifestDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,contentVersion: null == contentVersion ? _self.contentVersion : contentVersion // ignore: cast_nullable_to_non_nullable
as String,channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as ContentChannel,companionCount: null == companionCount ? _self.companionCount : companionCount // ignore: cast_nullable_to_non_nullable
as int,storyCount: null == storyCount ? _self.storyCount : storyCount // ignore: cast_nullable_to_non_nullable
as int,approvedCount: null == approvedCount ? _self.approvedCount : approvedCount // ignore: cast_nullable_to_non_nullable
as int,unapprovedCount: null == unapprovedCount ? _self.unapprovedCount : unapprovedCount // ignore: cast_nullable_to_non_nullable
as int,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}


/// @nodoc
mixin _$ReviewerDto {

 String get id; String get name; String get qualification; String get addedAt;
/// Create a copy of ReviewerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewerDtoCopyWith<ReviewerDto> get copyWith => _$ReviewerDtoCopyWithImpl<ReviewerDto>(this as ReviewerDto, _$identity);

  /// Serializes this ReviewerDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.qualification, qualification) || other.qualification == qualification)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,qualification,addedAt);

@override
String toString() {
  return 'ReviewerDto(id: $id, name: $name, qualification: $qualification, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class $ReviewerDtoCopyWith<$Res>  {
  factory $ReviewerDtoCopyWith(ReviewerDto value, $Res Function(ReviewerDto) _then) = _$ReviewerDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String qualification, String addedAt
});




}
/// @nodoc
class _$ReviewerDtoCopyWithImpl<$Res>
    implements $ReviewerDtoCopyWith<$Res> {
  _$ReviewerDtoCopyWithImpl(this._self, this._then);

  final ReviewerDto _self;
  final $Res Function(ReviewerDto) _then;

/// Create a copy of ReviewerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? qualification = null,Object? addedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,qualification: null == qualification ? _self.qualification : qualification // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewerDto].
extension ReviewerDtoPatterns on ReviewerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewerDto value)  $default,){
final _that = this;
switch (_that) {
case _ReviewerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewerDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String qualification,  String addedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewerDto() when $default != null:
return $default(_that.id,_that.name,_that.qualification,_that.addedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String qualification,  String addedAt)  $default,) {final _that = this;
switch (_that) {
case _ReviewerDto():
return $default(_that.id,_that.name,_that.qualification,_that.addedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String qualification,  String addedAt)?  $default,) {final _that = this;
switch (_that) {
case _ReviewerDto() when $default != null:
return $default(_that.id,_that.name,_that.qualification,_that.addedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewerDto implements ReviewerDto {
  const _ReviewerDto({required this.id, required this.name, required this.qualification, required this.addedAt});
  factory _ReviewerDto.fromJson(Map<String, dynamic> json) => _$ReviewerDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String qualification;
@override final  String addedAt;

/// Create a copy of ReviewerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewerDtoCopyWith<_ReviewerDto> get copyWith => __$ReviewerDtoCopyWithImpl<_ReviewerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewerDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.qualification, qualification) || other.qualification == qualification)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,qualification,addedAt);

@override
String toString() {
  return 'ReviewerDto(id: $id, name: $name, qualification: $qualification, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class _$ReviewerDtoCopyWith<$Res> implements $ReviewerDtoCopyWith<$Res> {
  factory _$ReviewerDtoCopyWith(_ReviewerDto value, $Res Function(_ReviewerDto) _then) = __$ReviewerDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String qualification, String addedAt
});




}
/// @nodoc
class __$ReviewerDtoCopyWithImpl<$Res>
    implements _$ReviewerDtoCopyWith<$Res> {
  __$ReviewerDtoCopyWithImpl(this._self, this._then);

  final _ReviewerDto _self;
  final $Res Function(_ReviewerDto) _then;

/// Create a copy of ReviewerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? qualification = null,Object? addedAt = null,}) {
  return _then(_ReviewerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,qualification: null == qualification ? _self.qualification : qualification // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ReviewersFileDto {

 int get schemaVersion; List<ReviewerDto> get reviewers;
/// Create a copy of ReviewersFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewersFileDtoCopyWith<ReviewersFileDto> get copyWith => _$ReviewersFileDtoCopyWithImpl<ReviewersFileDto>(this as ReviewersFileDto, _$identity);

  /// Serializes this ReviewersFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewersFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.reviewers, reviewers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(reviewers));

@override
String toString() {
  return 'ReviewersFileDto(schemaVersion: $schemaVersion, reviewers: $reviewers)';
}


}

/// @nodoc
abstract mixin class $ReviewersFileDtoCopyWith<$Res>  {
  factory $ReviewersFileDtoCopyWith(ReviewersFileDto value, $Res Function(ReviewersFileDto) _then) = _$ReviewersFileDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, List<ReviewerDto> reviewers
});




}
/// @nodoc
class _$ReviewersFileDtoCopyWithImpl<$Res>
    implements $ReviewersFileDtoCopyWith<$Res> {
  _$ReviewersFileDtoCopyWithImpl(this._self, this._then);

  final ReviewersFileDto _self;
  final $Res Function(ReviewersFileDto) _then;

/// Create a copy of ReviewersFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? reviewers = null,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,reviewers: null == reviewers ? _self.reviewers : reviewers // ignore: cast_nullable_to_non_nullable
as List<ReviewerDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewersFileDto].
extension ReviewersFileDtoPatterns on ReviewersFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewersFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewersFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewersFileDto value)  $default,){
final _that = this;
switch (_that) {
case _ReviewersFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewersFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewersFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  List<ReviewerDto> reviewers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewersFileDto() when $default != null:
return $default(_that.schemaVersion,_that.reviewers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  List<ReviewerDto> reviewers)  $default,) {final _that = this;
switch (_that) {
case _ReviewersFileDto():
return $default(_that.schemaVersion,_that.reviewers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  List<ReviewerDto> reviewers)?  $default,) {final _that = this;
switch (_that) {
case _ReviewersFileDto() when $default != null:
return $default(_that.schemaVersion,_that.reviewers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewersFileDto implements ReviewersFileDto {
  const _ReviewersFileDto({required this.schemaVersion, required final  List<ReviewerDto> reviewers}): _reviewers = reviewers;
  factory _ReviewersFileDto.fromJson(Map<String, dynamic> json) => _$ReviewersFileDtoFromJson(json);

@override final  int schemaVersion;
 final  List<ReviewerDto> _reviewers;
@override List<ReviewerDto> get reviewers {
  if (_reviewers is EqualUnmodifiableListView) return _reviewers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviewers);
}


/// Create a copy of ReviewersFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewersFileDtoCopyWith<_ReviewersFileDto> get copyWith => __$ReviewersFileDtoCopyWithImpl<_ReviewersFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewersFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewersFileDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._reviewers, _reviewers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,const DeepCollectionEquality().hash(_reviewers));

@override
String toString() {
  return 'ReviewersFileDto(schemaVersion: $schemaVersion, reviewers: $reviewers)';
}


}

/// @nodoc
abstract mixin class _$ReviewersFileDtoCopyWith<$Res> implements $ReviewersFileDtoCopyWith<$Res> {
  factory _$ReviewersFileDtoCopyWith(_ReviewersFileDto value, $Res Function(_ReviewersFileDto) _then) = __$ReviewersFileDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, List<ReviewerDto> reviewers
});




}
/// @nodoc
class __$ReviewersFileDtoCopyWithImpl<$Res>
    implements _$ReviewersFileDtoCopyWith<$Res> {
  __$ReviewersFileDtoCopyWithImpl(this._self, this._then);

  final _ReviewersFileDto _self;
  final $Res Function(_ReviewersFileDto) _then;

/// Create a copy of ReviewersFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? reviewers = null,}) {
  return _then(_ReviewersFileDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,reviewers: null == reviewers ? _self._reviewers : reviewers // ignore: cast_nullable_to_non_nullable
as List<ReviewerDto>,
  ));
}


}


/// @nodoc
mixin _$ApprovalChecklistDto {

 bool get sourcesMatch; bool get gradingsCorrect; bool get noEmbellishment; bool get reliabilityCorrect; bool get honorificsCorrect;/// Required for items flagged fitnaAdjacent.
 bool get fitnaSignOff;
/// Create a copy of ApprovalChecklistDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalChecklistDtoCopyWith<ApprovalChecklistDto> get copyWith => _$ApprovalChecklistDtoCopyWithImpl<ApprovalChecklistDto>(this as ApprovalChecklistDto, _$identity);

  /// Serializes this ApprovalChecklistDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalChecklistDto&&(identical(other.sourcesMatch, sourcesMatch) || other.sourcesMatch == sourcesMatch)&&(identical(other.gradingsCorrect, gradingsCorrect) || other.gradingsCorrect == gradingsCorrect)&&(identical(other.noEmbellishment, noEmbellishment) || other.noEmbellishment == noEmbellishment)&&(identical(other.reliabilityCorrect, reliabilityCorrect) || other.reliabilityCorrect == reliabilityCorrect)&&(identical(other.honorificsCorrect, honorificsCorrect) || other.honorificsCorrect == honorificsCorrect)&&(identical(other.fitnaSignOff, fitnaSignOff) || other.fitnaSignOff == fitnaSignOff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourcesMatch,gradingsCorrect,noEmbellishment,reliabilityCorrect,honorificsCorrect,fitnaSignOff);

@override
String toString() {
  return 'ApprovalChecklistDto(sourcesMatch: $sourcesMatch, gradingsCorrect: $gradingsCorrect, noEmbellishment: $noEmbellishment, reliabilityCorrect: $reliabilityCorrect, honorificsCorrect: $honorificsCorrect, fitnaSignOff: $fitnaSignOff)';
}


}

/// @nodoc
abstract mixin class $ApprovalChecklistDtoCopyWith<$Res>  {
  factory $ApprovalChecklistDtoCopyWith(ApprovalChecklistDto value, $Res Function(ApprovalChecklistDto) _then) = _$ApprovalChecklistDtoCopyWithImpl;
@useResult
$Res call({
 bool sourcesMatch, bool gradingsCorrect, bool noEmbellishment, bool reliabilityCorrect, bool honorificsCorrect, bool fitnaSignOff
});




}
/// @nodoc
class _$ApprovalChecklistDtoCopyWithImpl<$Res>
    implements $ApprovalChecklistDtoCopyWith<$Res> {
  _$ApprovalChecklistDtoCopyWithImpl(this._self, this._then);

  final ApprovalChecklistDto _self;
  final $Res Function(ApprovalChecklistDto) _then;

/// Create a copy of ApprovalChecklistDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourcesMatch = null,Object? gradingsCorrect = null,Object? noEmbellishment = null,Object? reliabilityCorrect = null,Object? honorificsCorrect = null,Object? fitnaSignOff = null,}) {
  return _then(_self.copyWith(
sourcesMatch: null == sourcesMatch ? _self.sourcesMatch : sourcesMatch // ignore: cast_nullable_to_non_nullable
as bool,gradingsCorrect: null == gradingsCorrect ? _self.gradingsCorrect : gradingsCorrect // ignore: cast_nullable_to_non_nullable
as bool,noEmbellishment: null == noEmbellishment ? _self.noEmbellishment : noEmbellishment // ignore: cast_nullable_to_non_nullable
as bool,reliabilityCorrect: null == reliabilityCorrect ? _self.reliabilityCorrect : reliabilityCorrect // ignore: cast_nullable_to_non_nullable
as bool,honorificsCorrect: null == honorificsCorrect ? _self.honorificsCorrect : honorificsCorrect // ignore: cast_nullable_to_non_nullable
as bool,fitnaSignOff: null == fitnaSignOff ? _self.fitnaSignOff : fitnaSignOff // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApprovalChecklistDto].
extension ApprovalChecklistDtoPatterns on ApprovalChecklistDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalChecklistDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalChecklistDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalChecklistDto value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalChecklistDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalChecklistDto value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalChecklistDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool sourcesMatch,  bool gradingsCorrect,  bool noEmbellishment,  bool reliabilityCorrect,  bool honorificsCorrect,  bool fitnaSignOff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalChecklistDto() when $default != null:
return $default(_that.sourcesMatch,_that.gradingsCorrect,_that.noEmbellishment,_that.reliabilityCorrect,_that.honorificsCorrect,_that.fitnaSignOff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool sourcesMatch,  bool gradingsCorrect,  bool noEmbellishment,  bool reliabilityCorrect,  bool honorificsCorrect,  bool fitnaSignOff)  $default,) {final _that = this;
switch (_that) {
case _ApprovalChecklistDto():
return $default(_that.sourcesMatch,_that.gradingsCorrect,_that.noEmbellishment,_that.reliabilityCorrect,_that.honorificsCorrect,_that.fitnaSignOff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool sourcesMatch,  bool gradingsCorrect,  bool noEmbellishment,  bool reliabilityCorrect,  bool honorificsCorrect,  bool fitnaSignOff)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalChecklistDto() when $default != null:
return $default(_that.sourcesMatch,_that.gradingsCorrect,_that.noEmbellishment,_that.reliabilityCorrect,_that.honorificsCorrect,_that.fitnaSignOff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApprovalChecklistDto implements ApprovalChecklistDto {
  const _ApprovalChecklistDto({required this.sourcesMatch, required this.gradingsCorrect, required this.noEmbellishment, required this.reliabilityCorrect, required this.honorificsCorrect, this.fitnaSignOff = false});
  factory _ApprovalChecklistDto.fromJson(Map<String, dynamic> json) => _$ApprovalChecklistDtoFromJson(json);

@override final  bool sourcesMatch;
@override final  bool gradingsCorrect;
@override final  bool noEmbellishment;
@override final  bool reliabilityCorrect;
@override final  bool honorificsCorrect;
/// Required for items flagged fitnaAdjacent.
@override@JsonKey() final  bool fitnaSignOff;

/// Create a copy of ApprovalChecklistDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalChecklistDtoCopyWith<_ApprovalChecklistDto> get copyWith => __$ApprovalChecklistDtoCopyWithImpl<_ApprovalChecklistDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApprovalChecklistDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalChecklistDto&&(identical(other.sourcesMatch, sourcesMatch) || other.sourcesMatch == sourcesMatch)&&(identical(other.gradingsCorrect, gradingsCorrect) || other.gradingsCorrect == gradingsCorrect)&&(identical(other.noEmbellishment, noEmbellishment) || other.noEmbellishment == noEmbellishment)&&(identical(other.reliabilityCorrect, reliabilityCorrect) || other.reliabilityCorrect == reliabilityCorrect)&&(identical(other.honorificsCorrect, honorificsCorrect) || other.honorificsCorrect == honorificsCorrect)&&(identical(other.fitnaSignOff, fitnaSignOff) || other.fitnaSignOff == fitnaSignOff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourcesMatch,gradingsCorrect,noEmbellishment,reliabilityCorrect,honorificsCorrect,fitnaSignOff);

@override
String toString() {
  return 'ApprovalChecklistDto(sourcesMatch: $sourcesMatch, gradingsCorrect: $gradingsCorrect, noEmbellishment: $noEmbellishment, reliabilityCorrect: $reliabilityCorrect, honorificsCorrect: $honorificsCorrect, fitnaSignOff: $fitnaSignOff)';
}


}

/// @nodoc
abstract mixin class _$ApprovalChecklistDtoCopyWith<$Res> implements $ApprovalChecklistDtoCopyWith<$Res> {
  factory _$ApprovalChecklistDtoCopyWith(_ApprovalChecklistDto value, $Res Function(_ApprovalChecklistDto) _then) = __$ApprovalChecklistDtoCopyWithImpl;
@override @useResult
$Res call({
 bool sourcesMatch, bool gradingsCorrect, bool noEmbellishment, bool reliabilityCorrect, bool honorificsCorrect, bool fitnaSignOff
});




}
/// @nodoc
class __$ApprovalChecklistDtoCopyWithImpl<$Res>
    implements _$ApprovalChecklistDtoCopyWith<$Res> {
  __$ApprovalChecklistDtoCopyWithImpl(this._self, this._then);

  final _ApprovalChecklistDto _self;
  final $Res Function(_ApprovalChecklistDto) _then;

/// Create a copy of ApprovalChecklistDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourcesMatch = null,Object? gradingsCorrect = null,Object? noEmbellishment = null,Object? reliabilityCorrect = null,Object? honorificsCorrect = null,Object? fitnaSignOff = null,}) {
  return _then(_ApprovalChecklistDto(
sourcesMatch: null == sourcesMatch ? _self.sourcesMatch : sourcesMatch // ignore: cast_nullable_to_non_nullable
as bool,gradingsCorrect: null == gradingsCorrect ? _self.gradingsCorrect : gradingsCorrect // ignore: cast_nullable_to_non_nullable
as bool,noEmbellishment: null == noEmbellishment ? _self.noEmbellishment : noEmbellishment // ignore: cast_nullable_to_non_nullable
as bool,reliabilityCorrect: null == reliabilityCorrect ? _self.reliabilityCorrect : reliabilityCorrect // ignore: cast_nullable_to_non_nullable
as bool,honorificsCorrect: null == honorificsCorrect ? _self.honorificsCorrect : honorificsCorrect // ignore: cast_nullable_to_non_nullable
as bool,fitnaSignOff: null == fitnaSignOff ? _self.fitnaSignOff : fitnaSignOff // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ApprovalDto {

 int get schemaVersion; ContentKind get kind; String get id; String get reviewerId; String get approvedAt;/// SHA-256 of the reviewed item (see `tool/content_hash.dart`).
 String get contentHash; ApprovalChecklistDto get checklist; String? get notes;
/// Create a copy of ApprovalDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApprovalDtoCopyWith<ApprovalDto> get copyWith => _$ApprovalDtoCopyWithImpl<ApprovalDto>(this as ApprovalDto, _$identity);

  /// Serializes this ApprovalDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApprovalDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.checklist, checklist) || other.checklist == checklist)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,kind,id,reviewerId,approvedAt,contentHash,checklist,notes);

@override
String toString() {
  return 'ApprovalDto(schemaVersion: $schemaVersion, kind: $kind, id: $id, reviewerId: $reviewerId, approvedAt: $approvedAt, contentHash: $contentHash, checklist: $checklist, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $ApprovalDtoCopyWith<$Res>  {
  factory $ApprovalDtoCopyWith(ApprovalDto value, $Res Function(ApprovalDto) _then) = _$ApprovalDtoCopyWithImpl;
@useResult
$Res call({
 int schemaVersion, ContentKind kind, String id, String reviewerId, String approvedAt, String contentHash, ApprovalChecklistDto checklist, String? notes
});


$ApprovalChecklistDtoCopyWith<$Res> get checklist;

}
/// @nodoc
class _$ApprovalDtoCopyWithImpl<$Res>
    implements $ApprovalDtoCopyWith<$Res> {
  _$ApprovalDtoCopyWithImpl(this._self, this._then);

  final ApprovalDto _self;
  final $Res Function(ApprovalDto) _then;

/// Create a copy of ApprovalDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? schemaVersion = null,Object? kind = null,Object? id = null,Object? reviewerId = null,Object? approvedAt = null,Object? contentHash = null,Object? checklist = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ContentKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reviewerId: null == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String,approvedAt: null == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as String,contentHash: null == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as ApprovalChecklistDto,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ApprovalDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApprovalChecklistDtoCopyWith<$Res> get checklist {
  
  return $ApprovalChecklistDtoCopyWith<$Res>(_self.checklist, (value) {
    return _then(_self.copyWith(checklist: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApprovalDto].
extension ApprovalDtoPatterns on ApprovalDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApprovalDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApprovalDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApprovalDto value)  $default,){
final _that = this;
switch (_that) {
case _ApprovalDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApprovalDto value)?  $default,){
final _that = this;
switch (_that) {
case _ApprovalDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  ContentKind kind,  String id,  String reviewerId,  String approvedAt,  String contentHash,  ApprovalChecklistDto checklist,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApprovalDto() when $default != null:
return $default(_that.schemaVersion,_that.kind,_that.id,_that.reviewerId,_that.approvedAt,_that.contentHash,_that.checklist,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  ContentKind kind,  String id,  String reviewerId,  String approvedAt,  String contentHash,  ApprovalChecklistDto checklist,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ApprovalDto():
return $default(_that.schemaVersion,_that.kind,_that.id,_that.reviewerId,_that.approvedAt,_that.contentHash,_that.checklist,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  ContentKind kind,  String id,  String reviewerId,  String approvedAt,  String contentHash,  ApprovalChecklistDto checklist,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ApprovalDto() when $default != null:
return $default(_that.schemaVersion,_that.kind,_that.id,_that.reviewerId,_that.approvedAt,_that.contentHash,_that.checklist,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApprovalDto implements ApprovalDto {
  const _ApprovalDto({required this.schemaVersion, required this.kind, required this.id, required this.reviewerId, required this.approvedAt, required this.contentHash, required this.checklist, this.notes});
  factory _ApprovalDto.fromJson(Map<String, dynamic> json) => _$ApprovalDtoFromJson(json);

@override final  int schemaVersion;
@override final  ContentKind kind;
@override final  String id;
@override final  String reviewerId;
@override final  String approvedAt;
/// SHA-256 of the reviewed item (see `tool/content_hash.dart`).
@override final  String contentHash;
@override final  ApprovalChecklistDto checklist;
@override final  String? notes;

/// Create a copy of ApprovalDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApprovalDtoCopyWith<_ApprovalDto> get copyWith => __$ApprovalDtoCopyWithImpl<_ApprovalDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApprovalDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApprovalDto&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.reviewerId, reviewerId) || other.reviewerId == reviewerId)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.contentHash, contentHash) || other.contentHash == contentHash)&&(identical(other.checklist, checklist) || other.checklist == checklist)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,schemaVersion,kind,id,reviewerId,approvedAt,contentHash,checklist,notes);

@override
String toString() {
  return 'ApprovalDto(schemaVersion: $schemaVersion, kind: $kind, id: $id, reviewerId: $reviewerId, approvedAt: $approvedAt, contentHash: $contentHash, checklist: $checklist, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ApprovalDtoCopyWith<$Res> implements $ApprovalDtoCopyWith<$Res> {
  factory _$ApprovalDtoCopyWith(_ApprovalDto value, $Res Function(_ApprovalDto) _then) = __$ApprovalDtoCopyWithImpl;
@override @useResult
$Res call({
 int schemaVersion, ContentKind kind, String id, String reviewerId, String approvedAt, String contentHash, ApprovalChecklistDto checklist, String? notes
});


@override $ApprovalChecklistDtoCopyWith<$Res> get checklist;

}
/// @nodoc
class __$ApprovalDtoCopyWithImpl<$Res>
    implements _$ApprovalDtoCopyWith<$Res> {
  __$ApprovalDtoCopyWithImpl(this._self, this._then);

  final _ApprovalDto _self;
  final $Res Function(_ApprovalDto) _then;

/// Create a copy of ApprovalDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? schemaVersion = null,Object? kind = null,Object? id = null,Object? reviewerId = null,Object? approvedAt = null,Object? contentHash = null,Object? checklist = null,Object? notes = freezed,}) {
  return _then(_ApprovalDto(
schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ContentKind,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reviewerId: null == reviewerId ? _self.reviewerId : reviewerId // ignore: cast_nullable_to_non_nullable
as String,approvedAt: null == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as String,contentHash: null == contentHash ? _self.contentHash : contentHash // ignore: cast_nullable_to_non_nullable
as String,checklist: null == checklist ? _self.checklist : checklist // ignore: cast_nullable_to_non_nullable
as ApprovalChecklistDto,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ApprovalDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApprovalChecklistDtoCopyWith<$Res> get checklist {
  
  return $ApprovalChecklistDtoCopyWith<$Res>(_self.checklist, (value) {
    return _then(_self.copyWith(checklist: value));
  });
}
}

// dart format on
