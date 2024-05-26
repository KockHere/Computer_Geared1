// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/specifications/Case.dart';
import 'package:shop_app/models/specifications/Gpu.dart';
import 'package:shop_app/models/specifications/Motherboard.dart';
import 'package:shop_app/models/specifications/Processor.dart';
import 'package:shop_app/models/specifications/Ram.dart';
import 'package:shop_app/models/specifications/Storage.dart';
import 'package:shop_app/variables.dart';

class PCComponentAPI {
  static Future<List<Product>> getListProductComponent(String category) async {
    if (category.toLowerCase() == "cooler cpu") {
      category = "cpu cooler";
    } else if (category.toLowerCase() == "fan") {
      category = "case cooler";
    } else if (category.toLowerCase() == "gpu") {
      category = "graphics-card";
    }
    List<Product> listProduct = [];
    final response = await http.get(
      Uri.parse(
          "${urlApi}pc-component/${category.toLowerCase().replaceAll(" ", "-")}"),
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

  static Future<Map<String, dynamic>> getProductComponent(
      String category, String id) async {
    if (category.toLowerCase() == "gpu") {
      category = "graphics-card";
    }
    if (category.toLowerCase() == "cooler cpu") {
      category = "cpu-cooler";
    }
    if (category.toLowerCase() == "fan") {
      category = "case-cooler";
    }
    Map<String, dynamic> productComponent = {};
    final response = await http.get(
      Uri.parse(
          "${urlApi}pc-component/${category.toLowerCase().replaceAll(" ", "-")}/$id"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> bodyJson =
          json.decode(utf8.decode(response.bodyBytes));
      productComponent = bodyJson;
    }
    return productComponent;
  }

  static Future<List<Product>> getListProductComponentPost(
      String category,
      Processor processor,
      Motherboard motherboard,
      Case caseSpec,
      Gpu gpu,
      Ram ram,
      Storage storage,
      List<Product> listSelectedProduct) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["storageDetail"] = storage.toJson2();
    data["ramDetails"] = ram.toJson2();
    data["caseDetails"] = caseSpec.toJson2();
    data["processorDetails"] = processor.toJson2();
    data["motherboardDetail"] = motherboard.toJson2();
    // data["gpuDetail"] = gpu.toJson2();
    Product? productProcessor = listSelectedProduct.isEmpty
        ? null
        : listSelectedProduct.firstWhere(
            (element) => element.categoryName!.toLowerCase() == "processor",
            orElse: () => Product());
    data["processoBrandId"] = productProcessor?.productBrandId;

    Product? productMotherboard = listSelectedProduct.isEmpty
        ? null
        : listSelectedProduct.firstWhere(
            (element) => element.categoryName!.toLowerCase() == "motherboard",
            orElse: () => Product());
    data["motherboardBrandId"] = productMotherboard?.productBrandId;

    Product? productCase = listSelectedProduct.isEmpty
        ? null
        : listSelectedProduct.firstWhere(
            (element) => element.categoryName!.toLowerCase() == "case",
            orElse: () => Product());
    data["caseBrandId"] = productCase?.productBrandId;

    Product? productGpu = listSelectedProduct.isEmpty
        ? null
        : listSelectedProduct.firstWhere(
            (element) => element.categoryName!.toLowerCase() == "gpu",
            orElse: () => Product());
    data["gpuBrandId"] = productGpu?.productBrandId;

    Product? productStorage = listSelectedProduct.isEmpty
        ? null
        : listSelectedProduct.firstWhere(
            (element) => element.categoryName!.toLowerCase() == "storage",
            orElse: () => Product());
    data["storageBrandId"] = productStorage?.productBrandId;

    Product? productRam = listSelectedProduct.isEmpty
        ? null
        : listSelectedProduct.firstWhere(
            (element) => element.categoryName!.toLowerCase() == "ram",
            orElse: () => Product());
    data["ramBrandId"] = productRam?.productBrandId;

    if (category.toLowerCase() == "gpu") {
      category = "graphics-card";
    }
    List<Product> listProduct = [];
    final response = await http.post(
      Uri.parse(
          "${urlApi}pc-component/${category.toLowerCase().replaceAll(" ", "-")}"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      List<dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      for (var element in bodyJson) {
        listProduct.add(Product.fromJson(element));
      }
    }
    return listProduct;
  }
}
