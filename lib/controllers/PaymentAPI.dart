// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/variables.dart';
import 'package:shop_app/models/Payment.dart';

class PaymentAPI {
  static Future<List<Payment>> getListPayment() async {
    List<Payment> listPayment= [];
    final response = await http.get(
      Uri.parse("${urlApi}payment"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listPayment.add(Payment.fromJson(element));
      }
    }
    return listPayment;
  }
}
