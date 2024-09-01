import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  bool isDarkModeChecked = false;

  bool get getisDarkModeChecked => isDarkModeChecked;

  void setisDarkModeChecked(bool isDark) {
    isDarkModeChecked = isDark;
    notifyListeners();
  }
}
