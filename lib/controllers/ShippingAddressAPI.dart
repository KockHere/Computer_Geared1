// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/ShippingAddress.dart';
import 'package:shop_app/variables.dart';

class ShippingAddressAPI {
  static Future<List<ShippingAddress>> getListShippingAddress() async {
    List<ShippingAddress> listShippingAddress = [];
    final response = await http.get(
      Uri.parse("${urlApi}auth/user/shipping-address"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listShippingAddress.add(ShippingAddress.fromJson(element));
      }
    }
    return listShippingAddress;
  }

  static Future<bool> createShippingAddress(
      ShippingAddress shippingAddress) async {
    final response = await http.post(
      Uri.parse("${urlApi}auth/user/shipping-address"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
      body: jsonEncode(shippingAddress.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> deleteShippingAddress(String shippingAddressId) async {
    final response = await http.delete(
      Uri.parse("${urlApi}auth/user/shipping-address/$shippingAddressId"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
