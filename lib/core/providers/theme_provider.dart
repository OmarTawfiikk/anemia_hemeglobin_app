import 'package:flutter/material.dart';
import 'package:anemia_hemeglobin_app/core/shared/local/cache_helper.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isLoading = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLoading => _isLoading;

  Future<void> loadThemePref() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isDark = await CacheHelper.getData(key: 'isDarkMode') ?? false;
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    } catch (e) {
      _themeMode = ThemeMode.system;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isOn) async {
    _isLoading = true;
    notifyListeners();

    try {
      _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
      await CacheHelper.setData(key: 'isDarkMode', value: isOn);
    } catch (e) {
      // Handle error if needed
    }

    _isLoading = false;
    notifyListeners();
  }
}
