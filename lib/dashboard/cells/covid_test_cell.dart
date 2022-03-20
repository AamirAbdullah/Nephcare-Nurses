import 'package:flutter/material.dart';
import 'package:nephcare_nurse/dashboard/covid_test_report.dart';
import 'package:nephcare_nurse/models/covid_test_histroy.dart';

class CovidTestCell extends StatefulWidget {
  final UserModel userModel;
  const CovidTestCell({Key? key, required this.userModel}) : super(key: key);

  @override
  State<CovidTestCell> createState() => _CovidTestCellState();
}

class _CovidTestCellState extends State<CovidTestCell> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.grey,
      child: Container(
        padding: const EdgeInsets.only(left: 12, bottom: 10, top: 5, right: 12),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  // "userimg",
                  "assets/img/logo.png",
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Request Id :',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.userModel.requestId.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "User Name : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  widget.userModel.userName,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  widget.userModel.email,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Payment Status : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  widget.userModel.paymentstatus == 0 ? 'pending' : 'done',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Test Result : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  widget.userModel.testStatus == 0
                      ? "Pending"
                      : widget.userModel.testStatus == 1
                          ? "Positive"
                          : "Negative",
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.userModel.testStatus == 0
                        ? Colors.orange
                        : widget.userModel.testStatus == 1
                            ? Colors.red
                            : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Phone No : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  widget.userModel.phoneno.toString() == ''
                      ? 'null'
                      : widget.userModel.phoneno.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.userModel.testStatus == 0
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CovidResult(userModel: widget.userModel),
                                ));
                          },
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          child: const Text("Add Result"))
                      : Container(),
                ],
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
