import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/helper/colors.dart';

class WithDrawRequests extends StatefulWidget {
  const WithDrawRequests({Key? key}) : super(key: key);

  @override
  State<WithDrawRequests> createState() => _WithDrawRequestsState();
}

class _WithDrawRequestsState extends State<WithDrawRequests> {
  @override
  Widget build(BuildContext context) {
    var a = true;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    color: HexColor('#404B63').withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 12, 0, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment History',
                      style: TextStyle(
                        color: basicthemecolor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 15, 15, 4),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(
                          //   height: 13,
                          // ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        '25\$',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        '24/3/2022',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    a == true ?
                                    CupertinoIcons.check_mark :
                                    CupertinoIcons.question,
                                    size: 30,
                                    color: a == true ? Colors.green: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
