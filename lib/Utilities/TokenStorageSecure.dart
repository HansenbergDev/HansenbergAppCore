import 'package:hansenberg_app_core/Utilities/TokenStorage.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageSecure implements TokenStorage {
  final storage = const FlutterSecureStorage();

  @override
  Future<bool> tokenExists() async {
    return (await storage.read(key: 'token')) != null;
  }

  @override
  Future<String> readToken() async {
    return (await storage.read(key: 'token'))!;
  }

  @override
  Future<void> writeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
