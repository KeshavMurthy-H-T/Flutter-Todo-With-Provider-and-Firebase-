import 'package:flutter/cupertino.dart';

class LoginController extends ChangeNotifier {
  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool value) {
    _passwordVisible = value;
    notifyListeners();
  }
}
