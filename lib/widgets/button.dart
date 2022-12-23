
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Mybutton extends StatelessWidget {
 const Mybutton({super.key, required this.label, required this.ontap});

final String label;
final Function() ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: kBlack,
          borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child:  Text(label, style: const TextStyle(color: Colors.white, fontSize: 10),), 
      ),
    );
  }
}