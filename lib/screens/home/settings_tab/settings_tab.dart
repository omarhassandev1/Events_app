import 'package:auto_size_text/auto_size_text.dart';
import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/common/widgets/custom_drop_down_menu.dart';
import 'package:evently_application/provider/settings_provider.dart';
import 'package:evently_application/screens/auth/login_screen.dart';
import 'package:evently_application/screens/home/settings_tab/widgets/settings_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/app_localizations.dart';

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
          label: AppLocalizations.of(context)!.language,
          value: Provider.of<SettingsProvider>(context).localization,
          items: [
            DropdownMenuItem(
              value: 'ar',
              child: Text(
                AppLocalizations.of(context)!.arabic,
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
                AppLocalizations.of(context)!.english,
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              Provider.of<SettingsProvider>(
                context,
                listen: false,
              ).editLocalization(value);
            }
          },
        ),
        CustomDropDownMenu<ThemeMode>(
          label: AppLocalizations.of(context)!.theme,
          value: Provider.of<SettingsProvider>(context).themeMode,
          items: [
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text(
                AppLocalizations.of(context)!.dark,
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text(
                AppLocalizations.of(context)!.light,
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              Provider.of<SettingsProvider>(
                context,
                listen: false,
              ).changeThemeMode(value);
            }
          },
        ),
        Spacer(),
        GestureDetector(
          onTap: (){
            showLogoutDialog(context);
          },

          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.errorColor,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            child: Row(
              spacing: 8,
              children: [
                Icon(Icons.logout, color: AppColors.lightBg),
                Text(
                  AppLocalizations.of(context)!.logout,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: AppColors.lightBg),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              AppLocalizations.of(context)!.logout,
              style: TextStyle(
                color: AppColors.errorColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              AppLocalizations.of(context)!.areYouSureLogout,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  foregroundColor: AppColors.lightBg,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routName);
                },
                child: Text(AppLocalizations.of(context)!.logout),
              ),
            ],
          ),
    );
  }
}
