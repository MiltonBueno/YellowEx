import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yellow_exchange/pages/forgot_password2.dart';

import '../classes/user.dart';

class ForgotPasswordBloc {

  BehaviorSubject<String> errorMessage = BehaviorSubject();
  BehaviorSubject<bool> errorEmail = BehaviorSubject();
  BehaviorSubject<bool> loadingReset = BehaviorSubject();
  BehaviorSubject<bool> loadingReset2 = BehaviorSubject();
  BehaviorSubject<bool> passwordObscure = BehaviorSubject();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<UserClass> registeredUsersList = [];

  User user = User();

  resetPassword(context) async {

    loadingReset.sink.add(true);

    errorEmail.sink.add(false);
    errorMessage.sink.add("");

    String email = emailController.text;

    if(email.isEmpty){
      errorEmail.sink.add(true);
      errorMessage.sink.add("Fill in the field with your email");
    }else if(!email.contains("@")){
      errorEmail.sink.add(true);
      errorMessage.sink.add("The email entered is invalid");
    }else{
      bool emailExists = false;
      for (var element in registeredUsersList) {
        if (element.email == email) {
          emailExists = true;
          break;
        }
      }
      if (emailExists) {

        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ForgotPassword2(email: email))
        );

      }else{
        errorEmail.sink.add(true);
        errorMessage.sink.add("The email was not found in the database");
      }
    }
    loadingReset.sink.add(false);
  }

  defineNewPassword(String selectedEmail){

  }

  getCurrentUsersList() async {

    print("12");
    registeredUsersList = await user.getRegisteredUsersList();

  }

  ForgotPasswordBloc(){
    getCurrentUsersList();
  }

}