import 'package:coffee_store_app/const.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget{
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final FocusNode? focusNode;

  const MyTextField({
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.focusNode,
  });

  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: backgroundColor,
          filled: true,
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.brown)
        ),
      ),
    );
  }
}