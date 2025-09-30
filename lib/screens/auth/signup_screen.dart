import 'package:flutter/material.dart';

import '../../common/theme/app_colors.dart';
import '../../common/widgets/custom_main_button.dart';
import '../../common/widgets/custom_outlined_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../gen/assets.gen.dart';
import 'login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const routName = '/signupScreen';

  @override
  Widget build(BuildContext context) {

    //
    return Scaffold(

      appBar: AppBar(
        title: Text('Register'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(Assets.images.appIcon.path, height: 140, width: 140),
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
                hintText: 'Name',
                prefixIcon: Assets.svg.email.svg(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).hoverColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                hintText: 'Password',
                prefixIcon: Assets.svg.lock.svg(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).hoverColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 16),              CustomTextField(
                hintText: 'Re Password',
                prefixIcon: Assets.svg.lock.svg(
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).hoverColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              CustomMainButton(text: 'Create Account', onPressed: () {}),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Already Have Account ? '),
                    TextSpan(
                      text: 'Login',
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
    );
  }
}
