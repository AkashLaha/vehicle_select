import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller; //A controller for an editable text field.Whenever the user modifies a text field with an associated TextEditingController, the text field updates value and the controller notifies its listeners.
  final String hintText;
  final bool
      obscureText; //for password not to show characters only dot will show

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey)),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
