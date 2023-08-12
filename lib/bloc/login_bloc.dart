import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/user.dart';

class LoginBloc {

  BehaviorSubject<String> errorMessage = BehaviorSubject();
  BehaviorSubject<bool> errorEmail = BehaviorSubject();
  BehaviorSubject<bool> errorPassword = BehaviorSubject();
  BehaviorSubject<bool> loadingLogin = BehaviorSubject();
  BehaviorSubject<bool> passwordObscure = BehaviorSubject();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<UserClass> registeredUsersList = [];

  User user = User();

  initialPageState(){
    errorEmail.sink.add(false);
    errorPassword.sink.add(false);
    errorMessage.sink.add("");
    emailController.clear();
    passwordController.clear();
  }

  goToSignUpPage(context){
    Navigator.pushNamed(context, "/signup");
    initialPageState();
  }

  goToForgotPasswordPage(context){
    Navigator.pushNamed(context, "/forgot");
    initialPageState();
  }

  checkRegisteredUsers(context) async {

    bool thereAre = await user.checkIfThereAreRegisteredUsers();

    //Mostrar mensagem falando que não há nenhum usuário adicionado e
    // perguntando se deseja adicionar usuarios simulados
    if(!thereAre){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Create simulated users"),
            content: const Text("There are no registered users in your database. "
                "Would you like to create simulated users or initialize the database with none?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Initialize with none"),
                    onPressed:  () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text("Simulate users"),
                    onPressed:  () async {

                      createSimulatedUsers();
                      Navigator.pop(context);

                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }else{

      await updateRegisteredUsers();

    }

  }

  createSimulatedUsers() async {

    await user.addSimulatedUsers();
    await updateRegisteredUsers();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(User.createdSimulatedUsers, "true");

  }

  updateRegisteredUsers() async {

    registeredUsersList = await user.getRegisteredUsersList();

  }

  deleteSimulatedUsers() async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(User.keyRegisteredUsers, "");
    
  }

  validateLogin(context) async {

    loadingLogin.sink.add(true);

    String email = emailController.text;
    String password = passwordController.text;

    if(registeredUsersList.isNotEmpty){
      if (email.isEmpty && password.isEmpty) {
        errorEmail.sink.add(true);
        errorPassword.sink.add(true);
        errorMessage.sink.add("Fill in the fields with your information");
      } else if (email.isEmpty) {
        errorPassword.sink.add(false);
        errorEmail.sink.add(true);
        errorMessage.sink.add("Fill in the field with your email");
      } else if (password.isEmpty) {
        errorEmail.sink.add(false);
        errorPassword.sink.add(true);
        errorMessage.sink.add("Fill in the field with your password");
      } else {
        bool emailExists = false;
        for (var element in registeredUsersList) {
          if (element.email == email) {
            emailExists = true;
            if (element.password == password) {

              //definir usuario logado
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(User.userLoggedKey, element.username);
              User.loggedUser = element;

              if (kDebugMode) {
                print("Login correto");
              }
              Navigator.pushReplacementNamed(context, "/home");
              errorEmail.sink.add(false);
              errorPassword.sink.add(false);
              errorMessage.sink.add("");

            } else {
              errorEmail.sink.add(false);
              errorPassword.sink.add(true);
              errorMessage.sink.add("Incorrect password");
            }
            break;
          }
        }
        if (!emailExists) {
          errorPassword.sink.add(false);
          errorEmail.sink.add(true);
          errorMessage.sink.add("Email not found");
        }
      }
    }else{
      errorMessage.sink.add("There are no registered users in the database");
    }

    loadingLogin.sink.add(false);

  }

  LoginBloc(){
    errorEmail.sink.add(false);
    errorPassword.sink.add(false);
    errorMessage.sink.add("");
    emailController.clear();
    passwordController.clear();
  }

}