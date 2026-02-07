import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeOption { light, dark }

class ThemeState {
  final ThemeModeOption themeMode;

  ThemeState(this.themeMode);
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(ThemeState(ThemeModeOption.light)) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'light';
    state = ThemeState(
      themeString == 'dark' ? ThemeModeOption.dark : ThemeModeOption.light,
    );
  }

  Future<void> setTheme(ThemeModeOption themeMode) async {
    state = ThemeState(themeMode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'themeMode', themeMode == ThemeModeOption.dark ? 'dark' : 'light');
  }
}