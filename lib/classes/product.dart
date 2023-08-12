import 'package:flutter/cupertino.dart';
import 'package:yellow_exchange/classes/category.dart';

class ProductClass {

  String name;
  int id;
  double value;
  String category;
  Image? image;
  String imageAsset;

  ProductClass({required this.name, required this.value, required this.category, this.image, required this.id, required this.imageAsset});

  String productToString(){
    return '$name|$id|$value|$category|$imageAsset';
  }

}

class Product {

  static List<ProductClass> allProducts = [];

  static String allProductsKey = "allProducts";

  ProductClass stringToProduct(String productString){
    List<String> components = productString.split('|');

    String name = components[0];
    int id = int.parse(components[1]);
    double value = double.parse(components[2]);
    String category = components[3];
    String imageAsset = components[4];

    return ProductClass(
      name: name,
      id: id,
      value: value,
      category: category,
      imageAsset: imageAsset,
    );
  }

  String turnProductsListToString(List<ProductClass> products) {
    List<String> productStrings = products.map((product) => product.productToString()).toList();
    return productStrings.join(';'); // Use a delimiter that separates product strings
  }

  List<ProductClass> turnProductsStringToList(String productsString) {
    List<String> productStrings = productsString.split(';'); // Split based on the delimiter
    List<ProductClass> products = productStrings.map((productString) => stringToProduct(productString)).toList();
    return products;
  }

}