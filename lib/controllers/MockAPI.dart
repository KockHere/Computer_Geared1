import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/CartItem.dart';
import 'package:shop_app/models/Category.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/variables.dart';

class MockAPI {
  static Future<User> login(String email, String password) async {
    User user = User(userId: "");
    final Map<String, dynamic> data = <String, dynamic>{};
    data["email"] = email;
    data["password"] = password;
    final response = await http.post(
      Uri.parse("${urlApi}user/login"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      var bodyJson = json.decode(utf8.decode(response.bodyBytes));
      user = User.fromJson(bodyJson);
    }
    return user;
  }

  static Future<bool> register(User user) async {
    final response = await http.post(
      Uri.parse("${urlApi}user/register"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<List<Category>> getListCategory() async {
    List<Category> listCategory = [];
    final response = await http.get(
      Uri.parse("${urlApi}category"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listCategory.add(Category.fromJson(element));
      }
    }
    return listCategory;
  }

  static Future<List<Category>> getListAllCategory() async {
    List<Category> listAllCategory = [];
    final response = await http.get(
      Uri.parse("${urlApi}categories"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listAllCategory.add(Category.fromJson(element));
      }
    }
    return listAllCategory;
  }

  static Future<List<Product>> getListProduct() async {
    List<Product> listProduct = [];
    final response = await http.get(
      Uri.parse("${urlApi}product"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listProduct.add(Product.fromJson(element));
      }
    }
    return listProduct;
  }

  static Future<List<CartItem>> getListCartItem() async {
    List<CartItem> listCartItem = [];
    final response = await http.get(
      Uri.parse("${urlApi}cart_item"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listCartItem.add(CartItem.fromJson(element));
      }
    }
    return listCartItem;
  }
}
