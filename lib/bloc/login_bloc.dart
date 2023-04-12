import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/user.dart';
class LoginBloc {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<UserClass> registeredUsersList = [];

  User user = User();

  goToSignUpPage(context){
    Navigator.pushNamed(context, "/signup");
  }

  goToForgotPasswordPage(context){
    Navigator.pushNamed(context, "/forgot");
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

  }

  updateRegisteredUsers() async {

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsers = prefs.getString(User.keyRegisteredUsers);
    if(registeredUsers != null && registeredUsers != ""){
      registeredUsersList = user.turnStringToList(registeredUsers!);
    }

  }

  deleteSimulatedUsers() async {
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(User.keyRegisteredUsers, "");
    
  }

  validateLogin(){

    String email = emailController.text;
    String password = passwordController.text;

    //Mensagem mostrando que não há usuários cadastrados

    if (email.isEmpty && password.isEmpty) {
      print("Preencha os campos com suas informações");
    } else if (email.isEmpty) {
      print("Preencha o campo com seu email");
    } else if (password.isEmpty) {
      print("Preencha o campo com sua senha");
    } else {
      bool emailExists = false;
      for (var element in registeredUsersList) {
        if (element.email == email) {
          emailExists = true;
          if (element.password == password) {
            //Login validado
            print("Login correto");
          } else {
            //Senha incorreta
            print("Senha incorreta");
          }
          break; // termina a busca pelo usuário
        }
      }
      if (!emailExists) {
        print("Email não encontrado");
        //Email não encontrado no banco de dados
      }
    }
  }

  LoginBloc(){

  }

}