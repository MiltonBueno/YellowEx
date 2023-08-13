import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yellow_exchange/classes/category.dart';
import 'package:yellow_exchange/classes/product.dart';

import '../classes/user.dart';

class HomeBloc {

  BehaviorSubject<String> selectedCategory = BehaviorSubject();
  BehaviorSubject<double> tValue = BehaviorSubject();
  BehaviorSubject<double> favoriteInitialSize = BehaviorSubject();
  BehaviorSubject<double> favoriteFinalSize = BehaviorSubject();
  BehaviorSubject<Color> favoriteInitialColor = BehaviorSubject();
  BehaviorSubject<Color> favoriteFinalColor = BehaviorSubject();
  BehaviorSubject<int> statePhase = BehaviorSubject();
  BehaviorSubject<bool> isNotificationPageOpen = BehaviorSubject();
  BehaviorSubject<bool> isNotificationPageAlreadyOpen = BehaviorSubject();
  BehaviorSubject<bool> notificationWasRead = BehaviorSubject();
  BehaviorSubject<List<ProductClass>> productsToShow = BehaviorSubject();
  BehaviorSubject<int> selectedProduct = BehaviorSubject();
  BehaviorSubject<List<int>> favoritedProductsIds = BehaviorSubject();
  BehaviorSubject<bool> deactivateFavorite = BehaviorSubject();
  Color heartColor = Colors.black;

  List<ProductClass> productsToShowList = [];
  List<ProductClass> favoritedProductsList = [];
  List<int> favoritedProductsIdList = [];

  double tValueDouble = 0;

  User user = User();

  openNotificationPage(){
    isNotificationPageOpen.sink.add(true);
    Future.delayed(const Duration(milliseconds: 150), () {
      isNotificationPageAlreadyOpen.sink.add(true);
    });
  }

  closeNotificationPage(){
    isNotificationPageOpen.sink.add(false);
    isNotificationPageAlreadyOpen.sink.add(false);
    // Future.delayed(const Duration(milliseconds: 150), () {
    // });
  }

  selectCategory(String category){
    selectedCategory.sink.add(category);
  }

  double getT(initialSize, finalSize, currentSize){
    double t = 0;
    if(initialSize == 35 && finalSize == 25){
      t = ((initialSize / currentSize) - 1) / ((35/25) - 1); //
    } else if(initialSize == 25 && finalSize == 35){
      t = (currentSize / initialSize - 1) / ((35 / 25) - 1); //Testado
    } else if(initialSize == 35 && finalSize == 40){
      t = (currentSize / initialSize - 1) / ((40 / 35) - 1); //Testado
    }else if(initialSize == 40 && finalSize == 35){
      t = (initialSize / currentSize - 1) / ((40 / 35) - 1);
    }else{
      t = 0;
    }
    return t;
  }

  bool isThisProductFavorited(int productId) {
    if(User.loggedUser != null){
      return User.loggedUser!.favoritedProducts.contains(productId);
    }else{
      // The user is not logged in; navigate to the login page
      return false;
    }
  }

  Future<void> updateFavoriteValues(
      int productId,
      bool isFavorited,
      double initialSize,
      double finalSize,
      Color initialColor,
      Color finalColor,
      Duration delay) async {
    selectedProduct.sink.add(productId);
    await Future.delayed(delay, () {
      favoriteInitialSize.sink.add(initialSize);
      favoriteFinalSize.sink.add(finalSize);
      favoriteInitialColor.sink.add(initialColor);
      favoriteFinalColor.sink.add(finalColor);
    });
  }

  void favoriteProduct(bool isFavorited, ProductClass product) {

    deactivateFavorite.sink.add(true);
    Future.delayed(const Duration(milliseconds: 125), () {
      deactivateFavorite.sink.add(false);
    });

    if (isFavorited) {
      favoritedProductsList.remove(product);
      favoritedProductsIdList.remove(product.id);
      favoritedProductsIds.sink.add(favoritedProductsIdList);
      updateLoggedUserFavoriteProducts(false, product.id);
      updateFavoriteValues(product.id, isFavorited, 35, 25, Colors.red, Colors.red, const Duration(milliseconds: 125));
      updateFavoriteValues(product.id, isFavorited, 25, 35, Colors.red, Colors.black, const Duration(milliseconds: 250));
    } else {
      favoritedProductsList.add(product);
      favoritedProductsIdList.add(product.id);
      favoritedProductsIds.sink.add(favoritedProductsIdList);
      updateLoggedUserFavoriteProducts(true, product.id);
      updateFavoriteValues(product.id, isFavorited, 35, 25, Colors.black, Colors.black, const Duration(milliseconds: 125));
      updateFavoriteValues(product.id, isFavorited, 25, 35, Colors.black, Colors.red, const Duration(milliseconds: 250));
      // updateFavoriteValues(product.id, isFavorited, 35, 40, Colors.red, Colors.red, const Duration(milliseconds: 375));
      // updateFavoriteValues(product.id, isFavorited, 40, 35, Colors.red, Colors.red, const Duration(milliseconds: 500));
    }
  }

  void favoriteProductMulticolor(bool isFavorited, ProductClass product) {
    if (isFavorited) {
      favoritedProductsList.remove(product);
      favoritedProductsIdList.remove(product.id);
      favoritedProductsIds.sink.add(favoritedProductsIdList);
      updateLoggedUserFavoriteProducts(false, product.id);
      updateFavoriteValues(product.id, isFavorited, 35, 25, Colors.red, Colors.red, const Duration(milliseconds: 125));
      updateFavoriteValues(product.id, isFavorited, 25, 35, Colors.red, Colors.black, const Duration(milliseconds: 250));
    } else {
      favoritedProductsList.add(product);
      favoritedProductsIdList.add(product.id);
      favoritedProductsIds.sink.add(favoritedProductsIdList);
      updateLoggedUserFavoriteProducts(true, product.id);
      updateFavoriteValues(product.id, isFavorited, 35, 25, Colors.black, Colors.green, const Duration(milliseconds: 125));
      updateFavoriteValues(product.id, isFavorited, 25, 35, Colors.green, Colors.orange, const Duration(milliseconds: 250));
      updateFavoriteValues(product.id, isFavorited, 35, 40, Colors.orange, Colors.yellow, const Duration(milliseconds: 375));
      updateFavoriteValues(product.id, isFavorited, 40, 35, Colors.yellow, Colors.red, const Duration(milliseconds: 500));
    }
  }

  updateLoggedUserFavoriteProducts(bool isAdd, int productId) async {
    if(User.loggedUser != null){

      UserClass currentAttributes = User.loggedUser!;
      List<int> currentFavoritedProducts = currentAttributes.favoritedProducts;

      if(isAdd){

        currentFavoritedProducts.add(productId);
        UserClass newUserAttributes = UserClass(
            currentAttributes.name, currentAttributes.email, currentAttributes.username, currentAttributes.password, currentAttributes.notificationRead,
            currentFavoritedProducts,
            currentAttributes.postedProducts, currentAttributes.toBuyProducts);
        final prefs = await SharedPreferences.getInstance();
        String allUsers = prefs.getString(User.keyRegisteredUsers) ?? "";
        List<UserClass> allUsersList = user.turnStringToList(allUsers);
        allUsersList.removeWhere((element) => element.username == currentAttributes.name);
        allUsersList.add(newUserAttributes);
        prefs.setString(User.keyRegisteredUsers, user.turnListToString(allUsersList));

      }else{

        currentFavoritedProducts.remove(productId);
        UserClass newUserAttributes = UserClass(
            currentAttributes.name, currentAttributes.email, currentAttributes.username, currentAttributes.password, currentAttributes.notificationRead,
            currentFavoritedProducts,
            currentAttributes.postedProducts, currentAttributes.toBuyProducts);
        final prefs = await SharedPreferences.getInstance();
        String allUsers = prefs.getString(User.keyRegisteredUsers) ?? "";
        List<UserClass> allUsersList = user.turnStringToList(allUsers);
        allUsersList.removeWhere((element) => element.username == currentAttributes.name);
        allUsersList.add(newUserAttributes);
        prefs.setString(User.keyRegisteredUsers, user.turnListToString(allUsersList));

      }
    }else{
      //lógica que redireciona pra login (criar função static)
    }
  }

  getProductsToShowList() async {
    final prefs = await SharedPreferences.getInstance();
    String wasSimulated = prefs.getString(User.createdSimulatedUsers) ?? "";
    if(wasSimulated == "true"){
      productsToShowList.addAll([ProductClass(
        id: 0,
        name: "Smartphone Samsung Galaxy",
        value: 2000.00,
        category: Category.electronics,
        image: Image.asset("assets/celular_s21.jpg", fit: BoxFit.contain),
        imageAsset: '',
      ),
        ProductClass(
          id: 1,
          name: "Produto qualquer",
          value: 150.00,
          category: Category.recreation,
          image: Image.asset("assets/forgot_password.jpg", fit: BoxFit.contain),
          imageAsset: '',
        ),
        ProductClass(
          id: 2,
          name: "Fundo de tela",
          value: 300.00,
          category: Category.clothing,
          image: Image.asset("assets/login_black.png", fit: BoxFit.contain),
          imageAsset: '',
        )
        // ProductClass(
        //   id: 2,
        //   name: "Fundo de tela",
        //   value: 300.00,
        //   category: Category.clothing,
        //   image: Image.file(File("/data/user/0/com.example.yellow_exchange/cache/ba2a3a23-a1e0-4fdd-93b2-3a6f81df61774085202887462916278.jpg"), fit: BoxFit.contain),
        //   imageAsset: '',
        // )
      ]);
      Product.allProducts = productsToShowList;
    }

    clearProductsToShowList();

    updateFavoritedProducts();

  }

  void clearProductsToShowList() {
    if (User.loggedUser != null) {
      if (Product.allProducts.isNotEmpty) {
        List<ProductClass> productsToRemove = [];
        for (var product in Product.allProducts) {
          if (User.loggedUser!.postedProducts.contains(product.id)) {
            productsToRemove.add(product);
          }
        }
        productsToShowList.removeWhere((element) => productsToRemove.contains(element));
      }
      productsToShow.sink.add(productsToShowList);
    } else {
      // The user is not logged in; navigate to the login page
    }
  }

  updateFavoritedProducts(){
    for(var product in Product.allProducts){
      for(var productId in User.loggedUser!.favoritedProducts){
        if(product.id == productId){
          favoritedProductsList.add(product);
        }
      }
    }
    for(var element in favoritedProductsList){
      favoritedProductsIdList.add(element.id);
    }
    favoritedProductsIds.sink.add(favoritedProductsIdList);
  }

  HomeBloc(){
    getProductsToShowList();
  }

}