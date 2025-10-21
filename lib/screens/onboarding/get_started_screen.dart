import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/generated/app_localizations.dart';
import 'package:evently_application/provider/settings_provider.dart';
import 'package:evently_application/screens/onboarding/onboarding_screen.dart';
import 'package:evently_application/screens/onboarding/widgets/onboarding_header.dart';
import 'package:evently_application/screens/onboarding/widgets/switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../gen/assets.gen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  static const String routeName = '/getStarted';

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    bool isArabic = settings.localization == 'ar';
    bool isDark = settings.themeMode == ThemeMode.dark;


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              OnboardingHeader(),
              Expanded(child: Assets.images.onboarding.a1.image()),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 32,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.personalizeTitle,
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.personalizeSubtitle,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 16,
                      children: [
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.language,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: AppColors.mainColor),
                            ),
                            Spacer(),
                            SwitchButton(
                              activeIcon: Assets.images.eg.image(),
                              inActiveIcon: Assets.images.us.image(),
                              value: isArabic,
                              onToggle: (value) {
                                Provider.of<SettingsProvider>(
                                  context,
                                  listen: false
                                ).editLocalization(value ? 'ar' : 'en');
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.theme,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: AppColors.mainColor),
                            ),
                            Spacer(),
                            SwitchButton(
                              activeIcon: Assets.svg.onboarding.moon.svg(),
                              inActiveIcon: Assets.svg.onboarding.sun.svg(),
                              value: isDark,
                              onToggle: (value) {
                                Provider.of<SettingsProvider>(
                                  context,
                                  listen: false
                                ).changeThemeMode(
                                  value ? ThemeMode.dark : ThemeMode.light,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(OnboardingScreen.routeName);
                        },
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.letsStart,
                          style: TextStyle(
                            color: AppColors.lightBg,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
