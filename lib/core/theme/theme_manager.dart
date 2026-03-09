import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum AppTheme {
  purple,
  blue,
  green,
  orange,
  pink,
  red,
}

class ThemeManager extends ChangeNotifier {
  static const String _themeBoxName = 'themeBox';
  static const String _themeKey = 'selectedTheme';
  
  AppTheme _currentTheme = AppTheme.purple;
  
  AppTheme get currentTheme => _currentTheme;
  
  ThemeManager() {
    _loadTheme();
  }
  
  Future<void> _loadTheme() async {
    final box = await Hive.openBox(_themeBoxName);
    final themeName = box.get(_themeKey, defaultValue: 'purple');
    _currentTheme = AppTheme.values.firstWhere(
      (theme) => theme.name == themeName,
      orElse: () => AppTheme.purple,
    );
    notifyListeners();
  }
  
  Future<void> setTheme(AppTheme theme) async {
    _currentTheme = theme;
    final box = await Hive.openBox(_themeBoxName);
    await box.put(_themeKey, theme.name);
    notifyListeners();
  }
  
  // Get theme colors
  ThemeColors getThemeColors() {
    switch (_currentTheme) {
      case AppTheme.purple:
        return ThemeColors(
          primary: Colors.purple.shade300,
          secondary: Colors.deepPurple.shade700,
          accent: Colors.purpleAccent,
          gradientStart: Colors.purple.withOpacity(0.6),
          gradientEnd: Colors.deepPurple.withOpacity(0.8),
        );
      case AppTheme.blue:
        return ThemeColors(
          primary: Colors.blue.shade300,
          secondary: Colors.indigo.shade700,
          accent: Colors.blueAccent,
          gradientStart: Colors.blue.withOpacity(0.6),
          gradientEnd: Colors.indigo.withOpacity(0.8),
        );
      case AppTheme.green:
        return ThemeColors(
          primary: Colors.green.shade300,
          secondary: Colors.teal.shade700,
          accent: Colors.greenAccent,
          gradientStart: Colors.green.withOpacity(0.6),
          gradientEnd: Colors.teal.withOpacity(0.8),
        );
      case AppTheme.orange:
        return ThemeColors(
          primary: Colors.orange.shade300,
          secondary: Colors.deepOrange.shade700,
          accent: Colors.orangeAccent,
          gradientStart: Colors.orange.withOpacity(0.6),
          gradientEnd: Colors.deepOrange.withOpacity(0.8),
        );
      case AppTheme.pink:
        return ThemeColors(
          primary: Colors.pink.shade300,
          secondary: Colors.pinkAccent.shade700,
          accent: Colors.pinkAccent,
          gradientStart: Colors.pink.withOpacity(0.6),
          gradientEnd: Colors.pinkAccent.withOpacity(0.8),
        );
      case AppTheme.red:
        return ThemeColors(
          primary: Colors.red.shade300,
          secondary: Colors.redAccent.shade700,
          accent: Colors.redAccent,
          gradientStart: Colors.red.withOpacity(0.6),
          gradientEnd: Colors.redAccent.withOpacity(0.8),
        );
    }
  }
  
  String getThemeName() {
    switch (_currentTheme) {
      case AppTheme.purple:
        return 'Purple Dream';
      case AppTheme.blue:
        return 'Ocean Blue';
      case AppTheme.green:
        return 'Nature Green';
      case AppTheme.orange:
        return 'Sunset Orange';
      case AppTheme.pink:
        return 'Pink Blossom';
      case AppTheme.red:
        return 'Ruby Red';
    }
  }
}

class ThemeColors {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color gradientStart;
  final Color gradientEnd;
  
  ThemeColors({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.gradientStart,
    required this.gradientEnd,
  });
}

// Global theme manager instance
final themeManager = ThemeManager();


