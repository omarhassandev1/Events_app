import 'package:evently_application/common/routes/app_routes.dart';
import 'package:evently_application/provider/events_provider.dart';
import 'package:evently_application/screens/home/main_layer_screen.dart';
import 'package:evently_application/screens/onboarding/get_started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/theme/app_themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding =
      prefs.getBool('seenOnboarding') ??
      false; // to skip onboarding if NOT the 1st time

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.dartTheme,
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,

        initialRoute:
            FirebaseAuth.instance.currentUser?.uid == null
                ? seenOnboarding
                    ? MainLayerScreen.routName
                    : GetStartedScreen.routeName
                : MainLayerScreen.routName,
        routes: AppRoutes.routes
      ),
    ),
  );
}
