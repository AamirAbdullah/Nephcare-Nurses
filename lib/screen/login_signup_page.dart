import 'package:flutter/material.dart';
import 'package:nephcare_nurse/main.dart';

class ChooseSignupLogin extends StatefulWidget {
  const ChooseSignupLogin({Key? key}) : super(key: key);

  @override
  State<ChooseSignupLogin> createState() => _ChooseSignupLoginState();
}

class _ChooseSignupLoginState extends State<ChooseSignupLogin> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //doctor_patient_art.png
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 45),
                      child: Opacity(
                          opacity: 1,
                          child: Image.asset(
                            'assets/doctor_patient_art.png',
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Work the way you want',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Build Your Career\n Right Here',
                      style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.w800,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // height: size.height,
              // decoration: BoxDecoration(
              //     color: theme.accentColor,
              //     borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              // ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Let\'s get started'.toUpperCase(),
                    style: const TextStyle(
                        // color: theme.primaryColor
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                      width: size.width,
                      height: 46,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, signuproute);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: const Text(
                            'Create An Account',
                            style: TextStyle(color: Colors.white),
                          ))),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: size.width,
                    // margin: EdgeInsets.symmetric(horizontal: ),
                    // padding: EdgeInsets.all(0),
                    color: Colors.grey.shade300,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, loginroute);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.grey),
                        )),
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
