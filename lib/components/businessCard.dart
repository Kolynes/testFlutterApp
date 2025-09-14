import 'package:flutter/material.dart';

import 'package:test_flutter/models/Business.dart';
import 'package:test_flutter/models/Service.dart';


/// A generic card that can render either a BusinessDTO or ServiceDTO.
class BusinessCard<T> extends StatelessWidget {
  final T data;
  final VoidCallback? onTap;

  const BusinessCard({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Determine type and fields
    final String title;
    final String? subtitle;
    final String? trailing;
    final IconData leadingIcon;

    if (data is BusinessDTO) {
      final businessData = data as BusinessDTO;
      title = businessData.name;
      subtitle = businessData.businessLocation;
      trailing = businessData.contactNumber;
      leadingIcon = Icons.business;
    } else if (data is ServiceDTO) {
      final serviceData = data as ServiceDTO;
      title = serviceData.name;
      subtitle = serviceData.businessName;
      trailing = null;
      leadingIcon = Icons.miscellaneous_services;
    } else {
      title = 'Unknown';
      subtitle = null;
      trailing = null;
      leadingIcon = Icons.help_outline;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.12),
            theme.colorScheme.secondary.withOpacity(0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withOpacity(0.18),
                        theme.colorScheme.primary.withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    child: Icon(leadingIcon, size: 34, color: theme.colorScheme.primary),
                  ),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              data is BusinessDTO ? Icons.location_on : Icons.business,
                              size: 18,
                              color: theme.colorScheme.secondary,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                subtitle,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.secondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (trailing != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                trailing,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[700],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 18, color: theme.colorScheme.primary.withOpacity(0.7)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
