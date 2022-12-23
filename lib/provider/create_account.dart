
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/screen_login.dart';

class Userdetailsvaribles extends ChangeNotifier{


final TextEditingController userNameController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController rePasswordController = TextEditingController();
final TextEditingController phoneNumberController = TextEditingController();
final  TextEditingController addressController = TextEditingController();
String? imagepath;
 
  Future<void> addPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
 
 imagepath = image.path;
  notifyListeners();

  }







clearcontroler(){
    userNameController.clear();
    nameController.clear();
    passwordController.clear();
    rePasswordController.clear();
    phoneNumberController.clear();
    addressController.clear();
    imagepath = null;
    notifyListeners();
  }





  passwordValidator(value) {
    if (value!.isEmpty) {
      return 'Invalid Password';
    } else if (value.length < 7) {
      return 'Password should Contain 8 letters';
    } else {
      return null;
    }
  }

  textformvalidator(value) {
    if (value!.isEmpty) {
      return 'Please Enter  Deatils';
    } else {
      return null;
    }
  }

  emailtextformvalidator(value) {
    if (value!.isEmpty || !value.contains('@')) {
      return 'Please Enter Valid Email';
    } else {
      return null;
    }
  }

logout() async {
  await FirebaseAuth.instance.signOut();
   notifyListeners();
  return ScreenLoginPage();
  
}
  

}