import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/models/payment_history_model.dart';

class MoneyHistory extends StatefulWidget {
final PaymentHisModel homeIndex;
  const MoneyHistory({Key? key, required this.homeIndex}) : super(key: key);

  @override
  State<MoneyHistory> createState() => _MoneyHistoryState();
}

class _MoneyHistoryState extends State<MoneyHistory> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      elevation: 4,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.grey,
      child: Container(
    padding: const EdgeInsets.only(
        left: 12, bottom: 10, top: 5, right: 12),
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 15, 15, 4),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amount: \$'+
                                widget.homeIndex.amount.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.homeIndex.time.toString().substring(0,10),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        widget.homeIndex.paymentstatus == 0
                            ? CupertinoIcons.check_mark
                            : CupertinoIcons.question,
                        size: 30,
                        color: widget.homeIndex.paymentstatus == 0
                            ? Colors.green
                            : Colors.red,
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
    );

  }
}
