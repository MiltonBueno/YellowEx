import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/user.dart';

class SignUpBloc {

  BehaviorSubject<String> errorMessage = BehaviorSubject();
  BehaviorSubject<bool> errorName = BehaviorSubject();
  BehaviorSubject<bool> errorEmail = BehaviorSubject();
  BehaviorSubject<bool> errorUsername = BehaviorSubject();
  BehaviorSubject<bool> errorPassword = BehaviorSubject();
  BehaviorSubject<bool> loadingSignUp = BehaviorSubject();
  BehaviorSubject<bool> passwordObscure = BehaviorSubject();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<UserClass> registeredUsersList = [];

  User user = User();

  addNewUser() async {

    loadingSignUp.sink.add(true);

    String name = nameController.text;
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    errorName.sink.add(false);
    errorEmail.sink.add(false);
    errorUsername.sink.add(false);
    errorPassword.sink.add(false);
    errorMessage.sink.add("");

    if(name.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty){
      if (name.isEmpty) {
        errorName.sink.add(true);
        errorMessage.sink.add("Fill in the fields with your information");
      }
      if (email.isEmpty) {
        errorEmail.sink.add(true);
        errorMessage.sink.add("Fill in the fields with your information");
      }
      if (username.isEmpty) {
        errorUsername.sink.add(true);
        errorMessage.sink.add("Fill in the fields with your information");
      }
      if (password.isEmpty) {
        errorPassword.sink.add(true);
        errorMessage.sink.add("Fill in the fields with your information");
      }
    }else if (!email.contains("@")){
      errorEmail.sink.add(true);
      errorMessage.sink.add("The email entered is invalid");
    }else if (password.contains(" ")){
      errorPassword.sink.add(true);
      errorMessage.sink.add("The password cannot contain whitespace characters");
    }else{
      bool emailExists = false;
      bool usernameExists = false;
      for (var element in registeredUsersList) {
        if (element.email == email) {
          errorEmail.sink.add(true);
          errorMessage.sink.add("There is already a user registered with that email");
          emailExists = true;
          break;
        }else if(element.username == username){
          errorUsername.sink.add(true);
          errorMessage.sink.add("There is already a user registered with that username");
          usernameExists = true;
          break;
        }
      }
      if (!emailExists && !usernameExists) {

        //Logic to add a new user

        final prefs = await SharedPreferences.getInstance();
        String? registeredUsers = prefs.getString(User.keyRegisteredUsers);
        if(registeredUsers != null && registeredUsers != ""){
          registeredUsersList = user.turnStringToList(registeredUsers);
        }

        registeredUsersList.add(UserClass(usernameController.text, emailController.text, usernameController.text, passwordController.text),);

        String usersString = user.turnListToString(registeredUsersList);

        await prefs.setString(User.keyRegisteredUsers, usersString);

        if (kDebugMode) {
          print("Cadastro realizado");
        } //Direcionar para tela login ou para tela home
        // com mensagem de boas vindas para novo usuário

      }
    }

    loadingSignUp.sink.add(false);

  }

  getCurrentUsersList() async {

    registeredUsersList = await user.getRegisteredUsersList();

  }

  SignUpBloc(){
    getCurrentUsersList();
  }

}