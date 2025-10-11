import 'package:evently_application/screens/auth/forget_password.dart';
import 'package:evently_application/screens/home/main_layer_screen.dart';
import 'package:evently_application/screens/new_event/new_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/screens/auth/login_screen.dart';
import '/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'common/theme/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.dartTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      initialRoute:
          FirebaseAuth.instance.currentUser?.uid == null
              ? LoginScreen.routName
              : MainLayerScreen.routName,
      routes: {
        LoginScreen.routName: (context) => LoginScreen(),
        SignupScreen.routName: (context) => SignupScreen(),
        ForgetPassword.routName: (context) => ForgetPassword(),
        MainLayerScreen.routName: (context) => MainLayerScreen(),
        NewEventScreen.routeName: (context) => NewEventScreen(),
      },
    ),
  );
}
