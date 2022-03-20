// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:nephcare_nurse/helper/colors.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nephcare_nurse/helper/image_file_piker.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/models/covid_test_histroy.dart';

class CovidResult extends StatefulWidget {
  final UserModel userModel;
  const CovidResult({Key? key, required this.userModel}) : super(key: key);

  @override
  State<CovidResult> createState() => _CovidResultState();
}

class _CovidResultState extends State<CovidResult> {
  int? status;
  FilePickerResult? _image;
  final _formKey = GlobalKey<FormState>();
  List<String> cities = ['Positive', 'Negative'];
  String? resulttxt;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Request Result"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
                alignment: Alignment.center,
                decoration: containerBorder,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Select Test Result',
                      style: TextStyle(
                          color: basicthemecolor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      alignment: AlignmentDirectional.bottomCenter,
                      menuMaxHeight: MediaQuery.of(context).size.height * 0.45,
                      isExpanded: true,
                      hint: const Text('Choose Result'),
                      decoration: dropdowndecoration(),
                      value: resulttxt,
                      validator: (value) => value == null
                          ? 'Please Select Test Report First'
                          : null,
                      onChanged: (String? value) {
                        setState(() {
                          resulttxt = value;
                        });
                      },
                      items: cities
                          .map((resultItem) => DropdownMenuItem(
                              value: resultItem, child: Text(resultItem)))
                          .toList(),
                      icon: const Icon(Icons.arrow_downward_rounded),
                      iconSize: 22,
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                width: MediaQuery.of(context).size.width,
                decoration: containerBorder,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' Select Test Result (optional) :',
                      style: TextStyle(
                          color: basicthemecolor, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // final result = await FilePicker.platform.pickFiles();
                        // if (result == null) {
                        //   return;
                        // }
                        // final file = result.files.first;
                        // Fluttertoast.showToast(
                        //     msg: "File Uploaded",
                        //     backgroundColor: basicthemecolor);
                        // setState(() {
                        //   _image = file;
                        // });
                        // openFile(file);

                        final file = await FilePickerHelper().getPDF();
                        if (file != null) {
                          Fluttertoast.showToast(
                              msg: "File Uploaded",
                              backgroundColor: basicthemecolor);
                          setState(() {
                            _image = file;
                          });
                        }
                      },
                      child: Center(
                        child: SizedBox(
                          height: 150,
                          width: 200,
                          child: Icon(
                            CupertinoIcons.cloud_upload_fill,
                            size: 80,
                            color: basicthemecolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (resulttxt == 'Positive') {
                      status = 1;
                    } else {
                      status = 2;
                    }
                    covidrequestresult(
                        requestid: widget.userModel.requestId,
                        status: status!,
                        context: context,
                        img: _image);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
                  margin: const EdgeInsets.only(top: 80),
                  child: IntrinsicWidth(
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.cloud_upload_fill,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Upload Result',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // Api
  Future<String> covidrequestresult(
      {required int status,
      required int requestid,
      context,
      FilePickerResult? img}) async {
    var apiURL = baseUrl + 'update/covid/request';

    var filename = img?.paths[0] ?? '';

    var formData = FormData.fromMap({
      'test_status': status,
      'request_id': requestid,
      'test_file': await MultipartFile.fromFile(img?.paths[0] ?? '',
          filename: filename, contentType: MediaType('image', 'png'))
    });

    Dio dio = Dio();
    Response responce;
    ;
    try {
      responce = await dio.post(
        apiURL,
        data: formData,
      );
      if (responce.statusCode == 200) {
        if (responce.data['success'] == true) {
          Fluttertoast.showToast(
              msg: "Uplodated SucessFully", backgroundColor: basicthemecolor);

          return '';
        } else if (responce.data['success'] == false) {
          Fluttertoast.showToast(
              msg: "${responce.data["Success_message"]}",
              backgroundColor: basicthemecolor);
          return '';
        } else {
          Fluttertoast.showToast(
              msg: "${responce.data["Success_message"]}",
              backgroundColor: basicthemecolor);
          return '';
        }
      }
    } catch (e) {
      // print(e);
      Fluttertoast.showToast(
          msg: "bad Internet request", backgroundColor: basicthemecolor);
      return 'bad Internet request';
    }

    return '';
  }
}
