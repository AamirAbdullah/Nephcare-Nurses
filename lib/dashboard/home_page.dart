import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nephcare_nurse/dashboard/cells/home_cell.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/models/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RequestModel> requests = [];
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
          title: const Text("Covid Requests"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 0.0),
          child: FutureBuilder(
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
                    return HomeCell(
                      requestModel: snapshot.data[index],
                      onTap: () => acceptedrequestApi(
                          id: snapshot.data[index].id, context: context),
                      // _onCellTap(doctors[index].id),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<RequestModel>> getrequest() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('api_token');
    var apiURL = baseUrl + 'get/covid/request';
    Response sr;
    Dio dio = Dio();
    try {
      setState(() {
        isLoading = true;
      });
      sr = await dio.post(apiURL,
          options: Options(headers: {"Authorization": "Bearer $token"}));
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

        for (var res in res1) {
          var id = res['Request'] ?? 0;
          var name = res['User_name'] ?? '';
          var email = res['User_Email'] ?? '';
          var phone = res['User_Phone'] ?? '';
          RequestModel requestModel = RequestModel(
            id: id,
            username: name,
            email: email,
            phoneno: phone,
          );

          requests.add(requestModel);
          // print(email);
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // print(e);
    }

    return requests;
  }

  Future<String> acceptedrequestApi({required int id, context}) async {
    var apiURL = baseUrl + 'accept/covid/request';
    final prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('user_id');
    var token = prefs.getString('api_token');
    var id1 = id;

    var formData = FormData.fromMap({
      'request_id': id1,
      'user_id': userid,
    });
    Dio dio = Dio();
    Response responce;
    // print(formData);
    try {
      responce = await dio.post(apiURL,
          data: formData,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (responce.statusCode == 200) {
        if (responce.data['success'] == true) {
          Fluttertoast.showToast(msg: "Request Accepted");
          setState(() {
            requests.removeWhere((_request) => _request.id == _request.id);
            request = getrequest();
          });
        } else if (responce.data['error'] == true) {
          Fluttertoast.showToast(msg: "Some Thing Went Wrong");
          return '';
        } else {
          Fluttertoast.showToast(msg: "${responce.data["error_data"]}");
          return '';
        }
      }
    } catch (e) {
      // print(e);
      Fluttertoast.showToast(msg: "bad Internet request");
      return 'bad Internet request';
    }

    return '';
  }
}

class WaitingCard extends StatelessWidget {
  const WaitingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: const Text('Please Wait...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500))),
      ],
    );
  }
}
