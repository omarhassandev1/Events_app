import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String localization = 'en';

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTheme = prefs.getString('themeMode') ?? 'light';
    if (savedTheme == 'dark') {
      themeMode = ThemeMode.dark;
    } else if (savedTheme == 'system') {
      themeMode = ThemeMode.system;
    } else {
      themeMode = ThemeMode.light;
    }

    localization = prefs.getString('localization') ?? 'en';

    notifyListeners();
  }

  Future<void> changeThemeMode(ThemeMode newThemeMode) async {
    themeMode = newThemeMode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', newThemeMode.name);
  }

  Future<void> editLocalization(String local) async {
    localization = local;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('localization', local);
  }
}
