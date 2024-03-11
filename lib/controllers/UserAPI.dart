// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/User.dart';
import 'package:shop_app/variables.dart';

class UserAPI {
  static Future<User> login(String email, String password) async {
    User user = User(userId: "");
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    final response = await http.post(
      Uri.parse("${urlApi}user/login"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var bodyJson = json.decode(utf8.decode(response.bodyBytes));
      user = User.fromJson(bodyJson);
    }
    return user;
  }

  static Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse("${urlApi}user/register"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
