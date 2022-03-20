import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/helper/theme.dart';
import 'package:nephcare_nurse/main.dart';
import 'package:nephcare_nurse/services/login_api.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: SingleChildScrollView(
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
                  "WELCOME BACK",
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
                    key: _formKey,
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
                            label1: 'email',
                            context: context,
                            prefixicon: Icon(
                              CupertinoIcons.mail,
                              color: basicthemecolor,
                              size: 22,
                            ),
                          ),
                          validator: (val) =>
                              val!.isValidEmail() ? null : 'email is not valid',
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
                        style:
                            ElevatedButton.styleFrom(primary: basicthemecolor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginApi(email, password, context);
                          }
                        },
                        child: Text(
                          "Login".toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ))),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "OR",
                  style: TextStyle(),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: size.width,
                    height: 46,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, signuproute);
                        },
                        child: const Text(
                          'SIGNUP',
                          style: TextStyle(color: Colors.black),
                        ))),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
