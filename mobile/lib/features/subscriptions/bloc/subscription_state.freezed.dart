// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubscriptionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionState()';
}


}

/// @nodoc
class $SubscriptionStateCopyWith<$Res>  {
$SubscriptionStateCopyWith(SubscriptionState _, $Res Function(SubscriptionState) __);
}


/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SubscriptionLoading value)?  loading,TResult Function( SubscriptionLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubscriptionLoading() when loading != null:
return loading(_that);case SubscriptionLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SubscriptionLoading value)  loading,required TResult Function( SubscriptionLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case SubscriptionLoading():
return loading(_that);case SubscriptionLoaded():
return loaded(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SubscriptionLoading value)?  loading,TResult? Function( SubscriptionLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case SubscriptionLoading() when loading != null:
return loading(_that);case SubscriptionLoaded() when loaded != null:
return loaded(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<Subscription> subscriptions,  double totalCommitment)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubscriptionLoading() when loading != null:
return loading();case SubscriptionLoaded() when loaded != null:
return loaded(_that.subscriptions,_that.totalCommitment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<Subscription> subscriptions,  double totalCommitment)  loaded,}) {final _that = this;
switch (_that) {
case SubscriptionLoading():
return loading();case SubscriptionLoaded():
return loaded(_that.subscriptions,_that.totalCommitment);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<Subscription> subscriptions,  double totalCommitment)?  loaded,}) {final _that = this;
switch (_that) {
case SubscriptionLoading() when loading != null:
return loading();case SubscriptionLoaded() when loaded != null:
return loaded(_that.subscriptions,_that.totalCommitment);case _:
  return null;

}
}

}

/// @nodoc


class SubscriptionLoading implements SubscriptionState {
  const SubscriptionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubscriptionState.loading()';
}


}




/// @nodoc


class SubscriptionLoaded implements SubscriptionState {
  const SubscriptionLoaded({required final  List<Subscription> subscriptions, required this.totalCommitment}): _subscriptions = subscriptions;
  

 final  List<Subscription> _subscriptions;
 List<Subscription> get subscriptions {
  if (_subscriptions is EqualUnmodifiableListView) return _subscriptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subscriptions);
}

 final  double totalCommitment;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionLoadedCopyWith<SubscriptionLoaded> get copyWith => _$SubscriptionLoadedCopyWithImpl<SubscriptionLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionLoaded&&const DeepCollectionEquality().equals(other._subscriptions, _subscriptions)&&(identical(other.totalCommitment, totalCommitment) || other.totalCommitment == totalCommitment));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_subscriptions),totalCommitment);

@override
String toString() {
  return 'SubscriptionState.loaded(subscriptions: $subscriptions, totalCommitment: $totalCommitment)';
}


}

/// @nodoc
abstract mixin class $SubscriptionLoadedCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionLoadedCopyWith(SubscriptionLoaded value, $Res Function(SubscriptionLoaded) _then) = _$SubscriptionLoadedCopyWithImpl;
@useResult
$Res call({
 List<Subscription> subscriptions, double totalCommitment
});




}
/// @nodoc
class _$SubscriptionLoadedCopyWithImpl<$Res>
    implements $SubscriptionLoadedCopyWith<$Res> {
  _$SubscriptionLoadedCopyWithImpl(this._self, this._then);

  final SubscriptionLoaded _self;
  final $Res Function(SubscriptionLoaded) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subscriptions = null,Object? totalCommitment = null,}) {
  return _then(SubscriptionLoaded(
subscriptions: null == subscriptions ? _self._subscriptions : subscriptions // ignore: cast_nullable_to_non_nullable
as List<Subscription>,totalCommitment: null == totalCommitment ? _self.totalCommitment : totalCommitment // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
