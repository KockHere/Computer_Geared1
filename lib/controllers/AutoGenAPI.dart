// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/specifications/AutoGen.dart';

import 'package:shop_app/variables.dart';

class AutoGenAPI {
  static Future<AutoGen> getListProductAutoGen(
      int purpose, int priceRange) async {
    AutoGen autoGen = AutoGen();
    final response = await http.get(
      Uri.parse(
          "${urlApi}pc-component/auto-gen-by-purpose/$purpose?total=${priceRange * 1000000}"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      if (response.contentLength != 0) {
        var bodyJson = json.decode(utf8.decode(response.bodyBytes));
        autoGen = AutoGen.fromJson(bodyJson);
      }
    }
    return autoGen;
  }
}
