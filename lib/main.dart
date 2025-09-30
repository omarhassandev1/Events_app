import 'package:evently_application/screens/auth/forget_password.dart';

import '/screens/auth/login_screen.dart';
import '/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';

import 'common/theme/app_themes.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.lightTheme,
    debugShowCheckedModeBanner: false,

    initialRoute: LoginScreen.routName,
    routes: {
      LoginScreen.routName : (context) => LoginScreen(),
      SignupScreen.routName : (context) => SignupScreen(),
      ForgetPassword.routName : (context) => ForgetPassword(),
    },
  ));
}
