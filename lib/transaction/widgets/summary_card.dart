import 'package:flutter/material.dart';
import 'package:smartwheels_task/core/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color? backgroundColor;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final double? width;

  const SummaryCard({
    super.key,
    required this.title,
    required this.amount,
    this.backgroundColor,
    this.icon,
    this.iconColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (width ?? 0.9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor ?? AppColors.card,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          if (icon != null)
            Icon(icon, size: 26, color: iconColor ?? AppColors.primary),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$title\n',
                  style: TextStyle(
                    color: textColor ?? AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: amount,
                  style: TextStyle(
                    color: textColor ?? AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
