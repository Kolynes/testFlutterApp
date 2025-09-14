import 'package:test_flutter/router.dart';
import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter/models/Business.dart';
import 'package:test_flutter/viewmodel/viewmodels.dart';
import 'package:test_flutter/components/businessCard.dart';

class BusinessListView extends StatefulWidget {
  final BusinessViewModel businessViewModel;
  const BusinessListView(this.businessViewModel, {super.key});

  @override
  State<BusinessListView> createState() => _BusinessListViewState();
}


class _BusinessListViewState extends State<BusinessListView> {
  CommandError? _lastError;

  @override
  void initState() {
    super.initState();
    widget.businessViewModel.fetchBusinessesCommand.errors.addListener(_onErrorChanged);
  }

  @override
  void dispose() {
    widget.businessViewModel.fetchBusinessesCommand.errors.removeListener(_onErrorChanged);
    super.dispose();
  }

  void _onErrorChanged() {
    final error = widget.businessViewModel.fetchBusinessesCommand.errors.value;
    if (error != null && error != _lastError) {
      _lastError = error;
  final message = error.error.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.redAccent,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => widget.businessViewModel.fetchBusinessesCommand.execute(),
            ),
          ),
        );
      }
    }
  }
  String _searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.businessViewModel.fetchBusinessesCommand.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search businesses...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.trim();
                });
              },
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: widget.businessViewModel.fetchBusinessesCommand.isExecuting,
        builder: (context, isExecuting, _) {
          return Selector<BusinessViewModel, List<BusinessDTO>>(
            selector: (context, vm) => vm.businesses,
            builder: (context, businesses, child) {
              final filtered = _searchQuery.isEmpty
                  ? businesses
                  : businesses.where((b) => b.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
              if (filtered.isEmpty && !isExecuting) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.business, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No businesses found',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: filtered.length + (isExecuting ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isExecuting && index == 0) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final businessIndex = isExecuting ? index - 1 : index;
                  return BusinessCard(
                    data: filtered[businessIndex],
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/businessDetails',
                        arguments: BusinessDetailsArgs(index: businessIndex),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}