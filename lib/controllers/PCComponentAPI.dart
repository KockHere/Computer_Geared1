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
      Storage storage) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != "processor") {
      data["processorDetails"] = processor.productId == "" ? null : processor;
      data["processor_brand_id"] = processor.productBrandId ?? "";
    }
    if (category != "motherboard") {
      data["motherboardDetail"] =
          motherboard.productId == "" ? null : motherboard;
      data["motherboard_brand_id"] = motherboard.productBrandId ?? "";
    }
    if (category != "case") {
      data["caseDetails"] = caseSpec.productId == "" ? null : caseSpec;
      data["case_brand_id"] = caseSpec.productBrandId ?? "";
    }
    if (category != "gpu") {
      data["gpuDetail"] = gpu.productId == "" ? null : gpu;
      data["gpu_brand_id"] = gpu.productBrandId ?? "";
    }
    if (category != "ram") {
      data["ramDetails"] = ram.productId == "" ? null : ram;
      data["ram_brand_id"] = ram.productBrandId ?? "";
    }
    if (category != "storage") {
      data["storageDetail"] = storage.productId == "" ? null : storage;
      data["storage_brand_id"] = storage.productBrandId ?? "";
    }

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
