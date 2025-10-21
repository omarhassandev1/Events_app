import 'package:evently_application/common/widgets/snackbar_helper.dart';
import 'package:evently_application/generated/app_localizations.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:evently_application/network/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/theme/app_colors.dart';
import '../../common/widgets/custom_main_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../gen/assets.gen.dart';
import '../../provider/settings_provider.dart';
import '../onboarding/widgets/switch_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const routName = '/signupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<SettingsProvider>(context);
    bool isArabic = settings.localization == 'ar';
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.register)),

      body: Form(
        key: _formKey,
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
                  controller: nameController,
                  hintText: AppLocalizations.of(context)!.name,
                  prefixIcon: Assets.svg.person.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.nameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Assets.svg.email.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  validator: (value) {
                    final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                    ).hasMatch(value ?? "");
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.emailRequired;
                    } else if (!emailValid) {
                      return AppLocalizations.of(context)!.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  isPassword: true,
                  controller: passwordController,
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Assets.svg.lock.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.passwordRequired;
                    } else if (value.length < 8) {
                      return AppLocalizations.of(context)!.passwordMinLength;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  isPassword: true,
                  controller: confirmPasswordController,
                  hintText: AppLocalizations.of(context)!.confirmPassword,
                  prefixIcon: Assets.svg.lock.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.passwordRequired;
                    } else if (value != passwordController.text) {
                      return AppLocalizations.of(context)!.passwordMismatch;
                    }
                  },
                ),
                const SizedBox(height: 16),

                !isLoading
                    ? CustomMainButton(
                      text: AppLocalizations.of(context)!.createAccount,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await AuthService.register(
                              UserModel(
                                email: emailController.text,
                                name: nameController.text,
                              ),
                              passwordController.text,
                            );
                            SnackBarHelper.showSnackBarHelper(
                              context: context,
                              message: AppLocalizations.of(context)!.loginSuccess,
                            );
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.of(context).pop();
                          } catch (e) {
                            SnackBarHelper.showErrorSnackBarHelper(
                              context: context,
                              message: e.toString(),
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      },
                    )
                    : CircularProgressIndicator(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.alreadyHaveAccount,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
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
          ),
        ),
      ),
    );
  }
}
