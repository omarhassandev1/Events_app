import 'package:evently_application/generated/app_localizations.dart';
import 'package:evently_application/provider/events_provider.dart';
import 'package:evently_application/provider/settings_provider.dart';
import 'package:evently_application/provider/user_provider.dart';
import 'package:evently_application/screens/auth/login_screen.dart';
import 'package:evently_application/screens/home/main_layer_screen.dart';
import 'package:evently_application/screens/onboarding/get_started_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/routes/app_routes.dart';
import 'common/theme/app_themes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MyApp(seenOnboarding: seenOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;
  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final isLoggedIn = FirebaseAuth.instance.currentUser?.uid != null;

    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.dartTheme,
      themeMode: settingsProvider.themeMode,
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn
          ? MainLayerScreen.routName
          : (seenOnboarding
          ? LoginScreen.routName
          : GetStartedScreen.routeName),

      routes: AppRoutes.routes,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(Provider.of<SettingsProvider>(context).localization),
    );
  }
}
