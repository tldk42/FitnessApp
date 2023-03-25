import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class LoginInfoStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _userLoginDataFile async {
    final path = await _localPath;
    log(path);
    return File('$path/');
  }

  Future<bool> setPersistentLoginData(String userId, String authToken) async {
    try {
      final file = await _userLoginDataFile;
      //* THE USER_ID AND AUTHENTICATION_TOKEN HAS BEEN SAVED
      return file
          .writeAsString(jsonEncode({'userId': userId, 'authToken': authToken}))
          .then((value) {
        //* THE USER_ID HAS BEEN SAVED
        return true;
      });
    } catch (e) {
      //* THE USER_ID AND AUTHENTICATION_TOKEN COULD NOT BE SAVED
      return false;
    }
  }


}