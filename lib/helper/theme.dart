import 'package:flutter/material.dart';
import 'package:nephcare_nurse/helper/colors.dart';

InputDecoration inputField1(
    {required String label1,
    BuildContext? context,
    Widget? suffixIcon,
    Widget? prefixicon}) {
  return InputDecoration(
    alignLabelWithHint: true,
    contentPadding: const EdgeInsets.fromLTRB(10, 18, 10, 18),
    errorStyle: const TextStyle(),
    prefixIcon: prefixicon,
    suffixIcon: suffixIcon,
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: basicthemecolor,
        )),
    errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: basicthemecolor,
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: basicthemecolor,
        )),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: basicthemecolor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15.0))),
    fillColor: Colors.white,
    filled: true,
    labelStyle: TextStyle(
      color: HexColor('#bbb'),
      height: 1,
    ),
    label: Text(
      label1,
      style: TextStyle(
        color: basicthemecolor,
      ),
    ),
  );
}

final containerBorder = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        offset: const Offset(0, 3),
        color: HexColor('#404B63').withOpacity(0.1),
        blurRadius: 10,
      ),
    ]);

// For email Validation
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

const String baseUrl = 'http://192.168.18.62/nephcare/public/api/';
// const String baseUrl = 'https://nbrarts.com/nephcare/public/api/';
// const String baseUrl = 'https://secureneph.com/public/api/';

//DropDown button theme
InputDecoration dropdowndecoration() {
  return InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20, 16, 15, 16),
    errorStyle: const TextStyle(),
    errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: HexColor('#D5D5D5'),
        )),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: HexColor('#D5D5D5'),
        )),
    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(
          color: HexColor('#D5D5D5'),
        )),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: HexColor('#D5D5D5'),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15.0))),
    fillColor: HexColor('#ffffff'),
    filled: true,
  );
}
