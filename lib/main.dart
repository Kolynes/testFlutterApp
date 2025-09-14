import 'dart:developer';

import 'package:command_it/command_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/di.dart';

import 'app.dart';

void main() async {
  Command.reportAllExceptions = true;
  Command.globalExceptionHandler = (ex, stack) {
  };

  final appContainer = await container();
  
  appContainer.interceptors.retryInterceptor.retryOnException(
    DioExceptionType.connectionError,
    (dio, code, err) async {
      log('Retrying after connection error...');
    },
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => appContainer.viewModels.businessViewModel,
      child: const TestApp(),
    ),
  );
}