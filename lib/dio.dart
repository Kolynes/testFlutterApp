import 'package:dio/dio.dart';
import 'package:test_flutter/config.dart';

typedef ExceptionListener = Future<void> Function(Dio, int retries, DioException error);

BaseOptions baseOptions(ClientConfig config) {
  return BaseOptions(
    baseUrl: config.apiBaseUrl,
  );
}

class RetryInterceptor extends InterceptorsWrapper {
  final Dio dio;
  final int retries;
  Duration Function(int retryCount)? retryDelay;

  final exceptionListeners = <int, List<ExceptionListener>>{};

  RetryInterceptor({
    required this.dio,
    this.retries = 3,
    this.retryDelay,
  }) {
    retryDelay = retryDelay ?? (int retryCount) => Duration(seconds: 1);
  }

  retryOnCode(int code, ExceptionListener listener) {
    exceptionListeners[code] ??= [];
    exceptionListeners[code]!.add(listener);
  }

  retryOnException(DioExceptionType type, ExceptionListener listener) {
    exceptionListeners[type.index] ??= [];
    exceptionListeners[type.index]!.add(listener);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    var extra = err.requestOptions.extra;
    int retryCount = extra['retry_count'] ?? 0;

    final code = err.response?.statusCode ?? err.type.index;

    final shouldRetry = exceptionListeners[code] != null && exceptionListeners[code]!.isNotEmpty;

    if (retryCount < retries && shouldRetry) {
      retryCount++;
      await Future.delayed(retryDelay!(retryCount));

      await Future.wait(
        exceptionListeners[code]!.map((listener) => listener(dio, retryCount, err)),
      );

      final options = err.requestOptions;
      options.extra = Map<String, dynamic>.from(options.extra)
        ..['retry_count'] = retryCount;

      try {
        final response = await dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        return super.onError(err, handler);
      }
    }
    return super.onError(err, handler);
  }
}