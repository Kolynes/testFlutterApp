import 'dart:developer';

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
    log('Getting saved businesses from Hive');
    final box = await collection.openBox('businessBox');
    log('Opened Hive box: businessBox');
    final savedBusinesses = (await box.get('businesses')) as List<dynamic>? ?? [];
    log('Retrieved ${savedBusinesses.length} businesses from Hive');
    return List<BusinessDTO>.from(
      savedBusinesses.map((item) => BusinessDTO.fromJson(item)),
    );
  }

  Stream<List<BusinessDTO>> fetchBusinesses() async* {
    yield await getSavedBusinesses();
    try {
      final response = await _businessService.fetchBusinesses();
      log(response.runtimeType.toString());
      final list = List<BusinessDTO>.from(
        (response as List).map((item) => BusinessDTO.fromJson(item)),
      );
      log('Fetched businesses from API: $list');
      yield list;
      await saveBusinesses(list);
    } catch (e, stackTrace) {
      log('Error fetching businesses stream: $e');
      log(stackTrace.toString());
      throw Exception('Failed to load businesses');
    }
  }
}