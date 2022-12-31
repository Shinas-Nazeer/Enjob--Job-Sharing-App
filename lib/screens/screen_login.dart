import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/globalerror/errormessage.dart';
import 'package:enjobproject/screens/screen_forgetpassword.dart';
import 'package:enjobproject/screens/screen_registration.dart';
import 'package:enjobproject/widgets/button.dart';
import 'package:enjobproject/widgets/sizedbox.dart';
import 'package:enjobproject/widgets/textform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../provider/create_account.dart';
import '../provider/googlesignin.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/or_widget.dart';

// ignore: must_be_immutable
class ScreenLoginPage extends StatelessWidget {
  ScreenLoginPage({super.key});

  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kWhite,
        body: Consumer<GoogleSignProvider>(
          builder: ((context, value1, child) => 
          ModalProgressHUD(
                inAsyncCall: value1.showspinner,
                child:
                 Padding(
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
                          Consumer<Userdetailsvaribles>(
                            builder: (context, value, child) => Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                              child: Column(
                                children: [
                                  CommonTextFormField(
                                      label: 'Enter UserName',
                                      validator: value.emailtextformvalidator,
                                      textEditingController:
                                          _userNameController),
                                  const Ksizedbox(),
                                  CommonTextFormField(
                                      label: 'EnterPassword',
                                      validator: value.textformvalidator,
                                      textEditingController:
                                          _passWordController)
                                ],
                              ),
                            ),
                          ),
                          const Ksizedbox(),
                          Mybutton(
                              label: 'Log in',
                              ontap: () async {
                                if (formKey.currentState!.validate()) {
                                  value1.showspinnering(true);
                                  try {
                                    await _auth.signInWithEmailAndPassword(
                                        email: _userNameController.text,
                                        password: _passWordController.text);
                                    value1.showspinnering(false);
                                  } catch (e) {
                                    globalMessage(
                                        color: Colors.red,
                                        messgae:
                                            'Invalid UserName Or password');
                                    value1.showspinnering(false);
                                  }
                                }
                              }),
                          const Ksizedbox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScreenForgetPassword()));
                                }),
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    'Forget Password?',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Ksizedbox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Don't have an account ?",
                                  )),
                              InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScreenRegistration()));
                                  }),
                                  child: const Text("Sign in",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontStyle: FontStyle.italic))),
                            ],
                          ),
                          const OrWidget(),
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
                )
              )),
        ));
  }
}
