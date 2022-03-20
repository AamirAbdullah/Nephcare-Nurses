import 'package:flutter/material.dart';
import 'package:nephcare_nurse/dashboard/edit_profile.dart';
import 'package:nephcare_nurse/dashboard/navigation_bar.dart';
import 'package:nephcare_nurse/dashboard/wallet_screen.dart';
import 'package:nephcare_nurse/screen/login_screen.dart';
import 'package:nephcare_nurse/screen/login_signup_page.dart';
import 'package:nephcare_nurse/screen/signup_screen.dart';
import 'package:nephcare_nurse/screen/splahscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == doctordashboardroute) {
          return MaterialPageRoute(
              builder: (context) => const MyNavigationBar());
        }

        if (settings.name == loginroute) {
          return MaterialPageRoute(builder: (context) => const Login());
        }
        if (settings.name == signuproute) {
          return MaterialPageRoute(builder: (context) => const SignUp());
        }
        if (settings.name == navigationbarroute) {
          return MaterialPageRoute(
              builder: (context) => const MyNavigationBar());
        }
        if (settings.name == chooseloginsignuproute) {
          return MaterialPageRoute(
              builder: (context) => const ChooseSignupLogin());
        }
        if (settings.name == editprofileroute) {
          return MaterialPageRoute(builder: (context) => const Editprofile());
        }
        if (settings.name == mywalletroute) {
          return MaterialPageRoute(builder: (context) => const MyWallet());
        }

        return null;
      },
    );
  }
}

const String doctordashboardroute = '/doctordashboard';
const String loginroute = '/login';
const String signuproute = '/signup';
const String navigationbarroute = '/MyNavigationBar';
const String chooseloginsignuproute = '/chooseloginsignup';
const String editprofileroute = '/Editprofile';
const String mywalletroute = '/MyWallet';
