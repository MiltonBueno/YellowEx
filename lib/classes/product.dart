import 'package:flutter/cupertino.dart';
import 'package:yellow_exchange/classes/category.dart';

class Product {

  String name;
  double value;
  String category;
  AssetImage image;

  Product({required this.name, required this.value, required this.category, required this.image});

}