import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

Future<String> updateProfileApi(
    String name, String email, String phone, var _image, context) async {
  // print('Enter in function');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('api_token');
  //
  // print(token);
  var filename = _image.path.split('/').last;
  // print('file name');
  // print(filename);
  var apiURL = baseUrl + 'nurse/update';
  var formData = FormData.fromMap({
    'name': name,
    'email': email,
    'phone': phone,
    'image': await MultipartFile.fromFile(_image.path,
        filename: filename, contentType: MediaType('image', 'png'))
  });
  Dio dio = Dio();
  Response responce;
  // print(formData);
  try {
    // print('Enter in try');
    responce = await dio.post(
      apiURL,
      options: Options(headers: {"Authorization": "Bearer $token"}),
      data: formData,
    );
    // print('Enter in 200');
    if (responce.data['error'] == false) {
      // var res1 = responce.data['user'];
      // print(res1);
      Fluttertoast.showToast(
          msg: "Updated Successfully", backgroundColor: basicthemecolor);
      Navigator.pushReplacementNamed(context, navigationbarroute);
    }
  } catch (e) {
    // print(e);
    Fluttertoast.showToast(
        msg: "some thing went wrong", backgroundColor: basicthemecolor);
    return 'some thing wrong';
  }
  return '';
}
