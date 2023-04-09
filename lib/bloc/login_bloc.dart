import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/user.dart';
class LoginBloc {

  late User user;

  List<User> registeredUsersList = [];

  goToSignUpPage(context){
    Navigator.pushNamed(context, "/signup");
  }

  goToForgotPasswordPage(context){
    Navigator.pushNamed(context, "/forgot");
  }

  checkAndCreateSimulatedUser() async {

    bool thereAre = await user.checkIfThereAreRegisteredUsers();

    if(!thereAre){
      await user.addSimulatedUsers();
    }

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsers = prefs.getString(User.keyRegisteredUsers);
    if(registeredUsers != null && registeredUsers != ""){
      registeredUsersList = user.turnStringToList(registeredUsers!) as List<User>;
    }


  }

  LoginBloc(){

  }

}