import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class BudgetBarWidget extends StatelessWidget {
  final double currentSpending;
  final double budgetLimit;

  const BudgetBarWidget({
    super.key,
    required this.currentSpending,
    required this.budgetLimit,
  });

  double get percentage => (currentSpending / budgetLimit).clamp(0.0, 1.0);

  Color get barColor {
    if (percentage < 0.7) {
      return AppColors.budgetOk; // Neon Lime - OK
    } else if (percentage < 0.9) {
      return AppColors.budgetWarning; // Yellow - Warning
    } else {
      return AppColors.budgetOver; // Red - Over budget
    }
  }

  String get statusText {
    if (percentage < 0.7) {
      return 'Budget OK ✓';
    } else if (percentage < 0.9) {
      return 'Nearing Limit ⚠';
    } else {
      return 'Over Budget!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.mediumGrey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Smart Budgeter',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: barColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: barColor, width: 1),
                ),
                child: Text(
                  statusText,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: barColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Amount Display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${currentSpending.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: barColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'of ₹${budgetLimit.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                // Background
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.mediumGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                // Animated Progress
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: 12,
                  width: MediaQuery.of(context).size.width * percentage * 0.85,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [barColor, barColor.withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: barColor.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Percentage Text
          Text(
            '${(percentage * 100).toStringAsFixed(1)}% of budget used',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
