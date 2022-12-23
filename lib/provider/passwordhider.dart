import 'package:flutter/cupertino.dart';

class PasswordHider extends ChangeNotifier {


bool isHidden1 = true;
bool changingspinner = false;
changeEyeIcon() {
    isHidden1 = !isHidden1;
  
    notifyListeners();
  }






}
