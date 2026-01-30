import 'package:flutter/material.dart';
import 'package:smartwheels_task/core/app_colors.dart';

class AppDropdownWidget extends StatelessWidget {
  final String label;
  final String? value; // ✅ nullable
  final String? hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const AppDropdownWidget({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.inputBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: hint != null ? Text(hint!) : null,
              isExpanded: true,
              items: items
                  .map(
                    (e) => DropdownMenuItem<String>(value: e, child: Text(e)),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
