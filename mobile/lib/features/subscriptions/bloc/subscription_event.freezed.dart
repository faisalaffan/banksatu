// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent()';
}


}

/// @nodoc
class $SubscriptionEventCopyWith<$Res>  {
$SubscriptionEventCopyWith(SubscriptionEvent _, $Res Function(SubscriptionEvent) __);
}


/// Adds pattern-matching-related methods to [SubscriptionEvent].
extension SubscriptionEventPatterns on SubscriptionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSubscriptions value)?  loadSubscriptions,TResult Function( CancelSubscription value)?  cancelSubscription,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSubscriptions() when loadSubscriptions != null:
return loadSubscriptions(_that);case CancelSubscription() when cancelSubscription != null:
return cancelSubscription(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSubscriptions value)  loadSubscriptions,required TResult Function( CancelSubscription value)  cancelSubscription,}){
final _that = this;
switch (_that) {
case LoadSubscriptions():
return loadSubscriptions(_that);case CancelSubscription():
return cancelSubscription(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSubscriptions value)?  loadSubscriptions,TResult? Function( CancelSubscription value)?  cancelSubscription,}){
final _that = this;
switch (_that) {
case LoadSubscriptions() when loadSubscriptions != null:
return loadSubscriptions(_that);case CancelSubscription() when cancelSubscription != null:
return cancelSubscription(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSubscriptions,TResult Function( String subscriptionId)?  cancelSubscription,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSubscriptions() when loadSubscriptions != null:
return loadSubscriptions();case CancelSubscription() when cancelSubscription != null:
return cancelSubscription(_that.subscriptionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSubscriptions,required TResult Function( String subscriptionId)  cancelSubscription,}) {final _that = this;
switch (_that) {
case LoadSubscriptions():
return loadSubscriptions();case CancelSubscription():
return cancelSubscription(_that.subscriptionId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSubscriptions,TResult? Function( String subscriptionId)?  cancelSubscription,}) {final _that = this;
switch (_that) {
case LoadSubscriptions() when loadSubscriptions != null:
return loadSubscriptions();case CancelSubscription() when cancelSubscription != null:
return cancelSubscription(_that.subscriptionId);case _:
  return null;

}
}

}

/// @nodoc


class LoadSubscriptions implements SubscriptionEvent {
  const LoadSubscriptions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSubscriptions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionEvent.loadSubscriptions()';
}


}




/// @nodoc


class CancelSubscription implements SubscriptionEvent {
  const CancelSubscription(this.subscriptionId);
  

 final  String subscriptionId;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelSubscriptionCopyWith<CancelSubscription> get copyWith => _$CancelSubscriptionCopyWithImpl<CancelSubscription>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelSubscription&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}


@override
int get hashCode => Object.hash(runtimeType,subscriptionId);

@override
String toString() {
  return 'SubscriptionEvent.cancelSubscription(subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class $CancelSubscriptionCopyWith<$Res> implements $SubscriptionEventCopyWith<$Res> {
  factory $CancelSubscriptionCopyWith(CancelSubscription value, $Res Function(CancelSubscription) _then) = _$CancelSubscriptionCopyWithImpl;
@useResult
$Res call({
 String subscriptionId
});




}
/// @nodoc
class _$CancelSubscriptionCopyWithImpl<$Res>
    implements $CancelSubscriptionCopyWith<$Res> {
  _$CancelSubscriptionCopyWithImpl(this._self, this._then);

  final CancelSubscription _self;
  final $Res Function(CancelSubscription) _then;

/// Create a copy of SubscriptionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subscriptionId = null,}) {
  return _then(CancelSubscription(
null == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
