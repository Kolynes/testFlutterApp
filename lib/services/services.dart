import 'dart:developer';

import 'package:dio/dio.dart';

class BusinessService {
  final Dio _dio;

  BusinessService(this._dio);

  Future<dynamic> fetchBusinesses() async {
    try {
      final response = await _dio.get('/businesses');
      log('Fetched businesses in service: ${response.data}');
      return response.data;
    } catch (e) {
      log('Error in fetchBusinesses: $e');
      throw Exception('Failed to load businesses');
    }
  }
}