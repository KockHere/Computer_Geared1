// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/specifications/UserPC.dart';
import 'package:shop_app/variables.dart';

class PCBuilderAPI {
  static Future<bool> addNewPC(UserPC userPC) async {
    final response = await http.post(
      Uri.parse("${urlApi}auth/user/pc-component/personal-build"),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(userPC.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<List<UserPC>> getListUserPc() async {
    List<UserPC> listUserPc = [];
    final response = await http.get(
      Uri.parse("${urlApi}auth/user/pc-component/personal-build"),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listUserPc.add(UserPC.fromJson(element));
      }
    }
    return listUserPc;
  }

  static Future<bool> deleteBuildPC(String id) async {
    final response = await http.delete(
      Uri.parse("${urlApi}auth/user/pc-component/personal-build/$id"),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<List<UserPC>> getListUserPcRecommend() async {
    List<UserPC> listUserPc = [];
    final response = await http.get(
      Uri.parse("${urlApi}product/pc-component/get-pre-build"),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 201) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listUserPc.add(UserPC.fromJson(element));
      }
    }
    return listUserPc;
  }

  static Future<bool> copyBuildPC(String id) async {
    final response = await http.post(
      Uri.parse("${urlApi}auth/user/pc-component/copy-personal-build/$id"),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
