import 'package:flutter/cupertino.dart';
import 'package:yellow_exchange/classes/category.dart';

class Product {

  String name;
  int id;
  double value;
  String category;
  Image? image;
  String imageAsset;


  Product({required this.name, required this.value, required this.category, this.image, required this.id, required this.imageAsset, });

  String productToString(){
    return '$name|$id|$value|$category|$imageAsset';
  }

}