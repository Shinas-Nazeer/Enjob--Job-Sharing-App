
import 'package:flutter/material.dart';

Widget dividerWidget() {
  return Column(
    children: const [
      SizedBox(
        height: 10,
      ),
      Divider(
        thickness: 1,
        color: Colors.grey,
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );
}