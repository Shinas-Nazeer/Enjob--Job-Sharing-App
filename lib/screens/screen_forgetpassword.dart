import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/screens/screen_homepage.dart';
import 'package:enjobproject/widgets/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../provider/create_account.dart';
import '../widgets/button.dart';

class ScreenForgetPassword extends StatelessWidget {
  ScreenForgetPassword({super.key});
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWithe70,
        elevation: 0,
        iconTheme: const IconThemeData(color: kBlack),
      ),
      body: Consumer<Userdetailsvaribles>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Enter Your Email will\nsend you the link',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
                    ),
                  ),
                  CommonTextFormField(
                      label: 'Enter Your Email',
                      validator: value.emailtextformvalidator,
                      textEditingController: value.userNameController),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Mybutton(
                    label: 'Reset Password',
                    ontap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await auth.sendPasswordResetEmail(
                              email: value.userNameController.text);
                     
                          await Fluttertoast.showToast(
                              msg: 'SuceesFuly send email Link',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.green,
                              fontSize: 18.0);
                        value.userNameController.clear();
                        } catch (e) {
                           await Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.red,
                              fontSize: 18.0);
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
