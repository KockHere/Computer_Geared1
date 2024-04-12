// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/variables.dart';

class VnPayAPI {
  static Future<String> createPayment(String orderId) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["orderId"] = orderId;
    final response = await http.post(
      Uri.parse("${urlApi}create_payment_url"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var bodyJson = json.decode(utf8.decode(response.bodyBytes));
      return bodyJson["vnpUrl"];
    }
    return "";
  }

  static Future<Map<String, dynamic>> finishPayment(String url) async {
    final Map<String, dynamic> data = {};
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      var bodyJson = json.decode(utf8.decode(response.bodyBytes));
      data["code"] = bodyJson["code"];
      data["success"] = bodyJson["success"];
    }
    return data;
  }
}
