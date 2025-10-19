import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.images.onboarding.header.path,
      height: 50,
    );
  }
}
