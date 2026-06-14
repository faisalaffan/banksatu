import 'package:dio/dio.dart';
import 'package:banksatu_mobile/core/error/exceptions.dart';
import 'package:banksatu_mobile/core/error/failures.dart';

Failure mapDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return NetworkFailure(
        message: 'Koneksi timeout. Periksa jaringan Anda.',
        originalError: error,
      );
    case DioExceptionType.connectionError:
      return NetworkFailure(
        message: 'Tidak dapat terhubung ke server.',
        originalError: error,
      );
    case DioExceptionType.badResponse:
      return _mapResponseError(error.response!);
    case DioExceptionType.cancel:
      return const NetworkFailure(message: 'Request dibatalkan.');
    default:
      return ServerFailure(
        message: 'Terjadi kesalahan. Silakan coba lagi.',
        originalError: error,
      );
  }
}

Failure _mapResponseError(Response response) {
  final statusCode = response.statusCode;
  final data = response.data;

  String message = 'Terjadi kesalahan server.';
  if (data is Map && data.containsKey('message')) {
    message = data['message'] as String;
  }

  switch (statusCode) {
    case 400:
      return ValidationFailure(message: message);
    case 401:
    case 403:
      return AuthFailure(message: message, statusCode: statusCode);
    case 404:
      return NotFoundFailure(message: message);
    case 422:
      final errors = <String, String>{};
      if (data is Map && data.containsKey('errors')) {
        (data['errors'] as Map).forEach((k, v) => errors[k.toString()] = v.toString());
      }
      return ValidationFailure(message: message, fieldErrors: errors);
    case 500:
    case 502:
    case 503:
      return ServerFailure(message: message, statusCode: statusCode);
    default:
      return ServerFailure(message: message, statusCode: statusCode);
  }
}
