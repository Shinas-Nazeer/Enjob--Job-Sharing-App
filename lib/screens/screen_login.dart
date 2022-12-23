import 'package:enjobproject/constants/constants.dart';

import 'package:enjobproject/screens/screen_forgetpassword.dart';
import 'package:enjobproject/screens/screen_registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../provider/googlesignin.dart';
import '../provider/passwordhider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


// ignore: must_be_immutable
class ScreenLoginPage extends StatelessWidget {
ScreenLoginPage({super.key});

  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? passWord;
  String? name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kThemecolor,
    
        body: Consumer<GoogleSignProvider>(
          builder: ((context, value1, child) =>
           ModalProgressHUD(
            inAsyncCall: value1.showspinner,
            child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: SingleChildScrollView(
              
                  
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: 160,
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
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: Consumer<PasswordHider>(
                              builder: (context, value, child) => 
                              TextFormField(
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
                                  obscureText: value.isHidden1,
                                  onChanged: (value) {
                                    passWord = value;
                                  },
                                  decoration: style('Enter Password',
                                      widget1: InkWell(
                                        onTap: (() {
                                       
                                          value.changeEyeIcon();
                                        
                                        }),
                                        child: Icon(
                                          value.isHidden1
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ))),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: Hero(
                                tag: 'button',
                                child: Material(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(30.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                   
                                   

                                      if (formKey.currentState!.validate()) {
                                         value1.showspinnering(true);
                                        try {
                                          await _auth.signInWithEmailAndPassword(
                                              email: name!, password: passWord!);
                                          value1.showspinnering(false);  
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  duration: Duration(seconds: 3),
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                      'Invalid UserName Or password')));
                                        }
                                      }
                                    },
                                    minWidth: 200.0,
                                    height: 42.0,
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             ScreenForgetPassword()));
                              }),
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                    color: Colors.white, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Don't have an account ?",
                                    style: TextStyle(color: Colors.white)),
                              ),
                              InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                               ScreenRegistration()));
                                  }),
                                  child: const Text("Sign in",
                                      style: TextStyle(color: Colors.red))),
                            ],
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 8),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      height: 1,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
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
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              )),
                          Consumer<GoogleSignProvider>(
                            builder: (context, value, child) {
                              return SignInButton(
                                Buttons.google,
                                text: "Sign up with Google",
                                onPressed: () {
                               
                           
                                  value.googleLogin1();
                               
                                    
                             
                             
                                  
                               
        
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          )
        ),)
          );
      
    
    
  }
}

InputDecoration style(label, {widget1 = const Icon(Icons.person)}) {
  return InputDecoration(
    suffix: widget1,
    hintText: label,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(35.0)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kThemecolor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}




