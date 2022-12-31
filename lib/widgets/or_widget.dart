

import 'package:enjobproject/constants/constants.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    Key? key,
  }) : super(key: key);
  
  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 130, vertical: 8),
        child: Row(
          children: [
            Flexible(
              child: Container(
                height: 1,
                color: kBlack,
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: 1,
                color: kBlack,
              ),
            ),
          ],
        ));
  }
}



