// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/Category.dart';
import 'package:shop_app/variables.dart';

class CategoryAPI {
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
}
