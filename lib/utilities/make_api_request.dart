import 'dart:convert';
import 'dart:io';

import 'package:fitness_app/resources/api_constants.dart';
import 'package:http/http.dart' as http;

Future getData({required String urlPath, String? authKey}) async {
  String backendServerHost = "${ApiConstants.baseUrl}$urlPath";
  http.Response response;

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
  final List<dynamic> data = jsonDecode(response.body);
  return data.map((e) => e as Map<String, dynamic>).toList();
}

Future sendData(
    {required String urlPath,
    Map<String, dynamic>? data,
    String? authKey}) async {
  String backendServerHost = "${ApiConstants.baseUrl}$urlPath";
  http.Response response;
  try {
    response = await http.post(Uri.parse(backendServerHost), body: data);

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
