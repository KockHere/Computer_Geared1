// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shop_app/models/Orders.dart';

import 'package:shop_app/variables.dart';
import 'package:shop_app/models/OrderStatus.dart';

class OrderAPI {
  static Future<List<OrderStatus>> getListOrderStatus() async {
    List<OrderStatus> listOrderStatus= [];
    final response = await http.get(
      Uri.parse("${urlApi}user/order-status"),
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

  static Future<List<Orders>> getListOrders() async {
    List<Orders> listOrders= [];
    final response = await http.get(
      Uri.parse("${urlApi}auth/user/order"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listOrders.add(Orders.fromJson(element));
      }
    }
    return listOrders;
  }

  static Future<String> createOrders(String paymentId, String addressId, List<String> listCartItemId) async {
    String orderId = "";
    List<Map<String, dynamic>> cartItemList = [];
    for (String cartItemId in listCartItemId) {
      Map<String, dynamic> cartItem = {};
      cartItem["cart_item_id"] = cartItemId;
      cartItemList.add(cartItem);
    }
    final Map<String, dynamic> data = <String, dynamic>{};
    data["payment_id"] = paymentId;
    data["address_id"] = addressId;
    data["cartItemList"] = cartItemList;
    final response = await http.post(
      Uri.parse("${urlApi}auth/user/order"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var bodyJson = json.decode(utf8.decode(response.bodyBytes));
      return bodyJson["orderId"];
    }
    return orderId;
  }
}
