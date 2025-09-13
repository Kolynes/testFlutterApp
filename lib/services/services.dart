import 'package:dio/dio.dart';

class BusinessService {
  final Dio _dio;

  BusinessService(this._dio);

  Future<List<Map<String, dynamic>>> fetchBusinesses() async {
    try {
      final response = await _dio.get('/businesses');
      return response.data;
    } catch (e) {
      throw Exception('Failed to load businesses');
    }
  }
}