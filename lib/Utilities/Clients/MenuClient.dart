import 'dart:convert';

import 'package:hansenberg_app_core/Models/Menu.dart';
import 'package:hansenberg_app_core/Utilities/Clients/HttpClient.dart';

class MenuClient {

  const MenuClient({required this.httpClient});

  final HttpClient httpClient;

  Future<void> createMenu(Menu menu, String token) async {
    final response = await httpClient.post(
        endpoint: '/menu',
        headers: <String, String> {
          'Content-Type': 'application/json',
          'x-access-token': token
        },
        body: <String, dynamic> {
          'monday': menu.monday,
          'tuesday': menu.tuesday,
          'wednesday': menu.wednesday,
          'thursday': menu.thursday
        }
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to create menu: ${response.statusCode}, ${response.body}");
    }
  }

  Future<Menu?> getMenu(int year, int week) async {
    final response = await httpClient.get(
        endpoint: '/menu/single',
        params: <String, String> {
          'year': '$year',
          'week': '$week',
        },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return Menu.fromJson(jsonDecode(response.body));
      }
      else {
        return null;
      }
    }
    else {
      print('Failed to get menu: ${response.statusCode}, ${response.body}');
      return null;
    }
  }

  // Future<List<Menu>> getMenuAll() async {
  //   final response = await httpClient.get(
  //       '/menu/all',
  //       <String, String> {},
  //       <String, String> {}
  //   );
  //
  //   if (response.statusCode == 200) {
  //     List<Map<String, dynamic>> json = jsonDecode(response.body);
  //     List<Menu> result = [];
  //
  //     for (var element in json) {
  //       result.add(Menu.fromJson(element));
  //     }
  //
  //     return result;
  //   }
  //   else {
  //     throw Exception('Failed to get all menus: ${response.statusCode}, ${response.body}');
  //   }
  // }
}