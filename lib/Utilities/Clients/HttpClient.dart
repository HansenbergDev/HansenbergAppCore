import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  HttpClient({required this.base});

  final String base;

  static const Duration defaultTimeoutDuration = Duration(seconds: 1);

  Future<http.Response> get({required String endpoint, Map<String, String> params = const {}, Map<String, String> headers = const {}}) {
    String formattedParams = "";

    if (params.isNotEmpty) {
      formattedParams = "?";


      for (var key in params.keys) {
        formattedParams = "$formattedParams$key=${params[key]}&";
      }

      formattedParams = formattedParams.substring(0, formattedParams.length - 1);
    }

    // final path = '$base$endpoint$formattedParams';
    final uri = Uri.http(base, '$endpoint$formattedParams');

    return http.get(
        uri,
        headers: headers
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }

  Future<http.Response> post({required String endpoint, required Map<String, String> headers, required Map<String, dynamic> body}) {
    return http.post(
      // Uri.parse("$base$endpoint"),
      Uri.http(base, endpoint),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }

  Future<http.Response> patch({required String endpoint, required Map<String, String> headers, required Map<String, dynamic> body}) {
    return http.patch(
        // Uri.parse("$base$endpoint"),
        Uri.http(base, endpoint),
        headers: headers,
        body: jsonEncode(body)
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }

  Future<http.Response> delete({required String endpoint, required Map<String, String> headers, Map<String, dynamic> body = const {}}) {
    return http.delete(
        // Uri.parse("$base$endpoint"),
        Uri.http(base, endpoint),
        headers: headers,
        body: jsonEncode(body)
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }
}