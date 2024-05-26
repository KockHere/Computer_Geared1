// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Review.dart';
import 'package:shop_app/variables.dart';

class ProductAPI {
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

  static Future<List<Review>> getListReview(String productId) async {
    List<Review> listReview = [];
    final response = await http.get(
      Uri.parse("${urlApi}product/$productId"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> result = bodyJson[0]["review_list"] ?? [];
      if (result.isNotEmpty) {
        for (var element in result) {
          listReview.add(Review.fromJson(element));
        }
      }
    }
    return listReview;
  }
}
