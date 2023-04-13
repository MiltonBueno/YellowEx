import 'package:flutter/material.dart';

Color errorColor = Colors.red;

InputDecoration buildCustomInputDecoration(String labelText, String hintText, bool error) {
  return InputDecoration(
    // icon: Icon(Icons.email),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color:
      error ? errorColor : const Color(0xff1a2a28),
          width: 1.5),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color:
      error ? errorColor : const Color(0xff1a2a28),
          width: 1.5),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color:
      error ? errorColor : const Color(0xff1a2a28),
          width: 1.5),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color:
      error ? errorColor : const Color(0xff1a2a28),
          width: 1.5),
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: error ? errorColor : const Color(0xff1a2a28),
      fontWeight: FontWeight.bold,
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
  );
}