import 'package:flutter/material.dart';
import 'package:github_app/helpers/consts.dart';

InputDecoration textDecor(String labelText, String hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
    isDense: true,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutralLight),
      borderRadius: BorderRadius.circular(8.0),
      gapPadding: 2,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: neutralLight),
      borderRadius: BorderRadius.circular(8.0),
      gapPadding: 2,
    ),
    labelText: labelText,
    labelStyle: const TextStyle(color: neutralLight, fontSize: 22),
    hintText: hintText,
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}

Container button(
  Widget child, {
  Color containerColor = neutralDark,
  Color borderColor = neutralDark,
  Color textColor = neutralLight,
  double width = 100,
  double height = 40,
  double fontSize = 20,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Container(
    width: width,
    height: height,
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: containerColor,
      border: Border.all(color: borderColor),
    ),
    child: Center(child: child),
  );
}
