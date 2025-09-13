import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter/repositories/repositories.dart';

class BusinessViewModel extends ChangeNotifier {
  final BusinessRepository repository;

  BusinessViewModel({required this.repository}) {
    fetchBusinessesCommand = Command.createAsyncNoParam(
      _fetchBusinesses,
      initialValue: null,
    );
  }

  List businesses = [];
  bool loading = false;
  CommandError? error;

  late final Command fetchBusinessesCommand;

  Future<void> _fetchBusinesses() async {
    businesses = await repository.fetchBusinesses();
    notifyListeners();
  }
}