// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'future_rails_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FutureRailsData {

 double get cbdcBalance; Map<String, double> get cryptoAssets; bool get isSecureCustodyBackupDone; double get bansosBalance; String get bansosLockedCategory; bool get bansosLockEnabled; double get educationBalance; String get educationLockedCategory;
/// Create a copy of FutureRailsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FutureRailsDataCopyWith<FutureRailsData> get copyWith => _$FutureRailsDataCopyWithImpl<FutureRailsData>(this as FutureRailsData, _$identity);

  /// Serializes this FutureRailsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FutureRailsData&&(identical(other.cbdcBalance, cbdcBalance) || other.cbdcBalance == cbdcBalance)&&const DeepCollectionEquality().equals(other.cryptoAssets, cryptoAssets)&&(identical(other.isSecureCustodyBackupDone, isSecureCustodyBackupDone) || other.isSecureCustodyBackupDone == isSecureCustodyBackupDone)&&(identical(other.bansosBalance, bansosBalance) || other.bansosBalance == bansosBalance)&&(identical(other.bansosLockedCategory, bansosLockedCategory) || other.bansosLockedCategory == bansosLockedCategory)&&(identical(other.bansosLockEnabled, bansosLockEnabled) || other.bansosLockEnabled == bansosLockEnabled)&&(identical(other.educationBalance, educationBalance) || other.educationBalance == educationBalance)&&(identical(other.educationLockedCategory, educationLockedCategory) || other.educationLockedCategory == educationLockedCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cbdcBalance,const DeepCollectionEquality().hash(cryptoAssets),isSecureCustodyBackupDone,bansosBalance,bansosLockedCategory,bansosLockEnabled,educationBalance,educationLockedCategory);

@override
String toString() {
  return 'FutureRailsData(cbdcBalance: $cbdcBalance, cryptoAssets: $cryptoAssets, isSecureCustodyBackupDone: $isSecureCustodyBackupDone, bansosBalance: $bansosBalance, bansosLockedCategory: $bansosLockedCategory, bansosLockEnabled: $bansosLockEnabled, educationBalance: $educationBalance, educationLockedCategory: $educationLockedCategory)';
}


}

/// @nodoc
abstract mixin class $FutureRailsDataCopyWith<$Res>  {
  factory $FutureRailsDataCopyWith(FutureRailsData value, $Res Function(FutureRailsData) _then) = _$FutureRailsDataCopyWithImpl;
@useResult
$Res call({
 double cbdcBalance, Map<String, double> cryptoAssets, bool isSecureCustodyBackupDone, double bansosBalance, String bansosLockedCategory, bool bansosLockEnabled, double educationBalance, String educationLockedCategory
});




}
/// @nodoc
class _$FutureRailsDataCopyWithImpl<$Res>
    implements $FutureRailsDataCopyWith<$Res> {
  _$FutureRailsDataCopyWithImpl(this._self, this._then);

  final FutureRailsData _self;
  final $Res Function(FutureRailsData) _then;

/// Create a copy of FutureRailsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cbdcBalance = null,Object? cryptoAssets = null,Object? isSecureCustodyBackupDone = null,Object? bansosBalance = null,Object? bansosLockedCategory = null,Object? bansosLockEnabled = null,Object? educationBalance = null,Object? educationLockedCategory = null,}) {
  return _then(_self.copyWith(
cbdcBalance: null == cbdcBalance ? _self.cbdcBalance : cbdcBalance // ignore: cast_nullable_to_non_nullable
as double,cryptoAssets: null == cryptoAssets ? _self.cryptoAssets : cryptoAssets // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isSecureCustodyBackupDone: null == isSecureCustodyBackupDone ? _self.isSecureCustodyBackupDone : isSecureCustodyBackupDone // ignore: cast_nullable_to_non_nullable
as bool,bansosBalance: null == bansosBalance ? _self.bansosBalance : bansosBalance // ignore: cast_nullable_to_non_nullable
as double,bansosLockedCategory: null == bansosLockedCategory ? _self.bansosLockedCategory : bansosLockedCategory // ignore: cast_nullable_to_non_nullable
as String,bansosLockEnabled: null == bansosLockEnabled ? _self.bansosLockEnabled : bansosLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,educationBalance: null == educationBalance ? _self.educationBalance : educationBalance // ignore: cast_nullable_to_non_nullable
as double,educationLockedCategory: null == educationLockedCategory ? _self.educationLockedCategory : educationLockedCategory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FutureRailsData].
extension FutureRailsDataPatterns on FutureRailsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FutureRailsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FutureRailsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FutureRailsData value)  $default,){
final _that = this;
switch (_that) {
case _FutureRailsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FutureRailsData value)?  $default,){
final _that = this;
switch (_that) {
case _FutureRailsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double cbdcBalance,  Map<String, double> cryptoAssets,  bool isSecureCustodyBackupDone,  double bansosBalance,  String bansosLockedCategory,  bool bansosLockEnabled,  double educationBalance,  String educationLockedCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FutureRailsData() when $default != null:
return $default(_that.cbdcBalance,_that.cryptoAssets,_that.isSecureCustodyBackupDone,_that.bansosBalance,_that.bansosLockedCategory,_that.bansosLockEnabled,_that.educationBalance,_that.educationLockedCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double cbdcBalance,  Map<String, double> cryptoAssets,  bool isSecureCustodyBackupDone,  double bansosBalance,  String bansosLockedCategory,  bool bansosLockEnabled,  double educationBalance,  String educationLockedCategory)  $default,) {final _that = this;
switch (_that) {
case _FutureRailsData():
return $default(_that.cbdcBalance,_that.cryptoAssets,_that.isSecureCustodyBackupDone,_that.bansosBalance,_that.bansosLockedCategory,_that.bansosLockEnabled,_that.educationBalance,_that.educationLockedCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double cbdcBalance,  Map<String, double> cryptoAssets,  bool isSecureCustodyBackupDone,  double bansosBalance,  String bansosLockedCategory,  bool bansosLockEnabled,  double educationBalance,  String educationLockedCategory)?  $default,) {final _that = this;
switch (_that) {
case _FutureRailsData() when $default != null:
return $default(_that.cbdcBalance,_that.cryptoAssets,_that.isSecureCustodyBackupDone,_that.bansosBalance,_that.bansosLockedCategory,_that.bansosLockEnabled,_that.educationBalance,_that.educationLockedCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FutureRailsData implements FutureRailsData {
  const _FutureRailsData({required this.cbdcBalance, required final  Map<String, double> cryptoAssets, required this.isSecureCustodyBackupDone, required this.bansosBalance, required this.bansosLockedCategory, this.bansosLockEnabled = true, this.educationBalance = 0.0, this.educationLockedCategory = "Biaya Sekolah / Kuliah"}): _cryptoAssets = cryptoAssets;
  factory _FutureRailsData.fromJson(Map<String, dynamic> json) => _$FutureRailsDataFromJson(json);

@override final  double cbdcBalance;
 final  Map<String, double> _cryptoAssets;
@override Map<String, double> get cryptoAssets {
  if (_cryptoAssets is EqualUnmodifiableMapView) return _cryptoAssets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_cryptoAssets);
}

@override final  bool isSecureCustodyBackupDone;
@override final  double bansosBalance;
@override final  String bansosLockedCategory;
@override@JsonKey() final  bool bansosLockEnabled;
@override@JsonKey() final  double educationBalance;
@override@JsonKey() final  String educationLockedCategory;

/// Create a copy of FutureRailsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FutureRailsDataCopyWith<_FutureRailsData> get copyWith => __$FutureRailsDataCopyWithImpl<_FutureRailsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FutureRailsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FutureRailsData&&(identical(other.cbdcBalance, cbdcBalance) || other.cbdcBalance == cbdcBalance)&&const DeepCollectionEquality().equals(other._cryptoAssets, _cryptoAssets)&&(identical(other.isSecureCustodyBackupDone, isSecureCustodyBackupDone) || other.isSecureCustodyBackupDone == isSecureCustodyBackupDone)&&(identical(other.bansosBalance, bansosBalance) || other.bansosBalance == bansosBalance)&&(identical(other.bansosLockedCategory, bansosLockedCategory) || other.bansosLockedCategory == bansosLockedCategory)&&(identical(other.bansosLockEnabled, bansosLockEnabled) || other.bansosLockEnabled == bansosLockEnabled)&&(identical(other.educationBalance, educationBalance) || other.educationBalance == educationBalance)&&(identical(other.educationLockedCategory, educationLockedCategory) || other.educationLockedCategory == educationLockedCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cbdcBalance,const DeepCollectionEquality().hash(_cryptoAssets),isSecureCustodyBackupDone,bansosBalance,bansosLockedCategory,bansosLockEnabled,educationBalance,educationLockedCategory);

@override
String toString() {
  return 'FutureRailsData(cbdcBalance: $cbdcBalance, cryptoAssets: $cryptoAssets, isSecureCustodyBackupDone: $isSecureCustodyBackupDone, bansosBalance: $bansosBalance, bansosLockedCategory: $bansosLockedCategory, bansosLockEnabled: $bansosLockEnabled, educationBalance: $educationBalance, educationLockedCategory: $educationLockedCategory)';
}


}

/// @nodoc
abstract mixin class _$FutureRailsDataCopyWith<$Res> implements $FutureRailsDataCopyWith<$Res> {
  factory _$FutureRailsDataCopyWith(_FutureRailsData value, $Res Function(_FutureRailsData) _then) = __$FutureRailsDataCopyWithImpl;
@override @useResult
$Res call({
 double cbdcBalance, Map<String, double> cryptoAssets, bool isSecureCustodyBackupDone, double bansosBalance, String bansosLockedCategory, bool bansosLockEnabled, double educationBalance, String educationLockedCategory
});




}
/// @nodoc
class __$FutureRailsDataCopyWithImpl<$Res>
    implements _$FutureRailsDataCopyWith<$Res> {
  __$FutureRailsDataCopyWithImpl(this._self, this._then);

  final _FutureRailsData _self;
  final $Res Function(_FutureRailsData) _then;

/// Create a copy of FutureRailsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cbdcBalance = null,Object? cryptoAssets = null,Object? isSecureCustodyBackupDone = null,Object? bansosBalance = null,Object? bansosLockedCategory = null,Object? bansosLockEnabled = null,Object? educationBalance = null,Object? educationLockedCategory = null,}) {
  return _then(_FutureRailsData(
cbdcBalance: null == cbdcBalance ? _self.cbdcBalance : cbdcBalance // ignore: cast_nullable_to_non_nullable
as double,cryptoAssets: null == cryptoAssets ? _self._cryptoAssets : cryptoAssets // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isSecureCustodyBackupDone: null == isSecureCustodyBackupDone ? _self.isSecureCustodyBackupDone : isSecureCustodyBackupDone // ignore: cast_nullable_to_non_nullable
as bool,bansosBalance: null == bansosBalance ? _self.bansosBalance : bansosBalance // ignore: cast_nullable_to_non_nullable
as double,bansosLockedCategory: null == bansosLockedCategory ? _self.bansosLockedCategory : bansosLockedCategory // ignore: cast_nullable_to_non_nullable
as String,bansosLockEnabled: null == bansosLockEnabled ? _self.bansosLockEnabled : bansosLockEnabled // ignore: cast_nullable_to_non_nullable
as bool,educationBalance: null == educationBalance ? _self.educationBalance : educationBalance // ignore: cast_nullable_to_non_nullable
as double,educationLockedCategory: null == educationLockedCategory ? _self.educationLockedCategory : educationLockedCategory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
