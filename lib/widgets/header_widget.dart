import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class HeaderWidget extends StatelessWidget {
  final String userName;
  final bool isSyncActive;

  const HeaderWidget({
    super.key,
    required this.userName,
    this.isSyncActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.darkGrey.withOpacity(0.6),
            AppColors.mediumGrey.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.electricCyan.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Greeting Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey, $userName 👋',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ready to scan & go?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          // Sync-Cart Status Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSyncActive
                  ? AppColors.neonLime.withOpacity(0.15)
                  : AppColors.error.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSyncActive ? AppColors.neonLime : AppColors.error,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSyncActive ? Icons.sync : Icons.sync_disabled,
                  color: isSyncActive ? AppColors.neonLime : AppColors.error,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isSyncActive ? 'Synced' : 'Offline',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: isSyncActive ? AppColors.neonLime : AppColors.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
