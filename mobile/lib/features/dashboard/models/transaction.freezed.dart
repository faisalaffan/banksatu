// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transaction {

 String get id; String get merchantName; String get originalAcquirerString; double get amount; String get category; DateTime get timestamp; double get latitude; double get longitude; Map<String, double> get feeBreakdown; bool get isSuccess;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.originalAcquirerString, originalAcquirerString) || other.originalAcquirerString == originalAcquirerString)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.feeBreakdown, feeBreakdown)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,merchantName,originalAcquirerString,amount,category,timestamp,latitude,longitude,const DeepCollectionEquality().hash(feeBreakdown),isSuccess);

@override
String toString() {
  return 'Transaction(id: $id, merchantName: $merchantName, originalAcquirerString: $originalAcquirerString, amount: $amount, category: $category, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, feeBreakdown: $feeBreakdown, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String id, String merchantName, String originalAcquirerString, double amount, String category, DateTime timestamp, double latitude, double longitude, Map<String, double> feeBreakdown, bool isSuccess
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? merchantName = null,Object? originalAcquirerString = null,Object? amount = null,Object? category = null,Object? timestamp = null,Object? latitude = null,Object? longitude = null,Object? feeBreakdown = null,Object? isSuccess = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,merchantName: null == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String,originalAcquirerString: null == originalAcquirerString ? _self.originalAcquirerString : originalAcquirerString // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,feeBreakdown: null == feeBreakdown ? _self.feeBreakdown : feeBreakdown // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String merchantName,  String originalAcquirerString,  double amount,  String category,  DateTime timestamp,  double latitude,  double longitude,  Map<String, double> feeBreakdown,  bool isSuccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.merchantName,_that.originalAcquirerString,_that.amount,_that.category,_that.timestamp,_that.latitude,_that.longitude,_that.feeBreakdown,_that.isSuccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String merchantName,  String originalAcquirerString,  double amount,  String category,  DateTime timestamp,  double latitude,  double longitude,  Map<String, double> feeBreakdown,  bool isSuccess)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.id,_that.merchantName,_that.originalAcquirerString,_that.amount,_that.category,_that.timestamp,_that.latitude,_that.longitude,_that.feeBreakdown,_that.isSuccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String merchantName,  String originalAcquirerString,  double amount,  String category,  DateTime timestamp,  double latitude,  double longitude,  Map<String, double> feeBreakdown,  bool isSuccess)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.merchantName,_that.originalAcquirerString,_that.amount,_that.category,_that.timestamp,_that.latitude,_that.longitude,_that.feeBreakdown,_that.isSuccess);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transaction implements Transaction {
  const _Transaction({required this.id, required this.merchantName, required this.originalAcquirerString, required this.amount, required this.category, required this.timestamp, required this.latitude, required this.longitude, required final  Map<String, double> feeBreakdown, this.isSuccess = true}): _feeBreakdown = feeBreakdown;
  factory _Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

@override final  String id;
@override final  String merchantName;
@override final  String originalAcquirerString;
@override final  double amount;
@override final  String category;
@override final  DateTime timestamp;
@override final  double latitude;
@override final  double longitude;
 final  Map<String, double> _feeBreakdown;
@override Map<String, double> get feeBreakdown {
  if (_feeBreakdown is EqualUnmodifiableMapView) return _feeBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_feeBreakdown);
}

@override@JsonKey() final  bool isSuccess;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.merchantName, merchantName) || other.merchantName == merchantName)&&(identical(other.originalAcquirerString, originalAcquirerString) || other.originalAcquirerString == originalAcquirerString)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other._feeBreakdown, _feeBreakdown)&&(identical(other.isSuccess, isSuccess) || other.isSuccess == isSuccess));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,merchantName,originalAcquirerString,amount,category,timestamp,latitude,longitude,const DeepCollectionEquality().hash(_feeBreakdown),isSuccess);

@override
String toString() {
  return 'Transaction(id: $id, merchantName: $merchantName, originalAcquirerString: $originalAcquirerString, amount: $amount, category: $category, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, feeBreakdown: $feeBreakdown, isSuccess: $isSuccess)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String merchantName, String originalAcquirerString, double amount, String category, DateTime timestamp, double latitude, double longitude, Map<String, double> feeBreakdown, bool isSuccess
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? merchantName = null,Object? originalAcquirerString = null,Object? amount = null,Object? category = null,Object? timestamp = null,Object? latitude = null,Object? longitude = null,Object? feeBreakdown = null,Object? isSuccess = null,}) {
  return _then(_Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,merchantName: null == merchantName ? _self.merchantName : merchantName // ignore: cast_nullable_to_non_nullable
as String,originalAcquirerString: null == originalAcquirerString ? _self.originalAcquirerString : originalAcquirerString // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,feeBreakdown: null == feeBreakdown ? _self._feeBreakdown : feeBreakdown // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isSuccess: null == isSuccess ? _self.isSuccess : isSuccess // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
