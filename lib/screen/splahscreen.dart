import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nephcare_nurse/dashboard/navigation_bar.dart';
import 'package:nephcare_nurse/screen/login_signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final player = AudioPlayer();

  int? userid;
  @override
  void initState() {
    playAudio();
    super.initState();
    loadData();
  }

  playAudio() {
    player.setVolume(2);
    player.setAsset("assets/heart_beat.mp3");
    player.play();
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

  Future loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('user_id');

    if (userid == null || userid == 0) {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChooseSignupLogin())));
    } else {
      Timer(
          const Duration(seconds: 7),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyNavigationBar())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Hero(
                  tag: "Logo ",
                  child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        "assets/nurses_logo.gif",
                        width: 140,
                        gaplessPlayback: true,
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
