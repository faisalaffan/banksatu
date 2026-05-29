// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SecurityState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityState()';
}


}

/// @nodoc
class $SecurityStateCopyWith<$Res>  {
$SecurityStateCopyWith(SecurityState _, $Res Function(SecurityState) __);
}


/// Adds pattern-matching-related methods to [SecurityState].
extension SecurityStatePatterns on SecurityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SecurityLoading value)?  loading,TResult Function( SecurityLoaded value)?  loaded,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SecurityLoading() when loading != null:
return loading(_that);case SecurityLoaded() when loaded != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SecurityLoading value)  loading,required TResult Function( SecurityLoaded value)  loaded,}){
final _that = this;
switch (_that) {
case SecurityLoading():
return loading(_that);case SecurityLoaded():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SecurityLoading value)?  loading,TResult? Function( SecurityLoaded value)?  loaded,}){
final _that = this;
switch (_that) {
case SecurityLoading() when loading != null:
return loading(_that);case SecurityLoaded() when loaded != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( SecuritySettings settings)?  loaded,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SecurityLoading() when loading != null:
return loading();case SecurityLoaded() when loaded != null:
return loaded(_that.settings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( SecuritySettings settings)  loaded,}) {final _that = this;
switch (_that) {
case SecurityLoading():
return loading();case SecurityLoaded():
return loaded(_that.settings);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( SecuritySettings settings)?  loaded,}) {final _that = this;
switch (_that) {
case SecurityLoading() when loading != null:
return loading();case SecurityLoaded() when loaded != null:
return loaded(_that.settings);case _:
  return null;

}
}

}

/// @nodoc


class SecurityLoading implements SecurityState {
  const SecurityLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SecurityState.loading()';
}


}




/// @nodoc


class SecurityLoaded implements SecurityState {
  const SecurityLoaded(this.settings);
  

 final  SecuritySettings settings;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityLoadedCopyWith<SecurityLoaded> get copyWith => _$SecurityLoadedCopyWithImpl<SecurityLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityLoaded&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'SecurityState.loaded(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $SecurityLoadedCopyWith<$Res> implements $SecurityStateCopyWith<$Res> {
  factory $SecurityLoadedCopyWith(SecurityLoaded value, $Res Function(SecurityLoaded) _then) = _$SecurityLoadedCopyWithImpl;
@useResult
$Res call({
 SecuritySettings settings
});


$SecuritySettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$SecurityLoadedCopyWithImpl<$Res>
    implements $SecurityLoadedCopyWith<$Res> {
  _$SecurityLoadedCopyWithImpl(this._self, this._then);

  final SecurityLoaded _self;
  final $Res Function(SecurityLoaded) _then;

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(SecurityLoaded(
null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as SecuritySettings,
  ));
}

/// Create a copy of SecurityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecuritySettingsCopyWith<$Res> get settings {
  
  return $SecuritySettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
