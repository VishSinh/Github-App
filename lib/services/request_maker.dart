import 'dart:convert';
import 'package:github_app/helpers/consts.dart';
import 'package:http/http.dart' as http;

class RequestMaker {
  static const _defaultHeaders = {
    'Content-Type': 'application/json',
  };

  static Future<http.Response> postRequest({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Duration timeoutDuration = const Duration(seconds: 30),
  }) async {
    final uri = Uri.parse(url);
    final mergedHeaders = {..._defaultHeaders, ...?headers};

    final response = await http.post(uri, headers: mergedHeaders, body: json.encode(body)).timeout(timeoutDuration);

    log.i('Request Body: $body\nApi Endpoint: $url\nResponse Status: ${response.statusCode}\nResponse Body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      final error = json.decode(response.body);
      final errorMessage = error['message'] ?? 'Unknown error occurred';
      throw Exception(errorMessage);
    }
  }

  static Future<http.Response> getRequest({
    required String url,
    Map<String, String>? headers,
    Duration timeoutDuration = const Duration(seconds: 30),
  }) async {
    final uri = Uri.parse(url);
    final mergedHeaders = {..._defaultHeaders, ...?headers};

    final response = await http.get(uri, headers: mergedHeaders).timeout(timeoutDuration);

    log.i('Api Endpoint: $url\nResponse Status: ${response.statusCode}\nResponse Body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      final error = json.decode(response.body);
      final errorMessage = error['message'] ?? 'Unknown error occurred';
      throw Exception(errorMessage);
    }
  }
}
