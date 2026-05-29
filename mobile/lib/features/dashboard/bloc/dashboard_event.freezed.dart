// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent()';
}


}

/// @nodoc
class $DashboardEventCopyWith<$Res>  {
$DashboardEventCopyWith(DashboardEvent _, $Res Function(DashboardEvent) __);
}


/// Adds pattern-matching-related methods to [DashboardEvent].
extension DashboardEventPatterns on DashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadDashboard value)?  loadDashboard,TResult Function( SearchTransactions value)?  searchTransactions,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadDashboard() when loadDashboard != null:
return loadDashboard(_that);case SearchTransactions() when searchTransactions != null:
return searchTransactions(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadDashboard value)  loadDashboard,required TResult Function( SearchTransactions value)  searchTransactions,}){
final _that = this;
switch (_that) {
case LoadDashboard():
return loadDashboard(_that);case SearchTransactions():
return searchTransactions(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadDashboard value)?  loadDashboard,TResult? Function( SearchTransactions value)?  searchTransactions,}){
final _that = this;
switch (_that) {
case LoadDashboard() when loadDashboard != null:
return loadDashboard(_that);case SearchTransactions() when searchTransactions != null:
return searchTransactions(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadDashboard,TResult Function( String query)?  searchTransactions,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadDashboard() when loadDashboard != null:
return loadDashboard();case SearchTransactions() when searchTransactions != null:
return searchTransactions(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadDashboard,required TResult Function( String query)  searchTransactions,}) {final _that = this;
switch (_that) {
case LoadDashboard():
return loadDashboard();case SearchTransactions():
return searchTransactions(_that.query);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadDashboard,TResult? Function( String query)?  searchTransactions,}) {final _that = this;
switch (_that) {
case LoadDashboard() when loadDashboard != null:
return loadDashboard();case SearchTransactions() when searchTransactions != null:
return searchTransactions(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class LoadDashboard implements DashboardEvent {
  const LoadDashboard();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadDashboard);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.loadDashboard()';
}


}




/// @nodoc


class SearchTransactions implements DashboardEvent {
  const SearchTransactions(this.query);
  

 final  String query;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchTransactionsCopyWith<SearchTransactions> get copyWith => _$SearchTransactionsCopyWithImpl<SearchTransactions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchTransactions&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'DashboardEvent.searchTransactions(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchTransactionsCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory $SearchTransactionsCopyWith(SearchTransactions value, $Res Function(SearchTransactions) _then) = _$SearchTransactionsCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchTransactionsCopyWithImpl<$Res>
    implements $SearchTransactionsCopyWith<$Res> {
  _$SearchTransactionsCopyWithImpl(this._self, this._then);

  final SearchTransactions _self;
  final $Res Function(SearchTransactions) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchTransactions(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
