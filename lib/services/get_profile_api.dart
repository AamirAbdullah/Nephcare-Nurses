// ignore_for_file: library_prefixes

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nephcare_nurse/dashboard/edit_profile.dart';
import 'package:nephcare_nurse/dashboard/profile_page.dart' as ProfilePage;

import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/models/userprofilemodal.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getprofileFunction() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userid = prefs.getInt('user_id');
  //
  // print(userid);
  var formData = FormData.fromMap({
    'user_id': userid,
  });

  const apiURL = baseUrl + 'get/profile';
  Response response;
  Dio dio = Dio();
  try {
    response = await dio.post(
      apiURL,
      data: formData,
    );
    if (response.data.toString() == '') {
      // setState(() {
      //   loading = false;
      // });
    }
    // print('resp');
    if (response.data['error'] == false) {
      // print('Enter in 200');
      var res1 = response.data['user'];
      // print(res1);
      UserProfileModal userdata = UserProfileModal(
        name: res1['name'] ?? '',
        email: res1['email'] ?? '',
        phone: res1['phone'] ?? '',
        image: res1['image'] ?? '',
      );
      ProfilePage.userProfileModal = userdata;
      userProfileModal = userdata;
      // Fluttertoast.showToast(
      //     msg: 'Profile Get', backgroundColor: basicthemecolor);
    }
    if (response.data['error'] == true) {
      Fluttertoast.showToast(
          msg: 'Fail To Get Profile', backgroundColor: basicthemecolor);
    }
  } catch (e) {
    // print(e);
    Fluttertoast.showToast(
        msg: 'Something Wrong', backgroundColor: basicthemecolor);
  }
  return '';
}
