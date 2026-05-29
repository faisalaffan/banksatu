// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syariah_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyariahEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyariahEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyariahEvent()';
}


}

/// @nodoc
class $SyariahEventCopyWith<$Res>  {
$SyariahEventCopyWith(SyariahEvent _, $Res Function(SyariahEvent) __);
}


/// Adds pattern-matching-related methods to [SyariahEvent].
extension SyariahEventPatterns on SyariahEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSyariah value)?  loadSyariah,TResult Function( CleanseSyubhat value)?  cleanseSyubhat,TResult Function( ToggleZakatAutoDebit value)?  toggleZakatAutoDebit,TResult Function( SignAkad value)?  signAkad,TResult Function( PayZakatNow value)?  payZakatNow,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSyariah() when loadSyariah != null:
return loadSyariah(_that);case CleanseSyubhat() when cleanseSyubhat != null:
return cleanseSyubhat(_that);case ToggleZakatAutoDebit() when toggleZakatAutoDebit != null:
return toggleZakatAutoDebit(_that);case SignAkad() when signAkad != null:
return signAkad(_that);case PayZakatNow() when payZakatNow != null:
return payZakatNow(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSyariah value)  loadSyariah,required TResult Function( CleanseSyubhat value)  cleanseSyubhat,required TResult Function( ToggleZakatAutoDebit value)  toggleZakatAutoDebit,required TResult Function( SignAkad value)  signAkad,required TResult Function( PayZakatNow value)  payZakatNow,}){
final _that = this;
switch (_that) {
case LoadSyariah():
return loadSyariah(_that);case CleanseSyubhat():
return cleanseSyubhat(_that);case ToggleZakatAutoDebit():
return toggleZakatAutoDebit(_that);case SignAkad():
return signAkad(_that);case PayZakatNow():
return payZakatNow(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSyariah value)?  loadSyariah,TResult? Function( CleanseSyubhat value)?  cleanseSyubhat,TResult? Function( ToggleZakatAutoDebit value)?  toggleZakatAutoDebit,TResult? Function( SignAkad value)?  signAkad,TResult? Function( PayZakatNow value)?  payZakatNow,}){
final _that = this;
switch (_that) {
case LoadSyariah() when loadSyariah != null:
return loadSyariah(_that);case CleanseSyubhat() when cleanseSyubhat != null:
return cleanseSyubhat(_that);case ToggleZakatAutoDebit() when toggleZakatAutoDebit != null:
return toggleZakatAutoDebit(_that);case SignAkad() when signAkad != null:
return signAkad(_that);case PayZakatNow() when payZakatNow != null:
return payZakatNow(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSyariah,TResult Function()?  cleanseSyubhat,TResult Function()?  toggleZakatAutoDebit,TResult Function( String akadName)?  signAkad,TResult Function( double amount)?  payZakatNow,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSyariah() when loadSyariah != null:
return loadSyariah();case CleanseSyubhat() when cleanseSyubhat != null:
return cleanseSyubhat();case ToggleZakatAutoDebit() when toggleZakatAutoDebit != null:
return toggleZakatAutoDebit();case SignAkad() when signAkad != null:
return signAkad(_that.akadName);case PayZakatNow() when payZakatNow != null:
return payZakatNow(_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSyariah,required TResult Function()  cleanseSyubhat,required TResult Function()  toggleZakatAutoDebit,required TResult Function( String akadName)  signAkad,required TResult Function( double amount)  payZakatNow,}) {final _that = this;
switch (_that) {
case LoadSyariah():
return loadSyariah();case CleanseSyubhat():
return cleanseSyubhat();case ToggleZakatAutoDebit():
return toggleZakatAutoDebit();case SignAkad():
return signAkad(_that.akadName);case PayZakatNow():
return payZakatNow(_that.amount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSyariah,TResult? Function()?  cleanseSyubhat,TResult? Function()?  toggleZakatAutoDebit,TResult? Function( String akadName)?  signAkad,TResult? Function( double amount)?  payZakatNow,}) {final _that = this;
switch (_that) {
case LoadSyariah() when loadSyariah != null:
return loadSyariah();case CleanseSyubhat() when cleanseSyubhat != null:
return cleanseSyubhat();case ToggleZakatAutoDebit() when toggleZakatAutoDebit != null:
return toggleZakatAutoDebit();case SignAkad() when signAkad != null:
return signAkad(_that.akadName);case PayZakatNow() when payZakatNow != null:
return payZakatNow(_that.amount);case _:
  return null;

}
}

}

/// @nodoc


class LoadSyariah implements SyariahEvent {
  const LoadSyariah();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSyariah);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyariahEvent.loadSyariah()';
}


}




/// @nodoc


class CleanseSyubhat implements SyariahEvent {
  const CleanseSyubhat();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CleanseSyubhat);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyariahEvent.cleanseSyubhat()';
}


}




/// @nodoc


class ToggleZakatAutoDebit implements SyariahEvent {
  const ToggleZakatAutoDebit();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToggleZakatAutoDebit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyariahEvent.toggleZakatAutoDebit()';
}


}




/// @nodoc


class SignAkad implements SyariahEvent {
  const SignAkad(this.akadName);
  

 final  String akadName;

/// Create a copy of SyariahEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignAkadCopyWith<SignAkad> get copyWith => _$SignAkadCopyWithImpl<SignAkad>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignAkad&&(identical(other.akadName, akadName) || other.akadName == akadName));
}


@override
int get hashCode => Object.hash(runtimeType,akadName);

@override
String toString() {
  return 'SyariahEvent.signAkad(akadName: $akadName)';
}


}

/// @nodoc
abstract mixin class $SignAkadCopyWith<$Res> implements $SyariahEventCopyWith<$Res> {
  factory $SignAkadCopyWith(SignAkad value, $Res Function(SignAkad) _then) = _$SignAkadCopyWithImpl;
@useResult
$Res call({
 String akadName
});




}
/// @nodoc
class _$SignAkadCopyWithImpl<$Res>
    implements $SignAkadCopyWith<$Res> {
  _$SignAkadCopyWithImpl(this._self, this._then);

  final SignAkad _self;
  final $Res Function(SignAkad) _then;

/// Create a copy of SyariahEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? akadName = null,}) {
  return _then(SignAkad(
null == akadName ? _self.akadName : akadName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PayZakatNow implements SyariahEvent {
  const PayZakatNow(this.amount);
  

 final  double amount;

/// Create a copy of SyariahEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayZakatNowCopyWith<PayZakatNow> get copyWith => _$PayZakatNowCopyWithImpl<PayZakatNow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayZakatNow&&(identical(other.amount, amount) || other.amount == amount));
}


@override
int get hashCode => Object.hash(runtimeType,amount);

@override
String toString() {
  return 'SyariahEvent.payZakatNow(amount: $amount)';
}


}

/// @nodoc
abstract mixin class $PayZakatNowCopyWith<$Res> implements $SyariahEventCopyWith<$Res> {
  factory $PayZakatNowCopyWith(PayZakatNow value, $Res Function(PayZakatNow) _then) = _$PayZakatNowCopyWithImpl;
@useResult
$Res call({
 double amount
});




}
/// @nodoc
class _$PayZakatNowCopyWithImpl<$Res>
    implements $PayZakatNowCopyWith<$Res> {
  _$PayZakatNowCopyWithImpl(this._self, this._then);

  final PayZakatNow _self;
  final $Res Function(PayZakatNow) _then;

/// Create a copy of SyariahEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? amount = null,}) {
  return _then(PayZakatNow(
null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
