import 'package:evently_application/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/theme/app_colors.dart';
import 'models/onboarding_model.dart';
import 'widgets/onboarding_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = 'onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);

    Navigator.of(context).pushNamed(LoginScreen.routName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              controller: _controller,
              itemCount: OnboardingModel.onBoardingTabsData.length,
              itemBuilder: (context, index) {
                return OnboardingTabWidget(
                  onboardingModel: OnboardingModel.onBoardingTabsData[index],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage != 0
                    ? TextButton(
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 20,
                        ),
                      ),
                    )
                    : const SizedBox(width: 70),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    OnboardingModel.onBoardingTabsData.length,
                    (index) => buildDot(index: index),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    if (currentPage == OnboardingModel.onBoardingTabsData.length - 1) {
                      completeOnboarding();
                      return;
                    }

                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Text(
                    currentPage != OnboardingModel.onBoardingTabsData.length - 1
                        ? "Next"
                        : 'Finish',
                    style: TextStyle(color: AppColors.mainColor, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: currentPage == index ? 25 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? AppColors.mainColor : Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
