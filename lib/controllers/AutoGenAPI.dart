// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/specifications/AutoGen.dart';
import 'package:shop_app/variables.dart';

class AutoGenAPI {
  static Future<AutoGen> getListProductAutoGen(
      List<String> purpose, int priceRange) async {
    Map<String, dynamic> data = {};
    data["purpose"] = "null";
    data["price_range"] = priceRange;
    AutoGen autoGen = AutoGen();
    final response = await http.post(
      Uri.parse("${urlApi}pc-component/random/auto-gen"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var bodyJson = json.decode(utf8.decode(response.bodyBytes));
      autoGen = AutoGen.fromJson(bodyJson);
    }
    return autoGen;
  }
}
