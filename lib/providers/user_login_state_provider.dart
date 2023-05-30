import 'package:fitness_app/utilities/make_api_request.dart';
import 'package:flutter/material.dart';

class UserLoginStateProvider with ChangeNotifier {
  String _userLoginAuthKey = "";
  Map<String, dynamic>? _userData;

  String get userLoginAuthKey => _userLoginAuthKey;

  Map<String, dynamic>? get user => _userData;

  void setAuthKeyValue(String receivedAuthKey) {
    _userLoginAuthKey = receivedAuthKey;
    notifyListeners();
  }

  void setUserData({required Map<String, dynamic> userData}) {
    _userData = userData;
    notifyListeners();
  }

  void setUserClassInfo({required Map<String, dynamic> classData}) {
    _userData?.addAll(classData);
    notifyListeners();
  }

  void updateFromServer() async {
    print(_userData!['member_id']);

    var result = await sendData(
        urlPath: 'common/sync_page.php', data: {'member_id': _userData!['member_id']});
    if (result != null) {
      print('UPDATE FORM STATE PROVIDER');
      if (result['success']) {
        setUserData(userData: result['userData']);
      }
    }
  }
}
