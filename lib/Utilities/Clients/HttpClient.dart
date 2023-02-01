import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  HttpClient({required this.urlBase, required this.endpointBase});

  final String urlBase;
  final String endpointBase;

  static const Duration defaultTimeoutDuration = Duration(seconds: 1);

  Future<http.Response> get({required String endpoint, Map<String, String> params = const {}, Map<String, String> headers = const {}}) {
    return http.get(
        Uri.http(urlBase, '$endpointBase$endpoint', params),
        headers: headers
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }

  Future<http.Response> post({required String endpoint, required Map<String, String> headers, required Map<String, dynamic> body}) {
    return http.post(
      Uri.http(urlBase, '$endpointBase$endpoint'),
      headers: headers,
      body: jsonEncode(body),
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }

  Future<http.Response> patch({required String endpoint, required Map<String, String> headers, required Map<String, dynamic> body}) {
    return http.patch(
        Uri.http(urlBase, '$endpointBase$endpoint'),
        headers: headers,
        body: jsonEncode(body)
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }

  Future<http.Response> delete({required String endpoint, required Map<String, String> headers, Map<String, dynamic> body = const {}}) {
    return http.delete(
        Uri.http(urlBase, '$endpointBase$endpoint'),
        headers: headers,
        body: jsonEncode(body)
    ).timeout(defaultTimeoutDuration, onTimeout: () { return http.Response('Error', 408); });
  }
}