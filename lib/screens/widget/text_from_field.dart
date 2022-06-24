import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.validator,
    required this.textinputaction,
    required this.textinputtype,
    required this.obscure,
    required this.controller,
    required this.hinttext,
    required this.labeltext
  }) : super(key: key);

  final TextInputType textinputtype;
  final bool obscure;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final String labeltext;
  final String hinttext;
  final TextInputAction textinputaction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textinputtype,
      obscureText: obscure ?? false,
      controller: controller,

      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: true,
      textInputAction: textinputaction,
      decoration: InputDecoration(
          //labelText: labeltext,
          labelStyle: TextStyle(color: Colors.green),
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 12),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 30),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 30),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 30),
            borderRadius: BorderRadius.circular(25.0),
          )),
    );
  }
}