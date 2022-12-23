
import 'package:flutter/material.dart';
errormessage(context , message){
   ScaffoldMessenger.of(context).showSnackBar(
                                               SnackBar(
                                                  duration: Duration(seconds: 3),
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    message  )));

}
