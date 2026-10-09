// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'citation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Grading {

 HadithGrade get grade; LocalizedText get gradedBy;
/// Create a copy of Grading
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradingCopyWith<Grading> get copyWith => _$GradingCopyWithImpl<Grading>(this as Grading, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Grading&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.gradedBy, gradedBy) || other.gradedBy == gradedBy));
}


@override
int get hashCode => Object.hash(runtimeType,grade,gradedBy);

@override
String toString() {
  return 'Grading(grade: $grade, gradedBy: $gradedBy)';
}


}

/// @nodoc
abstract mixin class $GradingCopyWith<$Res>  {
  factory $GradingCopyWith(Grading value, $Res Function(Grading) _then) = _$GradingCopyWithImpl;
@useResult
$Res call({
 HadithGrade grade, LocalizedText gradedBy
});


$LocalizedTextCopyWith<$Res> get gradedBy;

}
/// @nodoc
class _$GradingCopyWithImpl<$Res>
    implements $GradingCopyWith<$Res> {
  _$GradingCopyWithImpl(this._self, this._then);

  final Grading _self;
  final $Res Function(Grading) _then;

/// Create a copy of Grading
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? grade = null,Object? gradedBy = null,}) {
  return _then(_self.copyWith(
grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as HadithGrade,gradedBy: null == gradedBy ? _self.gradedBy : gradedBy // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}
/// Create a copy of Grading
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get gradedBy {
  
  return $LocalizedTextCopyWith<$Res>(_self.gradedBy, (value) {
    return _then(_self.copyWith(gradedBy: value));
  });
}
}


/// Adds pattern-matching-related methods to [Grading].
extension GradingPatterns on Grading {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Grading value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Grading() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Grading value)  $default,){
final _that = this;
switch (_that) {
case _Grading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Grading value)?  $default,){
final _that = this;
switch (_that) {
case _Grading() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HadithGrade grade,  LocalizedText gradedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Grading() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HadithGrade grade,  LocalizedText gradedBy)  $default,) {final _that = this;
switch (_that) {
case _Grading():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HadithGrade grade,  LocalizedText gradedBy)?  $default,) {final _that = this;
switch (_that) {
case _Grading() when $default != null:
return $default(_that.grade,_that.gradedBy);case _:
  return null;

}
}

}

/// @nodoc


class _Grading implements Grading {
  const _Grading({required this.grade, required this.gradedBy});
  

@override final  HadithGrade grade;
@override final  LocalizedText gradedBy;

/// Create a copy of Grading
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradingCopyWith<_Grading> get copyWith => __$GradingCopyWithImpl<_Grading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Grading&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.gradedBy, gradedBy) || other.gradedBy == gradedBy));
}


@override
int get hashCode => Object.hash(runtimeType,grade,gradedBy);

@override
String toString() {
  return 'Grading(grade: $grade, gradedBy: $gradedBy)';
}


}

/// @nodoc
abstract mixin class _$GradingCopyWith<$Res> implements $GradingCopyWith<$Res> {
  factory _$GradingCopyWith(_Grading value, $Res Function(_Grading) _then) = __$GradingCopyWithImpl;
@override @useResult
$Res call({
 HadithGrade grade, LocalizedText gradedBy
});


@override $LocalizedTextCopyWith<$Res> get gradedBy;

}
/// @nodoc
class __$GradingCopyWithImpl<$Res>
    implements _$GradingCopyWith<$Res> {
  __$GradingCopyWithImpl(this._self, this._then);

  final _Grading _self;
  final $Res Function(_Grading) _then;

/// Create a copy of Grading
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? grade = null,Object? gradedBy = null,}) {
  return _then(_Grading(
grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as HadithGrade,gradedBy: null == gradedBy ? _self.gradedBy : gradedBy // ignore: cast_nullable_to_non_nullable
as LocalizedText,
  ));
}

/// Create a copy of Grading
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get gradedBy {
  
  return $LocalizedTextCopyWith<$Res>(_self.gradedBy, (value) {
    return _then(_self.copyWith(gradedBy: value));
  });
}
}

/// @nodoc
mixin _$Citation {

 String get sourceId; LocatorStatus get locatorStatus; int? get volume; String? get page; String? get hadithNumber; LocalizedText? get chapterTitle; QuranRef? get quranRef; Grading? get grading; LocalizedText? get note;
/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CitationCopyWith<Citation> get copyWith => _$CitationCopyWithImpl<Citation>(this as Citation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Citation&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.locatorStatus, locatorStatus) || other.locatorStatus == locatorStatus)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.page, page) || other.page == page)&&(identical(other.hadithNumber, hadithNumber) || other.hadithNumber == hadithNumber)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.quranRef, quranRef) || other.quranRef == quranRef)&&(identical(other.grading, grading) || other.grading == grading)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,sourceId,locatorStatus,volume,page,hadithNumber,chapterTitle,quranRef,grading,note);

@override
String toString() {
  return 'Citation(sourceId: $sourceId, locatorStatus: $locatorStatus, volume: $volume, page: $page, hadithNumber: $hadithNumber, chapterTitle: $chapterTitle, quranRef: $quranRef, grading: $grading, note: $note)';
}


}

/// @nodoc
abstract mixin class $CitationCopyWith<$Res>  {
  factory $CitationCopyWith(Citation value, $Res Function(Citation) _then) = _$CitationCopyWithImpl;
@useResult
$Res call({
 String sourceId, LocatorStatus locatorStatus, int? volume, String? page, String? hadithNumber, LocalizedText? chapterTitle, QuranRef? quranRef, Grading? grading, LocalizedText? note
});


$LocalizedTextCopyWith<$Res>? get chapterTitle;$GradingCopyWith<$Res>? get grading;$LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class _$CitationCopyWithImpl<$Res>
    implements $CitationCopyWith<$Res> {
  _$CitationCopyWithImpl(this._self, this._then);

  final Citation _self;
  final $Res Function(Citation) _then;

/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceId = null,Object? locatorStatus = null,Object? volume = freezed,Object? page = freezed,Object? hadithNumber = freezed,Object? chapterTitle = freezed,Object? quranRef = freezed,Object? grading = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,locatorStatus: null == locatorStatus ? _self.locatorStatus : locatorStatus // ignore: cast_nullable_to_non_nullable
as LocatorStatus,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String?,hadithNumber: freezed == hadithNumber ? _self.hadithNumber : hadithNumber // ignore: cast_nullable_to_non_nullable
as String?,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as LocalizedText?,quranRef: freezed == quranRef ? _self.quranRef : quranRef // ignore: cast_nullable_to_non_nullable
as QuranRef?,grading: freezed == grading ? _self.grading : grading // ignore: cast_nullable_to_non_nullable
as Grading?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get chapterTitle {
    if (_self.chapterTitle == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.chapterTitle!, (value) {
    return _then(_self.copyWith(chapterTitle: value));
  });
}/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradingCopyWith<$Res>? get grading {
    if (_self.grading == null) {
    return null;
  }

  return $GradingCopyWith<$Res>(_self.grading!, (value) {
    return _then(_self.copyWith(grading: value));
  });
}/// Create a copy of Citation
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


/// Adds pattern-matching-related methods to [Citation].
extension CitationPatterns on Citation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Citation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Citation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Citation value)  $default,){
final _that = this;
switch (_that) {
case _Citation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Citation value)?  $default,){
final _that = this;
switch (_that) {
case _Citation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourceId,  LocatorStatus locatorStatus,  int? volume,  String? page,  String? hadithNumber,  LocalizedText? chapterTitle,  QuranRef? quranRef,  Grading? grading,  LocalizedText? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Citation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourceId,  LocatorStatus locatorStatus,  int? volume,  String? page,  String? hadithNumber,  LocalizedText? chapterTitle,  QuranRef? quranRef,  Grading? grading,  LocalizedText? note)  $default,) {final _that = this;
switch (_that) {
case _Citation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourceId,  LocatorStatus locatorStatus,  int? volume,  String? page,  String? hadithNumber,  LocalizedText? chapterTitle,  QuranRef? quranRef,  Grading? grading,  LocalizedText? note)?  $default,) {final _that = this;
switch (_that) {
case _Citation() when $default != null:
return $default(_that.sourceId,_that.locatorStatus,_that.volume,_that.page,_that.hadithNumber,_that.chapterTitle,_that.quranRef,_that.grading,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _Citation extends Citation {
  const _Citation({required this.sourceId, required this.locatorStatus, this.volume, this.page, this.hadithNumber, this.chapterTitle, this.quranRef, this.grading, this.note}): super._();
  

@override final  String sourceId;
@override final  LocatorStatus locatorStatus;
@override final  int? volume;
@override final  String? page;
@override final  String? hadithNumber;
@override final  LocalizedText? chapterTitle;
@override final  QuranRef? quranRef;
@override final  Grading? grading;
@override final  LocalizedText? note;

/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CitationCopyWith<_Citation> get copyWith => __$CitationCopyWithImpl<_Citation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Citation&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.locatorStatus, locatorStatus) || other.locatorStatus == locatorStatus)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.page, page) || other.page == page)&&(identical(other.hadithNumber, hadithNumber) || other.hadithNumber == hadithNumber)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.quranRef, quranRef) || other.quranRef == quranRef)&&(identical(other.grading, grading) || other.grading == grading)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,sourceId,locatorStatus,volume,page,hadithNumber,chapterTitle,quranRef,grading,note);

@override
String toString() {
  return 'Citation(sourceId: $sourceId, locatorStatus: $locatorStatus, volume: $volume, page: $page, hadithNumber: $hadithNumber, chapterTitle: $chapterTitle, quranRef: $quranRef, grading: $grading, note: $note)';
}


}

/// @nodoc
abstract mixin class _$CitationCopyWith<$Res> implements $CitationCopyWith<$Res> {
  factory _$CitationCopyWith(_Citation value, $Res Function(_Citation) _then) = __$CitationCopyWithImpl;
@override @useResult
$Res call({
 String sourceId, LocatorStatus locatorStatus, int? volume, String? page, String? hadithNumber, LocalizedText? chapterTitle, QuranRef? quranRef, Grading? grading, LocalizedText? note
});


@override $LocalizedTextCopyWith<$Res>? get chapterTitle;@override $GradingCopyWith<$Res>? get grading;@override $LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class __$CitationCopyWithImpl<$Res>
    implements _$CitationCopyWith<$Res> {
  __$CitationCopyWithImpl(this._self, this._then);

  final _Citation _self;
  final $Res Function(_Citation) _then;

/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceId = null,Object? locatorStatus = null,Object? volume = freezed,Object? page = freezed,Object? hadithNumber = freezed,Object? chapterTitle = freezed,Object? quranRef = freezed,Object? grading = freezed,Object? note = freezed,}) {
  return _then(_Citation(
sourceId: null == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String,locatorStatus: null == locatorStatus ? _self.locatorStatus : locatorStatus // ignore: cast_nullable_to_non_nullable
as LocatorStatus,volume: freezed == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as String?,hadithNumber: freezed == hadithNumber ? _self.hadithNumber : hadithNumber // ignore: cast_nullable_to_non_nullable
as String?,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as LocalizedText?,quranRef: freezed == quranRef ? _self.quranRef : quranRef // ignore: cast_nullable_to_non_nullable
as QuranRef?,grading: freezed == grading ? _self.grading : grading // ignore: cast_nullable_to_non_nullable
as Grading?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get chapterTitle {
    if (_self.chapterTitle == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.chapterTitle!, (value) {
    return _then(_self.copyWith(chapterTitle: value));
  });
}/// Create a copy of Citation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradingCopyWith<$Res>? get grading {
    if (_self.grading == null) {
    return null;
  }

  return $GradingCopyWith<$Res>(_self.grading!, (value) {
    return _then(_self.copyWith(grading: value));
  });
}/// Create a copy of Citation
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
mixin _$DatedClaim {

 HistoricalDate get date; Reliability get reliability; List<Citation> get citations; LocalizedText? get note;
/// Create a copy of DatedClaim
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatedClaimCopyWith<DatedClaim> get copyWith => _$DatedClaimCopyWithImpl<DatedClaim>(this as DatedClaim, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatedClaim&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other.citations, citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,date,reliability,const DeepCollectionEquality().hash(citations),note);

@override
String toString() {
  return 'DatedClaim(date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class $DatedClaimCopyWith<$Res>  {
  factory $DatedClaimCopyWith(DatedClaim value, $Res Function(DatedClaim) _then) = _$DatedClaimCopyWithImpl;
@useResult
$Res call({
 HistoricalDate date, Reliability reliability, List<Citation> citations, LocalizedText? note
});


$LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class _$DatedClaimCopyWithImpl<$Res>
    implements $DatedClaimCopyWith<$Res> {
  _$DatedClaimCopyWithImpl(this._self, this._then);

  final DatedClaim _self;
  final $Res Function(DatedClaim) _then;

/// Create a copy of DatedClaim
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}
/// Create a copy of DatedClaim
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


/// Adds pattern-matching-related methods to [DatedClaim].
extension DatedClaimPatterns on DatedClaim {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DatedClaim value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DatedClaim() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DatedClaim value)  $default,){
final _that = this;
switch (_that) {
case _DatedClaim():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DatedClaim value)?  $default,){
final _that = this;
switch (_that) {
case _DatedClaim() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HistoricalDate date,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DatedClaim() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HistoricalDate date,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)  $default,) {final _that = this;
switch (_that) {
case _DatedClaim():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HistoricalDate date,  Reliability reliability,  List<Citation> citations,  LocalizedText? note)?  $default,) {final _that = this;
switch (_that) {
case _DatedClaim() when $default != null:
return $default(_that.date,_that.reliability,_that.citations,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _DatedClaim implements DatedClaim {
  const _DatedClaim({required this.date, required this.reliability, final  List<Citation> citations = const <Citation>[], this.note}): _citations = citations;
  

@override final  HistoricalDate date;
@override final  Reliability reliability;
 final  List<Citation> _citations;
@override@JsonKey() List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}

@override final  LocalizedText? note;

/// Create a copy of DatedClaim
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DatedClaimCopyWith<_DatedClaim> get copyWith => __$DatedClaimCopyWithImpl<_DatedClaim>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DatedClaim&&(identical(other.date, date) || other.date == date)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&const DeepCollectionEquality().equals(other._citations, _citations)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,date,reliability,const DeepCollectionEquality().hash(_citations),note);

@override
String toString() {
  return 'DatedClaim(date: $date, reliability: $reliability, citations: $citations, note: $note)';
}


}

/// @nodoc
abstract mixin class _$DatedClaimCopyWith<$Res> implements $DatedClaimCopyWith<$Res> {
  factory _$DatedClaimCopyWith(_DatedClaim value, $Res Function(_DatedClaim) _then) = __$DatedClaimCopyWithImpl;
@override @useResult
$Res call({
 HistoricalDate date, Reliability reliability, List<Citation> citations, LocalizedText? note
});


@override $LocalizedTextCopyWith<$Res>? get note;

}
/// @nodoc
class __$DatedClaimCopyWithImpl<$Res>
    implements _$DatedClaimCopyWith<$Res> {
  __$DatedClaimCopyWithImpl(this._self, this._then);

  final _DatedClaim _self;
  final $Res Function(_DatedClaim) _then;

/// Create a copy of DatedClaim
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? reliability = null,Object? citations = null,Object? note = freezed,}) {
  return _then(_DatedClaim(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as LocalizedText?,
  ));
}

/// Create a copy of DatedClaim
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
mixin _$Fact {

 LocalizedText get label; Reliability get reliability; LocalizedText? get text; HistoricalDate? get date; List<Citation> get citations;
/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FactCopyWith<Fact> get copyWith => _$FactCopyWithImpl<Fact>(this as Fact, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Fact&&(identical(other.label, label) || other.label == label)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.text, text) || other.text == text)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.citations, citations));
}


@override
int get hashCode => Object.hash(runtimeType,label,reliability,text,date,const DeepCollectionEquality().hash(citations));

@override
String toString() {
  return 'Fact(label: $label, reliability: $reliability, text: $text, date: $date, citations: $citations)';
}


}

/// @nodoc
abstract mixin class $FactCopyWith<$Res>  {
  factory $FactCopyWith(Fact value, $Res Function(Fact) _then) = _$FactCopyWithImpl;
@useResult
$Res call({
 LocalizedText label, Reliability reliability, LocalizedText? text, HistoricalDate? date, List<Citation> citations
});


$LocalizedTextCopyWith<$Res> get label;$LocalizedTextCopyWith<$Res>? get text;

}
/// @nodoc
class _$FactCopyWithImpl<$Res>
    implements $FactCopyWith<$Res> {
  _$FactCopyWithImpl(this._self, this._then);

  final Fact _self;
  final $Res Function(Fact) _then;

/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? reliability = null,Object? text = freezed,Object? date = freezed,Object? citations = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate?,citations: null == citations ? _self.citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}
/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}


/// Adds pattern-matching-related methods to [Fact].
extension FactPatterns on Fact {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Fact value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Fact() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Fact value)  $default,){
final _that = this;
switch (_that) {
case _Fact():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Fact value)?  $default,){
final _that = this;
switch (_that) {
case _Fact() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalizedText label,  Reliability reliability,  LocalizedText? text,  HistoricalDate? date,  List<Citation> citations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Fact() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalizedText label,  Reliability reliability,  LocalizedText? text,  HistoricalDate? date,  List<Citation> citations)  $default,) {final _that = this;
switch (_that) {
case _Fact():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalizedText label,  Reliability reliability,  LocalizedText? text,  HistoricalDate? date,  List<Citation> citations)?  $default,) {final _that = this;
switch (_that) {
case _Fact() when $default != null:
return $default(_that.label,_that.reliability,_that.text,_that.date,_that.citations);case _:
  return null;

}
}

}

/// @nodoc


class _Fact implements Fact {
  const _Fact({required this.label, required this.reliability, this.text, this.date, final  List<Citation> citations = const <Citation>[]}): _citations = citations;
  

@override final  LocalizedText label;
@override final  Reliability reliability;
@override final  LocalizedText? text;
@override final  HistoricalDate? date;
 final  List<Citation> _citations;
@override@JsonKey() List<Citation> get citations {
  if (_citations is EqualUnmodifiableListView) return _citations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_citations);
}


/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FactCopyWith<_Fact> get copyWith => __$FactCopyWithImpl<_Fact>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Fact&&(identical(other.label, label) || other.label == label)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.text, text) || other.text == text)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._citations, _citations));
}


@override
int get hashCode => Object.hash(runtimeType,label,reliability,text,date,const DeepCollectionEquality().hash(_citations));

@override
String toString() {
  return 'Fact(label: $label, reliability: $reliability, text: $text, date: $date, citations: $citations)';
}


}

/// @nodoc
abstract mixin class _$FactCopyWith<$Res> implements $FactCopyWith<$Res> {
  factory _$FactCopyWith(_Fact value, $Res Function(_Fact) _then) = __$FactCopyWithImpl;
@override @useResult
$Res call({
 LocalizedText label, Reliability reliability, LocalizedText? text, HistoricalDate? date, List<Citation> citations
});


@override $LocalizedTextCopyWith<$Res> get label;@override $LocalizedTextCopyWith<$Res>? get text;

}
/// @nodoc
class __$FactCopyWithImpl<$Res>
    implements _$FactCopyWith<$Res> {
  __$FactCopyWithImpl(this._self, this._then);

  final _Fact _self;
  final $Res Function(_Fact) _then;

/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? reliability = null,Object? text = freezed,Object? date = freezed,Object? citations = null,}) {
  return _then(_Fact(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LocalizedText,reliability: null == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as Reliability,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as LocalizedText?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as HistoricalDate?,citations: null == citations ? _self._citations : citations // ignore: cast_nullable_to_non_nullable
as List<Citation>,
  ));
}

/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res> get label {
  
  return $LocalizedTextCopyWith<$Res>(_self.label, (value) {
    return _then(_self.copyWith(label: value));
  });
}/// Create a copy of Fact
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalizedTextCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $LocalizedTextCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}
}

// dart format on
