import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/dashboard/cells/covid_test_cell.dart';
import 'package:nephcare_nurse/dashboard/home_page.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/models/covid_test_histroy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CovidTest extends StatefulWidget {
  const CovidTest({Key? key}) : super(key: key);

  @override
  State<CovidTest> createState() => _CovidTestState();
}

class _CovidTestState extends State<CovidTest> {
  List<UserModel> userrequests = [];
  // pagination
  bool isLoading = false;
  bool hasMore = true;
  int cPage = 1;
// load on scroll
  ScrollController scrollController = ScrollController();
  late Future request;
  @override
  void initState() {
    setState(() {
      request = getrequest();
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          // if (isLoading == false && hasMore == true) {
          //   cPage++;
          //   setState(() {
          //     request = getrequest();
          //   });
          // }
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Visibility(
          visible: (cPage == 1)
              ? false
              : (hasMore == false)
                  ? true
                  : isLoading,
          child: Container(
            margin: const EdgeInsets.only(top: 0, bottom: 10.0, left: 0.0),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 3.0),
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
              color: const Color(0xFFFF1A00).withOpacity(0.95),
            ),
            child: Text(
              (hasMore == true) ? 'Loading More ...' : 'No More Available',
              style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Accepted Requests"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: FutureBuilder(
          future: request,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: const Center(child: WaitingCard()));
            } else {
              return ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0, top: 20.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CovidTestCell(
                    userModel: snapshot.data[index],
                    // _onCellTap(doctors[index].id),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<UserModel>> getrequest() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('api_token');
    var apiURL = baseUrl + 'get/covid/request';
    Response sr;
    Dio dio = Dio();
    try {
      setState(() {
        isLoading = true;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userid = prefs.getInt('user_id');

      var formdata = FormData.fromMap({
        'user_id': userid,
        'user_type': "nurse",
      });
      sr = await dio.post(apiURL,
          data: formdata,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));

      setState(() {
        isLoading = false;
      });
      if (sr.data.toString() == '[]') {
        setState(() {
          hasMore = false;
        });
      } else if (hasMore == true) {
        var resp = jsonDecode(jsonEncode(sr.data).toString());

        var res1 = resp['user_requests'];

        // print(res1);

        for (var res in res1) {
          var requestId = res["request_id"] ?? 0;
          var userName = res["user_name"] ?? '';
          var requestStatus = res["request_status"] ?? 'Accepted';
          var testStatus = res["test_status"] ?? 0;
          var userEmail = res["user_Email"] ?? '';
          var userPhone = res["user_Phone"] ?? '';
          var paymentstatus = res['payment_status'] ?? 0;
          UserModel userModel = UserModel(
              requestId: requestId,
              userName: userName,
              requestStatus: requestStatus,
              testStatus: testStatus,
              email: userEmail,
              paymentstatus: paymentstatus,
              phoneno: userPhone);
          userrequests.add(userModel);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      // print(e);
    }

    return userrequests;
  }
}
