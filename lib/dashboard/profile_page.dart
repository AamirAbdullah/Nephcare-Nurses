// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/helper/colors.dart';
import 'package:nephcare_nurse/main.dart';
import 'package:nephcare_nurse/models/userprofilemodal.dart';
import 'package:nephcare_nurse/services/get_profile_api.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


UserProfileModal? userProfileModal;
var loading = true;

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    getprofileFunction().then((value) => {
          setState(() {
            loading = false; // Future is completed with a value.
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading == true
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      child: const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Account',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
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
                    ),
                  ],
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: HexColor('#404B63').withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.fromLTRB(15, 120, 15, 0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                            ),
                            Container(
                              transform: Matrix4.translationValues(0, -38, 0),
                              child:
                              userProfileModal?.image.toString() == '' ||
                                      userProfileModal?.image.toString() == null
                                  ?
                              CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: Image.asset(
                                            'assets/imguser.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      child: ClipOval(
                                        child: Image.network(
                                            userProfileModal?.image,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, editprofileroute);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: 50,
                                child: Icon(
                                  CupertinoIcons.pencil,
                                  color: basicthemecolor,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            transform: Matrix4.translationValues(0, -28, 0),
                            child: Text(
                              userProfileModal?.name.toString() == '' ||
                                      userProfileModal?.name.toString() == null
                                  ? 'User Name'
                                  : userProfileModal?.name,
                              //
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Container(
                            transform: Matrix4.translationValues(0, -28, 0),
                            child: const Text('Hospital')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.envelope,
                              color: basicthemecolor,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              userProfileModal?.email.toString() == '' ||
                                      userProfileModal?.email.toString() == null
                                  ? 'useremail@gmail.com'
                                  : userProfileModal?.email,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.phone,
                              color: basicthemecolor,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              userProfileModal?.phone.toString() == '' ||
                                      userProfileModal?.phone.toString() == null
                                  ? '03*-**'
                                  : userProfileModal?.phone,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, mywalletroute);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.creditcard,
                                      size: 24,
                                      color: basicthemecolor,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'My Wallet',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: basicthemecolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                CupertinoIcons.chevron_forward,
                                size: 24,
                                color: basicthemecolor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => const WithDrawRequests()),
                                  // );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      CupertinoIcons.suit_heart,
                                      size: 24,
                                      color: basicthemecolor,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Favorites',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: basicthemecolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  CupertinoIcons.chevron_forward,
                                  size: 24,
                                  color: basicthemecolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  SharedPreferences preferences =
                                      await SharedPreferences.getInstance();
                                  await preferences.clear();
                                  Navigator.pushReplacementNamed(
                                      context, chooseloginsignuproute);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.power_settings_new,
                                      size: 20,
                                      color: basicthemecolor,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Logout',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: basicthemecolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Icon(
                                  CupertinoIcons.chevron_right,
                                  size: 24,
                                  color: basicthemecolor,
                                ),
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
    );
  }
}