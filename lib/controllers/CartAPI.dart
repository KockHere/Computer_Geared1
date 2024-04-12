// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/variables.dart';

class CartAPI {
  static Future<List<Cart>> getUserCart() async {
    List<Cart> listCart = [];
    final response = await http.get(
      Uri.parse("${urlApi}auth/user/cart"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: user.accessToken ?? "",
      },
    );
    if (response.statusCode == 200) {
      try {
        userCart = Cart.fromJson(bodyJson);
        List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
        for (var element in bodyJson) {
          listCart.add(Cart.fromJson(element));
          listUserCart.add(Cart.fromJson(element));
        }
        // prefs.then((dataPrefs) {
        //   dataPrefs.setString("USER_CART", jsonEncode(userCart.toJson()));
        // });
      } catch (ex) {
        listCart = [];
      }
    }
    return listCart;
  }

  static Future<bool> addCartItem(List<CartItem> listCartItem) async {
    Cart cartBody = Cart(productList: listCartItem);
    final response = await http.post(Uri.parse("${urlApi}auth/user/cart"),
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: user.accessToken ?? "",
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(cartBody.toJson()));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> addCartItemBuildPc(String userBuildPcId) async {
    final response = await http.post(
      Uri.parse("${urlApi}auth/user/cart-item/$userBuildPcId"),
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

  static Future<bool> updateQuantityCartItem(
      String cartItemId, int quantity) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["quantity"] = quantity;
    final response = await http.put(Uri.parse("${urlApi}cart-item/$cartItemId"),
        headers: <String, String>{
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: user.accessToken ?? "",
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> deleteBuildPcCartItem(String cartItemId) async {
    final response = await http.delete(
      Uri.parse("${urlApi}cart-item/$cartItemId"),
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
