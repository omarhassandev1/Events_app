import 'package:evently_application/screens/auth/forget_password.dart';
import 'package:evently_application/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';

import '../../common/theme/app_colors.dart';
import '../../common/widgets/custom_main_button.dart';
import '../../common/widgets/custom_outlined_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../gen/assets.gen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routName = '/loginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.images.appIcon.path,
                  height: 140,
                  width: 140,
                ),
                Text(
                  'Evently',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                  ),
                ),
                SizedBox(height: 24),
                CustomTextField(
                  hintText: 'Email',
                  prefixIcon: Assets.svg.email.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'password',
                  prefixIcon: Assets.svg.lock.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(ForgetPassword.routName);
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                CustomMainButton(
                  text: 'Login',
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupScreen.routName);
                  },
                ),
                const SizedBox(height: 24),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'Don’t Have Account ?  '),
                      TextSpan(
                        text: 'Create Account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.mainColor,
                        ),
                      ),
                    ],
                  ),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Text(
                      'Or',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 24),
                CustomOutlinedButton(
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.svg.google.svg(),
                      Text(
                        'Login With Google',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeThumbImage: AssetImage(Assets.images.us.path),
                  inactiveThumbImage: AssetImage(Assets.images.eg.path),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
