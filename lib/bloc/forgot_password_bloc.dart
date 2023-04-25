import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yellow_exchange/pages/forgot_password2.dart';

import '../classes/user.dart';

class ForgotPasswordBloc {

  BehaviorSubject<String> errorMessage = BehaviorSubject();
  BehaviorSubject<String> errorMessage2 = BehaviorSubject();
  BehaviorSubject<bool> errorEmail = BehaviorSubject();
  BehaviorSubject<bool> errorPassword = BehaviorSubject();
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

  defineNewPassword(String selectedEmail, context) async {

    loadingReset2.sink.add(true);

    errorPassword.sink.add(false);
    errorMessage2.sink.add("");

    String password = passwordController.text;

    if(password.isNotEmpty){
      if(!password.contains(" ")){
        for (var element in registeredUsersList) {
          if (element.email == selectedEmail) {
            if(element.password != password){

              element.password = password;

              String usersString = user.turnListToString(registeredUsersList);

              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(User.keyRegisteredUsers, usersString);

              Navigator.pop(context);
              Navigator.pop(context);

              showDialog(context: context, builder: (_){
                return const AlertDialog(
                  title: Text("New password set"),
                  content: Text("Your password has been successfully changed"),
                );
              });
              
            }else{
              errorPassword.sink.add(true);
              errorMessage2.sink.add("The new password cannot be the same as the previous one");
            }
            break;
          }
        }
      }else{
        errorPassword.sink.add(true);
        errorMessage2.sink.add("The password cannot contain whitespace characters");
      }
    }else{
      errorPassword.sink.add(true);
      errorMessage2.sink.add("Fill in the field with your new password");
    }

    loadingReset2.sink.add(false);

  }

  getCurrentUsersList() async {

    registeredUsersList = await user.getRegisteredUsersList();

  }

  ForgotPasswordBloc(){
    getCurrentUsersList();
  }

}