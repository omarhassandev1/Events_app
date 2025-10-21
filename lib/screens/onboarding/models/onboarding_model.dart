import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../generated/app_localizations.dart';

class OnboardingModel {
  final String imagePath;
  final int index;
  const OnboardingModel({
    required this.imagePath,
    required this.index
  });

  String getLocalizedTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (index) {
      case 1:
        return l10n.onboardingTitle1;
      case 2:
        return l10n.onboardingTitle2;
      case 3:
        return l10n.onboardingTitle3;

      default:
        return '';
    }
  }
  String getLocalizedBrief(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    switch (index) {
      case 1:
        return l10n.onboardingBrief1;
      case 2:
        return l10n.onboardingBrief2;
      case 3:
        return l10n.onboardingBrief3;

      default:
        return '';
    }
  }

  static List<OnboardingModel> onBoardingTabsData = [
    OnboardingModel(
      imagePath: Assets.images.onboarding.a2.path,
      index: 1
    ),OnboardingModel(
      imagePath: Assets.images.onboarding.a3.path,
      index: 2
    ),OnboardingModel(
      imagePath: Assets.images.onboarding.a4.path,
      index: 3
    ),

  ];
}
