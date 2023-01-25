import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  String _token = '';
  int _userID = 0;

  int get userID => _userID;
  String get token => _token;

  void setToken(String token) {
    this._token = token;
    notifyListeners();
  }

  void setUserID(int ID) {
    this._userID = ID;
    notifyListeners();
  }
}
