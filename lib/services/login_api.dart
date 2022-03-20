import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> loginApi(String email, String password, context) async {
  var apiURL = baseUrl + 'user/login';
  var formData = FormData.fromMap({
    'email': email,
    'password': password,
  });
  Dio dio = Dio();
  Response responce;
  // print(formData);
  try {
    responce = await dio.post(
      apiURL,
      data: formData,
    );
    if (responce.statusCode == 200) {
      if (responce.data['error'] == false) {
        var res1 = responce.data['user'];
        var apitoken = res1['api_token'];
        var id = res1['id'] ?? 0;
        var name = res1['name'] ?? '';
        var email = res1['email'] ?? '';
        var phone = res1['phone'] ?? '';

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('api_token', apitoken);
        prefs.setInt('user_id', id);
        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('phone', phone);
        const CircularProgressIndicator(
          color: Colors.red,
        );
        Navigator.pushReplacementNamed(context, navigationbarroute);
        return '';
      } else if (responce.data['error'] == true) {
        Fluttertoast.showToast(
            msg: "${responce.data["error_data"]}",
            backgroundColor: basicthemecolor);
        return '';
      } else {
        Fluttertoast.showToast(
            msg: "${responce.data["error_data"]}",
            backgroundColor: basicthemecolor);
        return '';
      }
    }
  } catch (e) {
    // print(e);
    Fluttertoast.showToast(
        msg: "bad Internet request", backgroundColor: basicthemecolor);
    return 'bad Internet request';
  }

  return '';
}

Future<String> signupApi(
    String email, String name, String password, context) async {
  var apiURL = baseUrl + 'user/register';
  var formData = FormData.fromMap({
    'email': email,
    'password': password,
    'name': name,
    'type': "2",
    'genre': 2,
    'firebase_token':
        "DIA8DT3Pqxq4dSAShcbQ0ZEEezDaJBmLDhuQDn261GGO2dV0YzqVoK0flYOK",
  });
  Dio dio = Dio();
  Response responce;

  try {
    responce = await dio.post(
      apiURL,
      data: formData,
    );
    if (responce.statusCode == 200) {
      if (responce.data['error'] == false) {
        var res1 = responce.data['user'];
        var apitoken = res1['api_token'];
        var id = res1['id'] ?? 0;
        var name = res1['name'] ?? '';
        var email = res1['email'] ?? '';
        var phone = res1['phone'] ?? '';

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('api_token', apitoken);
        prefs.setInt('user_id', id);
        prefs.setString('name', name);
        prefs.setString('email', email);
        prefs.setString('phone', phone);
        const CircularProgressIndicator(
          color: Colors.red,
        );
        Navigator.pushReplacementNamed(context, navigationbarroute);
        return '';
      } else if (responce.data['error'] == true) {
        Fluttertoast.showToast(
            msg: "${responce.data["error_data"]}",
            backgroundColor: basicthemecolor);
        return '';
      } else {
        Fluttertoast.showToast(
            msg: "${responce.data["error_data"]},",
            backgroundColor: basicthemecolor);
        return '';
      }
    }
  } catch (e) {
    // print(e);
    Fluttertoast.showToast(
        msg: "bad Internet request", backgroundColor: basicthemecolor);
    return 'bad Internet request';
  }

  return '';
}
