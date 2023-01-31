import 'dart:convert';

import 'package:hansenberg_app_core/Utilities/Clients/TokenClient.dart';

class StaffClient extends TokenClient {
  const StaffClient({required httpClient}) : super(httpClient: httpClient);

  Future<String?> loginStaff(String username, String password) async {
    final response = await httpClient.post(
        endpoint: '/staff/login',
        headers: <String, String> { },
        body: <String, dynamic> {
          'username': username,
          'password': password,
        }
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['token'];
    }
    else {
      print("Failed to login staff: ${response.statusCode}, ${response.body}");
      return null;
    }
  }
}