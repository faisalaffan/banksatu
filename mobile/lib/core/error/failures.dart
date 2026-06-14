/// Base failure class untuk semua error di aplikasi.
abstract class Failure {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const Failure({required this.message, this.statusCode, this.originalError});

  @override
  String toString() => '$runtimeType: $message';
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode, super.originalError});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.originalError});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.originalError});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.statusCode, super.originalError});
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({required super.message, this.fieldErrors});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.originalError});
}
