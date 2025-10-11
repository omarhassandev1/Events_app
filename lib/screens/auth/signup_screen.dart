import 'package:evently_application/common/widgets/snackbar_helper.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:evently_application/network/auth_service.dart';
import 'package:flutter/material.dart';

import '../../common/theme/app_colors.dart';
import '../../common/widgets/custom_main_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../gen/assets.gen.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text('Register')),

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
                  hintText: 'Name',
                  prefixIcon: Assets.svg.person.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Email',
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
                      return 'email is required';
                    } else if (!emailValid) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  isPassword: true,
                  controller: passwordController,
                  hintText: 'Password',
                  prefixIcon: Assets.svg.lock.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name is required';
                    } else if (value.length < 8) {
                      return 'password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  isPassword: true,
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  prefixIcon: Assets.svg.lock.svg(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).hoverColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is required';
                    } else if (value != passwordController.text) {
                      return 'password doesn\'t match';
                    }
                  },
                ),
                const SizedBox(height: 16),

                !isLoading
                    ? CustomMainButton(
                      text: 'Create Account',
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
                              message: 'Success',
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
                      'Already Have Account ? ',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Login',
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
