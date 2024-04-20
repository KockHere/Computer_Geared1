// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/User.dart';
import 'package:shop_app/variables.dart';

class UserAPI {
  static Future<User> login(String email, String password) async {
    user = User(userId: "");
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
      prefs.then((dataPrefs) {
        dataPrefs.setString("USER", jsonEncode(user.toJson()));
      });
    }
    return user;
  }

  static Future<bool> register(User newUser) async {
    final response = await http.post(
      Uri.parse("${urlApi}user/register"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(newUser.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> update(User newUser) async {
    final response = await http.put(
      Uri.parse("${urlApi}auth/information"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
      body: jsonEncode(newUser.toJson()),
    );
    if (response.statusCode == 201) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      user.firstName = bodyJson[0]["first_name"];
      user.lastName = bodyJson[0]["last_name"];
      user.phoneNumber = bodyJson[0]["phone_number"];
      return true;
    }
    return false;
  }

  static Future updateAvatar(File? image) async {
    if (image == null) return;

    var stream = http.ByteStream(image.openRead());
    var length = await image.length();

    var uri = Uri.parse("${urlApi}auth/avatar");
    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile("image", stream, length,
        filename: image.path.split('/').last);
    request.files.add(multipartFile);

    request.headers.addAll({
      HttpHeaders.authorizationHeader: user.accessToken ?? "",
    });

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    Map<String, dynamic> responseMap = json.decode(responseData);
    user.avatar = responseMap["avatar"];
  }
}
