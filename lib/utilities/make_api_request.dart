import 'dart:convert';
import 'dart:io';

import 'package:fitness_app/resources/api_constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getData(
    {required String urlPath, String? authKey}) async {
  String backendServerHost = "${ApiConstants.baseUrl}$urlPath";
  var response;

  try {
    response = await http.get(
      Uri.parse(backendServerHost),
      headers: <String, String>{
        'Content-Type': 'application/json',
        if (authKey != null) 'Authorization': authKey
      },
    );
  } on SocketException {
    return {'internetConnectionError': 'no internet connection'};
  }
  return jsonDecode(response.body);
}

Future<Map<String, dynamic>> sendData(
    {required String urlPath,
    required Map<String, dynamic> data,
    String? authKey}) async {
  String backendServerHost = "${ApiConstants.baseUrl}$urlPath";
  var response;
  try {
    response = await http.post(
      Uri.parse(backendServerHost),
      headers: <String, String>{
        'Content-Type': 'application/json',
        if (authKey != null) 'Authorization': authKey
      },
    );
  } on SocketException {
    return {'internetConnectionError': 'no internet connection'};
  }
  return jsonDecode(response.body);
}

Future<int> checkUrlValidity(String url) async {
  try {
    final response = await http.get(Uri.parse(url));

    return response.statusCode;
  } catch (e) {
    return 404;
  }
}
