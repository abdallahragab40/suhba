// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanionCategory {

 String get id; LocalizedText get name; int get order; ReviewInfo get review; LocalizedText? get description;/// What defines the category, with its sources.
 ContentBlock? get basis;/// Every companion in the content has been checked against the
/// category: anyone not a member is certainly not one, except those in
/// [contested].
 bool get complete;/// Companions whose membership the sources dispute; never offered as
/// a member or as a non-member.
 List<String> get contested;
/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanionCategoryCopyWith<CompanionCategory> get copyWith => _$CompanionCategoryCopyWithImpl<CompanionCategory>(this as CompanionCategory, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanionCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.review, review) || other.review == review)&&(identical(other.description, description) || other.description == description)&&(identical(other.basis, basis) || other.basis == basis)&&(identical(other.complete, complete) || other.complete == complete)&&const DeepCollectionEquality().equals(other.contested, contested));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,order,review,description,basis,complete,const DeepCollectionEquality().hash(contested));

@override
String toString() {
  return 'CompanionCategory(id: $id, name: $name, order: $order, review: $review, description: $description, basis: $basis, complete: $complete, contested: $contested)';
}


}

/// @nodoc
abstract mixin class $CompanionCategoryCopyWith<$Res>  {
  factory $CompanionCategoryCopyWith(CompanionCategory value, $Res Function(CompanionCategory) _then) = _$CompanionCategoryCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, int order, ReviewInfo review, LocalizedText? description, ContentBlock? basis, bool complete, List<String> contested
});


$LocalizedTextCopyWith<$Res> get name;$ReviewInfoCopyWith<$Res> get review;$LocalizedTextCopyWith<$Res>? get description;$ContentBlockCopyWith<$Res>? get basis;

}
/// @nodoc
class _$CompanionCategoryCopyWithImpl<$Res>
    implements $CompanionCategoryCopyWith<$Res> {
  _$CompanionCategoryCopyWithImpl(this._self, this._then);

  final CompanionCategory _self;
  final $Res Function(CompanionCategory) _then;

/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? order = null,Object? review = null,Object? description = freezed,Object? basis = freezed,Object? complete = null,Object? contested = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText?,basis: freezed == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as ContentBlock?,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,contested: null == contested ? _self.contested : contested // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentBlockCopyWith<$Res>? get basis {
    if (_self.basis == null) {
    return null;
  }

  return $ContentBlockCopyWith<$Res>(_self.basis!, (value) {
    return _then(_self.copyWith(basis: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompanionCategory].
extension CompanionCategoryPatterns on CompanionCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanionCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanionCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanionCategory value)  $default,){
final _that = this;
switch (_that) {
case _CompanionCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanionCategory value)?  $default,){
final _that = this;
switch (_that) {
case _CompanionCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  int order,  ReviewInfo review,  LocalizedText? description,  ContentBlock? basis,  bool complete,  List<String> contested)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanionCategory() when $default != null:
return $default(_that.id,_that.name,_that.order,_that.review,_that.description,_that.basis,_that.complete,_that.contested);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  int order,  ReviewInfo review,  LocalizedText? description,  ContentBlock? basis,  bool complete,  List<String> contested)  $default,) {final _that = this;
switch (_that) {
case _CompanionCategory():
return $default(_that.id,_that.name,_that.order,_that.review,_that.description,_that.basis,_that.complete,_that.contested);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText name,  int order,  ReviewInfo review,  LocalizedText? description,  ContentBlock? basis,  bool complete,  List<String> contested)?  $default,) {final _that = this;
switch (_that) {
case _CompanionCategory() when $default != null:
return $default(_that.id,_that.name,_that.order,_that.review,_that.description,_that.basis,_that.complete,_that.contested);case _:
  return null;

}
}

}

/// @nodoc


class _CompanionCategory implements CompanionCategory {
  const _CompanionCategory({required this.id, required this.name, required this.order, required this.review, this.description, this.basis, this.complete = false, final  List<String> contested = const <String>[]}): _contested = contested;
  

@override final  String id;
@override final  LocalizedText name;
@override final  int order;
@override final  ReviewInfo review;
@override final  LocalizedText? description;
/// What defines the category, with its sources.
@override final  ContentBlock? basis;
/// Every companion in the content has been checked against the
/// category: anyone not a member is certainly not one, except those in
/// [contested].
@override@JsonKey() final  bool complete;
/// Companions whose membership the sources dispute; never offered as
/// a member or as a non-member.
 final  List<String> _contested;
/// Companions whose membership the sources dispute; never offered as
/// a member or as a non-member.
@override@JsonKey() List<String> get contested {
  if (_contested is EqualUnmodifiableListView) return _contested;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contested);
}


/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanionCategoryCopyWith<_CompanionCategory> get copyWith => __$CompanionCategoryCopyWithImpl<_CompanionCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanionCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.order, order) || other.order == order)&&(identical(other.review, review) || other.review == review)&&(identical(other.description, description) || other.description == description)&&(identical(other.basis, basis) || other.basis == basis)&&(identical(other.complete, complete) || other.complete == complete)&&const DeepCollectionEquality().equals(other._contested, _contested));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,order,review,description,basis,complete,const DeepCollectionEquality().hash(_contested));

@override
String toString() {
  return 'CompanionCategory(id: $id, name: $name, order: $order, review: $review, description: $description, basis: $basis, complete: $complete, contested: $contested)';
}


}

/// @nodoc
abstract mixin class _$CompanionCategoryCopyWith<$Res> implements $CompanionCategoryCopyWith<$Res> {
  factory _$CompanionCategoryCopyWith(_CompanionCategory value, $Res Function(_CompanionCategory) _then) = __$CompanionCategoryCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, int order, ReviewInfo review, LocalizedText? description, ContentBlock? basis, bool complete, List<String> contested
});


@override $LocalizedTextCopyWith<$Res> get name;@override $ReviewInfoCopyWith<$Res> get review;@override $LocalizedTextCopyWith<$Res>? get description;@override $ContentBlockCopyWith<$Res>? get basis;

}
/// @nodoc
class __$CompanionCategoryCopyWithImpl<$Res>
    implements _$CompanionCategoryCopyWith<$Res> {
  __$CompanionCategoryCopyWithImpl(this._self, this._then);

  final _CompanionCategory _self;
  final $Res Function(_CompanionCategory) _then;

/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? order = null,Object? review = null,Object? description = freezed,Object? basis = freezed,Object? complete = null,Object? contested = null,}) {
  return _then(_CompanionCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as LocalizedText?,basis: freezed == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as ContentBlock?,complete: null == complete ? _self.complete : complete // ignore: cast_nullable_to_non_nullable
as bool,contested: null == contested ? _self._contested : contested // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get description {
    if (_self.description == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.description!, (value) {
    return _then(_self.copyWith(description: value));
  });
}/// Create a copy of CompanionCategory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentBlockCopyWith<$Res>? get basis {
    if (_self.basis == null) {
    return null;
  }

  return $ContentBlockCopyWith<$Res>(_self.basis!, (value) {
    return _then(_self.copyWith(basis: value));
  });
}
}

/// @nodoc
mixin _$HistoricalEvent {

 String get id; LocalizedText get name; EventType get type; HistoricalDate get date; LocalizedText get summary; Reliability get reliability; List<Citation> get citations; ReviewInfo get review; LocalizedText? get place; List<PersonRef> get participants;/// Where it happened (`HistoricalPlace` ids).
 List<String> get placeIds;/// What led to it, and what came of it.
 LocalizedText? get context; LocalizedText? get outcome;
/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoricalEventCopyWith<HistoricalEvent> get copyWith => _$HistoricalEventCopyWithImpl<HistoricalEvent>(this as HistoricalEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoricalEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other.participants, participants)&&const DeepCollectionEquality().equals(other.placeIds, placeIds)&&(identical(other.context, context) || other.context == context)&&(identical(other.outcome, outcome) || other.outcome == outcome));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,date,summary,reliability,const DeepCollectionEquality().hash(citations),review,place,const DeepCollectionEquality().hash(participants),const DeepCollectionEquality().hash(placeIds),context,outcome);

@override
String toString() {
  return 'HistoricalEvent(id: $id, name: $name, type: $type, date: $date, summary: $summary, reliability: $reliability, citations: $citations, review: $review, place: $place, participants: $participants, placeIds: $placeIds, context: $context, outcome: $outcome)';
}


}

/// @nodoc
abstract mixin class $HistoricalEventCopyWith<$Res>  {
  factory $HistoricalEventCopyWith(HistoricalEvent value, $Res Function(HistoricalEvent) _then) = _$HistoricalEventCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, EventType type, HistoricalDate date, LocalizedText summary, Reliability reliability, List<Citation> citations, ReviewInfo review, LocalizedText? place, List<PersonRef> participants, List<String> placeIds, LocalizedText? context, LocalizedText? outcome
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get summary;$ReviewInfoCopyWith<$Res> get review;$LocalizedTextCopyWith<$Res>? get place;$LocalizedTextCopyWith<$Res>? get context;$LocalizedTextCopyWith<$Res>? get outcome;

}
/// @nodoc
class _$HistoricalEventCopyWithImpl<$Res>
    implements $HistoricalEventCopyWith<$Res> {
  _$HistoricalEventCopyWithImpl(this._self, this._then);

  final HistoricalEvent _self;
  final $Res Function(HistoricalEvent) _then;

/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? place = freezed,Object? participants = null,Object? placeIds = null,Object? context = freezed,Object? outcome = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as LocalizedText?,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<PersonRef>,placeIds: null == placeIds ? _self.placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as LocalizedText?,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get context {
    if (_self.context == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.context!, (value) {
    return _then(_self.copyWith(context: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get outcome {
    if (_self.outcome == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.outcome!, (value) {
    return _then(_self.copyWith(outcome: value));
  });
}
}


/// Adds pattern-matching-related methods to [HistoricalEvent].
extension HistoricalEventPatterns on HistoricalEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoricalEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoricalEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoricalEvent value)  $default,){
final _that = this;
switch (_that) {
case _HistoricalEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoricalEvent value)?  $default,){
final _that = this;
switch (_that) {
case _HistoricalEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  EventType type,  HistoricalDate date,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  ReviewInfo review,  LocalizedText? place,  List<PersonRef> participants,  List<String> placeIds,  LocalizedText? context,  LocalizedText? outcome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoricalEvent() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.date,_that.summary,_that.reliability,_that.citations,_that.review,_that.place,_that.participants,_that.placeIds,_that.context,_that.outcome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  EventType type,  HistoricalDate date,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  ReviewInfo review,  LocalizedText? place,  List<PersonRef> participants,  List<String> placeIds,  LocalizedText? context,  LocalizedText? outcome)  $default,) {final _that = this;
switch (_that) {
case _HistoricalEvent():
return $default(_that.id,_that.name,_that.type,_that.date,_that.summary,_that.reliability,_that.citations,_that.review,_that.place,_that.participants,_that.placeIds,_that.context,_that.outcome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText name,  EventType type,  HistoricalDate date,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  ReviewInfo review,  LocalizedText? place,  List<PersonRef> participants,  List<String> placeIds,  LocalizedText? context,  LocalizedText? outcome)?  $default,) {final _that = this;
switch (_that) {
case _HistoricalEvent() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.date,_that.summary,_that.reliability,_that.citations,_that.review,_that.place,_that.participants,_that.placeIds,_that.context,_that.outcome);case _:
  return null;

}
}

}

/// @nodoc


class _HistoricalEvent implements HistoricalEvent {
  const _HistoricalEvent({required this.id, required this.name, required this.type, required this.date, required this.summary, required this.reliability, required final  List<Citation> citations, required this.review, this.place, final  List<PersonRef> participants = const <PersonRef>[], final  List<String> placeIds = const <String>[], this.context, this.outcome}): _citations = citations,_participants = participants,_placeIds = placeIds;
  

@override final  String id;
@override final  LocalizedText name;
@override final  EventType type;
@override final  HistoricalDate date;
@override final  LocalizedText summary;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  ReviewInfo review;
@override final  LocalizedText? place;
 final  List<PersonRef> _participants;
@override@JsonKey() List<PersonRef> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

/// Where it happened (`HistoricalPlace` ids).
 final  List<String> _placeIds;
/// Where it happened (`HistoricalPlace` ids).
@override@JsonKey() List<String> get placeIds {
  if (_placeIds is EqualUnmodifiableListView) return _placeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placeIds);
}

/// What led to it, and what came of it.
@override final  LocalizedText? context;
@override final  LocalizedText? outcome;

/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoricalEventCopyWith<_HistoricalEvent> get copyWith => __$HistoricalEventCopyWithImpl<_HistoricalEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoricalEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.review, review) || other.review == review)&&(identical(other.place, place) || other.place == place)&&const DeepCollectionEquality().equals(other._participants, _participants)&&const DeepCollectionEquality().equals(other._placeIds, _placeIds)&&(identical(other.context, context) || other.context == context)&&(identical(other.outcome, outcome) || other.outcome == outcome));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,type,date,summary,reliability,const DeepCollectionEquality().hash(_citations),review,place,const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_placeIds),context,outcome);

@override
String toString() {
  return 'HistoricalEvent(id: $id, name: $name, type: $type, date: $date, summary: $summary, reliability: $reliability, citations: $citations, review: $review, place: $place, participants: $participants, placeIds: $placeIds, context: $context, outcome: $outcome)';
}


}

/// @nodoc
abstract mixin class _$HistoricalEventCopyWith<$Res> implements $HistoricalEventCopyWith<$Res> {
  factory _$HistoricalEventCopyWith(_HistoricalEvent value, $Res Function(_HistoricalEvent) _then) = __$HistoricalEventCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, EventType type, HistoricalDate date, LocalizedText summary, Reliability reliability, List<Citation> citations, ReviewInfo review, LocalizedText? place, List<PersonRef> participants, List<String> placeIds, LocalizedText? context, LocalizedText? outcome
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get summary;@override $ReviewInfoCopyWith<$Res> get review;@override $LocalizedTextCopyWith<$Res>? get place;@override $LocalizedTextCopyWith<$Res>? get context;@override $LocalizedTextCopyWith<$Res>? get outcome;

}
/// @nodoc
class __$HistoricalEventCopyWithImpl<$Res>
    implements _$HistoricalEventCopyWith<$Res> {
  __$HistoricalEventCopyWithImpl(this._self, this._then);

  final _HistoricalEvent _self;
  final $Res Function(_HistoricalEvent) _then;

/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? review = null,Object? place = freezed,Object? participants = null,Object? placeIds = null,Object? context = freezed,Object? outcome = freezed,}) {
  return _then(_HistoricalEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as LocalizedText?,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<PersonRef>,placeIds: null == placeIds ? _self._placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,context: freezed == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as LocalizedText?,outcome: freezed == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get place {
    if (_self.place == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.place!, (value) {
    return _then(_self.copyWith(place: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get context {
    if (_self.context == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.context!, (value) {
    return _then(_self.copyWith(context: value));
  });
}/// Create a copy of HistoricalEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get outcome {
    if (_self.outcome == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.outcome!, (value) {
    return _then(_self.copyWith(outcome: value));
  });
}
}

/// @nodoc
mixin _$SourceReference {

 String get id; SourceType get type; LocalizedText get title; ReviewInfo get review; LocalizedText? get author; int? get authorDeathAH; LocalizedText? get edition; LocalizedText? get publisher; LocalizedText? get numberingScheme;
/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SourceReferenceCopyWith<SourceReference> get copyWith => _$SourceReferenceCopyWithImpl<SourceReference>(this as SourceReference, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SourceReference&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.review, review) || other.review == review)&&(identical(other.author, author) || other.author == author)&&(identical(other.authorDeathAH, authorDeathAH) || other.authorDeathAH == authorDeathAH)&&(identical(other.edition, edition) || other.edition == edition)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.numberingScheme, numberingScheme) || other.numberingScheme == numberingScheme));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,review,author,authorDeathAH,edition,publisher,numberingScheme);

@override
String toString() {
  return 'SourceReference(id: $id, type: $type, title: $title, review: $review, author: $author, authorDeathAH: $authorDeathAH, edition: $edition, publisher: $publisher, numberingScheme: $numberingScheme)';
}


}

/// @nodoc
abstract mixin class $SourceReferenceCopyWith<$Res>  {
  factory $SourceReferenceCopyWith(SourceReference value, $Res Function(SourceReference) _then) = _$SourceReferenceCopyWithImpl;
@useResult
$Res call({
 String id, SourceType type, LocalizedText title, ReviewInfo review, LocalizedText? author, int? authorDeathAH, LocalizedText? edition, LocalizedText? publisher, LocalizedText? numberingScheme
});


$LocalizedTextCopyWith<$Res> get title;$ReviewInfoCopyWith<$Res> get review;$LocalizedTextCopyWith<$Res>? get author;$LocalizedTextCopyWith<$Res>? get edition;$LocalizedTextCopyWith<$Res>? get publisher;$LocalizedTextCopyWith<$Res>? get numberingScheme;

}
/// @nodoc
class _$SourceReferenceCopyWithImpl<$Res>
    implements $SourceReferenceCopyWith<$Res> {
  _$SourceReferenceCopyWithImpl(this._self, this._then);

  final SourceReference _self;
  final $Res Function(SourceReference) _then;

/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? review = null,Object? author = freezed,Object? authorDeathAH = freezed,Object? edition = freezed,Object? publisher = freezed,Object? numberingScheme = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as LocalizedText?,authorDeathAH: freezed == authorDeathAH ? _self.authorDeathAH : authorDeathAH // ignore: cast_nullable_to_non_nullable
as int?,edition: freezed == edition ? _self.edition : edition // ignore: cast_nullable_to_non_nullable
as LocalizedText?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as LocalizedText?,numberingScheme: freezed == numberingScheme ? _self.numberingScheme : numberingScheme // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get edition {
    if (_self.edition == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.edition!, (value) {
    return _then(_self.copyWith(edition: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get publisher {
    if (_self.publisher == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.publisher!, (value) {
    return _then(_self.copyWith(publisher: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get numberingScheme {
    if (_self.numberingScheme == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.numberingScheme!, (value) {
    return _then(_self.copyWith(numberingScheme: value));
  });
}
}


/// Adds pattern-matching-related methods to [SourceReference].
extension SourceReferencePatterns on SourceReference {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SourceReference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SourceReference() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SourceReference value)  $default,){
final _that = this;
switch (_that) {
case _SourceReference():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SourceReference value)?  $default,){
final _that = this;
switch (_that) {
case _SourceReference() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SourceType type,  LocalizedText title,  ReviewInfo review,  LocalizedText? author,  int? authorDeathAH,  LocalizedText? edition,  LocalizedText? publisher,  LocalizedText? numberingScheme)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SourceReference() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SourceType type,  LocalizedText title,  ReviewInfo review,  LocalizedText? author,  int? authorDeathAH,  LocalizedText? edition,  LocalizedText? publisher,  LocalizedText? numberingScheme)  $default,) {final _that = this;
switch (_that) {
case _SourceReference():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SourceType type,  LocalizedText title,  ReviewInfo review,  LocalizedText? author,  int? authorDeathAH,  LocalizedText? edition,  LocalizedText? publisher,  LocalizedText? numberingScheme)?  $default,) {final _that = this;
switch (_that) {
case _SourceReference() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.review,_that.author,_that.authorDeathAH,_that.edition,_that.publisher,_that.numberingScheme);case _:
  return null;

}
}

}

/// @nodoc


class _SourceReference implements SourceReference {
  const _SourceReference({required this.id, required this.type, required this.title, required this.review, this.author, this.authorDeathAH, this.edition, this.publisher, this.numberingScheme});
  

@override final  String id;
@override final  SourceType type;
@override final  LocalizedText title;
@override final  ReviewInfo review;
@override final  LocalizedText? author;
@override final  int? authorDeathAH;
@override final  LocalizedText? edition;
@override final  LocalizedText? publisher;
@override final  LocalizedText? numberingScheme;

/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SourceReferenceCopyWith<_SourceReference> get copyWith => __$SourceReferenceCopyWithImpl<_SourceReference>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SourceReference&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.review, review) || other.review == review)&&(identical(other.author, author) || other.author == author)&&(identical(other.authorDeathAH, authorDeathAH) || other.authorDeathAH == authorDeathAH)&&(identical(other.edition, edition) || other.edition == edition)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&(identical(other.numberingScheme, numberingScheme) || other.numberingScheme == numberingScheme));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,title,review,author,authorDeathAH,edition,publisher,numberingScheme);

@override
String toString() {
  return 'SourceReference(id: $id, type: $type, title: $title, review: $review, author: $author, authorDeathAH: $authorDeathAH, edition: $edition, publisher: $publisher, numberingScheme: $numberingScheme)';
}


}

/// @nodoc
abstract mixin class _$SourceReferenceCopyWith<$Res> implements $SourceReferenceCopyWith<$Res> {
  factory _$SourceReferenceCopyWith(_SourceReference value, $Res Function(_SourceReference) _then) = __$SourceReferenceCopyWithImpl;
@override @useResult
$Res call({
 String id, SourceType type, LocalizedText title, ReviewInfo review, LocalizedText? author, int? authorDeathAH, LocalizedText? edition, LocalizedText? publisher, LocalizedText? numberingScheme
});


@override $LocalizedTextCopyWith<$Res> get title;@override $ReviewInfoCopyWith<$Res> get review;@override $LocalizedTextCopyWith<$Res>? get author;@override $LocalizedTextCopyWith<$Res>? get edition;@override $LocalizedTextCopyWith<$Res>? get publisher;@override $LocalizedTextCopyWith<$Res>? get numberingScheme;

}
/// @nodoc
class __$SourceReferenceCopyWithImpl<$Res>
    implements _$SourceReferenceCopyWith<$Res> {
  __$SourceReferenceCopyWithImpl(this._self, this._then);

  final _SourceReference _self;
  final $Res Function(_SourceReference) _then;

/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? review = null,Object? author = freezed,Object? authorDeathAH = freezed,Object? edition = freezed,Object? publisher = freezed,Object? numberingScheme = freezed,}) {
  return _then(_SourceReference(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SourceType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as LocalizedText?,authorDeathAH: freezed == authorDeathAH ? _self.authorDeathAH : authorDeathAH // ignore: cast_nullable_to_non_nullable
as int?,edition: freezed == edition ? _self.edition : edition // ignore: cast_nullable_to_non_nullable
as LocalizedText?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as LocalizedText?,numberingScheme: freezed == numberingScheme ? _self.numberingScheme : numberingScheme // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get edition {
    if (_self.edition == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.edition!, (value) {
    return _then(_self.copyWith(edition: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get publisher {
    if (_self.publisher == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.publisher!, (value) {
    return _then(_self.copyWith(publisher: value));
  });
}/// Create a copy of SourceReference
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get numberingScheme {
    if (_self.numberingScheme == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.numberingScheme!, (value) {
    return _then(_self.copyWith(numberingScheme: value));
  });
}
}

/// @nodoc
mixin _$Person {

 String get id; LocalizedText get name; PersonHonorific get honorific; ReviewInfo get review; Gender? get gender;
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonCopyWith<Person> get copyWith => _$PersonCopyWithImpl<Person>(this as Person, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Person&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.honorific, honorific) || other.honorific == honorific)&&(identical(other.review, review) || other.review == review)&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,honorific,review,gender);

@override
String toString() {
  return 'Person(id: $id, name: $name, honorific: $honorific, review: $review, gender: $gender)';
}


}

/// @nodoc
abstract mixin class $PersonCopyWith<$Res>  {
  factory $PersonCopyWith(Person value, $Res Function(Person) _then) = _$PersonCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, PersonHonorific honorific, ReviewInfo review, Gender? gender
});


$LocalizedTextCopyWith<$Res> get name;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$PersonCopyWithImpl<$Res>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._self, this._then);

  final Person _self;
  final $Res Function(Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? honorific = null,Object? review = null,Object? gender = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,honorific: null == honorific ? _self.honorific : honorific // ignore: cast_nullable_to_non_nullable
as PersonHonorific,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,
  ));
}
/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [Person].
extension PersonPatterns on Person {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Person value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Person value)  $default,){
final _that = this;
switch (_that) {
case _Person():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Person value)?  $default,){
final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  PersonHonorific honorific,  ReviewInfo review,  Gender? gender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Person() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  PersonHonorific honorific,  ReviewInfo review,  Gender? gender)  $default,) {final _that = this;
switch (_that) {
case _Person():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText name,  PersonHonorific honorific,  ReviewInfo review,  Gender? gender)?  $default,) {final _that = this;
switch (_that) {
case _Person() when $default != null:
return $default(_that.id,_that.name,_that.honorific,_that.review,_that.gender);case _:
  return null;

}
}

}

/// @nodoc


class _Person implements Person {
  const _Person({required this.id, required this.name, required this.honorific, required this.review, this.gender});
  

@override final  String id;
@override final  LocalizedText name;
@override final  PersonHonorific honorific;
@override final  ReviewInfo review;
@override final  Gender? gender;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonCopyWith<_Person> get copyWith => __$PersonCopyWithImpl<_Person>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Person&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.honorific, honorific) || other.honorific == honorific)&&(identical(other.review, review) || other.review == review)&&(identical(other.gender, gender) || other.gender == gender));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,honorific,review,gender);

@override
String toString() {
  return 'Person(id: $id, name: $name, honorific: $honorific, review: $review, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$PersonCopyWith(_Person value, $Res Function(_Person) _then) = __$PersonCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, PersonHonorific honorific, ReviewInfo review, Gender? gender
});


@override $LocalizedTextCopyWith<$Res> get name;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$PersonCopyWithImpl<$Res>
    implements _$PersonCopyWith<$Res> {
  __$PersonCopyWithImpl(this._self, this._then);

  final _Person _self;
  final $Res Function(_Person) _then;

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? honorific = null,Object? review = null,Object? gender = freezed,}) {
  return _then(_Person(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,honorific: null == honorific ? _self.honorific : honorific // ignore: cast_nullable_to_non_nullable
as PersonHonorific,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender?,
  ));
}

/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Person
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

// dart format on
