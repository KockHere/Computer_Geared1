// ignore_for_file: file_names
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:shop_app/models/District.dart';
import 'package:shop_app/models/Province.dart';
import 'package:shop_app/models/Ward.dart';
import 'package:shop_app/variables.dart';

class AddressAPI {

  static Future<List<Province>> getListProvince() async {
    List<Province> listProvince = [];
    final response = await http.get(
      Uri.parse("${urlApiAddress}province"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      Map<String, dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> result = bodyJson["results"];
      for (var element in result) {
        listProvince.add(Province.fromJson(element));
      }
    }
    return listProvince;
  }

  static Future<List<District>> getListDistrict(String provinceId) async {
    List<District> listDistrict = [];
    final response = await http.get(
      Uri.parse("${urlApiAddress}province/district/$provinceId"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> result = bodyJson["results"];
      for (var element in result) {
        listDistrict.add(District.fromJson(element));
      }
    }
    return listDistrict;
  }

  static Future<List<Ward>> getListWard(String districtId) async {
    List<Ward> listWard = [];
    final response = await http.get(
      Uri.parse("${urlApiAddress}province/ward/$districtId"),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> bodyJson = json.decode(utf8.decode(response.bodyBytes));
      List<dynamic> result = bodyJson["results"];
      for (var element in result) {
        listWard.add(Ward.fromJson(element));
      }
    }
    return listWard;
  }
}
