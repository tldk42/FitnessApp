import 'package:flutter/material.dart';

class UserLoginStateProvider with ChangeNotifier {
  String _userLoginAuthKey = "";

  double _bankBalance = 0;

  String get userLoginAuthKey => _userLoginAuthKey;

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


}
