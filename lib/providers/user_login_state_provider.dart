import 'package:flutter/material.dart';

class UserLoginStateProvider with ChangeNotifier {
  String _userLoginAuthKey = "";
  Map<String, dynamic>? _userData;
  double _bankBalance = 0;

  String get userLoginAuthKey => _userLoginAuthKey;

  Map<String, dynamic>? get user => _userData;

  String get bankBalance {
    String stringFieldBankBalance = _bankBalance.toStringAsFixed(2);
    if (stringFieldBankBalance.split('.').last == '00') {
      return stringFieldBankBalance.split('.').first;
    } else {
      return stringFieldBankBalance;
    }
  }

  void setAuthKeyValue(String receivedAuthKey) {
    _userLoginAuthKey = receivedAuthKey;
    notifyListeners();
  }

  void setUserData({required Map<String, dynamic> userData}) {
    _userData = userData;
    notifyListeners();
  }
}
