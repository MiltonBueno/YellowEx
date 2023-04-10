import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/user.dart';
class LoginBloc {

  List<UserClass> registeredUsersList = [];

  goToSignUpPage(context){
    Navigator.pushNamed(context, "/signup");
  }

  goToForgotPasswordPage(context){
    Navigator.pushNamed(context, "/forgot");
  }

  checkAndCreateSimulatedUser(context) async {

    User user = User();

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
                    onPressed:  () {

                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    //Se desejar

    // await user.addSimulatedUsers();
    //
    // final prefs = await SharedPreferences.getInstance();
    // String? registeredUsers = prefs.getString(User.keyRegisteredUsers);
    // if(registeredUsers != null && registeredUsers != ""){
    //   registeredUsersList = user.turnStringToList(registeredUsers!);
    // }

  }

  validateLogin(String insertedEmail, String insertedPassword){

    for(var element in registeredUsersList){
      bool emailExists = false;
      if(element.email == insertedEmail){
        emailExists = true;
        if(element.password == insertedPassword){
          //Login validado
        }else{
          //Senha incorreta
        }
      }
      if(!emailExists){
        //Email não encontrado no banco de dados
      }
    }

  }

  LoginBloc(){

  }

}