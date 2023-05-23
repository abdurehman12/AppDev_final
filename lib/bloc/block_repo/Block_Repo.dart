import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "../US_model.dart";
import 'dart:convert';

class BlockRepo {
  Future<List<US_model>> getBlock() async {
    print("CHEKKK");
    var url = Uri.parse('https://date.nager.at/api/v2/publicholidays/2020/US');
    var response = await http.get(url);
    print(response.body);
    // print(data.map((e) => US_model.fromJson(e)).toList());
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      print(result);
      // print(result.map((e) => US_model.fromJson(e)).toList());
      return result.map((e) => US_model.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
