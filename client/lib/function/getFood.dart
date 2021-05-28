import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../model/foods.dart';

List<Foods> parseFood(String responseBody) {
  var list = json.decode(responseBody) as List<dynamic>;
  var foods = list.map((model) => Foods.fromJson(model)).toList();
  return foods;
}

Future<List<Foods>> fetchFoods() async {
  final response = await http
      .get(Uri.parse("https://ezcooks.herokuapp.com/food?category=all"));
  if (response.statusCode == 200) {
    return compute(parseFood, response.body);
  } else {
    print("get food error");
  }
}
