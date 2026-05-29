// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent()';
}


}

/// @nodoc
class $SecurityEventCopyWith<$Res>  {
$SecurityEventCopyWith(SecurityEvent _, $Res Function(SecurityEvent) __);
}


/// Adds pattern-matching-related methods to [SecurityEvent].
extension SecurityEventPatterns on SecurityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSecurity value)?  loadSecurity,TResult Function( ToggleCardFreeze value)?  toggleCardFreeze,TResult Function( ToggleOnlinePayment value)?  toggleOnlinePayment,TResult Function( ToggleInternational value)?  toggleInternational,TResult Function( UpdateSpendingLimit value)?  updateSpendingLimit,TResult Function( TogglePasskey value)?  togglePasskey,TResult Function( ToggleCategoryLock value)?  toggleCategoryLock,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSecurity() when loadSecurity != null:
return loadSecurity(_that);case ToggleCardFreeze() when toggleCardFreeze != null:
return toggleCardFreeze(_that);case ToggleOnlinePayment() when toggleOnlinePayment != null:
return toggleOnlinePayment(_that);case ToggleInternational() when toggleInternational != null:
return toggleInternational(_that);case UpdateSpendingLimit() when updateSpendingLimit != null:
return updateSpendingLimit(_that);case TogglePasskey() when togglePasskey != null:
return togglePasskey(_that);case ToggleCategoryLock() when toggleCategoryLock != null:
return toggleCategoryLock(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSecurity value)  loadSecurity,required TResult Function( ToggleCardFreeze value)  toggleCardFreeze,required TResult Function( ToggleOnlinePayment value)  toggleOnlinePayment,required TResult Function( ToggleInternational value)  toggleInternational,required TResult Function( UpdateSpendingLimit value)  updateSpendingLimit,required TResult Function( TogglePasskey value)  togglePasskey,required TResult Function( ToggleCategoryLock value)  toggleCategoryLock,}){
final _that = this;
switch (_that) {
case LoadSecurity():
return loadSecurity(_that);case ToggleCardFreeze():
return toggleCardFreeze(_that);case ToggleOnlinePayment():
return toggleOnlinePayment(_that);case ToggleInternational():
return toggleInternational(_that);case UpdateSpendingLimit():
return updateSpendingLimit(_that);case TogglePasskey():
return togglePasskey(_that);case ToggleCategoryLock():
return toggleCategoryLock(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSecurity value)?  loadSecurity,TResult? Function( ToggleCardFreeze value)?  toggleCardFreeze,TResult? Function( ToggleOnlinePayment value)?  toggleOnlinePayment,TResult? Function( ToggleInternational value)?  toggleInternational,TResult? Function( UpdateSpendingLimit value)?  updateSpendingLimit,TResult? Function( TogglePasskey value)?  togglePasskey,TResult? Function( ToggleCategoryLock value)?  toggleCategoryLock,}){
final _that = this;
switch (_that) {
case LoadSecurity() when loadSecurity != null:
return loadSecurity(_that);case ToggleCardFreeze() when toggleCardFreeze != null:
return toggleCardFreeze(_that);case ToggleOnlinePayment() when toggleOnlinePayment != null:
return toggleOnlinePayment(_that);case ToggleInternational() when toggleInternational != null:
return toggleInternational(_that);case UpdateSpendingLimit() when updateSpendingLimit != null:
return updateSpendingLimit(_that);case TogglePasskey() when togglePasskey != null:
return togglePasskey(_that);case ToggleCategoryLock() when toggleCategoryLock != null:
return toggleCategoryLock(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSecurity,TResult Function()?  toggleCardFreeze,TResult Function()?  toggleOnlinePayment,TResult Function()?  toggleInternational,TResult Function( double newLimit)?  updateSpendingLimit,TResult Function()?  togglePasskey,TResult Function( String category)?  toggleCategoryLock,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSecurity() when loadSecurity != null:
return loadSecurity();case ToggleCardFreeze() when toggleCardFreeze != null:
return toggleCardFreeze();case ToggleOnlinePayment() when toggleOnlinePayment != null:
return toggleOnlinePayment();case ToggleInternational() when toggleInternational != null:
return toggleInternational();case UpdateSpendingLimit() when updateSpendingLimit != null:
return updateSpendingLimit(_that.newLimit);case TogglePasskey() when togglePasskey != null:
return togglePasskey();case ToggleCategoryLock() when toggleCategoryLock != null:
return toggleCategoryLock(_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSecurity,required TResult Function()  toggleCardFreeze,required TResult Function()  toggleOnlinePayment,required TResult Function()  toggleInternational,required TResult Function( double newLimit)  updateSpendingLimit,required TResult Function()  togglePasskey,required TResult Function( String category)  toggleCategoryLock,}) {final _that = this;
switch (_that) {
case LoadSecurity():
return loadSecurity();case ToggleCardFreeze():
return toggleCardFreeze();case ToggleOnlinePayment():
return toggleOnlinePayment();case ToggleInternational():
return toggleInternational();case UpdateSpendingLimit():
return updateSpendingLimit(_that.newLimit);case TogglePasskey():
return togglePasskey();case ToggleCategoryLock():
return toggleCategoryLock(_that.category);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSecurity,TResult? Function()?  toggleCardFreeze,TResult? Function()?  toggleOnlinePayment,TResult? Function()?  toggleInternational,TResult? Function( double newLimit)?  updateSpendingLimit,TResult? Function()?  togglePasskey,TResult? Function( String category)?  toggleCategoryLock,}) {final _that = this;
switch (_that) {
case LoadSecurity() when loadSecurity != null:
return loadSecurity();case ToggleCardFreeze() when toggleCardFreeze != null:
return toggleCardFreeze();case ToggleOnlinePayment() when toggleOnlinePayment != null:
return toggleOnlinePayment();case ToggleInternational() when toggleInternational != null:
return toggleInternational();case UpdateSpendingLimit() when updateSpendingLimit != null:
return updateSpendingLimit(_that.newLimit);case TogglePasskey() when togglePasskey != null:
return togglePasskey();case ToggleCategoryLock() when toggleCategoryLock != null:
return toggleCategoryLock(_that.category);case _:
  return null;

}
}

}

/// @nodoc


class LoadSecurity implements SecurityEvent {
  const LoadSecurity();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSecurity);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent.loadSecurity()';
}


}




/// @nodoc


class ToggleCardFreeze implements SecurityEvent {
  const ToggleCardFreeze();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleCardFreeze);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent.toggleCardFreeze()';
}


}




/// @nodoc


class ToggleOnlinePayment implements SecurityEvent {
  const ToggleOnlinePayment();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleOnlinePayment);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent.toggleOnlinePayment()';
}


}




/// @nodoc


class ToggleInternational implements SecurityEvent {
  const ToggleInternational();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleInternational);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent.toggleInternational()';
}


}




/// @nodoc


class UpdateSpendingLimit implements SecurityEvent {
  const UpdateSpendingLimit(this.newLimit);
  

 final  double newLimit;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateSpendingLimitCopyWith<UpdateSpendingLimit> get copyWith => _$UpdateSpendingLimitCopyWithImpl<UpdateSpendingLimit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSpendingLimit&&(identical(other.newLimit, newLimit) || other.newLimit == newLimit));
}


@override
int get hashCode => Object.hash(runtimeType,newLimit);

@override
String toString() {
  return 'SecurityEvent.updateSpendingLimit(newLimit: $newLimit)';
}


}

/// @nodoc
abstract mixin class $UpdateSpendingLimitCopyWith<$Res> implements $SecurityEventCopyWith<$Res> {
  factory $UpdateSpendingLimitCopyWith(UpdateSpendingLimit value, $Res Function(UpdateSpendingLimit) _then) = _$UpdateSpendingLimitCopyWithImpl;
@useResult
$Res call({
 double newLimit
});




}
/// @nodoc
class _$UpdateSpendingLimitCopyWithImpl<$Res>
    implements $UpdateSpendingLimitCopyWith<$Res> {
  _$UpdateSpendingLimitCopyWithImpl(this._self, this._then);

  final UpdateSpendingLimit _self;
  final $Res Function(UpdateSpendingLimit) _then;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newLimit = null,}) {
  return _then(UpdateSpendingLimit(
null == newLimit ? _self.newLimit : newLimit // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class TogglePasskey implements SecurityEvent {
  const TogglePasskey();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TogglePasskey);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityEvent.togglePasskey()';
}


}




/// @nodoc


class ToggleCategoryLock implements SecurityEvent {
  const ToggleCategoryLock(this.category);
  

 final  String category;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToggleCategoryLockCopyWith<ToggleCategoryLock> get copyWith => _$ToggleCategoryLockCopyWithImpl<ToggleCategoryLock>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleCategoryLock&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'SecurityEvent.toggleCategoryLock(category: $category)';
}


}

/// @nodoc
abstract mixin class $ToggleCategoryLockCopyWith<$Res> implements $SecurityEventCopyWith<$Res> {
  factory $ToggleCategoryLockCopyWith(ToggleCategoryLock value, $Res Function(ToggleCategoryLock) _then) = _$ToggleCategoryLockCopyWithImpl;
@useResult
$Res call({
 String category
});




}
/// @nodoc
class _$ToggleCategoryLockCopyWithImpl<$Res>
    implements $ToggleCategoryLockCopyWith<$Res> {
  _$ToggleCategoryLockCopyWithImpl(this._self, this._then);

  final ToggleCategoryLock _self;
  final $Res Function(ToggleCategoryLock) _then;

/// Create a copy of SecurityEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = null,}) {
  return _then(ToggleCategoryLock(
null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
