
import 'package:enjobproject/screens/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:enjobproject/provider/googlesignin.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';



   class ScreenCompanyProfile extends StatelessWidget {
   ScreenCompanyProfile({super.key});
final user = FirebaseAuth.instance.currentUser!;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kThemecolor,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Container(
            
                height: 300,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                        // color: kThemecolor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50.0,
                                backgroundImage:(user.photoURL != null) ? NetworkImage(user.photoURL!) : const AssetImage('') as ImageProvider
                            ),
                             ),
                            // Text(user.displayName!, style: TextStyle(fontSize: 19),),
                            const Divider(
                              thickness: 2,
                            ),
                            const Text('Account Information',style: TextStyle(color: kThemecolor),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                           
                              children: [
                                  IconButton(onPressed: (() {
                             
                           }), icon: (const FaIcon(FontAwesome.google, color: Colors.red, size: 20,))),
    
                                Text(user.email!, style: const TextStyle(color: Colors.red, fontSize: 16),  overflow: TextOverflow.ellipsis, ),
                              ],
                            ),
                            Row(
                                mainAxisSize: MainAxisSize.min,
                              children: [
                                  Icon(Icons.phone, color: Colors.white,),
                                // Text({User.phoneNumber}),
                              ],
                            ),
                            const Divider(
                             thickness: 2, 
                            ), 
                          
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                           IconButton(onPressed: (() {
                             
                           }), icon: (const FaIcon(FontAwesome.google, color: Colors.red, size: 40,))),
                             
                               IconButton(onPressed: (() {
                             
                           }), icon: (const FaIcon(FontAwesome.whatsapp, color: Colors.green, size: 40,))),
                              
                             IconButton(onPressed: (() {
                             
                           }), icon: (const FaIcon(FontAwesome.phone, color: Colors.blue, size: 40,))),
                              
                              ],
                            ),
                          
                          ],
                        )
    
            ),
            ElevatedButton(onPressed: () {
           
           final provider = Provider.of<GoogleSignProvider>(context,listen: false);
           provider.logout();
             logout();
            }, child: Text('log Out'))
          ],
        ),
      ),
    );
  }




}

logout () async{
 await FirebaseAuth.instance.signOut();
  return ScreenLoginPage();
}



