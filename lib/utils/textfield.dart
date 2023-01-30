import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.textInputType,
      required this.iconData,
      required this.obscureText})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final IconData iconData;
  final bool obscureText;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: TextFormField(
        validator: (value) {
          return null;
        },
        onSaved: (newValue) {},
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        cursorColor: Colors.teal,
      
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(
              color: Colors.teal.shade200, fontWeight: FontWeight.w400),
          labelStyle:
              const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
          icon: Icon(
            iconData,
            color: Colors.teal,
          ),
        ),
      ),
    );
  }
}
