import 'package:evently_application/common/widgets/snackbar_helper.dart';
import 'package:evently_application/models/user_model.dart';
import 'package:evently_application/network/auth_service.dart';
import 'package:evently_application/screens/auth/forget_password.dart';
import 'package:evently_application/screens/auth/signup_screen.dart';
import 'package:evently_application/screens/home/main_layer_screen.dart';
import 'package:flutter/material.dart';

import '../../common/theme/app_colors.dart';
import '../../common/widgets/custom_main_button.dart';
import '../../common/widgets/custom_outlined_button.dart';
import '../../common/widgets/custom_text_field.dart';
import '../../gen/assets.gen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routName = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                    hintText: 'password',
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

                  !isLoading
                      ? CustomMainButton(
                        text: 'Login',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              setState(() {
                                isLoading = true;
                              });
                              UserModel? user = await AuthService.login(
                                emailController.text,
                                passwordController.text,
                              );
                              if(user==null){
                                throw 'Invalid user';
                              }
                              Navigator.of(context).pushReplacementNamed(MainLayerScreen.routName);
                              SnackBarHelper.showSnackBarHelper(
                                context: context,
                                message: 'Success',
                              );
                              setState(() {
                                isLoading = false;
                              });
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
                        'Don’t Have Account?  ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(SignupScreen.routName);
                        },
                        child: Text(
                          'Create Account',
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
      ),
    );
  }
}
