import 'package:flutter/material.dart';

class LoginBloc {

  goToSignUpPage(context){
    Navigator.pushNamed(context, "/signup");
  }

  goToForgotPasswordPage(context){
    Navigator.pushNamed(context, "/forgot");
  }

}