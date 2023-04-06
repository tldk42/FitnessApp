import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DeviceInfoStorage {
  String _deviceOS = Platform.operatingSystem;
  String _deviceOSVersion = Platform.operatingSystemVersion;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _userDeviceInfoFile async {
    final path = await _localPath;

    return File('$path/device_info_storage.json');
  }

  Future<bool> initializeInstallationStatus() async {
    DateTime dateOfFirstUse = DateTime.now();

    try {
      final file = await _userDeviceInfoFile;

      return file
          .writeAsString(jsonEncode({
            'deviceOS': _deviceOS,
            'deviceOSVersion': _deviceOSVersion,
            'dateOfFirstUse': dateOfFirstUse.toString()
          }))
          .then((value) => true);
    } catch (e) {
      return false;
    }
  }

  Future<bool> get wasUsedBefore async {
    try {
      final file = await _userDeviceInfoFile;
      final contents = await file.readAsString();
      Map<String, dynamic> data = jsonDecode(contents);
      if (data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteFile() async {
    try {
      final file = await _userDeviceInfoFile;

      await file.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
