import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/di.dart';

import 'app.dart';

void main() async {
  final appContainer = await container();

  runApp(
    ChangeNotifierProvider(
      create: (context) => appContainer.viewModels.businessViewModel,
      child: const TestApp(),
    ),
  );
}