import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yellow_exchange/classes/product.dart';

import '../classes/user.dart';

class SplashBloc{

  User user = User();

  Product product = Product();

  getUserLoggedAndDefineRoute(context) async {
    final prefs = await SharedPreferences.getInstance();
    String userLoggedUsername = prefs.getString(User.userLoggedKey) ?? "";
    getListOfAllProducts(prefs);
    if(userLoggedUsername != ""){
      List<UserClass> registeredUsersList = await user.getRegisteredUsersList();
      for(var element in registeredUsersList){
        if(element.username == userLoggedUsername){
          User.loggedUser = element;
        }
      }
      // Navigator.pushNamed(context, "/login");
      Navigator.pushNamed(context, "/home");
    }else{
      Navigator.pushNamed(context, "/login");
    }
  }

  getListOfAllProducts(prefs) async {
    String allProductsString = prefs.getString(Product.allProductsKey) ?? "";
    if(allProductsString != ""){
      Product.allProducts = product.turnProductsStringToList(allProductsString);
    }
  }

}