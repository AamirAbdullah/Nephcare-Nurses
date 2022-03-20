import 'package:flutter/material.dart';
import 'package:nephcare_nurse/models/request_model.dart';

class HomeCell extends StatefulWidget {
  final RequestModel requestModel;
  final Function onTap;
  const HomeCell({Key? key, required this.requestModel, required this.onTap})
      : super(key: key);

  @override
  State<HomeCell> createState() => _HomeCellState();
}

class _HomeCellState extends State<HomeCell> {
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
                  widget.requestModel.id.toString(),
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
                  widget.requestModel.username,
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
                  "email : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  widget.requestModel.email,
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
                  "Phone No : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  widget.requestModel.phoneno.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Adress : ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Flex(
                    textDirection: TextDirection.rtl,
                    direction: Axis.horizontal,
                    children: const [
                      Expanded(
                        child: Text(
                          'On your device, find your fav area',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
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
                  ElevatedButton(
                      onPressed: () => widget.onTap(),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: const Text("Accept")),
                  const SizedBox(
                    width: 10,
                  ),
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
