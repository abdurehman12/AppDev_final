import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import '../Products_model.dart';
import 'dart:convert';

class BlockRepo2 {
  Future<List<Products>> getBlock() async {
    print("CHEKKK");
    var url = Uri.parse('https://dummyjson.com/products');
    var response = await http.get(url);
    List<Products> ffinal = [];
    print(jsonDecode(response.body)["products"][0]);
    // print(data.map((e) => US_model.fromJson(e)).toList());
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)["products"];

      // print(result.map((e) => US_model.fromJson(e)).toList());
      ffinal = result.map((e) => Products.fromJson(e)).toList();
      print(ffinal);
      return ffinal;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
