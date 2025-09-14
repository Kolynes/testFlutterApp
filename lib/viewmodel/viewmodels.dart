import 'dart:developer';

import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/models/Business.dart';
import 'package:test_flutter/repositories/repositories.dart';

class BusinessViewModel extends ChangeNotifier {
  final BusinessRepository repository;

  List<BusinessDTO> businesses = [];
  late final Command fetchBusinessesCommand;

  BusinessViewModel({required this.repository}) {
    fetchBusinessesCommand = Command.createAsyncNoParamNoResult(
      _fetchBusinesses,
    );
  }

  Future<void> _fetchBusinesses() async {
    await for (final state in repository.fetchBusinesses()) {
      log('Fetched businesses: $state');
      businesses = state;
      notifyListeners();
    }
  }
}
