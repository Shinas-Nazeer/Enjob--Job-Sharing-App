import 'package:enjobproject/constants/constants.dart';
import 'package:flutter/material.dart';


showAlerttoUser(context, label, {Function()?  onpressed}) => showDialog(
    context: context,
    builder: (context) {
      return   AlertDialog(


        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            Text(label,),
              
          ],
        
        ),
        actions: [   TextButton(onPressed: onpressed, child: const Text('Yes ', style: TextStyle(color: kBlack ),)),
          TextButton(onPressed: (() {
            Navigator.pop(context);
          }), child: const Text('No ', style: TextStyle(color: kBlack ), ))
        ],
      );
    });