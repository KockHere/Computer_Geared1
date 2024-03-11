// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/variables.dart';

class CartAPI {
  static Future<Cart> getUserCart() async {
    final response = await http.get(
      Uri.parse("${urlApi}auth/user/cart"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      try {
        var bodyJson = json.decode(utf8.decode(response.bodyBytes));
        userCart = Cart.fromJson(bodyJson);
      } catch (ex) {
        userCart = Cart(cartId: "");
      }
    }
    return userCart;
  }

  static Future<Cart> addCartItem(List<CartItem> listCartItem) async {
    Cart cartBody = Cart(productList: listCartItem);
    final response = await http.post(
      Uri.parse("${urlApi}auth/user/cart"),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(cartBody.toJson())
    );
    if (response.statusCode == 200) {
      try {
        var bodyJson = json.decode(utf8.decode(response.bodyBytes));
        userCart = Cart.fromJson(bodyJson);
      } catch (ex) {
        userCart = Cart(cartId: "");
      }
    }
    return userCart;
  }

  static Future<bool> updateQuantityCartItem(String cartItemId, int quantity) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["quantity"] = quantity;
    final response = await http.put(
      Uri.parse("${urlApi}cart-item/$cartItemId"),
      headers: <String, String>{
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(data)
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}