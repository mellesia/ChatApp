import 'package:flutter/material.dart';

class CustomeFormTextField extends StatelessWidget {
  CustomeFormTextField(
      {this.onChanged, this.hintText, this.obscureText = false});

  Function(String)? onChanged;
  String? hintText;

  //3a4an a5li el password maykon4 bayn
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required ';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        //focusedBorder
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
