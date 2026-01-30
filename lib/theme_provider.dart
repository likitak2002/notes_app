// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool getValue() => _isDarkMode;

  void updateTheme({required bool value}) {
    _isDarkMode = value;
    notifyListeners();
  }
}
