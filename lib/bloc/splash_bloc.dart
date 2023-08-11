import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/user.dart';

class SplashBloc{

  User user = User();

  getUserLoggedAndDefineRoute(context) async {
    final prefs = await SharedPreferences.getInstance();
    String userLoggedUsername = prefs.getString(User.userLoggedKey) ?? "";
    if(userLoggedUsername != ""){
      List<UserClass> registeredUsersList = await user.getRegisteredUsersList();
      for(var element in registeredUsersList){
        if(element.username == userLoggedUsername){
          User.loggedUser = element;
        }
      }
      Navigator.pushNamed(context, "/home");
    }else{
      Navigator.pushNamed(context, "/login");
    }
  }

}