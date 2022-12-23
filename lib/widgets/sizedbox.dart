

import 'package:flutter/material.dart';

class Sizedbox extends StatelessWidget {
  const Sizedbox({
    Key? key, this.height= 10.0  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height
    );
  }
}