import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:news_app/themes/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  ThemeMode _themeMode;

  ThemeProvider()
      : _themeData = sunnyCitrusTheme,
        _themeMode = ThemeMode.system {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;
  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeData themeData, ThemeMode themeMode) {
    _themeData = themeData;
    _themeMode = themeMode;
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme') ?? 'sunnyCitrus';
    switch (themeName) {
      case 'oceanBreeze':
        _themeData = oceanBreezeTheme;
        break;
      case 'lavenderDream':
        _themeData = lavenderDreamTheme;
        break;
      case 'forestGreen':
        _themeData = forestGreenTheme;
        break;
      case 'sunnyCitrus':
      default:
        _themeData = sunnyCitrusTheme;
        break;
    }
    notifyListeners();
  }

  void _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String themeName;
    if (_themeData == oceanBreezeTheme) {
      themeName = 'oceanBreeze';
    } else if (_themeData == lavenderDreamTheme) {
      themeName = 'lavenderDream';
    } else if (_themeData == forestGreenTheme) {
      themeName = 'forestGreen';
    } else {
      themeName = 'sunnyCitrus';
    }
    await prefs.setString('theme', themeName);
  }
}