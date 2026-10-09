// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'companion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonRef {

 LocalizedText get displayName; String? get companionId; String? get personId;
/// Create a copy of PersonRef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonRefCopyWith<PersonRef> get copyWith => _$PersonRefCopyWithImpl<PersonRef>(this as PersonRef, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonRef&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.companionId, companionId) || other.companionId == companionId)&&(identical(other.personId, personId) || other.personId == personId));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,companionId,personId);

@override
String toString() {
  return 'PersonRef(displayName: $displayName, companionId: $companionId, personId: $personId)';
}


}

/// @nodoc
abstract mixin class $PersonRefCopyWith<$Res>  {
  factory $PersonRefCopyWith(PersonRef value, $Res Function(PersonRef) _then) = _$PersonRefCopyWithImpl;
@useResult
$Res call({
 LocalizedText displayName, String? companionId, String? personId
});


$LocalizedTextCopyWith<$Res> get displayName;

}
/// @nodoc
class _$PersonRefCopyWithImpl<$Res>
    implements $PersonRefCopyWith<$Res> {
  _$PersonRefCopyWithImpl(this._self, this._then);

  final PersonRef _self;
  final $Res Function(PersonRef) _then;

/// Create a copy of PersonRef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? companionId = freezed,Object? personId = freezed,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as LocalizedText,companionId: freezed == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String?,personId: freezed == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PersonRef
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get displayName {
  
  return $LocalizedTextCopyWith<$Res>(_self.displayName, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonRef].
extension PersonRefPatterns on PersonRef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonRef value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonRef() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonRef value)  $default,){
final _that = this;
switch (_that) {
case _PersonRef():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonRef value)?  $default,){
final _that = this;
switch (_that) {
case _PersonRef() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedText displayName,  String? companionId,  String? personId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonRef() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedText displayName,  String? companionId,  String? personId)  $default,) {final _that = this;
switch (_that) {
case _PersonRef():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedText displayName,  String? companionId,  String? personId)?  $default,) {final _that = this;
switch (_that) {
case _PersonRef() when $default != null:
return $default(_that.displayName,_that.companionId,_that.personId);case _:
  return null;

}
}

}

/// @nodoc


class _PersonRef implements PersonRef {
  const _PersonRef({required this.displayName, this.companionId, this.personId});
  

@override final  LocalizedText displayName;
@override final  String? companionId;
@override final  String? personId;

/// Create a copy of PersonRef
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonRefCopyWith<_PersonRef> get copyWith => __$PersonRefCopyWithImpl<_PersonRef>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonRef&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.companionId, companionId) || other.companionId == companionId)&&(identical(other.personId, personId) || other.personId == personId));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,companionId,personId);

@override
String toString() {
  return 'PersonRef(displayName: $displayName, companionId: $companionId, personId: $personId)';
}


}

/// @nodoc
abstract mixin class _$PersonRefCopyWith<$Res> implements $PersonRefCopyWith<$Res> {
  factory _$PersonRefCopyWith(_PersonRef value, $Res Function(_PersonRef) _then) = __$PersonRefCopyWithImpl;
@override @useResult
$Res call({
 LocalizedText displayName, String? companionId, String? personId
});


@override $LocalizedTextCopyWith<$Res> get displayName;

}
/// @nodoc
class __$PersonRefCopyWithImpl<$Res>
    implements _$PersonRefCopyWith<$Res> {
  __$PersonRefCopyWithImpl(this._self, this._then);

  final _PersonRef _self;
  final $Res Function(_PersonRef) _then;

/// Create a copy of PersonRef
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? companionId = freezed,Object? personId = freezed,}) {
  return _then(_PersonRef(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as LocalizedText,companionId: freezed == companionId ? _self.companionId : companionId // ignore: cast_nullable_to_non_nullable
as String?,personId: freezed == personId ? _self.personId : personId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PersonRef
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get displayName {
  
  return $LocalizedTextCopyWith<$Res>(_self.displayName, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}
}

/// @nodoc
mixin _$Relation {

 RelationType get type; PersonRef get person; List<Citation> get citations;
/// Create a copy of Relation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelationCopyWith<Relation> get copyWith => _$RelationCopyWithImpl<Relation>(this as Relation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Relation&&(identical(other.type, type) || other.type == type)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other.citations, citations));
}


@override
int get hashCode => Object.hash(runtimeType,type,person,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'Relation(type: $type, person: $person, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $RelationCopyWith<$Res>  {
  factory $RelationCopyWith(Relation value, $Res Function(Relation) _then) = _$RelationCopyWithImpl;
@useResult
$Res call({
 RelationType type, PersonRef person, List<Citation> citations
});


$PersonRefCopyWith<$Res> get person;

}
/// @nodoc
class _$RelationCopyWithImpl<$Res>
    implements $RelationCopyWith<$Res> {
  _$RelationCopyWithImpl(this._self, this._then);

  final Relation _self;
  final $Res Function(Relation) _then;

/// Create a copy of Relation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? person = null,Object? citations = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as PersonRef,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}
/// Create a copy of Relation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefCopyWith<$Res> get person {
  
  return $PersonRefCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}


/// Adds pattern-matching-related methods to [Relation].
extension RelationPatterns on Relation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Relation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Relation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Relation value)  $default,){
final _that = this;
switch (_that) {
case _Relation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Relation value)?  $default,){
final _that = this;
switch (_that) {
case _Relation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RelationType type,  PersonRef person,  List<Citation> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Relation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RelationType type,  PersonRef person,  List<Citation> citations)  $default,) {final _that = this;
switch (_that) {
case _Relation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RelationType type,  PersonRef person,  List<Citation> citations)?  $default,) {final _that = this;
switch (_that) {
case _Relation() when $default != null:
return $default(_that.type,_that.person,_that.citations);case _:
  return null;

}
}

}

/// @nodoc


class _Relation implements Relation {
  const _Relation({required this.type, required this.person, final  List<Citation> citations = const <Citation>[]}): _citations = citations;
  

@override final  RelationType type;
@override final  PersonRef person;
 final  List<Citation> _citations;
@override@JsonKey() List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of Relation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelationCopyWith<_Relation> get copyWith => __$RelationCopyWithImpl<_Relation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Relation&&(identical(other.type, type) || other.type == type)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other._citations, _citations));
}


@override
int get hashCode => Object.hash(runtimeType,type,person,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'Relation(type: $type, person: $person, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$RelationCopyWith<$Res> implements $RelationCopyWith<$Res> {
  factory _$RelationCopyWith(_Relation value, $Res Function(_Relation) _then) = __$RelationCopyWithImpl;
@override @useResult
$Res call({
 RelationType type, PersonRef person, List<Citation> citations
});


@override $PersonRefCopyWith<$Res> get person;

}
/// @nodoc
class __$RelationCopyWithImpl<$Res>
    implements _$RelationCopyWith<$Res> {
  __$RelationCopyWithImpl(this._self, this._then);

  final _Relation _self;
  final $Res Function(_Relation) _then;

/// Create a copy of Relation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? person = null,Object? citations = null,}) {
  return _then(_Relation(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RelationType,person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as PersonRef,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}

/// Create a copy of Relation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonRefCopyWith<$Res> get person {
  
  return $PersonRefCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}
}

/// @nodoc
mixin _$Membership {

 String get categoryId; List<Citation> get citations; LocalizedText? get note;
/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MembershipCopyWith<Membership> get copyWith => _$MembershipCopyWithImpl<Membership>(this as Membership, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Membership&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'Membership(categoryId: $categoryId, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $MembershipCopyWith<$Res>  {
  factory $MembershipCopyWith(Membership value, $Res Function(Membership) _then) = _$MembershipCopyWithImpl;
@useResult
$Res call({
 String categoryId, List<Citation> citations, LocalizedText? note
});


$LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class _$MembershipCopyWithImpl<$Res>
    implements $MembershipCopyWith<$Res> {
  _$MembershipCopyWithImpl(this._self, this._then);

  final Membership _self;
  final $Res Function(Membership) _then;

/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of Membership
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


/// Adds pattern-matching-related methods to [Membership].
extension MembershipPatterns on Membership {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Membership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Membership() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Membership value)  $default,){
final _that = this;
switch (_that) {
case _Membership():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Membership value)?  $default,){
final _that = this;
switch (_that) {
case _Membership() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String categoryId,  List<Citation> citations,  LocalizedText? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Membership() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String categoryId,  List<Citation> citations,  LocalizedText? note)  $default,) {final _that = this;
switch (_that) {
case _Membership():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String categoryId,  List<Citation> citations,  LocalizedText? note)?  $default,) {final _that = this;
switch (_that) {
case _Membership() when $default != null:
return $default(_that.categoryId,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Membership implements Membership {
  const _Membership({required this.categoryId, required final  List<Citation> citations, this.note}): _citations = citations;
  

@override final  String categoryId;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedText? note;

/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MembershipCopyWith<_Membership> get copyWith => __$MembershipCopyWithImpl<_Membership>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Membership&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'Membership(categoryId: $categoryId, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$MembershipCopyWith<$Res> implements $MembershipCopyWith<$Res> {
  factory _$MembershipCopyWith(_Membership value, $Res Function(_Membership) _then) = __$MembershipCopyWithImpl;
@override @useResult
$Res call({
 String categoryId, List<Citation> citations, LocalizedText? note
});


@override $LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class __$MembershipCopyWithImpl<$Res>
    implements _$MembershipCopyWith<$Res> {
  __$MembershipCopyWithImpl(this._self, this._then);

  final _Membership _self;
  final $Res Function(_Membership) _then;

/// Create a copy of Membership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_Membership(
categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of Membership
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
mixin _$BiographySection {

 String get id; SectionKind get kind; LocalizedText get title; List<ContentBlock> get blocks;/// Fingerprint of the section's content; changes whenever it is edited.
 String get revision;
/// Create a copy of BiographySection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BiographySectionCopyWith<BiographySection> get copyWith => _$BiographySectionCopyWithImpl<BiographySection>(this as BiographySection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BiographySection&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,const DeepCollectionEquality().hash(blocks),revision);

@override
String toString() {
  return 'BiographySection(id: $id, kind: $kind, title: $title, blocks: $blocks, revision: $revision)';
}


}

/// @nodoc
abstract mixin class $BiographySectionCopyWith<$Res>  {
  factory $BiographySectionCopyWith(BiographySection value, $Res Function(BiographySection) _then) = _$BiographySectionCopyWithImpl;
@useResult
$Res call({
 String id, SectionKind kind, LocalizedText title, List<ContentBlock> blocks, String revision
});


$LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class _$BiographySectionCopyWithImpl<$Res>
    implements $BiographySectionCopyWith<$Res> {
  _$BiographySectionCopyWithImpl(this._self, this._then);

  final BiographySection _self;
  final $Res Function(BiographySection) _then;

/// Create a copy of BiographySection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? blocks = null,Object? revision = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SectionKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of BiographySection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}


/// Adds pattern-matching-related methods to [BiographySection].
extension BiographySectionPatterns on BiographySection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BiographySection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BiographySection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BiographySection value)  $default,){
final _that = this;
switch (_that) {
case _BiographySection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BiographySection value)?  $default,){
final _that = this;
switch (_that) {
case _BiographySection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SectionKind kind,  LocalizedText title,  List<ContentBlock> blocks,  String revision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BiographySection() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.blocks,_that.revision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SectionKind kind,  LocalizedText title,  List<ContentBlock> blocks,  String revision)  $default,) {final _that = this;
switch (_that) {
case _BiographySection():
return $default(_that.id,_that.kind,_that.title,_that.blocks,_that.revision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SectionKind kind,  LocalizedText title,  List<ContentBlock> blocks,  String revision)?  $default,) {final _that = this;
switch (_that) {
case _BiographySection() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.blocks,_that.revision);case _:
  return null;

}
}

}

/// @nodoc


class _BiographySection implements BiographySection {
  const _BiographySection({required this.id, required this.kind, required this.title, required final  List<ContentBlock> blocks, required this.revision}): _blocks = blocks;
  

@override final  String id;
@override final  SectionKind kind;
@override final  LocalizedText title;
 final  List<ContentBlock> _blocks;
@override List<ContentBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

/// Fingerprint of the section's content; changes whenever it is edited.
@override final  String revision;

/// Create a copy of BiographySection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BiographySectionCopyWith<_BiographySection> get copyWith => __$BiographySectionCopyWithImpl<_BiographySection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BiographySection&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&(identical(other.revision, revision) || other.revision == revision));
}


@override
int get hashCode => Object.hash(runtimeType,id,kind,title,const DeepCollectionEquality().hash(_blocks),revision);

@override
String toString() {
  return 'BiographySection(id: $id, kind: $kind, title: $title, blocks: $blocks, revision: $revision)';
}


}

/// @nodoc
abstract mixin class _$BiographySectionCopyWith<$Res> implements $BiographySectionCopyWith<$Res> {
  factory _$BiographySectionCopyWith(_BiographySection value, $Res Function(_BiographySection) _then) = __$BiographySectionCopyWithImpl;
@override @useResult
$Res call({
 String id, SectionKind kind, LocalizedText title, List<ContentBlock> blocks, String revision
});


@override $LocalizedTextCopyWith<$Res> get title;

}
/// @nodoc
class __$BiographySectionCopyWithImpl<$Res>
    implements _$BiographySectionCopyWith<$Res> {
  __$BiographySectionCopyWithImpl(this._self, this._then);

  final _BiographySection _self;
  final $Res Function(_BiographySection) _then;

/// Create a copy of BiographySection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? blocks = null,Object? revision = null,}) {
  return _then(_BiographySection(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SectionKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of BiographySection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}
}

/// @nodoc
mixin _$TimelineEvent {

 String get id; TimelineEra get era; HistoricalDate get date; LocalizedText get title; Reliability get reliability; List<Citation> get citations; LocalizedText? get summary; String? get eventId; String? get sectionId;
/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimelineEventCopyWith<TimelineEvent> get copyWith => _$TimelineEventCopyWithImpl<TimelineEvent>(this as TimelineEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimelineEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId));
}


@override
int get hashCode => Object.hash(runtimeType,id,era,date,title,reliability,const DeepCollectionEquality().hash(citations),summary,eventId,sectionId);

@override
String toString() {
  return 'TimelineEvent(id: $id, era: $era, date: $date, title: $title, reliability: $reliability, citations: $citations, summary: $summary, eventId: $eventId, sectionId: $sectionId)';
}


}

/// @nodoc
abstract mixin class $TimelineEventCopyWith<$Res>  {
  factory $TimelineEventCopyWith(TimelineEvent value, $Res Function(TimelineEvent) _then) = _$TimelineEventCopyWithImpl;
@useResult
$Res call({
 String id, TimelineEra era, HistoricalDate date, LocalizedText title, Reliability reliability, List<Citation> citations, LocalizedText? summary, String? eventId, String? sectionId
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res>? get summary;

}
/// @nodoc
class _$TimelineEventCopyWithImpl<$Res>
    implements $TimelineEventCopyWith<$Res> {
  _$TimelineEventCopyWithImpl(this._self, this._then);

  final TimelineEvent _self;
  final $Res Function(TimelineEvent) _then;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? era = null,Object? date = null,Object? title = null,Object? reliability = null,Object? citations = null,Object? summary = freezed,Object? eventId = freezed,Object? sectionId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as TimelineEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [TimelineEvent].
extension TimelineEventPatterns on TimelineEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimelineEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimelineEvent value)  $default,){
final _that = this;
switch (_that) {
case _TimelineEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimelineEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TimelineEra era,  HistoricalDate date,  LocalizedText title,  Reliability reliability,  List<Citation> citations,  LocalizedText? summary,  String? eventId,  String? sectionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TimelineEra era,  HistoricalDate date,  LocalizedText title,  Reliability reliability,  List<Citation> citations,  LocalizedText? summary,  String? eventId,  String? sectionId)  $default,) {final _that = this;
switch (_that) {
case _TimelineEvent():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TimelineEra era,  HistoricalDate date,  LocalizedText title,  Reliability reliability,  List<Citation> citations,  LocalizedText? summary,  String? eventId,  String? sectionId)?  $default,) {final _that = this;
switch (_that) {
case _TimelineEvent() when $default != null:
return $default(_that.id,_that.era,_that.date,_that.title,_that.reliability,_that.citations,_that.summary,_that.eventId,_that.sectionId);case _:
  return null;

}
}

}

/// @nodoc


class _TimelineEvent implements TimelineEvent {
  const _TimelineEvent({required this.id, required this.era, required this.date, required this.title, required this.reliability, required final  List<Citation> citations, this.summary, this.eventId, this.sectionId}): _citations = citations;
  

@override final  String id;
@override final  TimelineEra era;
@override final  HistoricalDate date;
@override final  LocalizedText title;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedText? summary;
@override final  String? eventId;
@override final  String? sectionId;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimelineEventCopyWith<_TimelineEvent> get copyWith => __$TimelineEventCopyWithImpl<_TimelineEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimelineEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.title, title) || other.title == title)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.sectionId, sectionId) || other.sectionId == sectionId));
}


@override
int get hashCode => Object.hash(runtimeType,id,era,date,title,reliability,const DeepCollectionEquality().hash(_citations),summary,eventId,sectionId);

@override
String toString() {
  return 'TimelineEvent(id: $id, era: $era, date: $date, title: $title, reliability: $reliability, citations: $citations, summary: $summary, eventId: $eventId, sectionId: $sectionId)';
}


}

/// @nodoc
abstract mixin class _$TimelineEventCopyWith<$Res> implements $TimelineEventCopyWith<$Res> {
  factory _$TimelineEventCopyWith(_TimelineEvent value, $Res Function(_TimelineEvent) _then) = __$TimelineEventCopyWithImpl;
@override @useResult
$Res call({
 String id, TimelineEra era, HistoricalDate date, LocalizedText title, Reliability reliability, List<Citation> citations, LocalizedText? summary, String? eventId, String? sectionId
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res>? get summary;

}
/// @nodoc
class __$TimelineEventCopyWithImpl<$Res>
    implements _$TimelineEventCopyWith<$Res> {
  __$TimelineEventCopyWithImpl(this._self, this._then);

  final _TimelineEvent _self;
  final $Res Function(_TimelineEvent) _then;

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? era = null,Object? date = null,Object? title = null,Object? reliability = null,Object? citations = null,Object? summary = freezed,Object? eventId = freezed,Object? sectionId = freezed,}) {
  return _then(_TimelineEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as TimelineEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String?,sectionId: freezed == sectionId ? _self.sectionId : sectionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of TimelineEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get summary {
    if (_self.summary == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.summary!, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
mixin _$CompanionSummary {

 String get id; Gender get gender; LocalizedText get name; LocalizedText get summary; ReviewInfo get review;/// Display order in lists (lower first); null sorts last.
 int? get order; LocalizedText? get kunya; List<LocalizedText> get titles; List<String> get aliases; List<String> get categoryIds; HistoricalDate? get death;
/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanionSummaryCopyWith<CompanionSummary> get copyWith => _$CompanionSummaryCopyWithImpl<CompanionSummary>(this as CompanionSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanionSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&(identical(other.order, order) || other.order == order)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other.titles, titles)&&const DeepCollectionEquality().equals(other.aliases, aliases)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&(identical(other.death, death) || other.death == death));
}


@override
int get hashCode => Object.hash(runtimeType,id,gender,name,summary,review,order,kunya,const DeepCollectionEquality().hash(titles),const DeepCollectionEquality().hash(aliases),const DeepCollectionEquality().hash(categoryIds),death);

@override
String toString() {
  return 'CompanionSummary(id: $id, gender: $gender, name: $name, summary: $summary, review: $review, order: $order, kunya: $kunya, titles: $titles, aliases: $aliases, categoryIds: $categoryIds, death: $death)';
}


}

/// @nodoc
abstract mixin class $CompanionSummaryCopyWith<$Res>  {
  factory $CompanionSummaryCopyWith(CompanionSummary value, $Res Function(CompanionSummary) _then) = _$CompanionSummaryCopyWithImpl;
@useResult
$Res call({
 String id, Gender gender, LocalizedText name, LocalizedText summary, ReviewInfo review, int? order, LocalizedText? kunya, List<LocalizedText> titles, List<String> aliases, List<String> categoryIds, HistoricalDate? death
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get summary;$ReviewInfoCopyWith<$Res> get review;$LocalizedTextCopyWith<$Res>? get kunya;

}
/// @nodoc
class _$CompanionSummaryCopyWithImpl<$Res>
    implements $CompanionSummaryCopyWith<$Res> {
  _$CompanionSummaryCopyWithImpl(this._self, this._then);

  final CompanionSummary _self;
  final $Res Function(CompanionSummary) _then;

/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? gender = null,Object? name = null,Object? summary = null,Object? review = null,Object? order = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? categoryIds = null,Object? death = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedText?,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as HistoricalDate?,
  ));
}
/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}
}


/// Adds pattern-matching-related methods to [CompanionSummary].
extension CompanionSummaryPatterns on CompanionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanionSummary value)  $default,){
final _that = this;
switch (_that) {
case _CompanionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CompanionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Gender gender,  LocalizedText name,  LocalizedText summary,  ReviewInfo review,  int? order,  LocalizedText? kunya,  List<LocalizedText> titles,  List<String> aliases,  List<String> categoryIds,  HistoricalDate? death)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanionSummary() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Gender gender,  LocalizedText name,  LocalizedText summary,  ReviewInfo review,  int? order,  LocalizedText? kunya,  List<LocalizedText> titles,  List<String> aliases,  List<String> categoryIds,  HistoricalDate? death)  $default,) {final _that = this;
switch (_that) {
case _CompanionSummary():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Gender gender,  LocalizedText name,  LocalizedText summary,  ReviewInfo review,  int? order,  LocalizedText? kunya,  List<LocalizedText> titles,  List<String> aliases,  List<String> categoryIds,  HistoricalDate? death)?  $default,) {final _that = this;
switch (_that) {
case _CompanionSummary() when $default != null:
return $default(_that.id,_that.gender,_that.name,_that.summary,_that.review,_that.order,_that.kunya,_that.titles,_that.aliases,_that.categoryIds,_that.death);case _:
  return null;

}
}

}

/// @nodoc


class _CompanionSummary implements CompanionSummary {
  const _CompanionSummary({required this.id, required this.gender, required this.name, required this.summary, required this.review, this.order, this.kunya, final  List<LocalizedText> titles = const <LocalizedText>[], final  List<String> aliases = const <String>[], final  List<String> categoryIds = const <String>[], this.death}): _titles = titles,_aliases = aliases,_categoryIds = categoryIds;
  

@override final  String id;
@override final  Gender gender;
@override final  LocalizedText name;
@override final  LocalizedText summary;
@override final  ReviewInfo review;
/// Display order in lists (lower first); null sorts last.
@override final  int? order;
@override final  LocalizedText? kunya;
 final  List<LocalizedText> _titles;
@override@JsonKey() List<LocalizedText> get titles {
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

@override final  HistoricalDate? death;

/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanionSummaryCopyWith<_CompanionSummary> get copyWith => __$CompanionSummaryCopyWithImpl<_CompanionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanionSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&(identical(other.order, order) || other.order == order)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other._titles, _titles)&&const DeepCollectionEquality().equals(other._aliases, _aliases)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&(identical(other.death, death) || other.death == death));
}


@override
int get hashCode => Object.hash(runtimeType,id,gender,name,summary,review,order,kunya,const DeepCollectionEquality().hash(_titles),const DeepCollectionEquality().hash(_aliases),const DeepCollectionEquality().hash(_categoryIds),death);

@override
String toString() {
  return 'CompanionSummary(id: $id, gender: $gender, name: $name, summary: $summary, review: $review, order: $order, kunya: $kunya, titles: $titles, aliases: $aliases, categoryIds: $categoryIds, death: $death)';
}


}

/// @nodoc
abstract mixin class _$CompanionSummaryCopyWith<$Res> implements $CompanionSummaryCopyWith<$Res> {
  factory _$CompanionSummaryCopyWith(_CompanionSummary value, $Res Function(_CompanionSummary) _then) = __$CompanionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, Gender gender, LocalizedText name, LocalizedText summary, ReviewInfo review, int? order, LocalizedText? kunya, List<LocalizedText> titles, List<String> aliases, List<String> categoryIds, HistoricalDate? death
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get summary;@override $ReviewInfoCopyWith<$Res> get review;@override $LocalizedTextCopyWith<$Res>? get kunya;

}
/// @nodoc
class __$CompanionSummaryCopyWithImpl<$Res>
    implements _$CompanionSummaryCopyWith<$Res> {
  __$CompanionSummaryCopyWithImpl(this._self, this._then);

  final _CompanionSummary _self;
  final $Res Function(_CompanionSummary) _then;

/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? gender = null,Object? name = null,Object? summary = null,Object? review = null,Object? order = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? categoryIds = null,Object? death = freezed,}) {
  return _then(_CompanionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedText?,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as List<String>,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as HistoricalDate?,
  ));
}

/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of CompanionSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}
}

/// @nodoc
mixin _$Companion {

 String get id; Gender get gender;/// The usual short name, e.g. أبو بكر الصديق.
 LocalizedText get name; LocalizedText get fullName; LocalizedText get summary; ReviewInfo get review;/// Work-level bibliography for the whole biography (source IDs).
 List<String> get references; int? get order; LocalizedText? get lineage; LocalizedText? get kunya; List<LocalizedText> get titles; List<String> get aliases; DatedClaim? get birth; DatedClaim? get death; LocalizedText? get deathPlace; List<Fact> get atAGlance; List<Membership> get memberships; List<Relation> get relations; List<BiographySection> get sections; List<String> get storyIds; List<TimelineEvent> get timeline;
/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanionCopyWith<Companion> get copyWith => _$CompanionCopyWithImpl<Companion>(this as Companion, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Companion&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.references, references)&&(identical(other.order, order) || other.order == order)&&(identical(other.lineage, lineage) || other.lineage == lineage)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other.titles, titles)&&const DeepCollectionEquality().equals(other.aliases, aliases)&&(identical(other.birth, birth) || other.birth == birth)&&(identical(other.death, death) || other.death == death)&&(identical(other.deathPlace, deathPlace) || other.deathPlace == deathPlace)&&const DeepCollectionEquality().equals(other.atAGlance, atAGlance)&&const DeepCollectionEquality().equals(other.memberships, memberships)&&const DeepCollectionEquality().equals(other.relations, relations)&&const DeepCollectionEquality().equals(other.sections, sections)&&const DeepCollectionEquality().equals(other.storyIds, storyIds)&&const DeepCollectionEquality().equals(other.timeline, timeline));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,gender,name,fullName,summary,review,const DeepCollectionEquality().hash(references),order,lineage,kunya,const DeepCollectionEquality().hash(titles),const DeepCollectionEquality().hash(aliases),birth,death,deathPlace,const DeepCollectionEquality().hash(atAGlance),const DeepCollectionEquality().hash(memberships),const DeepCollectionEquality().hash(relations),const DeepCollectionEquality().hash(sections),const DeepCollectionEquality().hash(storyIds),const DeepCollectionEquality().hash(timeline)]);

@override
String toString() {
  return 'Companion(id: $id, gender: $gender, name: $name, fullName: $fullName, summary: $summary, review: $review, references: $references, order: $order, lineage: $lineage, kunya: $kunya, titles: $titles, aliases: $aliases, birth: $birth, death: $death, deathPlace: $deathPlace, atAGlance: $atAGlance, memberships: $memberships, relations: $relations, sections: $sections, storyIds: $storyIds, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class $CompanionCopyWith<$Res>  {
  factory $CompanionCopyWith(Companion value, $Res Function(Companion) _then) = _$CompanionCopyWithImpl;
@useResult
$Res call({
 String id, Gender gender, LocalizedText name, LocalizedText fullName, LocalizedText summary, ReviewInfo review, List<String> references, int? order, LocalizedText? lineage, LocalizedText? kunya, List<LocalizedText> titles, List<String> aliases, DatedClaim? birth, DatedClaim? death, LocalizedText? deathPlace, List<Fact> atAGlance, List<Membership> memberships, List<Relation> relations, List<BiographySection> sections, List<String> storyIds, List<TimelineEvent> timeline
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get fullName;$LocalizedTextCopyWith<$Res> get summary;$ReviewInfoCopyWith<$Res> get review;$LocalizedTextCopyWith<$Res>? get lineage;$LocalizedTextCopyWith<$Res>? get kunya;$DatedClaimCopyWith<$Res>? get birth;$DatedClaimCopyWith<$Res>? get death;$LocalizedTextCopyWith<$Res>? get deathPlace;

}
/// @nodoc
class _$CompanionCopyWithImpl<$Res>
    implements $CompanionCopyWith<$Res> {
  _$CompanionCopyWithImpl(this._self, this._then);

  final Companion _self;
  final $Res Function(Companion) _then;

/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? gender = null,Object? name = null,Object? fullName = null,Object? summary = null,Object? review = null,Object? references = null,Object? order = freezed,Object? lineage = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? birth = freezed,Object? death = freezed,Object? deathPlace = freezed,Object? atAGlance = null,Object? memberships = null,Object? relations = null,Object? sections = null,Object? storyIds = null,Object? timeline = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,lineage: freezed == lineage ? _self.lineage : lineage // ignore: cast_nullable_to_non_nullable
as LocalizedText?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedText?,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,aliases: null == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,birth: freezed == birth ? _self.birth : birth // ignore: cast_nullable_to_non_nullable
as DatedClaim?,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as DatedClaim?,deathPlace: freezed == deathPlace ? _self.deathPlace : deathPlace // ignore: cast_nullable_to_non_nullable
as LocalizedText?,atAGlance: null == atAGlance ? _self.atAGlance : atAGlance // ignore: cast_nullable_to_non_nullable
as List<Fact>,memberships: null == memberships ? _self.memberships : memberships // ignore: cast_nullable_to_non_nullable
as List<Membership>,relations: null == relations ? _self.relations : relations // ignore: cast_nullable_to_non_nullable
as List<Relation>,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<BiographySection>,storyIds: null == storyIds ? _self.storyIds : storyIds // ignore: cast_nullable_to_non_nullable
as List<String>,timeline: null == timeline ? _self.timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineEvent>,
  ));
}
/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get fullName {
  
  return $LocalizedTextCopyWith<$Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get lineage {
    if (_self.lineage == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.lineage!, (value) {
    return _then(_self.copyWith(lineage: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimCopyWith<$Res>? get birth {
    if (_self.birth == null) {
    return null;
  }

  return $DatedClaimCopyWith<$Res>(_self.birth!, (value) {
    return _then(_self.copyWith(birth: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimCopyWith<$Res>? get death {
    if (_self.death == null) {
    return null;
  }

  return $DatedClaimCopyWith<$Res>(_self.death!, (value) {
    return _then(_self.copyWith(death: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get deathPlace {
    if (_self.deathPlace == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.deathPlace!, (value) {
    return _then(_self.copyWith(deathPlace: value));
  });
}
}


/// Adds pattern-matching-related methods to [Companion].
extension CompanionPatterns on Companion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Companion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Companion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Companion value)  $default,){
final _that = this;
switch (_that) {
case _Companion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Companion value)?  $default,){
final _that = this;
switch (_that) {
case _Companion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Gender gender,  LocalizedText name,  LocalizedText fullName,  LocalizedText summary,  ReviewInfo review,  List<String> references,  int? order,  LocalizedText? lineage,  LocalizedText? kunya,  List<LocalizedText> titles,  List<String> aliases,  DatedClaim? birth,  DatedClaim? death,  LocalizedText? deathPlace,  List<Fact> atAGlance,  List<Membership> memberships,  List<Relation> relations,  List<BiographySection> sections,  List<String> storyIds,  List<TimelineEvent> timeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Companion() when $default != null:
return $default(_that.id,_that.gender,_that.name,_that.fullName,_that.summary,_that.review,_that.references,_that.order,_that.lineage,_that.kunya,_that.titles,_that.aliases,_that.birth,_that.death,_that.deathPlace,_that.atAGlance,_that.memberships,_that.relations,_that.sections,_that.storyIds,_that.timeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Gender gender,  LocalizedText name,  LocalizedText fullName,  LocalizedText summary,  ReviewInfo review,  List<String> references,  int? order,  LocalizedText? lineage,  LocalizedText? kunya,  List<LocalizedText> titles,  List<String> aliases,  DatedClaim? birth,  DatedClaim? death,  LocalizedText? deathPlace,  List<Fact> atAGlance,  List<Membership> memberships,  List<Relation> relations,  List<BiographySection> sections,  List<String> storyIds,  List<TimelineEvent> timeline)  $default,) {final _that = this;
switch (_that) {
case _Companion():
return $default(_that.id,_that.gender,_that.name,_that.fullName,_that.summary,_that.review,_that.references,_that.order,_that.lineage,_that.kunya,_that.titles,_that.aliases,_that.birth,_that.death,_that.deathPlace,_that.atAGlance,_that.memberships,_that.relations,_that.sections,_that.storyIds,_that.timeline);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Gender gender,  LocalizedText name,  LocalizedText fullName,  LocalizedText summary,  ReviewInfo review,  List<String> references,  int? order,  LocalizedText? lineage,  LocalizedText? kunya,  List<LocalizedText> titles,  List<String> aliases,  DatedClaim? birth,  DatedClaim? death,  LocalizedText? deathPlace,  List<Fact> atAGlance,  List<Membership> memberships,  List<Relation> relations,  List<BiographySection> sections,  List<String> storyIds,  List<TimelineEvent> timeline)?  $default,) {final _that = this;
switch (_that) {
case _Companion() when $default != null:
return $default(_that.id,_that.gender,_that.name,_that.fullName,_that.summary,_that.review,_that.references,_that.order,_that.lineage,_that.kunya,_that.titles,_that.aliases,_that.birth,_that.death,_that.deathPlace,_that.atAGlance,_that.memberships,_that.relations,_that.sections,_that.storyIds,_that.timeline);case _:
  return null;

}
}

}

/// @nodoc


class _Companion implements Companion {
  const _Companion({required this.id, required this.gender, required this.name, required this.fullName, required this.summary, required this.review, required final  List<String> references, this.order, this.lineage, this.kunya, final  List<LocalizedText> titles = const <LocalizedText>[], final  List<String> aliases = const <String>[], this.birth, this.death, this.deathPlace, final  List<Fact> atAGlance = const <Fact>[], final  List<Membership> memberships = const <Membership>[], final  List<Relation> relations = const <Relation>[], final  List<BiographySection> sections = const <BiographySection>[], final  List<String> storyIds = const <String>[], final  List<TimelineEvent> timeline = const <TimelineEvent>[]}): _references = references,_titles = titles,_aliases = aliases,_atAGlance = atAGlance,_memberships = memberships,_relations = relations,_sections = sections,_storyIds = storyIds,_timeline = timeline;
  

@override final  String id;
@override final  Gender gender;
/// The usual short name, e.g. أبو بكر الصديق.
@override final  LocalizedText name;
@override final  LocalizedText fullName;
@override final  LocalizedText summary;
@override final  ReviewInfo review;
/// Work-level bibliography for the whole biography (source IDs).
 final  List<String> _references;
/// Work-level bibliography for the whole biography (source IDs).
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

@override final  int? order;
@override final  LocalizedText? lineage;
@override final  LocalizedText? kunya;
 final  List<LocalizedText> _titles;
@override@JsonKey() List<LocalizedText> get titles {
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

@override final  DatedClaim? birth;
@override final  DatedClaim? death;
@override final  LocalizedText? deathPlace;
 final  List<Fact> _atAGlance;
@override@JsonKey() List<Fact> get atAGlance {
  if (_atAGlance is EqualUnmodifiableListView) return _atAGlance;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_atAGlance);
}

 final  List<Membership> _memberships;
@override@JsonKey() List<Membership> get memberships {
  if (_memberships is EqualUnmodifiableListView) return _memberships;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberships);
}

 final  List<Relation> _relations;
@override@JsonKey() List<Relation> get relations {
  if (_relations is EqualUnmodifiableListView) return _relations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relations);
}

 final  List<BiographySection> _sections;
@override@JsonKey() List<BiographySection> get sections {
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

 final  List<TimelineEvent> _timeline;
@override@JsonKey() List<TimelineEvent> get timeline {
  if (_timeline is EqualUnmodifiableListView) return _timeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeline);
}


/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanionCopyWith<_Companion> get copyWith => __$CompanionCopyWithImpl<_Companion>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Companion&&(identical(other.id, id) || other.id == id)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.name, name) || other.name == name)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._references, _references)&&(identical(other.order, order) || other.order == order)&&(identical(other.lineage, lineage) || other.lineage == lineage)&&(identical(other.kunya, kunya) || other.kunya == kunya)&&const DeepCollectionEquality().equals(other._titles, _titles)&&const DeepCollectionEquality().equals(other._aliases, _aliases)&&(identical(other.birth, birth) || other.birth == birth)&&(identical(other.death, death) || other.death == death)&&(identical(other.deathPlace, deathPlace) || other.deathPlace == deathPlace)&&const DeepCollectionEquality().equals(other._atAGlance, _atAGlance)&&const DeepCollectionEquality().equals(other._memberships, _memberships)&&const DeepCollectionEquality().equals(other._relations, _relations)&&const DeepCollectionEquality().equals(other._sections, _sections)&&const DeepCollectionEquality().equals(other._storyIds, _storyIds)&&const DeepCollectionEquality().equals(other._timeline, _timeline));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,gender,name,fullName,summary,review,const DeepCollectionEquality().hash(_references),order,lineage,kunya,const DeepCollectionEquality().hash(_titles),const DeepCollectionEquality().hash(_aliases),birth,death,deathPlace,const DeepCollectionEquality().hash(_atAGlance),const DeepCollectionEquality().hash(_memberships),const DeepCollectionEquality().hash(_relations),const DeepCollectionEquality().hash(_sections),const DeepCollectionEquality().hash(_storyIds),const DeepCollectionEquality().hash(_timeline)]);

@override
String toString() {
  return 'Companion(id: $id, gender: $gender, name: $name, fullName: $fullName, summary: $summary, review: $review, references: $references, order: $order, lineage: $lineage, kunya: $kunya, titles: $titles, aliases: $aliases, birth: $birth, death: $death, deathPlace: $deathPlace, atAGlance: $atAGlance, memberships: $memberships, relations: $relations, sections: $sections, storyIds: $storyIds, timeline: $timeline)';
}


}

/// @nodoc
abstract mixin class _$CompanionCopyWith<$Res> implements $CompanionCopyWith<$Res> {
  factory _$CompanionCopyWith(_Companion value, $Res Function(_Companion) _then) = __$CompanionCopyWithImpl;
@override @useResult
$Res call({
 String id, Gender gender, LocalizedText name, LocalizedText fullName, LocalizedText summary, ReviewInfo review, List<String> references, int? order, LocalizedText? lineage, LocalizedText? kunya, List<LocalizedText> titles, List<String> aliases, DatedClaim? birth, DatedClaim? death, LocalizedText? deathPlace, List<Fact> atAGlance, List<Membership> memberships, List<Relation> relations, List<BiographySection> sections, List<String> storyIds, List<TimelineEvent> timeline
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get fullName;@override $LocalizedTextCopyWith<$Res> get summary;@override $ReviewInfoCopyWith<$Res> get review;@override $LocalizedTextCopyWith<$Res>? get lineage;@override $LocalizedTextCopyWith<$Res>? get kunya;@override $DatedClaimCopyWith<$Res>? get birth;@override $DatedClaimCopyWith<$Res>? get death;@override $LocalizedTextCopyWith<$Res>? get deathPlace;

}
/// @nodoc
class __$CompanionCopyWithImpl<$Res>
    implements _$CompanionCopyWith<$Res> {
  __$CompanionCopyWithImpl(this._self, this._then);

  final _Companion _self;
  final $Res Function(_Companion) _then;

/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? gender = null,Object? name = null,Object? fullName = null,Object? summary = null,Object? review = null,Object? references = null,Object? order = freezed,Object? lineage = freezed,Object? kunya = freezed,Object? titles = null,Object? aliases = null,Object? birth = freezed,Object? death = freezed,Object? deathPlace = freezed,Object? atAGlance = null,Object? memberships = null,Object? relations = null,Object? sections = null,Object? storyIds = null,Object? timeline = null,}) {
  return _then(_Companion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as Gender,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as LocalizedText,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int?,lineage: freezed == lineage ? _self.lineage : lineage // ignore: cast_nullable_to_non_nullable
as LocalizedText?,kunya: freezed == kunya ? _self.kunya : kunya // ignore: cast_nullable_to_non_nullable
as LocalizedText?,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<LocalizedText>,aliases: null == aliases ? _self._aliases : aliases // ignore: cast_nullable_to_non_nullable
as List<String>,birth: freezed == birth ? _self.birth : birth // ignore: cast_nullable_to_non_nullable
as DatedClaim?,death: freezed == death ? _self.death : death // ignore: cast_nullable_to_non_nullable
as DatedClaim?,deathPlace: freezed == deathPlace ? _self.deathPlace : deathPlace // ignore: cast_nullable_to_non_nullable
as LocalizedText?,atAGlance: null == atAGlance ? _self._atAGlance : atAGlance // ignore: cast_nullable_to_non_nullable
as List<Fact>,memberships: null == memberships ? _self._memberships : memberships // ignore: cast_nullable_to_non_nullable
as List<Membership>,relations: null == relations ? _self._relations : relations // ignore: cast_nullable_to_non_nullable
as List<Relation>,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<BiographySection>,storyIds: null == storyIds ? _self._storyIds : storyIds // ignore: cast_nullable_to_non_nullable
as List<String>,timeline: null == timeline ? _self._timeline : timeline // ignore: cast_nullable_to_non_nullable
as List<TimelineEvent>,
  ));
}

/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get fullName {
  
  return $LocalizedTextCopyWith<$Res>(_self.fullName, (value) {
    return _then(_self.copyWith(fullName: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get lineage {
    if (_self.lineage == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.lineage!, (value) {
    return _then(_self.copyWith(lineage: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get kunya {
    if (_self.kunya == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.kunya!, (value) {
    return _then(_self.copyWith(kunya: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimCopyWith<$Res>? get birth {
    if (_self.birth == null) {
    return null;
  }

  return $DatedClaimCopyWith<$Res>(_self.birth!, (value) {
    return _then(_self.copyWith(birth: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DatedClaimCopyWith<$Res>? get death {
    if (_self.death == null) {
    return null;
  }

  return $DatedClaimCopyWith<$Res>(_self.death!, (value) {
    return _then(_self.copyWith(death: value));
  });
}/// Create a copy of Companion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get deathPlace {
    if (_self.deathPlace == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.deathPlace!, (value) {
    return _then(_self.copyWith(deathPlace: value));
  });
}
}

// dart format on
