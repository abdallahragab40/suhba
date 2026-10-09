// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seerah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SeerahPeriod {

 String get id; LocalizedText get name; HistoricalDate get date; LocalizedText get summary; Reliability get reliability; List<Citation> get citations; List<String> get chapterIds;
/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahPeriodCopyWith<SeerahPeriod> get copyWith => _$SeerahPeriodCopyWithImpl<SeerahPeriod>(this as SeerahPeriod, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&const DeepCollectionEquality().equals(other.chapterIds, chapterIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,date,summary,reliability,const DeepCollectionEquality().hash(citations),const DeepCollectionEquality().hash(chapterIds));

@override
String toString() {
  return 'SeerahPeriod(id: $id, name: $name, date: $date, summary: $summary, reliability: $reliability, citations: $citations, chapterIds: $chapterIds)';
}


}

/// @nodoc
abstract mixin class $SeerahPeriodCopyWith<$Res>  {
  factory $SeerahPeriodCopyWith(SeerahPeriod value, $Res Function(SeerahPeriod) _then) = _$SeerahPeriodCopyWithImpl;
@useResult
$Res call({
 String id, LocalizedText name, HistoricalDate date, LocalizedText summary, Reliability reliability, List<Citation> citations, List<String> chapterIds
});


$LocalizedTextCopyWith<$Res> get name;$LocalizedTextCopyWith<$Res> get summary;

}
/// @nodoc
class _$SeerahPeriodCopyWithImpl<$Res>
    implements $SeerahPeriodCopyWith<$Res> {
  _$SeerahPeriodCopyWithImpl(this._self, this._then);

  final SeerahPeriod _self;
  final $Res Function(SeerahPeriod) _then;

/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? chapterIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,chapterIds: null == chapterIds ? _self.chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahPeriod].
extension SeerahPeriodPatterns on SeerahPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahPeriod value)  $default,){
final _that = this;
switch (_that) {
case _SeerahPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  HistoricalDate date,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  List<String> chapterIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahPeriod() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  LocalizedText name,  HistoricalDate date,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  List<String> chapterIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahPeriod():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  LocalizedText name,  HistoricalDate date,  LocalizedText summary,  Reliability reliability,  List<Citation> citations,  List<String> chapterIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahPeriod() when $default != null:
return $default(_that.id,_that.name,_that.date,_that.summary,_that.reliability,_that.citations,_that.chapterIds);case _:
  return null;

}
}

}

/// @nodoc


class _SeerahPeriod implements SeerahPeriod {
  const _SeerahPeriod({required this.id, required this.name, required this.date, required this.summary, required this.reliability, required final  List<Citation> citations, required final  List<String> chapterIds}): _citations = citations,_chapterIds = chapterIds;
  

@override final  String id;
@override final  LocalizedText name;
@override final  HistoricalDate date;
@override final  LocalizedText summary;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override List<Citation> get citations {
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


/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahPeriodCopyWith<_SeerahPeriod> get copyWith => __$SeerahPeriodCopyWithImpl<_SeerahPeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.date, date) || other.date == date)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&const DeepCollectionEquality().equals(other._chapterIds, _chapterIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,date,summary,reliability,const DeepCollectionEquality().hash(_citations),const DeepCollectionEquality().hash(_chapterIds));

@override
String toString() {
  return 'SeerahPeriod(id: $id, name: $name, date: $date, summary: $summary, reliability: $reliability, citations: $citations, chapterIds: $chapterIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahPeriodCopyWith<$Res> implements $SeerahPeriodCopyWith<$Res> {
  factory _$SeerahPeriodCopyWith(_SeerahPeriod value, $Res Function(_SeerahPeriod) _then) = __$SeerahPeriodCopyWithImpl;
@override @useResult
$Res call({
 String id, LocalizedText name, HistoricalDate date, LocalizedText summary, Reliability reliability, List<Citation> citations, List<String> chapterIds
});


@override $LocalizedTextCopyWith<$Res> get name;@override $LocalizedTextCopyWith<$Res> get summary;

}
/// @nodoc
class __$SeerahPeriodCopyWithImpl<$Res>
    implements _$SeerahPeriodCopyWith<$Res> {
  __$SeerahPeriodCopyWithImpl(this._self, this._then);

  final _SeerahPeriod _self;
  final $Res Function(_SeerahPeriod) _then;

/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? date = null,Object? summary = null,Object? reliability = null,Object? citations = null,Object? chapterIds = null,}) {
  return _then(_SeerahPeriod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as LocalizedText,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,chapterIds: null == chapterIds ? _self._chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get name {
  
  return $LocalizedTextCopyWith<$Res>(_self.name, (value) {
    return _then(_self.copyWith(name: value));
  });
}/// Create a copy of SeerahPeriod
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get summary {
  
  return $LocalizedTextCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
mixin _$SeerahCollection {

 LocalizedText get title; LocalizedText get subtitle; List<ContentBlock> get introduction; List<SeerahPeriod> get periods;/// Reading order.
 List<String> get chapterIds; List<String> get topicIds; LocalizedText get methodology; List<String> get references; ReviewInfo get review; List<String> get featuredEventIds; List<String> get featuredPlaceIds; List<String> get companionIds; List<String> get visualIds;
/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahCollectionCopyWith<SeerahCollection> get copyWith => _$SeerahCollectionCopyWithImpl<SeerahCollection>(this as SeerahCollection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahCollection&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other.introduction, introduction)&&const DeepCollectionEquality().equals(other.periods, periods)&&const DeepCollectionEquality().equals(other.chapterIds, chapterIds)&&const DeepCollectionEquality().equals(other.topicIds, topicIds)&&(identical(other.methodology, methodology) || other.methodology == methodology)&&const DeepCollectionEquality().equals(other.references, references)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other.featuredEventIds, featuredEventIds)&&const DeepCollectionEquality().equals(other.featuredPlaceIds, featuredPlaceIds)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&const DeepCollectionEquality().equals(other.visualIds, visualIds));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle,const DeepCollectionEquality().hash(introduction),const DeepCollectionEquality().hash(periods),const DeepCollectionEquality().hash(chapterIds),const DeepCollectionEquality().hash(topicIds),methodology,const DeepCollectionEquality().hash(references),review,const DeepCollectionEquality().hash(featuredEventIds),const DeepCollectionEquality().hash(featuredPlaceIds),const DeepCollectionEquality().hash(companionIds),const DeepCollectionEquality().hash(visualIds));

@override
String toString() {
  return 'SeerahCollection(title: $title, subtitle: $subtitle, introduction: $introduction, periods: $periods, chapterIds: $chapterIds, topicIds: $topicIds, methodology: $methodology, references: $references, review: $review, featuredEventIds: $featuredEventIds, featuredPlaceIds: $featuredPlaceIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class $SeerahCollectionCopyWith<$Res>  {
  factory $SeerahCollectionCopyWith(SeerahCollection value, $Res Function(SeerahCollection) _then) = _$SeerahCollectionCopyWithImpl;
@useResult
$Res call({
 LocalizedText title, LocalizedText subtitle, List<ContentBlock> introduction, List<SeerahPeriod> periods, List<String> chapterIds, List<String> topicIds, LocalizedText methodology, List<String> references, ReviewInfo review, List<String> featuredEventIds, List<String> featuredPlaceIds, List<String> companionIds, List<String> visualIds
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get subtitle;$LocalizedTextCopyWith<$Res> get methodology;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahCollectionCopyWithImpl<$Res>
    implements $SeerahCollectionCopyWith<$Res> {
  _$SeerahCollectionCopyWithImpl(this._self, this._then);

  final SeerahCollection _self;
  final $Res Function(SeerahCollection) _then;

/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? subtitle = null,Object? introduction = null,Object? periods = null,Object? chapterIds = null,Object? topicIds = null,Object? methodology = null,Object? references = null,Object? review = null,Object? featuredEventIds = null,Object? featuredPlaceIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as LocalizedText,introduction: null == introduction ? _self.introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<SeerahPeriod>,chapterIds: null == chapterIds ? _self.chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,topicIds: null == topicIds ? _self.topicIds : topicIds // ignore: cast_nullable_to_non_nullable
as List<String>,methodology: null == methodology ? _self.methodology : methodology // ignore: cast_nullable_to_non_nullable
as LocalizedText,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,featuredEventIds: null == featuredEventIds ? _self.featuredEventIds : featuredEventIds // ignore: cast_nullable_to_non_nullable
as List<String>,featuredPlaceIds: null == featuredPlaceIds ? _self.featuredPlaceIds : featuredPlaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self.visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get subtitle {
  
  return $LocalizedTextCopyWith<$Res>(_self.subtitle, (value) {
    return _then(_self.copyWith(subtitle: value));
  });
}/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get methodology {
  
  return $LocalizedTextCopyWith<$Res>(_self.methodology, (value) {
    return _then(_self.copyWith(methodology: value));
  });
}/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahCollection].
extension SeerahCollectionPatterns on SeerahCollection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahCollection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahCollection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahCollection value)  $default,){
final _that = this;
switch (_that) {
case _SeerahCollection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahCollection value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahCollection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedText title,  LocalizedText subtitle,  List<ContentBlock> introduction,  List<SeerahPeriod> periods,  List<String> chapterIds,  List<String> topicIds,  LocalizedText methodology,  List<String> references,  ReviewInfo review,  List<String> featuredEventIds,  List<String> featuredPlaceIds,  List<String> companionIds,  List<String> visualIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahCollection() when $default != null:
return $default(_that.title,_that.subtitle,_that.introduction,_that.periods,_that.chapterIds,_that.topicIds,_that.methodology,_that.references,_that.review,_that.featuredEventIds,_that.featuredPlaceIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedText title,  LocalizedText subtitle,  List<ContentBlock> introduction,  List<SeerahPeriod> periods,  List<String> chapterIds,  List<String> topicIds,  LocalizedText methodology,  List<String> references,  ReviewInfo review,  List<String> featuredEventIds,  List<String> featuredPlaceIds,  List<String> companionIds,  List<String> visualIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahCollection():
return $default(_that.title,_that.subtitle,_that.introduction,_that.periods,_that.chapterIds,_that.topicIds,_that.methodology,_that.references,_that.review,_that.featuredEventIds,_that.featuredPlaceIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedText title,  LocalizedText subtitle,  List<ContentBlock> introduction,  List<SeerahPeriod> periods,  List<String> chapterIds,  List<String> topicIds,  LocalizedText methodology,  List<String> references,  ReviewInfo review,  List<String> featuredEventIds,  List<String> featuredPlaceIds,  List<String> companionIds,  List<String> visualIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahCollection() when $default != null:
return $default(_that.title,_that.subtitle,_that.introduction,_that.periods,_that.chapterIds,_that.topicIds,_that.methodology,_that.references,_that.review,_that.featuredEventIds,_that.featuredPlaceIds,_that.companionIds,_that.visualIds);case _:
  return null;

}
}

}

/// @nodoc


class _SeerahCollection implements SeerahCollection {
  const _SeerahCollection({required this.title, required this.subtitle, required final  List<ContentBlock> introduction, required final  List<SeerahPeriod> periods, required final  List<String> chapterIds, required final  List<String> topicIds, required this.methodology, required final  List<String> references, required this.review, final  List<String> featuredEventIds = const <String>[], final  List<String> featuredPlaceIds = const <String>[], final  List<String> companionIds = const <String>[], final  List<String> visualIds = const <String>[]}): _introduction = introduction,_periods = periods,_chapterIds = chapterIds,_topicIds = topicIds,_references = references,_featuredEventIds = featuredEventIds,_featuredPlaceIds = featuredPlaceIds,_companionIds = companionIds,_visualIds = visualIds;
  

@override final  LocalizedText title;
@override final  LocalizedText subtitle;
 final  List<ContentBlock> _introduction;
@override List<ContentBlock> get introduction {
  if (_introduction is EqualUnmodifiableListView) return _introduction;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_introduction);
}

 final  List<SeerahPeriod> _periods;
@override List<SeerahPeriod> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}

/// Reading order.
 final  List<String> _chapterIds;
/// Reading order.
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

@override final  LocalizedText methodology;
 final  List<String> _references;
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

@override final  ReviewInfo review;
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


/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahCollectionCopyWith<_SeerahCollection> get copyWith => __$SeerahCollectionCopyWithImpl<_SeerahCollection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahCollection&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&const DeepCollectionEquality().equals(other._introduction, _introduction)&&const DeepCollectionEquality().equals(other._periods, _periods)&&const DeepCollectionEquality().equals(other._chapterIds, _chapterIds)&&const DeepCollectionEquality().equals(other._topicIds, _topicIds)&&(identical(other.methodology, methodology) || other.methodology == methodology)&&const DeepCollectionEquality().equals(other._references, _references)&&(identical(other.review, review) || other.review == review)&&const DeepCollectionEquality().equals(other._featuredEventIds, _featuredEventIds)&&const DeepCollectionEquality().equals(other._featuredPlaceIds, _featuredPlaceIds)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&const DeepCollectionEquality().equals(other._visualIds, _visualIds));
}


@override
int get hashCode => Object.hash(runtimeType,title,subtitle,const DeepCollectionEquality().hash(_introduction),const DeepCollectionEquality().hash(_periods),const DeepCollectionEquality().hash(_chapterIds),const DeepCollectionEquality().hash(_topicIds),methodology,const DeepCollectionEquality().hash(_references),review,const DeepCollectionEquality().hash(_featuredEventIds),const DeepCollectionEquality().hash(_featuredPlaceIds),const DeepCollectionEquality().hash(_companionIds),const DeepCollectionEquality().hash(_visualIds));

@override
String toString() {
  return 'SeerahCollection(title: $title, subtitle: $subtitle, introduction: $introduction, periods: $periods, chapterIds: $chapterIds, topicIds: $topicIds, methodology: $methodology, references: $references, review: $review, featuredEventIds: $featuredEventIds, featuredPlaceIds: $featuredPlaceIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahCollectionCopyWith<$Res> implements $SeerahCollectionCopyWith<$Res> {
  factory _$SeerahCollectionCopyWith(_SeerahCollection value, $Res Function(_SeerahCollection) _then) = __$SeerahCollectionCopyWithImpl;
@override @useResult
$Res call({
 LocalizedText title, LocalizedText subtitle, List<ContentBlock> introduction, List<SeerahPeriod> periods, List<String> chapterIds, List<String> topicIds, LocalizedText methodology, List<String> references, ReviewInfo review, List<String> featuredEventIds, List<String> featuredPlaceIds, List<String> companionIds, List<String> visualIds
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get subtitle;@override $LocalizedTextCopyWith<$Res> get methodology;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahCollectionCopyWithImpl<$Res>
    implements _$SeerahCollectionCopyWith<$Res> {
  __$SeerahCollectionCopyWithImpl(this._self, this._then);

  final _SeerahCollection _self;
  final $Res Function(_SeerahCollection) _then;

/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? subtitle = null,Object? introduction = null,Object? periods = null,Object? chapterIds = null,Object? topicIds = null,Object? methodology = null,Object? references = null,Object? review = null,Object? featuredEventIds = null,Object? featuredPlaceIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_SeerahCollection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as LocalizedText,introduction: null == introduction ? _self._introduction : introduction // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<SeerahPeriod>,chapterIds: null == chapterIds ? _self._chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,topicIds: null == topicIds ? _self._topicIds : topicIds // ignore: cast_nullable_to_non_nullable
as List<String>,methodology: null == methodology ? _self.methodology : methodology // ignore: cast_nullable_to_non_nullable
as LocalizedText,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,featuredEventIds: null == featuredEventIds ? _self._featuredEventIds : featuredEventIds // ignore: cast_nullable_to_non_nullable
as List<String>,featuredPlaceIds: null == featuredPlaceIds ? _self._featuredPlaceIds : featuredPlaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self._visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get subtitle {
  
  return $LocalizedTextCopyWith<$Res>(_self.subtitle, (value) {
    return _then(_self.copyWith(subtitle: value));
  });
}/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get methodology {
  
  return $LocalizedTextCopyWith<$Res>(_self.methodology, (value) {
    return _then(_self.copyWith(methodology: value));
  });
}/// Create a copy of SeerahCollection
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

/// @nodoc
mixin _$SeerahChapterSummary {

 String get id;/// 1-based position in the reading order.
 int get number; LocalizedText get title; LocalizedText get abstract; SeerahEra get era; HistoricalDate get date; ReviewInfo get review;/// Words of readable prose, for an estimated reading time.
 int get wordCount; List<String> get visualIds;
/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahChapterSummaryCopyWith<SeerahChapterSummary> get copyWith => _$SeerahChapterSummaryCopyWithImpl<SeerahChapterSummary>(this as SeerahChapterSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahChapterSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&const DeepCollectionEquality().equals(other.visualIds, visualIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,era,date,review,wordCount,const DeepCollectionEquality().hash(visualIds));

@override
String toString() {
  return 'SeerahChapterSummary(id: $id, number: $number, title: $title, abstract: $abstract, era: $era, date: $date, review: $review, wordCount: $wordCount, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class $SeerahChapterSummaryCopyWith<$Res>  {
  factory $SeerahChapterSummaryCopyWith(SeerahChapterSummary value, $Res Function(SeerahChapterSummary) _then) = _$SeerahChapterSummaryCopyWithImpl;
@useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, SeerahEra era, HistoricalDate date, ReviewInfo review, int wordCount, List<String> visualIds
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get abstract;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahChapterSummaryCopyWithImpl<$Res>
    implements $SeerahChapterSummaryCopyWith<$Res> {
  _$SeerahChapterSummaryCopyWithImpl(this._self, this._then);

  final SeerahChapterSummary _self;
  final $Res Function(SeerahChapterSummary) _then;

/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? review = null,Object? wordCount = null,Object? visualIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,visualIds: null == visualIds ? _self.visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahChapterSummary].
extension SeerahChapterSummaryPatterns on SeerahChapterSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahChapterSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahChapterSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahChapterSummary value)  $default,){
final _that = this;
switch (_that) {
case _SeerahChapterSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahChapterSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahChapterSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  SeerahEra era,  HistoricalDate date,  ReviewInfo review,  int wordCount,  List<String> visualIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahChapterSummary() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.era,_that.date,_that.review,_that.wordCount,_that.visualIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  SeerahEra era,  HistoricalDate date,  ReviewInfo review,  int wordCount,  List<String> visualIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahChapterSummary():
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.era,_that.date,_that.review,_that.wordCount,_that.visualIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  SeerahEra era,  HistoricalDate date,  ReviewInfo review,  int wordCount,  List<String> visualIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahChapterSummary() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.era,_that.date,_that.review,_that.wordCount,_that.visualIds);case _:
  return null;

}
}

}

/// @nodoc


class _SeerahChapterSummary implements SeerahChapterSummary {
  const _SeerahChapterSummary({required this.id, required this.number, required this.title, required this.abstract, required this.era, required this.date, required this.review, required this.wordCount, final  List<String> visualIds = const <String>[]}): _visualIds = visualIds;
  

@override final  String id;
/// 1-based position in the reading order.
@override final  int number;
@override final  LocalizedText title;
@override final  LocalizedText abstract;
@override final  SeerahEra era;
@override final  HistoricalDate date;
@override final  ReviewInfo review;
/// Words of readable prose, for an estimated reading time.
@override final  int wordCount;
 final  List<String> _visualIds;
@override@JsonKey() List<String> get visualIds {
  if (_visualIds is EqualUnmodifiableListView) return _visualIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_visualIds);
}


/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahChapterSummaryCopyWith<_SeerahChapterSummary> get copyWith => __$SeerahChapterSummaryCopyWithImpl<_SeerahChapterSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahChapterSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&const DeepCollectionEquality().equals(other._visualIds, _visualIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,era,date,review,wordCount,const DeepCollectionEquality().hash(_visualIds));

@override
String toString() {
  return 'SeerahChapterSummary(id: $id, number: $number, title: $title, abstract: $abstract, era: $era, date: $date, review: $review, wordCount: $wordCount, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahChapterSummaryCopyWith<$Res> implements $SeerahChapterSummaryCopyWith<$Res> {
  factory _$SeerahChapterSummaryCopyWith(_SeerahChapterSummary value, $Res Function(_SeerahChapterSummary) _then) = __$SeerahChapterSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, SeerahEra era, HistoricalDate date, ReviewInfo review, int wordCount, List<String> visualIds
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get abstract;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahChapterSummaryCopyWithImpl<$Res>
    implements _$SeerahChapterSummaryCopyWith<$Res> {
  __$SeerahChapterSummaryCopyWithImpl(this._self, this._then);

  final _SeerahChapterSummary _self;
  final $Res Function(_SeerahChapterSummary) _then;

/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? review = null,Object? wordCount = null,Object? visualIds = null,}) {
  return _then(_SeerahChapterSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,visualIds: null == visualIds ? _self._visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapterSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

/// @nodoc
mixin _$SeerahChapter {

 String get id; int get number; LocalizedText get title; LocalizedText get abstract; SeerahEra get era; HistoricalDate get date; List<String> get references; List<ContentBlock> get blocks; ReviewInfo get review;/// Fingerprint of the chapter's content; changes whenever it is edited.
 String get revision; List<String> get eventIds; List<String> get placeIds; List<String> get companionIds; List<String> get visualIds;
/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahChapterCopyWith<SeerahChapter> get copyWith => _$SeerahChapterCopyWithImpl<SeerahChapter>(this as SeerahChapter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.references, references)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&(identical(other.review, review) || other.review == review)&&(identical(other.revision, revision) || other.revision == revision)&&const DeepCollectionEquality().equals(other.eventIds, eventIds)&&const DeepCollectionEquality().equals(other.placeIds, placeIds)&&const DeepCollectionEquality().equals(other.companionIds, companionIds)&&const DeepCollectionEquality().equals(other.visualIds, visualIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,era,date,const DeepCollectionEquality().hash(references),const DeepCollectionEquality().hash(blocks),review,revision,const DeepCollectionEquality().hash(eventIds),const DeepCollectionEquality().hash(placeIds),const DeepCollectionEquality().hash(companionIds),const DeepCollectionEquality().hash(visualIds));

@override
String toString() {
  return 'SeerahChapter(id: $id, number: $number, title: $title, abstract: $abstract, era: $era, date: $date, references: $references, blocks: $blocks, review: $review, revision: $revision, eventIds: $eventIds, placeIds: $placeIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class $SeerahChapterCopyWith<$Res>  {
  factory $SeerahChapterCopyWith(SeerahChapter value, $Res Function(SeerahChapter) _then) = _$SeerahChapterCopyWithImpl;
@useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, SeerahEra era, HistoricalDate date, List<String> references, List<ContentBlock> blocks, ReviewInfo review, String revision, List<String> eventIds, List<String> placeIds, List<String> companionIds, List<String> visualIds
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get abstract;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahChapterCopyWithImpl<$Res>
    implements $SeerahChapterCopyWith<$Res> {
  _$SeerahChapterCopyWithImpl(this._self, this._then);

  final SeerahChapter _self;
  final $Res Function(SeerahChapter) _then;

/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? references = null,Object? blocks = null,Object? review = null,Object? revision = null,Object? eventIds = null,Object? placeIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self.eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,placeIds: null == placeIds ? _self.placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self.visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahChapter].
extension SeerahChapterPatterns on SeerahChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahChapter value)  $default,){
final _that = this;
switch (_that) {
case _SeerahChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahChapter value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  SeerahEra era,  HistoricalDate date,  List<String> references,  List<ContentBlock> blocks,  ReviewInfo review,  String revision,  List<String> eventIds,  List<String> placeIds,  List<String> companionIds,  List<String> visualIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahChapter() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.era,_that.date,_that.references,_that.blocks,_that.review,_that.revision,_that.eventIds,_that.placeIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  SeerahEra era,  HistoricalDate date,  List<String> references,  List<ContentBlock> blocks,  ReviewInfo review,  String revision,  List<String> eventIds,  List<String> placeIds,  List<String> companionIds,  List<String> visualIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahChapter():
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.era,_that.date,_that.references,_that.blocks,_that.review,_that.revision,_that.eventIds,_that.placeIds,_that.companionIds,_that.visualIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  SeerahEra era,  HistoricalDate date,  List<String> references,  List<ContentBlock> blocks,  ReviewInfo review,  String revision,  List<String> eventIds,  List<String> placeIds,  List<String> companionIds,  List<String> visualIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahChapter() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.era,_that.date,_that.references,_that.blocks,_that.review,_that.revision,_that.eventIds,_that.placeIds,_that.companionIds,_that.visualIds);case _:
  return null;

}
}

}

/// @nodoc


class _SeerahChapter implements SeerahChapter {
  const _SeerahChapter({required this.id, required this.number, required this.title, required this.abstract, required this.era, required this.date, required final  List<String> references, required final  List<ContentBlock> blocks, required this.review, required this.revision, final  List<String> eventIds = const <String>[], final  List<String> placeIds = const <String>[], final  List<String> companionIds = const <String>[], final  List<String> visualIds = const <String>[]}): _references = references,_blocks = blocks,_eventIds = eventIds,_placeIds = placeIds,_companionIds = companionIds,_visualIds = visualIds;
  

@override final  String id;
@override final  int number;
@override final  LocalizedText title;
@override final  LocalizedText abstract;
@override final  SeerahEra era;
@override final  HistoricalDate date;
 final  List<String> _references;
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

 final  List<ContentBlock> _blocks;
@override List<ContentBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

@override final  ReviewInfo review;
/// Fingerprint of the chapter's content; changes whenever it is edited.
@override final  String revision;
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


/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahChapterCopyWith<_SeerahChapter> get copyWith => __$SeerahChapterCopyWithImpl<_SeerahChapter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.era, era) || other.era == era)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._references, _references)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&(identical(other.review, review) || other.review == review)&&(identical(other.revision, revision) || other.revision == revision)&&const DeepCollectionEquality().equals(other._eventIds, _eventIds)&&const DeepCollectionEquality().equals(other._placeIds, _placeIds)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds)&&const DeepCollectionEquality().equals(other._visualIds, _visualIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,era,date,const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_blocks),review,revision,const DeepCollectionEquality().hash(_eventIds),const DeepCollectionEquality().hash(_placeIds),const DeepCollectionEquality().hash(_companionIds),const DeepCollectionEquality().hash(_visualIds));

@override
String toString() {
  return 'SeerahChapter(id: $id, number: $number, title: $title, abstract: $abstract, era: $era, date: $date, references: $references, blocks: $blocks, review: $review, revision: $revision, eventIds: $eventIds, placeIds: $placeIds, companionIds: $companionIds, visualIds: $visualIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahChapterCopyWith<$Res> implements $SeerahChapterCopyWith<$Res> {
  factory _$SeerahChapterCopyWith(_SeerahChapter value, $Res Function(_SeerahChapter) _then) = __$SeerahChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, SeerahEra era, HistoricalDate date, List<String> references, List<ContentBlock> blocks, ReviewInfo review, String revision, List<String> eventIds, List<String> placeIds, List<String> companionIds, List<String> visualIds
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get abstract;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahChapterCopyWithImpl<$Res>
    implements _$SeerahChapterCopyWith<$Res> {
  __$SeerahChapterCopyWithImpl(this._self, this._then);

  final _SeerahChapter _self;
  final $Res Function(_SeerahChapter) _then;

/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? era = null,Object? date = null,Object? references = null,Object? blocks = null,Object? review = null,Object? revision = null,Object? eventIds = null,Object? placeIds = null,Object? companionIds = null,Object? visualIds = null,}) {
  return _then(_SeerahChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,era: null == era ? _self.era : era // ignore: cast_nullable_to_non_nullable
as SeerahEra,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,eventIds: null == eventIds ? _self._eventIds : eventIds // ignore: cast_nullable_to_non_nullable
as List<String>,placeIds: null == placeIds ? _self._placeIds : placeIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,visualIds: null == visualIds ? _self._visualIds : visualIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahChapter
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

/// @nodoc
mixin _$SeerahTopicSummary {

 String get id; int get number; LocalizedText get title; LocalizedText get abstract; ReviewInfo get review; int get wordCount;
/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahTopicSummaryCopyWith<SeerahTopicSummary> get copyWith => _$SeerahTopicSummaryCopyWithImpl<SeerahTopicSummary>(this as SeerahTopicSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahTopicSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,review,wordCount);

@override
String toString() {
  return 'SeerahTopicSummary(id: $id, number: $number, title: $title, abstract: $abstract, review: $review, wordCount: $wordCount)';
}


}

/// @nodoc
abstract mixin class $SeerahTopicSummaryCopyWith<$Res>  {
  factory $SeerahTopicSummaryCopyWith(SeerahTopicSummary value, $Res Function(SeerahTopicSummary) _then) = _$SeerahTopicSummaryCopyWithImpl;
@useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, ReviewInfo review, int wordCount
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get abstract;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahTopicSummaryCopyWithImpl<$Res>
    implements $SeerahTopicSummaryCopyWith<$Res> {
  _$SeerahTopicSummaryCopyWithImpl(this._self, this._then);

  final SeerahTopicSummary _self;
  final $Res Function(SeerahTopicSummary) _then;

/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? review = null,Object? wordCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahTopicSummary].
extension SeerahTopicSummaryPatterns on SeerahTopicSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahTopicSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahTopicSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahTopicSummary value)  $default,){
final _that = this;
switch (_that) {
case _SeerahTopicSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahTopicSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahTopicSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  ReviewInfo review,  int wordCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahTopicSummary() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.review,_that.wordCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  ReviewInfo review,  int wordCount)  $default,) {final _that = this;
switch (_that) {
case _SeerahTopicSummary():
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.review,_that.wordCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  ReviewInfo review,  int wordCount)?  $default,) {final _that = this;
switch (_that) {
case _SeerahTopicSummary() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.review,_that.wordCount);case _:
  return null;

}
}

}

/// @nodoc


class _SeerahTopicSummary implements SeerahTopicSummary {
  const _SeerahTopicSummary({required this.id, required this.number, required this.title, required this.abstract, required this.review, required this.wordCount});
  

@override final  String id;
@override final  int number;
@override final  LocalizedText title;
@override final  LocalizedText abstract;
@override final  ReviewInfo review;
@override final  int wordCount;

/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahTopicSummaryCopyWith<_SeerahTopicSummary> get copyWith => __$SeerahTopicSummaryCopyWithImpl<_SeerahTopicSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahTopicSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&(identical(other.review, review) || other.review == review)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,review,wordCount);

@override
String toString() {
  return 'SeerahTopicSummary(id: $id, number: $number, title: $title, abstract: $abstract, review: $review, wordCount: $wordCount)';
}


}

/// @nodoc
abstract mixin class _$SeerahTopicSummaryCopyWith<$Res> implements $SeerahTopicSummaryCopyWith<$Res> {
  factory _$SeerahTopicSummaryCopyWith(_SeerahTopicSummary value, $Res Function(_SeerahTopicSummary) _then) = __$SeerahTopicSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, ReviewInfo review, int wordCount
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get abstract;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahTopicSummaryCopyWithImpl<$Res>
    implements _$SeerahTopicSummaryCopyWith<$Res> {
  __$SeerahTopicSummaryCopyWithImpl(this._self, this._then);

  final _SeerahTopicSummary _self;
  final $Res Function(_SeerahTopicSummary) _then;

/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? review = null,Object? wordCount = null,}) {
  return _then(_SeerahTopicSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,wordCount: null == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopicSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

/// @nodoc
mixin _$SeerahTopic {

 String get id; int get number; LocalizedText get title; LocalizedText get abstract; List<String> get references; List<ContentBlock> get blocks; ReviewInfo get review; String get revision; List<String> get chapterIds; List<String> get companionIds;
/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahTopicCopyWith<SeerahTopic> get copyWith => _$SeerahTopicCopyWithImpl<SeerahTopic>(this as SeerahTopic, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&const DeepCollectionEquality().equals(other.references, references)&&const DeepCollectionEquality().equals(other.blocks, blocks)&&(identical(other.review, review) || other.review == review)&&(identical(other.revision, revision) || other.revision == revision)&&const DeepCollectionEquality().equals(other.chapterIds, chapterIds)&&const DeepCollectionEquality().equals(other.companionIds, companionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,const DeepCollectionEquality().hash(references),const DeepCollectionEquality().hash(blocks),review,revision,const DeepCollectionEquality().hash(chapterIds),const DeepCollectionEquality().hash(companionIds));

@override
String toString() {
  return 'SeerahTopic(id: $id, number: $number, title: $title, abstract: $abstract, references: $references, blocks: $blocks, review: $review, revision: $revision, chapterIds: $chapterIds, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class $SeerahTopicCopyWith<$Res>  {
  factory $SeerahTopicCopyWith(SeerahTopic value, $Res Function(SeerahTopic) _then) = _$SeerahTopicCopyWithImpl;
@useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, List<String> references, List<ContentBlock> blocks, ReviewInfo review, String revision, List<String> chapterIds, List<String> companionIds
});


$LocalizedTextCopyWith<$Res> get title;$LocalizedTextCopyWith<$Res> get abstract;$ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class _$SeerahTopicCopyWithImpl<$Res>
    implements $SeerahTopicCopyWith<$Res> {
  _$SeerahTopicCopyWithImpl(this._self, this._then);

  final SeerahTopic _self;
  final $Res Function(SeerahTopic) _then;

/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? references = null,Object? blocks = null,Object? review = null,Object? revision = null,Object? chapterIds = null,Object? companionIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,chapterIds: null == chapterIds ? _self.chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self.companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahTopic].
extension SeerahTopicPatterns on SeerahTopic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahTopic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahTopic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahTopic value)  $default,){
final _that = this;
switch (_that) {
case _SeerahTopic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahTopic value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahTopic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  List<String> references,  List<ContentBlock> blocks,  ReviewInfo review,  String revision,  List<String> chapterIds,  List<String> companionIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahTopic() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.references,_that.blocks,_that.review,_that.revision,_that.chapterIds,_that.companionIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  List<String> references,  List<ContentBlock> blocks,  ReviewInfo review,  String revision,  List<String> chapterIds,  List<String> companionIds)  $default,) {final _that = this;
switch (_that) {
case _SeerahTopic():
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.references,_that.blocks,_that.review,_that.revision,_that.chapterIds,_that.companionIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int number,  LocalizedText title,  LocalizedText abstract,  List<String> references,  List<ContentBlock> blocks,  ReviewInfo review,  String revision,  List<String> chapterIds,  List<String> companionIds)?  $default,) {final _that = this;
switch (_that) {
case _SeerahTopic() when $default != null:
return $default(_that.id,_that.number,_that.title,_that.abstract,_that.references,_that.blocks,_that.review,_that.revision,_that.chapterIds,_that.companionIds);case _:
  return null;

}
}

}

/// @nodoc


class _SeerahTopic implements SeerahTopic {
  const _SeerahTopic({required this.id, required this.number, required this.title, required this.abstract, required final  List<String> references, required final  List<ContentBlock> blocks, required this.review, required this.revision, final  List<String> chapterIds = const <String>[], final  List<String> companionIds = const <String>[]}): _references = references,_blocks = blocks,_chapterIds = chapterIds,_companionIds = companionIds;
  

@override final  String id;
@override final  int number;
@override final  LocalizedText title;
@override final  LocalizedText abstract;
 final  List<String> _references;
@override List<String> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

 final  List<ContentBlock> _blocks;
@override List<ContentBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}

@override final  ReviewInfo review;
@override final  String revision;
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


/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahTopicCopyWith<_SeerahTopic> get copyWith => __$SeerahTopicCopyWithImpl<_SeerahTopic>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.title, title) || other.title == title)&&(identical(other.abstract, abstract) || other.abstract == abstract)&&const DeepCollectionEquality().equals(other._references, _references)&&const DeepCollectionEquality().equals(other._blocks, _blocks)&&(identical(other.review, review) || other.review == review)&&(identical(other.revision, revision) || other.revision == revision)&&const DeepCollectionEquality().equals(other._chapterIds, _chapterIds)&&const DeepCollectionEquality().equals(other._companionIds, _companionIds));
}


@override
int get hashCode => Object.hash(runtimeType,id,number,title,abstract,const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_blocks),review,revision,const DeepCollectionEquality().hash(_chapterIds),const DeepCollectionEquality().hash(_companionIds));

@override
String toString() {
  return 'SeerahTopic(id: $id, number: $number, title: $title, abstract: $abstract, references: $references, blocks: $blocks, review: $review, revision: $revision, chapterIds: $chapterIds, companionIds: $companionIds)';
}


}

/// @nodoc
abstract mixin class _$SeerahTopicCopyWith<$Res> implements $SeerahTopicCopyWith<$Res> {
  factory _$SeerahTopicCopyWith(_SeerahTopic value, $Res Function(_SeerahTopic) _then) = __$SeerahTopicCopyWithImpl;
@override @useResult
$Res call({
 String id, int number, LocalizedText title, LocalizedText abstract, List<String> references, List<ContentBlock> blocks, ReviewInfo review, String revision, List<String> chapterIds, List<String> companionIds
});


@override $LocalizedTextCopyWith<$Res> get title;@override $LocalizedTextCopyWith<$Res> get abstract;@override $ReviewInfoCopyWith<$Res> get review;

}
/// @nodoc
class __$SeerahTopicCopyWithImpl<$Res>
    implements _$SeerahTopicCopyWith<$Res> {
  __$SeerahTopicCopyWithImpl(this._self, this._then);

  final _SeerahTopic _self;
  final $Res Function(_SeerahTopic) _then;

/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? title = null,Object? abstract = null,Object? references = null,Object? blocks = null,Object? review = null,Object? revision = null,Object? chapterIds = null,Object? companionIds = null,}) {
  return _then(_SeerahTopic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as LocalizedText,abstract: null == abstract ? _self.abstract : abstract // ignore: cast_nullable_to_non_nullable
as LocalizedText,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<String>,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<ContentBlock>,review: null == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as ReviewInfo,revision: null == revision ? _self.revision : revision // ignore: cast_nullable_to_non_nullable
as String,chapterIds: null == chapterIds ? _self._chapterIds : chapterIds // ignore: cast_nullable_to_non_nullable
as List<String>,companionIds: null == companionIds ? _self._companionIds : companionIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get title {
  
  return $LocalizedTextCopyWith<$Res>(_self.title, (value) {
    return _then(_self.copyWith(title: value));
  });
}/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get abstract {
  
  return $LocalizedTextCopyWith<$Res>(_self.abstract, (value) {
    return _then(_self.copyWith(abstract: value));
  });
}/// Create a copy of SeerahTopic
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInfoCopyWith<$Res> get review {
  
  return $ReviewInfoCopyWith<$Res>(_self.review, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}

/// @nodoc
mixin _$SeerahIndex {

 SeerahCollection get collection; List<SeerahChapterSummary> get chapters; List<SeerahTopicSummary> get topics;
/// Create a copy of SeerahIndex
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeerahIndexCopyWith<SeerahIndex> get copyWith => _$SeerahIndexCopyWithImpl<SeerahIndex>(this as SeerahIndex, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeerahIndex&&(identical(other.collection, collection) || other.collection == collection)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&const DeepCollectionEquality().equals(other.topics, topics));
}


@override
int get hashCode => Object.hash(runtimeType,collection,const DeepCollectionEquality().hash(chapters),const DeepCollectionEquality().hash(topics));

@override
String toString() {
  return 'SeerahIndex(collection: $collection, chapters: $chapters, topics: $topics)';
}


}

/// @nodoc
abstract mixin class $SeerahIndexCopyWith<$Res>  {
  factory $SeerahIndexCopyWith(SeerahIndex value, $Res Function(SeerahIndex) _then) = _$SeerahIndexCopyWithImpl;
@useResult
$Res call({
 SeerahCollection collection, List<SeerahChapterSummary> chapters, List<SeerahTopicSummary> topics
});


$SeerahCollectionCopyWith<$Res> get collection;

}
/// @nodoc
class _$SeerahIndexCopyWithImpl<$Res>
    implements $SeerahIndexCopyWith<$Res> {
  _$SeerahIndexCopyWithImpl(this._self, this._then);

  final SeerahIndex _self;
  final $Res Function(SeerahIndex) _then;

/// Create a copy of SeerahIndex
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? collection = null,Object? chapters = null,Object? topics = null,}) {
  return _then(_self.copyWith(
collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as SeerahCollection,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<SeerahChapterSummary>,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<SeerahTopicSummary>,
  ));
}
/// Create a copy of SeerahIndex
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeerahCollectionCopyWith<$Res> get collection {
  
  return $SeerahCollectionCopyWith<$Res>(_self.collection, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}


/// Adds pattern-matching-related methods to [SeerahIndex].
extension SeerahIndexPatterns on SeerahIndex {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeerahIndex value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeerahIndex() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeerahIndex value)  $default,){
final _that = this;
switch (_that) {
case _SeerahIndex():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeerahIndex value)?  $default,){
final _that = this;
switch (_that) {
case _SeerahIndex() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SeerahCollection collection,  List<SeerahChapterSummary> chapters,  List<SeerahTopicSummary> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeerahIndex() when $default != null:
return $default(_that.collection,_that.chapters,_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SeerahCollection collection,  List<SeerahChapterSummary> chapters,  List<SeerahTopicSummary> topics)  $default,) {final _that = this;
switch (_that) {
case _SeerahIndex():
return $default(_that.collection,_that.chapters,_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SeerahCollection collection,  List<SeerahChapterSummary> chapters,  List<SeerahTopicSummary> topics)?  $default,) {final _that = this;
switch (_that) {
case _SeerahIndex() when $default != null:
return $default(_that.collection,_that.chapters,_that.topics);case _:
  return null;

}
}

}

/// @nodoc


class _SeerahIndex implements SeerahIndex {
  const _SeerahIndex({required this.collection, required final  List<SeerahChapterSummary> chapters, required final  List<SeerahTopicSummary> topics}): _chapters = chapters,_topics = topics;
  

@override final  SeerahCollection collection;
 final  List<SeerahChapterSummary> _chapters;
@override List<SeerahChapterSummary> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

 final  List<SeerahTopicSummary> _topics;
@override List<SeerahTopicSummary> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}


/// Create a copy of SeerahIndex
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeerahIndexCopyWith<_SeerahIndex> get copyWith => __$SeerahIndexCopyWithImpl<_SeerahIndex>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeerahIndex&&(identical(other.collection, collection) || other.collection == collection)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&const DeepCollectionEquality().equals(other._topics, _topics));
}


@override
int get hashCode => Object.hash(runtimeType,collection,const DeepCollectionEquality().hash(_chapters),const DeepCollectionEquality().hash(_topics));

@override
String toString() {
  return 'SeerahIndex(collection: $collection, chapters: $chapters, topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$SeerahIndexCopyWith<$Res> implements $SeerahIndexCopyWith<$Res> {
  factory _$SeerahIndexCopyWith(_SeerahIndex value, $Res Function(_SeerahIndex) _then) = __$SeerahIndexCopyWithImpl;
@override @useResult
$Res call({
 SeerahCollection collection, List<SeerahChapterSummary> chapters, List<SeerahTopicSummary> topics
});


@override $SeerahCollectionCopyWith<$Res> get collection;

}
/// @nodoc
class __$SeerahIndexCopyWithImpl<$Res>
    implements _$SeerahIndexCopyWith<$Res> {
  __$SeerahIndexCopyWithImpl(this._self, this._then);

  final _SeerahIndex _self;
  final $Res Function(_SeerahIndex) _then;

/// Create a copy of SeerahIndex
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? collection = null,Object? chapters = null,Object? topics = null,}) {
  return _then(_SeerahIndex(
collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as SeerahCollection,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<SeerahChapterSummary>,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<SeerahTopicSummary>,
  ));
}

/// Create a copy of SeerahIndex
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeerahCollectionCopyWith<$Res> get collection {
  
  return $SeerahCollectionCopyWith<$Res>(_self.collection, (value) {
    return _then(_self.copyWith(collection: value));
  });
}
}

// dart format on
