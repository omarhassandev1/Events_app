import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({super.key, required this.child, this.onPressed});

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(16),
              side: BorderSide(color: AppColors.mainColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
              )
            ),
            onPressed: onPressed,
            child: child,
          ),
        ),
      ],
    );
  }
}
