import 'dart:convert';

import 'package:http/http.dart' as http;

import 'baseservice.dart';

class AuthService extends BaseApiService {
  Future<Map<String, dynamic>> loginapi(userName, password) async {
    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse(
          "https://bdohur9vha.execute-api.ap-south-1.amazonaws.com/v1/auth"),
      headers: headers,
      body: json.encode(
        {
          "request_type": "authenticate",
          "payload": {
            "scope": "wms",
            "username": userName,
            "password": password
          }
        }
      ),
    );
    print("responsedata$response");
    Map<String, dynamic> responsedata = jsonDecode(response.body);
    return responsedata;
  }

  Future<List<String>?> tokenReferesh(userId, token) async {
    var headers = {
      'Content-Type': 'application/json'};
    final body = {
      "request_type": "renew_token",
      "payload": {
        "username": userId,
        "scope": "wms",
        "refresh_token": token
      }
    };
    final response = await http.post(
        Uri.parse(
            "https://bdohur9vha.execute-api.ap-south-1.amazonaws.com/v1/auth"),
        headers: headers,
        body: jsonEncode(body));
    Map<String, dynamic> apiResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (apiResponse["code"] != 200) {
        return null;
      } else {
        return [apiResponse["id_token"]];
      }
    }
    return null;
  }
}
