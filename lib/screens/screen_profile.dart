import 'package:enjobproject/screens/screen_login.dart';
import 'package:enjobproject/screens/screen_showpostedjobs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:enjobproject/provider/googlesignin.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../provider/create_account.dart';

class ScreenCompanyProfile extends StatelessWidget {
   ScreenCompanyProfile({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
        child: Container(
          decoration: const BoxDecoration(
              color: kThemecolor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                    height: 450,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                      
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                 
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor: kWhite,
                              radius: 50.0,
                              // backgroundImage: (user.photoURL != null)
                              //     ? NetworkImage(user.photoURL!)
                              //     : const AssetImage('') as ImageProvider
                                  ),
                        ),
                        // Text(
                        //   user.displayName!,
                        //   style: const TextStyle(
                        //       fontSize: 19, ),
                        // ),
                        const Divider(
                          thickness: 2,
                        ),
                        const Text(
                          'Account Information',
                          style: TextStyle(
                              fontSize: 12, ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: (() {}),
                                icon: (const FaIcon(
                                  FontAwesome.google,
                                  color: Colors.red,
                                  size: 20,
                                ))),
                            Text(
                              user.email!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.phone,
                          color: Colors.white,
                          semanticLabel: 'Log out',
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        Column(
                          children: [
                            TextButton.icon(
                              onPressed: (() {
                                final provider =
                                    Provider.of<GoogleSignProvider>(context,
                                        listen: false);
                                provider.logout();
                          
                              Provider.of<Userdetailsvaribles>(context, listen: false).logout();

                              }),
                              icon: const Text('Log Out',),
                              label: const FaIcon(FontAwesome.logout,),
                            ),
                            TextButton.icon(
                              onPressed: (() {}),
                              icon: const Text('Applied Jobs'),
                              label: const FaIcon(FontAwesome.yoast),
                            ),
                            TextButton.icon(
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ScreenPostedJObs()));
                              }),
                              icon: const Text('Posted Jobs'),
                              label: const FaIcon(FontAwesome.upload_cloud),
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





