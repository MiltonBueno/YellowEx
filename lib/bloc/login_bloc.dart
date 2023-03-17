import 'package:flutter/material.dart';

class LoginBloc {

  goToSignUpPage(context){
    Navigator.pushNamed(context, "/signup");
  }

}