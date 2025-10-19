import 'package:evently_application/common/theme/app_colors.dart';
import 'package:evently_application/screens/onboarding/onboarding_screen.dart';
import 'package:evently_application/screens/onboarding/widgets/onboarding_header.dart';
import 'package:evently_application/screens/onboarding/widgets/switch_widget.dart';
import 'package:flutter/material.dart';

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
                          'Personalize Your Experience',
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.',
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
                              'Language',
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: AppColors.mainColor),
                            ),
                            Spacer(),
                            SwitchButton(activeIcon: Assets.images.eg.image(),inActiveIcon: Assets.images.us.image()),

                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Theme',
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(color: AppColors.mainColor),
                            ),
                            Spacer(),
                            SwitchButton(activeIcon: Assets.svg.onboarding.moon.svg(),inActiveIcon: Assets.svg.onboarding.sun.svg(),),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(OnboardingScreen.routeName);
                        },
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Let\'s Start',
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
