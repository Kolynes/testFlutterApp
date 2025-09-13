import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/di.dart';

import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => viewModels().businessViewModel,
      child: const TestApp()),
    );
}