import 'package:enjobproject/widgets/button.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ScreenLetsgo extends StatelessWidget {
  const ScreenLetsgo({super.key});

  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: kThemecolor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(width1 * 0.1, 0, width1 * 0.1, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height1 * 0.01),
                    child: const Text(
                      'Find Your \nDream job! ',
                      style: kTextstyle,
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                      ),
                      const KButton(label: "Lets's Go")
                    ],
                  ),
                ]),
          ),
        ));
  }
}
