import 'package:auto_size_text/auto_size_text.dart';
import 'package:evently_application/screens/onboarding/models/onboarding_model.dart';
import 'package:evently_application/screens/onboarding/widgets/onboarding_header.dart';
import 'package:flutter/material.dart';
import '../../../common/theme/app_colors.dart';

class OnboardingTabWidget extends StatelessWidget {
  const OnboardingTabWidget({super.key, required this.onboardingModel});

  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        spacing: 30,
        children: [
          SafeArea(child: OnboardingHeader()),
          Expanded(
            flex: 5,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onboardingModel.imagePath),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                FittedBox(
                  child: Text(
                    onboardingModel.getLocalizedTitle(context),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
                Expanded(
                  child: AutoSizeText(
                    onboardingModel.getLocalizedBrief(context),
                    minFontSize: 16,
                    style: Theme.of(context).textTheme.titleMedium,
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
