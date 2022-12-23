// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/screens/screen_profile.dart';
import 'package:enjobproject/widgets/button.dart';
import 'package:enjobproject/widgets/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../provider/create_account.dart';
import '../widgets/sizedbox.dart';

// ignore: must_be_immutable
class ScreenRegistration extends StatelessWidget {
  ScreenRegistration({super.key});
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kWhite,
          iconTheme: const IconThemeData(color: kBlack),
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Provider.of<Userdetailsvaribles>(context, listen: false)
                    .logout();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Consumer<Userdetailsvaribles>(
          builder: (context, globalvariable, child) => SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Create Your \nAccount here',
                            style: TextStyle(
                                color: kBlack, fontSize: size.height * 0.05)),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (() {
                        globalvariable.addPhoto();
                      }),
                      child: Container(
                        width: size.width * 0.24,
                        height: size.width * 0.24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: kBlack)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: globalvariable.imagepath == null
                                ? const Icon(Icons.add_a_photo, color: kBlack)
                                : Image.file(
                                    File(globalvariable.imagepath!),
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                  ),
                  const Sizedbox(),
                  CommonTextFormField(
                    label: 'Enter Email Name',
                    validator: globalvariable.emailtextformvalidator,
                    textEditingController: globalvariable.userNameController,
                  ),
                  const Sizedbox(),
                  CommonTextFormField(
                    label: 'Enter Your Name',
                    validator: globalvariable.textformvalidator,
                    textEditingController: globalvariable.nameController,
                  ),
                  const Sizedbox(),
                  CommonTextFormField(
                    label: 'Enter password',
                    validator: globalvariable.passwordValidator,
                    textEditingController: globalvariable.passwordController,
                  ),
                  const Sizedbox(),
                  CommonTextFormField(
                    label: 'Confirm Password',
                    validator: (value) {
                      if (value != globalvariable.passwordController.text &&
                          value!.isEmpty) {
                        return "Password Doesn't match";
                      } else {
                        return null;
                      }
                    },
                    textEditingController: globalvariable.rePasswordController,
                  ),
                  const Sizedbox(),
                  CommonTextFormField(
                    label: 'Phone Number',
                    validator: globalvariable.textformvalidator,
                    textEditingController: globalvariable.phoneNumberController,
                  ),
                  const Sizedbox(),
                  Mybutton(
                    label: 'Create Your Account',
                    ontap: () async {
                      if (formKey.currentState!.validate()) {
                        if (globalvariable.imagepath == null) {
                          await Fluttertoast.showToast(
                              msg: 'Upload Your Image',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.red,
                              fontSize: 18.0);
                        } else {
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: globalvariable.userNameController.text
                                    .trim()
                                    .toLowerCase(),
                                password: globalvariable.passwordController.text
                                    .trim());
                            final User? user = _auth.currentUser;
                            final uid = user!.uid;
                            final ref = FirebaseStorage.instance
                                .ref()
                                .child('UserImages')
                                .child('$uid.jpg');
                            await ref.putFile(File(globalvariable.imagepath!));
                            imageUrl = await ref.getDownloadURL();
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(uid)
                                .set({
                              'id': uid,
                              'name': globalvariable.nameController.text,
                              'phone':
                                  globalvariable.phoneNumberController.text,
                              'address': 'not',
                              'userimage': imageUrl,
                            });

                            await Fluttertoast.showToast(
                                msg: 'Account Created Sucessfully',
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.green,
                                fontSize: 18.0);

                            globalvariable.clearcontroler();
                          } catch (e) {
                            await Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.red,
                                fontSize: 18.0);
                          }
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
