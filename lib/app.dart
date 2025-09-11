import 'package:flutter/material.dart';
import 'package:test_flutter/router.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      initialRoute: '/',
    );
  }
}