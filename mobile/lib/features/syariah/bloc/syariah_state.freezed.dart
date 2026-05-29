// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'syariah_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SyariahState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyariahState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyariahState()';
}


}

/// @nodoc
class $SyariahStateCopyWith<$Res>  {
$SyariahStateCopyWith(SyariahState _, $Res Function(SyariahState) __);
}


/// Adds pattern-matching-related methods to [SyariahState].
extension SyariahStatePatterns on SyariahState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SyariahLoading value)?  loading,TResult Function( SyariahLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SyariahLoading() when loading != null:
return loading(_that);case SyariahLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SyariahLoading value)  loading,required TResult Function( SyariahLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case SyariahLoading():
return loading(_that);case SyariahLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SyariahLoading value)?  loading,TResult? Function( SyariahLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case SyariahLoading() when loading != null:
return loading(_that);case SyariahLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( SyariahStateData data)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SyariahLoading() when loading != null:
return loading();case SyariahLoaded() when loaded != null:
return loaded(_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( SyariahStateData data)  loaded,}) {final _that = this;
switch (_that) {
case SyariahLoading():
return loading();case SyariahLoaded():
return loaded(_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( SyariahStateData data)?  loaded,}) {final _that = this;
switch (_that) {
case SyariahLoading() when loading != null:
return loading();case SyariahLoaded() when loaded != null:
return loaded(_that.data);case _:
  return null;

}
}

}

/// @nodoc


class SyariahLoading implements SyariahState {
  const SyariahLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyariahLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SyariahState.loading()';
}


}




/// @nodoc


class SyariahLoaded implements SyariahState {
  const SyariahLoaded(this.data);
  

 final  SyariahStateData data;

/// Create a copy of SyariahState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyariahLoadedCopyWith<SyariahLoaded> get copyWith => _$SyariahLoadedCopyWithImpl<SyariahLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyariahLoaded&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'SyariahState.loaded(data: $data)';
}


}

/// @nodoc
abstract mixin class $SyariahLoadedCopyWith<$Res> implements $SyariahStateCopyWith<$Res> {
  factory $SyariahLoadedCopyWith(SyariahLoaded value, $Res Function(SyariahLoaded) _then) = _$SyariahLoadedCopyWithImpl;
@useResult
$Res call({
 SyariahStateData data
});


$SyariahStateDataCopyWith<$Res> get data;

}
/// @nodoc
class _$SyariahLoadedCopyWithImpl<$Res>
    implements $SyariahLoadedCopyWith<$Res> {
  _$SyariahLoadedCopyWithImpl(this._self, this._then);

  final SyariahLoaded _self;
  final $Res Function(SyariahLoaded) _then;

/// Create a copy of SyariahState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(SyariahLoaded(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SyariahStateData,
  ));
}

/// Create a copy of SyariahState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SyariahStateDataCopyWith<$Res> get data {
  
  return $SyariahStateDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

// dart format on
