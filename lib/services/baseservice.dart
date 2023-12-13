import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant.dart';

class BaseApiService {
    final String baseUrl = '${ConstData.baseUrl}';

  var client = http.Client();

  Future<Map<String, dynamic>> sendRequest(
    String path, {
    String method = 'GET',
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final url =
        Uri.parse('$baseUrl$path').replace(queryParameters: queryParameters);
    final headers = {
      'Authorization': token,
      'Content-Type': 'application/json',
      // 'node_id': franchiseHubId,
    };
    if (method == 'GET') {
      {
        final response = await http.get(url, headers: headers);
        if (response.statusCode < 200) {
          final responseBody = response.body;
          // serviceLocator<SlackLogger>().sendSlackMessage(
          //     'PhoneNo: $franchisephone \nFailed to send request: ${response.request}\nResponseBody: $responseBody\nStatusCode: ${response.statusCode}');
          throw HttpException(
              '$path failed: ${response.statusCode}\n$responseBody');
        }

        final responseBody = response.body;
        final parsed = json.decode(responseBody) as Map<String, dynamic>;

        return parsed;
      }
    } else if (method == 'POST') {
      {
        final response = await http.post(url,
            headers: headers, body: json.encode(body ?? {}));
        if (response.statusCode < 200) {
          final responseBody = response.body;
          // serviceLocator<SlackLogger>().sendSlackMessage(
          //     'PhoneNo: $franchisephone \nFailed to send request: ${response.request}\nResponseBody: $responseBody\nStatusCode: ${response.statusCode}\n RequestBody: ${body.toString()}');
          throw HttpException(
              '$path failed: ${response.statusCode}\n$responseBody');
        }

        final responseBody = response.body;
        final parsed = json.decode(responseBody) as Map<String, dynamic>;

        return parsed;
      }
    } else if (method == 'PUT') {
      {
        final response = await http.put(url,
            headers: headers, body: json.encode(body ?? {}));
        if (response.statusCode < 200) {
          final responseBody = response.body;
          // serviceLocator<SlackLogger>().sendSlackMessage(
          //     'PhoneNo: $franchisephone \nFailed to send request: ${response.request}\nResponseBody: $responseBody\nStatusCode: ${response.statusCode} \n RequestBody: ${body.toString()}');
          throw HttpException(
              '$path failed: ${response.statusCode}\n$responseBody');
        }

        final responseBody = response.body;
        final parsed = json.decode(responseBody) as Map<String, dynamic>;

        return parsed;
      }
    } else if (method == 'PATCH') {
      {
        final response = await http.patch(url,
            headers: headers, body: json.encode(body ?? {}));
        if (response.statusCode < 200) {
          final responseBody = response.body;
          // serviceLocator<SlackLogger>().sendSlackMessage(
          //     'PhoneNo: $franchisephone \nFailed to send request: ${response.request}\nResponseBody: $responseBody\nStatusCode: ${response.statusCode}\n RequestBody: ${body.toString()}');
          throw HttpException(
              '$path failed: ${response.statusCode}\n$responseBody');
        }

        final responseBody = response.body;
        final parsed = json.decode(responseBody) as Map<String, dynamic>;

        return parsed;
      }
    } else if (method == 'DELETE') {
      {
        final response = await http.delete(url, headers: headers);
        if (response.statusCode < 200 || response.statusCode >= 300) {
          final responseBody = response.body;
          // serviceLocator<SlackLogger>().sendSlackMessage(
          //     'PhoneNo: $franchisephone \nFailed to send request: ${response.request}\nResponseBody: $responseBody\nStatusCode: ${response.statusCode}');
          throw HttpException(
              '$path failed: ${response.statusCode}\n$responseBody');
        }

        final responseBody = response.body;
        final parsed = json.decode(responseBody) as Map<String, dynamic>;

        return parsed;
      }
    } else {
      throw HttpException(
          'Method $method is not supported. Please use GET, POST, PUT, or DELETE');
    }
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return 'HttpException: $message';
  }
}
