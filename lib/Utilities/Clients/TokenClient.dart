
import 'package:hansenberg_app_core/Utilities/Clients/HttpClient.dart';

class TokenClient {
  const TokenClient({required this.httpClient});

  final HttpClient httpClient;

  Future<bool?> checkTokenValidity(String token, {bool isStaffToken = false}) async {
    final response = await httpClient.post(
        endpoint: isStaffToken ? '/staff/tokenCheck' : '/student/tokenCheck',
        headers: <String, String> {
          'x-access-token': token
        },
        body: <String, dynamic> { }
    );

    if (response.statusCode == 200) {
      return true;
    }
    else if (response.statusCode == 401) {
      return false;
    }
    else {
      return null;
    }
  }
}