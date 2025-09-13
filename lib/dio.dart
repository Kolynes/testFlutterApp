import 'package:dio/dio.dart';
import 'package:test_flutter/config.dart';

BaseOptions baseOptions(ClientConfig config) {
  return BaseOptions(
    baseUrl: config.apiBaseUrl,
  );
}

class RetryInterceptor extends InterceptorsWrapper {

}