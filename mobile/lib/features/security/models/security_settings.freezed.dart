// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SecuritySettings {

 bool get cardFrozen; bool get onlinePaymentLocked; bool get internationalLocked; double get dailySpendingLimit; double get currentSpending; bool get passkeyEnabled; List<String> get lockedMerchantCategories;
/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecuritySettingsCopyWith<SecuritySettings> get copyWith => _$SecuritySettingsCopyWithImpl<SecuritySettings>(this as SecuritySettings, _$identity);

  /// Serializes this SecuritySettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecuritySettings&&(identical(other.cardFrozen, cardFrozen) || other.cardFrozen == cardFrozen)&&(identical(other.onlinePaymentLocked, onlinePaymentLocked) || other.onlinePaymentLocked == onlinePaymentLocked)&&(identical(other.internationalLocked, internationalLocked) || other.internationalLocked == internationalLocked)&&(identical(other.dailySpendingLimit, dailySpendingLimit) || other.dailySpendingLimit == dailySpendingLimit)&&(identical(other.currentSpending, currentSpending) || other.currentSpending == currentSpending)&&(identical(other.passkeyEnabled, passkeyEnabled) || other.passkeyEnabled == passkeyEnabled)&&const DeepCollectionEquality().equals(other.lockedMerchantCategories, lockedMerchantCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardFrozen,onlinePaymentLocked,internationalLocked,dailySpendingLimit,currentSpending,passkeyEnabled,const DeepCollectionEquality().hash(lockedMerchantCategories));

@override
String toString() {
  return 'SecuritySettings(cardFrozen: $cardFrozen, onlinePaymentLocked: $onlinePaymentLocked, internationalLocked: $internationalLocked, dailySpendingLimit: $dailySpendingLimit, currentSpending: $currentSpending, passkeyEnabled: $passkeyEnabled, lockedMerchantCategories: $lockedMerchantCategories)';
}


}

/// @nodoc
abstract mixin class $SecuritySettingsCopyWith<$Res>  {
  factory $SecuritySettingsCopyWith(SecuritySettings value, $Res Function(SecuritySettings) _then) = _$SecuritySettingsCopyWithImpl;
@useResult
$Res call({
 bool cardFrozen, bool onlinePaymentLocked, bool internationalLocked, double dailySpendingLimit, double currentSpending, bool passkeyEnabled, List<String> lockedMerchantCategories
});




}
/// @nodoc
class _$SecuritySettingsCopyWithImpl<$Res>
    implements $SecuritySettingsCopyWith<$Res> {
  _$SecuritySettingsCopyWithImpl(this._self, this._then);

  final SecuritySettings _self;
  final $Res Function(SecuritySettings) _then;

/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardFrozen = null,Object? onlinePaymentLocked = null,Object? internationalLocked = null,Object? dailySpendingLimit = null,Object? currentSpending = null,Object? passkeyEnabled = null,Object? lockedMerchantCategories = null,}) {
  return _then(_self.copyWith(
cardFrozen: null == cardFrozen ? _self.cardFrozen : cardFrozen // ignore: cast_nullable_to_non_nullable
as bool,onlinePaymentLocked: null == onlinePaymentLocked ? _self.onlinePaymentLocked : onlinePaymentLocked // ignore: cast_nullable_to_non_nullable
as bool,internationalLocked: null == internationalLocked ? _self.internationalLocked : internationalLocked // ignore: cast_nullable_to_non_nullable
as bool,dailySpendingLimit: null == dailySpendingLimit ? _self.dailySpendingLimit : dailySpendingLimit // ignore: cast_nullable_to_non_nullable
as double,currentSpending: null == currentSpending ? _self.currentSpending : currentSpending // ignore: cast_nullable_to_non_nullable
as double,passkeyEnabled: null == passkeyEnabled ? _self.passkeyEnabled : passkeyEnabled // ignore: cast_nullable_to_non_nullable
as bool,lockedMerchantCategories: null == lockedMerchantCategories ? _self.lockedMerchantCategories : lockedMerchantCategories // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SecuritySettings].
extension SecuritySettingsPatterns on SecuritySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecuritySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecuritySettings value)  $default,){
final _that = this;
switch (_that) {
case _SecuritySettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecuritySettings value)?  $default,){
final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool cardFrozen,  bool onlinePaymentLocked,  bool internationalLocked,  double dailySpendingLimit,  double currentSpending,  bool passkeyEnabled,  List<String> lockedMerchantCategories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
return $default(_that.cardFrozen,_that.onlinePaymentLocked,_that.internationalLocked,_that.dailySpendingLimit,_that.currentSpending,_that.passkeyEnabled,_that.lockedMerchantCategories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool cardFrozen,  bool onlinePaymentLocked,  bool internationalLocked,  double dailySpendingLimit,  double currentSpending,  bool passkeyEnabled,  List<String> lockedMerchantCategories)  $default,) {final _that = this;
switch (_that) {
case _SecuritySettings():
return $default(_that.cardFrozen,_that.onlinePaymentLocked,_that.internationalLocked,_that.dailySpendingLimit,_that.currentSpending,_that.passkeyEnabled,_that.lockedMerchantCategories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool cardFrozen,  bool onlinePaymentLocked,  bool internationalLocked,  double dailySpendingLimit,  double currentSpending,  bool passkeyEnabled,  List<String> lockedMerchantCategories)?  $default,) {final _that = this;
switch (_that) {
case _SecuritySettings() when $default != null:
return $default(_that.cardFrozen,_that.onlinePaymentLocked,_that.internationalLocked,_that.dailySpendingLimit,_that.currentSpending,_that.passkeyEnabled,_that.lockedMerchantCategories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SecuritySettings implements SecuritySettings {
  const _SecuritySettings({required this.cardFrozen, required this.onlinePaymentLocked, required this.internationalLocked, required this.dailySpendingLimit, required this.currentSpending, required this.passkeyEnabled, final  List<String> lockedMerchantCategories = const []}): _lockedMerchantCategories = lockedMerchantCategories;
  factory _SecuritySettings.fromJson(Map<String, dynamic> json) => _$SecuritySettingsFromJson(json);

@override final  bool cardFrozen;
@override final  bool onlinePaymentLocked;
@override final  bool internationalLocked;
@override final  double dailySpendingLimit;
@override final  double currentSpending;
@override final  bool passkeyEnabled;
 final  List<String> _lockedMerchantCategories;
@override@JsonKey() List<String> get lockedMerchantCategories {
  if (_lockedMerchantCategories is EqualUnmodifiableListView) return _lockedMerchantCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lockedMerchantCategories);
}


/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecuritySettingsCopyWith<_SecuritySettings> get copyWith => __$SecuritySettingsCopyWithImpl<_SecuritySettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SecuritySettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecuritySettings&&(identical(other.cardFrozen, cardFrozen) || other.cardFrozen == cardFrozen)&&(identical(other.onlinePaymentLocked, onlinePaymentLocked) || other.onlinePaymentLocked == onlinePaymentLocked)&&(identical(other.internationalLocked, internationalLocked) || other.internationalLocked == internationalLocked)&&(identical(other.dailySpendingLimit, dailySpendingLimit) || other.dailySpendingLimit == dailySpendingLimit)&&(identical(other.currentSpending, currentSpending) || other.currentSpending == currentSpending)&&(identical(other.passkeyEnabled, passkeyEnabled) || other.passkeyEnabled == passkeyEnabled)&&const DeepCollectionEquality().equals(other._lockedMerchantCategories, _lockedMerchantCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardFrozen,onlinePaymentLocked,internationalLocked,dailySpendingLimit,currentSpending,passkeyEnabled,const DeepCollectionEquality().hash(_lockedMerchantCategories));

@override
String toString() {
  return 'SecuritySettings(cardFrozen: $cardFrozen, onlinePaymentLocked: $onlinePaymentLocked, internationalLocked: $internationalLocked, dailySpendingLimit: $dailySpendingLimit, currentSpending: $currentSpending, passkeyEnabled: $passkeyEnabled, lockedMerchantCategories: $lockedMerchantCategories)';
}


}

/// @nodoc
abstract mixin class _$SecuritySettingsCopyWith<$Res> implements $SecuritySettingsCopyWith<$Res> {
  factory _$SecuritySettingsCopyWith(_SecuritySettings value, $Res Function(_SecuritySettings) _then) = __$SecuritySettingsCopyWithImpl;
@override @useResult
$Res call({
 bool cardFrozen, bool onlinePaymentLocked, bool internationalLocked, double dailySpendingLimit, double currentSpending, bool passkeyEnabled, List<String> lockedMerchantCategories
});




}
/// @nodoc
class __$SecuritySettingsCopyWithImpl<$Res>
    implements _$SecuritySettingsCopyWith<$Res> {
  __$SecuritySettingsCopyWithImpl(this._self, this._then);

  final _SecuritySettings _self;
  final $Res Function(_SecuritySettings) _then;

/// Create a copy of SecuritySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardFrozen = null,Object? onlinePaymentLocked = null,Object? internationalLocked = null,Object? dailySpendingLimit = null,Object? currentSpending = null,Object? passkeyEnabled = null,Object? lockedMerchantCategories = null,}) {
  return _then(_SecuritySettings(
cardFrozen: null == cardFrozen ? _self.cardFrozen : cardFrozen // ignore: cast_nullable_to_non_nullable
as bool,onlinePaymentLocked: null == onlinePaymentLocked ? _self.onlinePaymentLocked : onlinePaymentLocked // ignore: cast_nullable_to_non_nullable
as bool,internationalLocked: null == internationalLocked ? _self.internationalLocked : internationalLocked // ignore: cast_nullable_to_non_nullable
as bool,dailySpendingLimit: null == dailySpendingLimit ? _self.dailySpendingLimit : dailySpendingLimit // ignore: cast_nullable_to_non_nullable
as double,currentSpending: null == currentSpending ? _self.currentSpending : currentSpending // ignore: cast_nullable_to_non_nullable
as double,passkeyEnabled: null == passkeyEnabled ? _self.passkeyEnabled : passkeyEnabled // ignore: cast_nullable_to_non_nullable
as bool,lockedMerchantCategories: null == lockedMerchantCategories ? _self._lockedMerchantCategories : lockedMerchantCategories // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
