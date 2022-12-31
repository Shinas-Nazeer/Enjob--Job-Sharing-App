

import 'package:flutter/material.dart';

class Ksizedbox extends StatelessWidget {
  const Ksizedbox({
    Key? key, this.height= 10.0  }) : super(key: key);
  final double height;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height
    );
  }
}