import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nephcare_nurse/dashboard/covid_test.dart';
import 'package:nephcare_nurse/dashboard/home_page.dart';
import 'package:nephcare_nurse/dashboard/profile_page.dart';
import 'package:nephcare_nurse/dashboard/setting.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selectedIndex = 0;
  static const List<Widget> widgetOptions = <Widget>[
    HomePage(),
    CovidTest(),
    ProfilePage(),
    Setting(),
  ];

  onItemTapped(
    int index,
  ) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   signInroute,
          //       (route) => false,
          // );
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            drawerEnableOpenDragGesture: false,
            body: Center(
              child: widgetOptions.elementAt(selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                unselectedFontSize: 12.0,
                selectedFontSize: 12.0,
                unselectedItemColor: Colors.black,
                selectedLabelStyle:
                    const TextStyle(decorationColor: Colors.red),
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      CupertinoIcons.home,
                    ),
                    icon: Icon(
                      CupertinoIcons.home,
                    ),
                    label: ('Home'),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      CupertinoIcons.add_circled,
                    ),
                    icon: Icon(
                      CupertinoIcons.add_circled,
                    ),
                    label: ('Request'),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      CupertinoIcons.person,
                    ),
                    icon: Icon(
                      CupertinoIcons.person,
                    ),
                    label: ('Profile'),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(
                      CupertinoIcons.settings,
                    ),
                    icon: Icon(
                      CupertinoIcons.settings,
                    ),
                    label: ('Settings'),
                  ),
                ],
                currentIndex: selectedIndex,
                selectedItemColor: Colors.red,
                iconSize: 20,
                onTap: onItemTapped,
                elevation: 5),
          ),
        ),
      ),
    );
  }
}
