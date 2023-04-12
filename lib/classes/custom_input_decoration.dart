import 'package:flutter/material.dart';

InputDecoration buildCustomInputDecoration(String labelText, String hintText) {
  return InputDecoration(
    // icon: Icon(Icons.email),
    disabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xff1a2a28), width: 1.5),
    ),
    labelText: labelText,
    labelStyle: const TextStyle(
      color: Color(0xff1a2a28),
      fontWeight: FontWeight.bold,
    ),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
  );
}