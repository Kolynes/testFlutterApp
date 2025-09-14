

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_flutter/config.dart';

Future<BoxCollection> appCollection(CollectionConfig config) async {
  final safeDirectory = await getApplicationDocumentsDirectory();
  return await BoxCollection.open(
    config.name,
    {'businessBox'},
    path: '${safeDirectory.path}/${config.name}',
  );
}