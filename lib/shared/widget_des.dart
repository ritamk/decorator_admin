import 'package:decorator_admin/shared/constants.dart';
import 'package:flutter/material.dart';

ButtonStyle authSignInBtnStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(buttonCol),
    foregroundColor: MaterialStateProperty.all(buttonTextCol),
    shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
    alignment: Alignment.center,
  );
}

InputDecoration authTextInputDecoration(
    String label, IconData suffixIcon, String? prefix) {
  return InputDecoration(
    prefixText: prefix ?? "",
    contentPadding: const EdgeInsets.all(20.0),
    fillColor: formFieldCol,
    filled: true,
    prefixIcon: Icon(suffixIcon),
    labelText: label,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: textFieldBorder(),
    focusedBorder: textFieldBorder(),
    errorBorder: textFieldBorder(),
  );
}

OutlineInputBorder textFieldBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(30.0),
  );
}

Widget divider(double height, double width) {
  return Container(
    color: Colors.black12,
    height: height,
    width: width,
  );
}
