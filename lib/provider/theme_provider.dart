import 'package:flutter/material.dart';

import '../storge/pref_controller.dart';

class ThemeProvider extends ChangeNotifier {
  Color kWhite = Colors.white;
  Color kBlack = Colors.black;
  Color kPrimary = Colors.teal;

  late ThemeData _theme;

  ThemeProvider({required bool isDarkMode}) {
    _theme = isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  ThemeData get theme => _theme;

  void changeTheme() {
    final isDark = _theme == ThemeData.dark();
    if (isDark) {
      _theme = ThemeData.light();
      print('light theme ${_theme.toString()}');
      kWhite = Colors.white;
      kBlack = Colors.black;
      CacheHelper.sharedPreferences!.setBool('isDarkMode', true);
      notifyListeners();
    } else {
      _theme = ThemeData.dark();
      kWhite = Colors.black;
      kBlack = Colors.white;
      print('dark theme ${_theme.toString()}');
      CacheHelper.sharedPreferences!.setBool('isDarkMode', false);
      notifyListeners();
    }
    print(kWhite);
    print(kBlack);
    notifyListeners();
  }
}
