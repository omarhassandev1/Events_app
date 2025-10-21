import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    required this.onChanged,
    this.label, this.value,
  });

  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? label;
  final T? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          DropdownButtonFormField<T>(
            icon: Icon(Icons.arrow_drop_down, color: AppColors.mainColor),
            decoration: InputDecoration(
              border: _getBorder(),
              focusedBorder: _getBorder(),
              enabledBorder: _getBorder(),
            ),
            items: items,
            onChanged: onChanged,
            value: value,
          ),
        ],
      ),
    );
  }

  _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.mainColor),
    );
  }
}
