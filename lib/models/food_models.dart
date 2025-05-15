// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_element, dead_code, missing_required_param, unused_import

import 'package:flutter/cupertino.dart';

class FoodModel {
  String? food_name;
  String? food_type;
  String? food_image;
  String? food_linkImage;
  int? food_price;
  FoodModel({
    required this.food_name,
    required this.food_type,
    @required this.food_image,
    @required this.food_linkImage,
    required this.food_price,
  });
  factory FoodModel.fromMap(Map<String, dynamic> foodmenu) {
    String food_name = foodmenu["name"];
    String food_type = foodmenu["type"];
    String? food_image = foodmenu["image"];
    String? food_linkImage = foodmenu["linkImage"];
    int food_price = foodmenu["price"];
    if (foodmenu == null) {
      return FoodModel(
          food_name: food_name,
          food_type: food_type,
          food_image: food_image,
          food_linkImage: food_linkImage,
          food_price: 0);
    } else {
      return FoodModel(
          food_name: food_name,
          food_type: food_type,
          food_image: food_image,
          food_linkImage: food_linkImage,
          food_price: food_price);
    }
  }
  Map<String, dynamic> FoodToMap() {
    return {
      "name": food_name,
      "type": food_type,
      "image": food_image,
      "price": food_price,
      "linkImage" : food_linkImage,
    };
  }
}
