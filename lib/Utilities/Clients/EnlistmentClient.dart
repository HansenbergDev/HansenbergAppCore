import 'dart:convert';

import 'package:hansenberg_app_core/Models/Enlistment.dart';
import 'package:hansenberg_app_core/Utilities/Clients/HttpClient.dart';

class EnlistmentClient {

  const EnlistmentClient({required this.httpClient});

  final HttpClient httpClient;

  Future<bool> updateEnlistment(int year, int week, Enlistment enlistment, String token) async {
    final response = await httpClient.patch(
        endpoint: '/student/enlistment',
        headers: <String, String> {
          'Content-Type': 'application/json',
          'x-access-token': token
        },
        body: <String, dynamic> {
          'year': year,
          'week': week,
          'monday': enlistment.monday,
          'tuesday': enlistment.tuesday,
          'wednesday': enlistment.wednesday,
          'thursday': enlistment.thursday,
          'friday': enlistment.friday,
        }
    );

    return response.statusCode == 200;
  }

  Future<bool> createEnlistment(int year, int week, Enlistment enlistment, String token) async {
    final response = await httpClient.post(
        endpoint: '/student/enlistment',
        headers: <String, String> {
          'Content-Type': 'application/json',
          'x-access-token': token
        },
        body: <String, dynamic> {
          'year': year,
          'week': week,
          'monday': enlistment.monday,
          'tuesday': enlistment.tuesday,
          'wednesday': enlistment.wednesday,
          'thursday': enlistment.thursday,
          'friday': enlistment.friday,
        }
    );

    return response.statusCode == 201;
  }

  Future<Enlistment?> getEnlistment(int year, int week, String token) async {
    final response = await httpClient.get(
        endpoint: '/student/enlistment/single',
        params: <String, String> {
          'year': '$year',
          'week': '$week',
        },
        headers: <String, String> {
          'x-access-token': token
        }
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Enlistment.fromJson(jsonDecode(response.body));
    }
    else {
      print("Failed to get enlistment: ${response.statusCode}, ${response.body}");
      return null;
    }
  }

  Future<int?> getEnlistmentsOfDay(String day, int week, int year, String token) async {
    if (day != 'monday' && day != 'tuesday' && day != 'wednesday' && day != 'thursday' && day != 'friday') {
      return null;
    }

    final response = await httpClient.get(
        endpoint: '/staff/enlistment/day',
        headers: <String, String> {
          'x-access-token': token
        },
        params: <String, String> {
          'day': day,
          'week': '$week',
          'year': '$year'
        }
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return jsonDecode(response.body)['count'];
    }

    return null;
  }
}