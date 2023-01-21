import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration loginInputDecoration (
    {required String hintText,
    required String labelText,
    IconData? prefixIcon}
  ){
    return  InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color:Colors.deepPurple),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple,width: 2),
                ),
                hintText: hintText,
                labelText: labelText,
                labelStyle: TextStyle(color:Colors.grey),
                 prefixIcon: prefixIcon != null 
                 ? Icon( prefixIcon, color: Colors.deepPurple )
                 : null
              );
  }
}