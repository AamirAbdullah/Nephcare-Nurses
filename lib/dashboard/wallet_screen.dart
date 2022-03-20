import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nephcare_nurse/dashboard/cells/withdraw_requests.dart';
import 'package:nephcare_nurse/dashboard/home_page.dart';
import 'package:nephcare_nurse/dashboard/widhdraw_money.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/models/payment_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

int? balance;
var loading = false;
var a = true;

class _MyWalletState extends State<MyWallet> {
  List<PaymentHisModel> moneyhistory = [];
  late Future requestList;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    walletFunction().then((value) => {setState(() {
      loading = false;
    })});
    setState(() {
      requestList = widrawmoneyhistoryapi();
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
    return Scaffold(
      body: loading == true ? Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.13,
              decoration: BoxDecoration(
                color: basicthemecolor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                border: Border.all(color: basicthemecolor),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    color: HexColor('#404B63').withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: 50,
                      child: const Icon(
                        CupertinoIcons.chevron_back,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    width: 50,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Balance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // balance == null ?
                        // '\$ 0.0' : '\$ '+
                        balance.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        ' USD',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Recharge your wallet by adding amount through card",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please add one.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      border: Border.all(color: basicthemecolor),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WidthDrawMoney(balance: balance)),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.creditcard,
                            size: 16,
                            color: basicthemecolor,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Widhdraw',
                            style: TextStyle(
                              color: basicthemecolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Payment History',
                    style: TextStyle(
                      color: basicthemecolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   child: ListView.builder(
                  //       itemCount: moneyhistory.length,
                  //       itemBuilder: (BuildContext context, int index) =>
                  //           money_history_card(
                  //             hostime: moneyhistory[index],
                  //           )),
                  // ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 0.0),
              child: FutureBuilder(
                future: requestList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: const Center(child: WaitingCard()));
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MoneyHistory(
                          homeIndex: snapshot.data[index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> walletFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('api_token');
    // print(token);

    const apiURL = baseUrl + 'get/wallet';
    Response response;
    Dio dio = Dio();
    try {
      response = await dio.post(apiURL,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.data.toString() == '') {
        setState(() {});
      }
      // var resp = jsonDecode(jsonEncode(response.data).toString());

      // print('resp');
      // print(resp);
      if (response.data['error'] == false) {
        var res1 = response.data['user'];
        balance = res1['balance'] ?? 0;
        // print(balance);
        setState(() {
          balance = balance;
        });
      }
    } catch (e) {
      setState(() {});
      // print(e);
    }
    return balance.toString();
  }

  // Api Money History
  Future<List<PaymentHisModel>> widrawmoneyhistoryapi({context}) async {
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
      print(responce.data);
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

          return moneyhistory;
        } else if (responce.data['success'] == false) {
          res1 = responce.data['error_message'];
          Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
          Navigator.pop(context, false);
        } else {
          Fluttertoast.showToast(msg: res1, backgroundColor: basicthemecolor);
          Navigator.pop(context, false);
        }
      }
    } catch (e) {
      // print(e);
      Fluttertoast.showToast(
          msg: "some thing wrong", backgroundColor: basicthemecolor);
    }

    return moneyhistory;
  }
}
