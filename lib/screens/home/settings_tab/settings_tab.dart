import 'package:auto_size_text/auto_size_text.dart';
import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_drop_down_menu.dart';
import 'package:evently_application/screens/home/settings_tab/widgets/settings_header.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeader(),
        CustomDropDownMenu<String>(
          label: 'Languages',
          items: [
            DropdownMenuItem(
              value: 'ar',
              child: Text(
                'Arabic',
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'en',
              child: Text(
                'English',
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (value) {},
        ),
        CustomDropDownMenu<String>(
          label: 'Theme',
          items: [
            DropdownMenuItem(
              value: 'Dark',
              child: Text(
                'Dark',
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'Light',
              child: Text(
                'Light',
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (value) {},
        ),
      ],
    );
  }
}

//         DropdownButtonFormField(
//             items: [
//               DropdownMenuItem(value: 'ar',child: Text('Arabic'),),
//               DropdownMenuItem(value: 'en',child: Text('English'),),
//             ]
//             , onChanged: (value){})
