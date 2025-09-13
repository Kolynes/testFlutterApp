import 'package:test_flutter/models/Business.dart';
import 'package:test_flutter/services/services.dart';

class BusinessRepository {
  final BusinessService _businessService;

  BusinessRepository(this._businessService);

  Future<List<BusinessDTO>> fetchBusinesses() async {
    try {
      final response = await _businessService.fetchBusinesses();
      return response.map((json) => BusinessDTO.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load businesses');
    }
  }
}