// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syariah_state_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyariahStateData {

 double get halalBalance; double get syubhatBalance; double get zakatDue; bool get isAkadSigned; String get selectedAkad; List<String> get availableAkads; bool get zakatAutoDebitEnabled;
/// Create a copy of SyariahStateData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyariahStateDataCopyWith<SyariahStateData> get copyWith => _$SyariahStateDataCopyWithImpl<SyariahStateData>(this as SyariahStateData, _$identity);

  /// Serializes this SyariahStateData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyariahStateData&&(identical(other.halalBalance, halalBalance) || other.halalBalance == halalBalance)&&(identical(other.syubhatBalance, syubhatBalance) || other.syubhatBalance == syubhatBalance)&&(identical(other.zakatDue, zakatDue) || other.zakatDue == zakatDue)&&(identical(other.isAkadSigned, isAkadSigned) || other.isAkadSigned == isAkadSigned)&&(identical(other.selectedAkad, selectedAkad) || other.selectedAkad == selectedAkad)&&const DeepCollectionEquality().equals(other.availableAkads, availableAkads)&&(identical(other.zakatAutoDebitEnabled, zakatAutoDebitEnabled) || other.zakatAutoDebitEnabled == zakatAutoDebitEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,halalBalance,syubhatBalance,zakatDue,isAkadSigned,selectedAkad,const DeepCollectionEquality().hash(availableAkads),zakatAutoDebitEnabled);

@override
String toString() {
  return 'SyariahStateData(halalBalance: $halalBalance, syubhatBalance: $syubhatBalance, zakatDue: $zakatDue, isAkadSigned: $isAkadSigned, selectedAkad: $selectedAkad, availableAkads: $availableAkads, zakatAutoDebitEnabled: $zakatAutoDebitEnabled)';
}


}

/// @nodoc
abstract mixin class $SyariahStateDataCopyWith<$Res>  {
  factory $SyariahStateDataCopyWith(SyariahStateData value, $Res Function(SyariahStateData) _then) = _$SyariahStateDataCopyWithImpl;
@useResult
$Res call({
 double halalBalance, double syubhatBalance, double zakatDue, bool isAkadSigned, String selectedAkad, List<String> availableAkads, bool zakatAutoDebitEnabled
});




}
/// @nodoc
class _$SyariahStateDataCopyWithImpl<$Res>
    implements $SyariahStateDataCopyWith<$Res> {
  _$SyariahStateDataCopyWithImpl(this._self, this._then);

  final SyariahStateData _self;
  final $Res Function(SyariahStateData) _then;

/// Create a copy of SyariahStateData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? halalBalance = null,Object? syubhatBalance = null,Object? zakatDue = null,Object? isAkadSigned = null,Object? selectedAkad = null,Object? availableAkads = null,Object? zakatAutoDebitEnabled = null,}) {
  return _then(_self.copyWith(
halalBalance: null == halalBalance ? _self.halalBalance : halalBalance // ignore: cast_nullable_to_non_nullable
as double,syubhatBalance: null == syubhatBalance ? _self.syubhatBalance : syubhatBalance // ignore: cast_nullable_to_non_nullable
as double,zakatDue: null == zakatDue ? _self.zakatDue : zakatDue // ignore: cast_nullable_to_non_nullable
as double,isAkadSigned: null == isAkadSigned ? _self.isAkadSigned : isAkadSigned // ignore: cast_nullable_to_non_nullable
as bool,selectedAkad: null == selectedAkad ? _self.selectedAkad : selectedAkad // ignore: cast_nullable_to_non_nullable
as String,availableAkads: null == availableAkads ? _self.availableAkads : availableAkads // ignore: cast_nullable_to_non_nullable
as List<String>,zakatAutoDebitEnabled: null == zakatAutoDebitEnabled ? _self.zakatAutoDebitEnabled : zakatAutoDebitEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SyariahStateData].
extension SyariahStateDataPatterns on SyariahStateData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyariahStateData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyariahStateData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyariahStateData value)  $default,){
final _that = this;
switch (_that) {
case _SyariahStateData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyariahStateData value)?  $default,){
final _that = this;
switch (_that) {
case _SyariahStateData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double halalBalance,  double syubhatBalance,  double zakatDue,  bool isAkadSigned,  String selectedAkad,  List<String> availableAkads,  bool zakatAutoDebitEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyariahStateData() when $default != null:
return $default(_that.halalBalance,_that.syubhatBalance,_that.zakatDue,_that.isAkadSigned,_that.selectedAkad,_that.availableAkads,_that.zakatAutoDebitEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double halalBalance,  double syubhatBalance,  double zakatDue,  bool isAkadSigned,  String selectedAkad,  List<String> availableAkads,  bool zakatAutoDebitEnabled)  $default,) {final _that = this;
switch (_that) {
case _SyariahStateData():
return $default(_that.halalBalance,_that.syubhatBalance,_that.zakatDue,_that.isAkadSigned,_that.selectedAkad,_that.availableAkads,_that.zakatAutoDebitEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double halalBalance,  double syubhatBalance,  double zakatDue,  bool isAkadSigned,  String selectedAkad,  List<String> availableAkads,  bool zakatAutoDebitEnabled)?  $default,) {final _that = this;
switch (_that) {
case _SyariahStateData() when $default != null:
return $default(_that.halalBalance,_that.syubhatBalance,_that.zakatDue,_that.isAkadSigned,_that.selectedAkad,_that.availableAkads,_that.zakatAutoDebitEnabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyariahStateData implements SyariahStateData {
  const _SyariahStateData({required this.halalBalance, required this.syubhatBalance, required this.zakatDue, required this.isAkadSigned, required this.selectedAkad, final  List<String> availableAkads = const [], this.zakatAutoDebitEnabled = false}): _availableAkads = availableAkads;
  factory _SyariahStateData.fromJson(Map<String, dynamic> json) => _$SyariahStateDataFromJson(json);

@override final  double halalBalance;
@override final  double syubhatBalance;
@override final  double zakatDue;
@override final  bool isAkadSigned;
@override final  String selectedAkad;
 final  List<String> _availableAkads;
@override@JsonKey() List<String> get availableAkads {
  if (_availableAkads is EqualUnmodifiableListView) return _availableAkads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableAkads);
}

@override@JsonKey() final  bool zakatAutoDebitEnabled;

/// Create a copy of SyariahStateData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyariahStateDataCopyWith<_SyariahStateData> get copyWith => __$SyariahStateDataCopyWithImpl<_SyariahStateData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyariahStateDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyariahStateData&&(identical(other.halalBalance, halalBalance) || other.halalBalance == halalBalance)&&(identical(other.syubhatBalance, syubhatBalance) || other.syubhatBalance == syubhatBalance)&&(identical(other.zakatDue, zakatDue) || other.zakatDue == zakatDue)&&(identical(other.isAkadSigned, isAkadSigned) || other.isAkadSigned == isAkadSigned)&&(identical(other.selectedAkad, selectedAkad) || other.selectedAkad == selectedAkad)&&const DeepCollectionEquality().equals(other._availableAkads, _availableAkads)&&(identical(other.zakatAutoDebitEnabled, zakatAutoDebitEnabled) || other.zakatAutoDebitEnabled == zakatAutoDebitEnabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,halalBalance,syubhatBalance,zakatDue,isAkadSigned,selectedAkad,const DeepCollectionEquality().hash(_availableAkads),zakatAutoDebitEnabled);

@override
String toString() {
  return 'SyariahStateData(halalBalance: $halalBalance, syubhatBalance: $syubhatBalance, zakatDue: $zakatDue, isAkadSigned: $isAkadSigned, selectedAkad: $selectedAkad, availableAkads: $availableAkads, zakatAutoDebitEnabled: $zakatAutoDebitEnabled)';
}


}

/// @nodoc
abstract mixin class _$SyariahStateDataCopyWith<$Res> implements $SyariahStateDataCopyWith<$Res> {
  factory _$SyariahStateDataCopyWith(_SyariahStateData value, $Res Function(_SyariahStateData) _then) = __$SyariahStateDataCopyWithImpl;
@override @useResult
$Res call({
 double halalBalance, double syubhatBalance, double zakatDue, bool isAkadSigned, String selectedAkad, List<String> availableAkads, bool zakatAutoDebitEnabled
});




}
/// @nodoc
class __$SyariahStateDataCopyWithImpl<$Res>
    implements _$SyariahStateDataCopyWith<$Res> {
  __$SyariahStateDataCopyWithImpl(this._self, this._then);

  final _SyariahStateData _self;
  final $Res Function(_SyariahStateData) _then;

/// Create a copy of SyariahStateData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? halalBalance = null,Object? syubhatBalance = null,Object? zakatDue = null,Object? isAkadSigned = null,Object? selectedAkad = null,Object? availableAkads = null,Object? zakatAutoDebitEnabled = null,}) {
  return _then(_SyariahStateData(
halalBalance: null == halalBalance ? _self.halalBalance : halalBalance // ignore: cast_nullable_to_non_nullable
as double,syubhatBalance: null == syubhatBalance ? _self.syubhatBalance : syubhatBalance // ignore: cast_nullable_to_non_nullable
as double,zakatDue: null == zakatDue ? _self.zakatDue : zakatDue // ignore: cast_nullable_to_non_nullable
as double,isAkadSigned: null == isAkadSigned ? _self.isAkadSigned : isAkadSigned // ignore: cast_nullable_to_non_nullable
as bool,selectedAkad: null == selectedAkad ? _self.selectedAkad : selectedAkad // ignore: cast_nullable_to_non_nullable
as String,availableAkads: null == availableAkads ? _self._availableAkads : availableAkads // ignore: cast_nullable_to_non_nullable
as List<String>,zakatAutoDebitEnabled: null == zakatAutoDebitEnabled ? _self.zakatAutoDebitEnabled : zakatAutoDebitEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
