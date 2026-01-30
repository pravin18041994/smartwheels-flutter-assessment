import 'package:flutter/material.dart';
import 'package:smartwheels_task/core/app_colors.dart';

class TransactionListItem extends StatelessWidget {
  final String title;
  final String time;
  final String category;
  final String type;
  final double amount;

  const TransactionListItem({
    super.key,
    required this.title,
    required this.time,
    required this.category,
    required this.type,
    required this.amount,
  });

  bool get isIncome => type.toLowerCase() == 'income';

  @override
  Widget build(BuildContext context) {
    final icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final iconColor = isIncome ? AppColors.incomeGreen : Colors.red;

    final formattedAmount =
        '${isIncome ? '+' : '-'}${amount.toStringAsFixed(2)}';

    final amountColor = isIncome
        ? AppColors.incomeGreen
        : AppColors.expenseBlue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: AppColors.inputBg,
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            height: 28,
            width: 1,
            color: AppColors.textSecondary.withValues(alpha: 0.25),
          ),

          const SizedBox(width: 8),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Center(
              child: Text(
                category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Container(
            height: 28,
            width: 1,
            color: AppColors.textSecondary.withValues(alpha: 0.25),
          ),

          const SizedBox(width: 8),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  type,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedAmount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: amountColor,
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
