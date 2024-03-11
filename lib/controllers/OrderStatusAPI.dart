// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/variables.dart';
import 'package:shop_app/models/OrderStatus.dart';

class OrderStatusAPI {
  static Future<List<OrderStatus>> getListOrderStatus() async {
    List<OrderStatus> listOrderStatus= [];
    final response = await http.get(
      Uri.parse("${urlApi}auth/user/order-status"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listOrderStatus.add(OrderStatus.fromJson(element));
      }
    }
    return listOrderStatus;
  }
}
