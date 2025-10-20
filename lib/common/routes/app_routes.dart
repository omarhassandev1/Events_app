import 'package:flutter/material.dart';
import 'package:evently_application/screens/auth/forget_password.dart';
import 'package:evently_application/screens/events/new_event/new_event_screen.dart';
import 'package:evently_application/screens/onboarding/onboarding_screen.dart';
import '../../screens/home/main_layer_screen.dart';
import '../../screens/onboarding/get_started_screen.dart';
import '/screens/auth/login_screen.dart';
import '/screens/auth/signup_screen.dart';
class AppRoutes{
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routName: (context) => LoginScreen(),
    SignupScreen.routName: (context) => SignupScreen(),
    ForgetPassword.routName: (context) => ForgetPassword(),
    MainLayerScreen.routName: (context) => MainLayerScreen(),
    NewEventScreen.routeName: (context) => NewEventScreen(),
    OnboardingScreen.routeName: (context) => OnboardingScreen(),
    GetStartedScreen.routeName: (context) => GetStartedScreen(),
  };
}