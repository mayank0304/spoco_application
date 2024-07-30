import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final dynamic initVal;
  final dynamic onSav;
  final dynamic hint;
  final Icon icon;

  const MyTextFormField({super.key, this.initVal, required this.onSav, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initVal,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: Colors.white,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white
          ),
          labelStyle: const TextStyle(
              color: Colors.white,
              // fontWeight: FontWeight.bold
              ),
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(Radius.circular(16))),
              filled: true,
              fillColor: const Color(0xFF1A3636)
),
        onSaved: onSav
    );
  }
}