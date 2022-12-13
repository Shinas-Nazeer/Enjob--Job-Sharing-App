import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

bool showspinner  = false;
  GoogleSignInAccount get user => _user!;
  Future googleLogin1() async {
    showspinnering(true);
    try {
        
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    
      await FirebaseAuth.instance.signInWithCredential(credential);
     showspinnering(false);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }



void showspinnering (bool value){
  showspinner = value;
  notifyListeners();
}





}
