import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/screens/screen_cahtlist.dart';
import 'package:enjobproject/screens/screen_homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../screens/profle.dart';
import '../screens/screen_adddetails.dart';

import '../screens/screen_searchjob.dart';

class BottomNavbarwidget extends StatefulWidget {
  const BottomNavbarwidget({super.key});

  @override
  State<BottomNavbarwidget> createState() => _BottomNavbarwidgetState();
}

class _BottomNavbarwidgetState extends State<BottomNavbarwidget> {
  int page = 0;

  List<Widget> pages = [
    const ScreenHomePage(),
    const ScreenSearchJob(),
    const ScreenAddDetails(),
    ProfileScreen(),
  //  const ChatList()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          color: kWhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18),
            child: GNav(
                gap: 8,
                onTabChange: (index) {
                  setState(() {
                    page = index;
                  });
                },
                backgroundColor: kWhite,
                color: kBlack54,
                activeColor: kWhite,
                tabBackgroundColor: Colors.black54,
                padding: const EdgeInsets.all(15),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'home',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.add,
                    text: 'Post',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                  // GButton(
                  //   icon: Icons.whatsapp,  
                  //   text: 'Chat',
                  // ),
                ]),
          ),
        ),
        body: pages.elementAt(page));
  }
}
