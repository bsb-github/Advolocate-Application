import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_string_generator/random_string_generator.dart';

class OtpProvider extends ChangeNotifier {
  String _OTP = "";
  bool _verified = false;

  String get OTP => _OTP;
  bool get verified => _verified;

  void setOTP(String code) {
    _OTP = OTP;
    notifyListeners();
  }

  void setVerified(bool isVerified) {
    _verified = isVerified;
    notifyListeners();
  }
}
