import 'package:hive/hive.dart';
import 'package:test_flutter/config.dart';

Future<BoxCollection> appCollection(CollectionConfig config) async {
  return await BoxCollection.open(
    config.name,
    {'businessBox'},
    path: config.path,
  );
}