import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = false;
  Timer? _timer;
  
  static const String _themeModeKey = 'theme_mode';

  ThemeProvider() {
    _loadThemeMode();
    _setupTimer();
  }

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeModeKey);
    
    if (themeModeString == 'ThemeMode.light') {
      _themeMode = ThemeMode.light;
      _isDarkMode = false;
    } else if (themeModeString == 'ThemeMode.dark') {
      _themeMode = ThemeMode.dark;
      _isDarkMode = true;
    } else {
      _themeMode = ThemeMode.system;
      _updateAutoTheme();
    }
    
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString());
    
    if (mode == ThemeMode.system) {
      _updateAutoTheme();
    } else {
      _isDarkMode = mode == ThemeMode.dark;
    }
    
    notifyListeners();
  }

  void _setupTimer() {
    // Check every minute if we need to update the theme in auto mode
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (_themeMode == ThemeMode.system) {
        _updateAutoTheme();
      }
    });
  }

  void _updateAutoTheme() {
    final hour = DateTime.now().hour;
    // Dark mode between 6 PM and 6 AM
    final newIsDarkMode = hour < 6 || hour >= 18;
    
    if (_isDarkMode != newIsDarkMode) {
      _isDarkMode = newIsDarkMode;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
} 