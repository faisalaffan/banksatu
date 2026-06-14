import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:banksatu_mobile/core/error/error_handler.dart';
import 'package:banksatu_mobile/core/error/failures.dart';

void main() {
  group('mapDioError', () {
    test('connection timeout returns NetworkFailure', () {
      final error = DioException(
        type: DioExceptionType.connectionTimeout,
        requestOptions: RequestOptions(path: '/test'),
      );
      final failure = mapDioError(error);

      expect(failure, isA<NetworkFailure>());
    });

    test('badResponse 401 returns AuthFailure', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 401,
          data: {'message': 'Unauthorized'},
        ),
        requestOptions: RequestOptions(path: '/test'),
      );
      final failure = mapDioError(error);

      expect(failure, isA<AuthFailure>());
    });

    test('badResponse 404 returns NotFoundFailure', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
        ),
        requestOptions: RequestOptions(path: '/test'),
      );
      final failure = mapDioError(error);

      expect(failure, isA<NotFoundFailure>());
    });

    test('badResponse 500 returns ServerFailure', () {
      final error = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 500,
        ),
        requestOptions: RequestOptions(path: '/test'),
      );
      final failure = mapDioError(error);

      expect(failure, isA<ServerFailure>());
    });

    test('connection error returns NetworkFailure', () {
      final error = DioException(
        type: DioExceptionType.connectionError,
        requestOptions: RequestOptions(path: '/test'),
      );
      final failure = mapDioError(error);

      expect(failure, isA<NetworkFailure>());
    });
  });
}
