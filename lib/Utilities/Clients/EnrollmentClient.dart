import 'dart:convert';

import 'package:hansenberg_app_core/Utilities/Clients/HttpClient.dart';

class EnrollmentClient {
  const EnrollmentClient({required this.httpClient});

  final HttpClient httpClient;

  Future<bool> postEnrollmentNumber(int week, int year, int number, String token) async {
    final response = await httpClient.post(
        endpoint: '/staff/enrolled_number/week',
        headers: <String, String> {
          'Content-Type': 'application/json',
          'x-access-token': token
        },
        body: <String, dynamic> {
          'week': week,
          'year': year,
          'number': number
        });

    return response.statusCode == 201;
  }

  Future<bool> patchEnrollmentNumber(int week, int year, int number, String token) async {
    final response = await httpClient.patch(
        endpoint: '/staff/enrolled_number/week',
        headers: <String, String> {
          'Content-Type': 'application/json',
          'x-access-token': token
        },
        body: <String, dynamic> {
          'week': week,
          'year': year,
          'number': number
        });

    return response.statusCode == 200;
  }

  Future<int?> getEnrollmentNumber(int week, int year, String token) async {
    final response = await httpClient.get(
      endpoint: '/staff/enrolled_number/week',
      headers: <String, String> {
        'x-access-token': token
      },
      params: <String, String> {
        'week': '$week',
        'year': '$year'
      }
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(response.body)['number_of_enrolled_students'];
    }

    return null;
  }
}