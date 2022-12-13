import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:enjobproject/screens/screen_adddetails.dart';
import 'package:enjobproject/screens/screen_chat.dart';
import 'package:enjobproject/screens/screen_homepage.dart';

import 'package:enjobproject/screens/screen_profile.dart';
import 'package:enjobproject/screens/screen_search.dart';

import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int page = 0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  List<Widget> pages = [
    const ScreenHomePage(),
    const ScreenSearch(),
    const ScreenAddDetails(),
    ScreenCompanyProfile(),
    const ChatPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: const[
             Icon(Icons.home, size: 30),
           Icon(Icons.search, size: 30),
           Icon(Icons.add, size: 30),
             Icon(Icons.person, size: 30),
             Icon(Icons.chat, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: kThemecolor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: pages.elementAt(page));
  }
}
