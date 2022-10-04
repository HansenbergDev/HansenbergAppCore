import 'dart:convert';

import 'package:hansenberg_app_core/Models/Student.dart';
import 'package:hansenberg_app_core/Utilities/Clients/HttpClient.dart';
import 'package:intl/intl.dart';

class StudentClient {
  const StudentClient({required this.httpClient});

  final HttpClient httpClient;

  Future<String> registerStudent(String name, DateTime enrolledFrom, DateTime enrolledTo) async {
    final response = await httpClient.post(
      endpoint: '/student/register',
      headers: <String, String> {
        'Content-Type': 'application/json'
      },
      body: <String, dynamic> {
        'name': name,
        'enrolled_from': DateFormat("yyyy-MM-dd").format(enrolledFrom),
        'enrolled_to': DateFormat("yyyy-MM-dd").format(enrolledTo)
      }
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['token'];
    }
    else {
      throw Exception("Failed to create student: ${response.statusCode}, ${response.body}");
    }
  }

  Future<Student?> getStudent(String token) async {
    final response = await httpClient.get(
        endpoint: '/student',
        headers: <String, String> {
          'x-access-token': token
        });

    if (response.statusCode == 200) {
      return Student.fromJson(jsonDecode(response.body));
    }
    else {
      print('Failed to get student: ${response.statusCode}, ${response.body}');
      return null;
    }
  }

  Future<bool> deleteStudent(String token) async {
    final response = await httpClient.delete(
        endpoint: '/student',
        headers: <String, String> {
          'x-access-token': token
        },
    );

    if (response.statusCode == 410) {
      return true;
    }
    else {
      print('Failed to delete student: ${response.statusCode}, ${response.body}');
      return false;
    }
  }
}
