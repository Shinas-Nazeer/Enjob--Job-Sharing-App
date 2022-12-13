import 'dart:io';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:enjobproject/screens/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ScreenRegistration extends StatefulWidget {
  const ScreenRegistration({super.key});

  @override
  State<ScreenRegistration> createState() => _ScreenRegistrationState();
}

class _ScreenRegistrationState extends State<ScreenRegistration> {
  final _auth = FirebaseAuth.instance;
  String? name;
  File? userimage;
  String? passWord;
  bool _isHidden = true;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
//  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: (AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Create Your Account here'),
            ],
            isRepeatingAnimation: true,
          )),
          backgroundColor: kThemecolor,
          elevation: 0,
        ),
        backgroundColor: kThemecolor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (() {
                        showImageDialogtoUser(context);
                      }),
                      child: Container(
                        width: size.width * 0.24,
                        height: size.width * 0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            )),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: userimage == null
                                ? const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  )
                                : Image.file(
                                    userimage!,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please Enter a Valid Email address';
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.center,
                      onChanged: (value1) {
                        name = value1;
                      },
                      decoration: style('Enter Username'),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Invalid Password';
                          } else if (value.length < 7) {
                            return 'Password should Contain 8 letters';
                          } else {
                            return null;
                          }
                        },
                        textAlign: TextAlign.center,
                        obscureText: _isHidden,
                        onChanged: (value) {
                          passWord = value;
                        },
                        decoration: style(
                          'Enter Password',
                          Widget1: eyehideonoff(),
                        )),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration:
                          style('Confirm Password', Widget1: eyehideonoff()),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: style('Phone Number'),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: style('Company Address'),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                        minWidth: 200.0,
                        height: 42.0,
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: name!, password: passWord!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.red,
                                      content:
                                          Text('Account Created Succesfully')));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScreenLoginPage()));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'User Name and PassWord Already exist')));
                            }
                          } else {
                            print('In valid scenario');
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: kThemecolor),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  InkWell eyehideonoff() {
    return InkWell(
      onTap: (() {
        setState(() {
          _isHidden = !_isHidden;
        });
      }),
      child: Icon(
        _isHidden ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  InputDecoration style(label, {Widget1 = const Icon(Icons.person)}) {
    return InputDecoration(
      suffix: Widget1,
      hintText: label,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(35.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: kThemecolor, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
  }
}

showImageDialogtoUser(context) => showDialog(
    context: context,
    builder: (context) {
      return   AlertDialog(

  
        title: const Text('Choose an Option' , style: TextStyle(color: kThemecolor),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (() {
                  //open camera function to user
                }),
                child: Row(
                  children: const  [
                    Icon(Icons.camera_alt_outlined, color: kThemecolor,),
                    Text('camera', style: TextStyle(color: kThemecolor)),
                  ],
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (() {
                    //open gallery of the user
                  }),
                  child: Row(
                  children: const  [
                    Icon(Icons.image, color: kThemecolor,),
                    Text('Gallery', style: TextStyle(color: kThemecolor)),
                  ],
                            ),
                ),
              ),
          ],
        ),
      );
    });
