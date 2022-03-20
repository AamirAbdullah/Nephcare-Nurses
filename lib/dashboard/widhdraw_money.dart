// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/models/payment_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidthDrawMoney extends StatefulWidget {
  final int? balance;
  const WidthDrawMoney({Key? key, required this.balance}) : super(key: key);

  @override
  State<WidthDrawMoney> createState() => _WidthDrawMoneyState();
}

class _WidthDrawMoneyState extends State<WidthDrawMoney> {
  String bankdetail = '';
  String money = '';
  String error = '';
  final formKey = GlobalKey<FormState>();
  List<PaymentHisModel> moneyhistory = [];
  int? bal;
  var loading;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    widrawmoneyhistoryapi().then((value) => {
          setState(() {
            loading = false;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Request Covid Test"),
        centerTitle: true,
        backgroundColor: basicthemecolor,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.chevron_back),
          color: Colors.white,
        ),
      ),
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: containerBorder,
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              textAlignVertical: TextAlignVertical.bottom,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: inputField1(
                                label1: 'Amount',
                                context: context,
                                prefixicon: Icon(
                                  CupertinoIcons.money_dollar,
                                  color: basicthemecolor,
                                  size: 22,
                                ),
                              ),
                              validator: (val) => val!.isEmpty
                                  ? 'please enter valid amount'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  money = val;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              maxLines: 8,
                              keyboardType: TextInputType.streetAddress,
                              textAlignVertical: TextAlignVertical.bottom,
                              textInputAction: TextInputAction.next,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              decoration: inputField1(
                                label1: 'Complte Bank Detail',
                                context: context,
                              ),
                              validator: (val) => val!.length < 15
                                  ? 'please give correct detail'
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  bankdetail = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(15),
                    width: size.width,
                    height: 46,
                    child: ElevatedButton(
                      child: Text(
                        "Widhdraw Your Money".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: basicthemecolor),
                      onPressed: () {
                        {
                          if (formKey.currentState!.validate()) {
                            if (widget.balance! <= int.parse(money)) {
                              Fluttertoast.showToast(
                                msg: 'Your Wallet Amount is less than amount ' +
                                    widget.balance.toString(),
                                backgroundColor: basicthemecolor,
                                gravity: ToastGravity.BOTTOM,
                              );
                            } else {
                              widrawmoneyapi(
                                  bankdetail: bankdetail,
                                  money: money,
                                  context: context);
                            }
                          }
                        }
                      },
                    )),
              ],
            ),
    );
  }

  Future<String> widrawmoneyapi(
      {required String bankdetail, required String money, context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var token = prefs.getString('api_token');

    //
    var apiURL = baseUrl + 'withdraw/request';
    var formData = FormData.fromMap({
      'user_id': userId,
      'amount': int.parse(money),
      'details': bankdetail,
    });

    Dio dio = Dio();
    Response responce;
    // print(formData);
    try {
      responce = await dio.post(
        apiURL,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: formData,
      );
      // print(responce.data);
      if (responce.statusCode == 200) {
        var res1;
        if (responce.data['success'] == true) {
          res1 = responce.data['success_message'];
          // print(res1);
          Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
          Navigator.pop(context, false);
          return 'success';
        } else if (responce.data['success'] == false) {
          res1 = responce.data['error_message'];
          Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
          Navigator.pop(context, false);
          return 'failure';
        } else {
          Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
          Navigator.pop(context, false);
          return 'failure';
        }
      }
    } catch (e) {
      // print(e);
      Fluttertoast.showToast(
          msg: "some thing wrong", backgroundColor: basicthemecolor);
      return 'failure';
    }

    return '';
  }

  // Api Money History
  Future<String> widrawmoneyhistoryapi({context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt('user_id');
    var token = prefs.getString('api_token');

    //
    var apiURL = baseUrl + 'withdraw/request/all';
    var formData = FormData.fromMap({
      'user_id': userId,
    });
    // print('ddddddddddddddddddddddddddd');
    Dio dio = Dio();
    Response responce;

    try {
      responce = await dio.post(
        apiURL,
        options: Options(headers: {"Authorization": "Bearer $token"}),
        data: formData,
      );
      // print(responce.data);
      if (responce.statusCode == 200) {
        var res1;
        if (responce.data['success'] == true) {
          res1 = responce.data['withdraw_requests'];
          for (var res in res1) {
            var id = res["id"] ?? 0;
            var amount = res["amount"] ?? 0;
            var paymentstatus = res["payment_status"] ?? 0;
            var updatedat = res["updated_at"] ?? '';
            PaymentHisModel paymentHisModel = PaymentHisModel(
              id: id,
              amount: amount,
              paymentstatus: paymentstatus,
              time: updatedat,
            );
            moneyhistory.add(paymentHisModel);
          }

          return 'success';
        } else if (responce.data['success'] == false) {
          res1 = responce.data['error_message'];
          Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
          Navigator.pop(context, false);
          return 'failure';
        } else {
          Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
          Navigator.pop(context, false);
          return 'failure';
        }
      }
    } catch (e) {
      // print(e);
      Fluttertoast.showToast(
          msg: "some thing wrong", backgroundColor: basicthemecolor);
      return 'failure';
    }

    return '';
  }
}
