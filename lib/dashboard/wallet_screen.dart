import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/dashboard/widhdraw_money.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

int? balance;

class _MyWalletState extends State<MyWallet> {
  @override
  void initState() {
    walletFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              ],
            ),
          )
        ],
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
}
