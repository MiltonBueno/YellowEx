import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yellow_exchange/classes/category.dart';

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
  Color heartColor = Colors.black;

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

  Future<void> updateFavoriteValues(
      double initialSize,
      double finalSize,
      Color initialColor,
      Color finalColor,
      Color newHeartColor,
      Duration delay) async {
    await Future.delayed(delay, () {
      favoriteInitialSize.sink.add(initialSize);
      favoriteFinalSize.sink.add(finalSize);
      favoriteInitialColor.sink.add(initialColor);
      favoriteFinalColor.sink.add(finalColor);
      heartColor = newHeartColor;
    });
  }

  void favoriteProduct() {
    if (heartColor == Colors.red) {
      updateFavoriteValues(35, 25, Colors.red, Colors.red, Colors.red, const Duration(milliseconds: 125));
      updateFavoriteValues(25, 35, Colors.red, Colors.black, Colors.black, const Duration(milliseconds: 250));
    } else {
      updateFavoriteValues(35, 25, Colors.black, Colors.black, Colors.black, const Duration(milliseconds: 125));
      updateFavoriteValues(25, 35, Colors.black, Colors.red, Colors.red, const Duration(milliseconds: 250));
      updateFavoriteValues(35, 40, Colors.red, Colors.red, Colors.red, const Duration(milliseconds: 375));
      updateFavoriteValues(40, 35, Colors.red, Colors.red, Colors.red, const Duration(milliseconds: 500));
    }
  }

  void favoriteProductMulticolor() {
    if (heartColor == Colors.red) {
      updateFavoriteValues(35, 25, Colors.red, Colors.red, Colors.red, const Duration(milliseconds: 125));
      updateFavoriteValues(25, 35, Colors.red, Colors.black, Colors.black, const Duration(milliseconds: 250));
    } else {
      updateFavoriteValues(35, 25, Colors.black, Colors.green, Colors.green, const Duration(milliseconds: 125));
      updateFavoriteValues(25, 35, Colors.green, Colors.orange, Colors.orange, const Duration(milliseconds: 250));
      updateFavoriteValues(35, 40, Colors.orange, Colors.yellow, Colors.yellow, const Duration(milliseconds: 375));
      updateFavoriteValues(40, 35, Colors.yellow, Colors.red, Colors.red, const Duration(milliseconds: 500));
    }
  }

}