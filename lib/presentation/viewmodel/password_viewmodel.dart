import 'package:flutter/material.dart';

class PasswordVisibilityProvider extends ChangeNotifier {
  
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void toggleVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
