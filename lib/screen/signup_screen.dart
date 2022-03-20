import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/main.dart';
import 'package:nephcare_nurse/services/login_api.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  String name = '';
  String password = '';
  String email = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/img/logo.png",
                        width: 100,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "FIND AROUND YOU!",
                    style: TextStyle(fontSize: 24, color: basicthemecolor),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: containerBorder,
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.bottom,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: inputField1(
                              label1: 'Name',
                              context: context,
                              prefixicon: Icon(
                                CupertinoIcons.mail,
                                color: basicthemecolor,
                                size: 22,
                              ),
                            ),
                            validator: (val) => val!.isNotEmpty
                                ? null
                                : 'Name Feild must not be empty',
                            onChanged: (val) {
                              setState(() {
                                name = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.bottom,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: inputField1(
                              label1: 'email',
                              context: context,
                              prefixicon: Icon(
                                CupertinoIcons.mail,
                                color: basicthemecolor,
                                size: 22,
                              ),
                            ),
                            validator: (val) => val!.isValidEmail()
                                ? null
                                : 'email is not valid',
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            textAlignVertical: TextAlignVertical.bottom,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            decoration: inputField1(
                                label1: 'Password',
                                context: context,
                                prefixicon: Icon(
                                  CupertinoIcons.padlock,
                                  color: basicthemecolor,
                                  size: 22,
                                ),
                                suffixIcon: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                  icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black26,
                                  ),
                                )),
                            validator: (val) => val!.length < 6
                                ? 'Password more than 6 digit'
                                : null,
                            obscureText: hidePassword,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      margin: const EdgeInsets.all(15),
                      width: size.width,
                      height: 46,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: basicthemecolor),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signupApi(email, name, password, context);
                            }
                          },
                          child: Text(
                            "SIGNUP".toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ))),
                  const SizedBox(
                    height: 30,
                  ),
                  const Hero(
                      tag: "OR",
                      child: Text(
                        "OR",
                        style: TextStyle(),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: size.width,
                      height: 46,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, loginroute);
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.black),
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
