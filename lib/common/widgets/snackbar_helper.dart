import 'package:evently_application/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SnackBarHelper {
  static showSnackBarHelper({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.withValues(alpha: .7),
        content: Row(
          spacing: 8,
          children: [
            Icon(Icons.check_circle_outline_outlined, color: AppColors.lightBg),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }

  static showErrorSnackBarHelper({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.withValues(alpha: .7),
        content: Row(
          spacing: 8,
          children: [
            Icon(Icons.error_outline, color: AppColors.lightBg),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
  }
}
