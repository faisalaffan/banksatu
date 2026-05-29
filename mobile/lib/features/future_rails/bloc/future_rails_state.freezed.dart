// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'future_rails_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FutureRailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FutureRailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FutureRailsState()';
}


}

/// @nodoc
class $FutureRailsStateCopyWith<$Res>  {
$FutureRailsStateCopyWith(FutureRailsState _, $Res Function(FutureRailsState) __);
}


/// Adds pattern-matching-related methods to [FutureRailsState].
extension FutureRailsStatePatterns on FutureRailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FutureRailsLoading value)?  loading,TResult Function( FutureRailsLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FutureRailsLoading() when loading != null:
return loading(_that);case FutureRailsLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FutureRailsLoading value)  loading,required TResult Function( FutureRailsLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case FutureRailsLoading():
return loading(_that);case FutureRailsLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FutureRailsLoading value)?  loading,TResult? Function( FutureRailsLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case FutureRailsLoading() when loading != null:
return loading(_that);case FutureRailsLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( FutureRailsData data,  String? transactionStatusMessage,  bool isTransactionSuccessful)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FutureRailsLoading() when loading != null:
return loading();case FutureRailsLoaded() when loaded != null:
return loaded(_that.data,_that.transactionStatusMessage,_that.isTransactionSuccessful);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( FutureRailsData data,  String? transactionStatusMessage,  bool isTransactionSuccessful)  loaded,}) {final _that = this;
switch (_that) {
case FutureRailsLoading():
return loading();case FutureRailsLoaded():
return loaded(_that.data,_that.transactionStatusMessage,_that.isTransactionSuccessful);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( FutureRailsData data,  String? transactionStatusMessage,  bool isTransactionSuccessful)?  loaded,}) {final _that = this;
switch (_that) {
case FutureRailsLoading() when loading != null:
return loading();case FutureRailsLoaded() when loaded != null:
return loaded(_that.data,_that.transactionStatusMessage,_that.isTransactionSuccessful);case _:
  return null;

}
}

}

/// @nodoc


class FutureRailsLoading implements FutureRailsState {
  const FutureRailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FutureRailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FutureRailsState.loading()';
}


}




/// @nodoc


class FutureRailsLoaded implements FutureRailsState {
  const FutureRailsLoaded({required this.data, this.transactionStatusMessage, this.isTransactionSuccessful = true});
  

 final  FutureRailsData data;
 final  String? transactionStatusMessage;
@JsonKey() final  bool isTransactionSuccessful;

/// Create a copy of FutureRailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FutureRailsLoadedCopyWith<FutureRailsLoaded> get copyWith => _$FutureRailsLoadedCopyWithImpl<FutureRailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FutureRailsLoaded&&(identical(other.data, data) || other.data == data)&&(identical(other.transactionStatusMessage, transactionStatusMessage) || other.transactionStatusMessage == transactionStatusMessage)&&(identical(other.isTransactionSuccessful, isTransactionSuccessful) || other.isTransactionSuccessful == isTransactionSuccessful));
}


@override
int get hashCode => Object.hash(runtimeType,data,transactionStatusMessage,isTransactionSuccessful);

@override
String toString() {
  return 'FutureRailsState.loaded(data: $data, transactionStatusMessage: $transactionStatusMessage, isTransactionSuccessful: $isTransactionSuccessful)';
}


}

/// @nodoc
abstract mixin class $FutureRailsLoadedCopyWith<$Res> implements $FutureRailsStateCopyWith<$Res> {
  factory $FutureRailsLoadedCopyWith(FutureRailsLoaded value, $Res Function(FutureRailsLoaded) _then) = _$FutureRailsLoadedCopyWithImpl;
@useResult
$Res call({
 FutureRailsData data, String? transactionStatusMessage, bool isTransactionSuccessful
});


$FutureRailsDataCopyWith<$Res> get data;

}
/// @nodoc
class _$FutureRailsLoadedCopyWithImpl<$Res>
    implements $FutureRailsLoadedCopyWith<$Res> {
  _$FutureRailsLoadedCopyWithImpl(this._self, this._then);

  final FutureRailsLoaded _self;
  final $Res Function(FutureRailsLoaded) _then;

/// Create a copy of FutureRailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? transactionStatusMessage = freezed,Object? isTransactionSuccessful = null,}) {
  return _then(FutureRailsLoaded(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as FutureRailsData,transactionStatusMessage: freezed == transactionStatusMessage ? _self.transactionStatusMessage : transactionStatusMessage // ignore: cast_nullable_to_non_nullable
as String?,isTransactionSuccessful: null == isTransactionSuccessful ? _self.isTransactionSuccessful : isTransactionSuccessful // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FutureRailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FutureRailsDataCopyWith<$Res> get data {
  
  return $FutureRailsDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
