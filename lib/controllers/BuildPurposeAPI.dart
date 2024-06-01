// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/BuildPurpose.dart';
import 'package:shop_app/variables.dart';

class BuildPurposeAPI {
  static Future<List<BuildPurpose>> getListBuildPurpose() async {
    List<BuildPurpose> listBuildPurpose = [];
    final response = await http.get(
      Uri.parse("${urlApi}pc-build-purpose"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listBuildPurpose.add(BuildPurpose.fromJson(element));
      }
    }
    return listBuildPurpose;
  }
}
