import 'package:hive/hive.dart';
import 'package:test_flutter/models/Business.dart';
import 'package:test_flutter/services/services.dart';

class BusinessRepository {
  final BusinessService _businessService;
  final BoxCollection collection;

  BusinessRepository(this._businessService, this.collection);

  Future<void> saveBusinesses(List<BusinessDTO> businesses) async {
    final box = await collection.openBox('businessBox');
    await box.put('businesses', businesses.map((b) => b.toJson()).toList());
  }

  Future<void> deleteBusinesses() async {
    final box = await collection.openBox('businessBox');
    await box.delete('businesses');
  }

  Future<List<BusinessDTO>> getSavedBusinesses() async {
    final box = await collection.openBox('businessBox');
    final savedBusinesses = box.get('businesses') as List<dynamic>? ?? [];
    return savedBusinesses.map((json) => BusinessDTO.fromJson(json)).toList();
  }

  Stream<List<BusinessDTO>> fetchBusinesses() async* {
    yield await getSavedBusinesses();
    try {
      final response = await _businessService.fetchBusinesses();
      yield response.map((json) => BusinessDTO.fromJson(json)).toList();
      await saveBusinesses(response.map((json) => BusinessDTO.fromJson(json)).toList());
    } catch (e) {
      throw Exception('Failed to load businesses');
    }
  }
}