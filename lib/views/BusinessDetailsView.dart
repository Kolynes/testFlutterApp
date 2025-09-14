import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_flutter/viewmodel/viewmodels.dart';
import 'package:test_flutter/models/Business.dart';


class BusinessDetailsView extends StatelessWidget {
  final int index;
  const BusinessDetailsView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final business = context.select<BusinessViewModel, BusinessDTO>((vm) => vm.businesses[index]);
    return Scaffold(
      appBar: AppBar(
        title: Text(business.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(Icons.business, size: 48, color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              business.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 8),
                Text(
                  business.businessLocation,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(
                  business.contactNumber,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
