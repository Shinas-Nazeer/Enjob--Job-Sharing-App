import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/main.dart';
import 'package:enjobproject/screens/screen_applied_jobs.dart';
import 'package:enjobproject/screens/screen_showpostedjobs.dart';
import 'package:enjobproject/widgets/button.dart';
import 'package:enjobproject/widgets/divider.dart';
import 'package:enjobproject/widgets/sizedbox.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../globalerror/alert.dart';
import '../provider/create_account.dart';
import '../provider/googlesignin.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen(
      {super.key,   
      });

  final _user = FirebaseAuth.instance.currentUser!;

  Widget userInfo({required IconData icon, required String content}) {
    return Row(
      children: [
        Icon(
          icon,
        ),
        const SizedBox(width: 5,),
        Flexible(
          child: Text(
            content,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: kWhite,
          elevation: 0,
          iconTheme: const IconThemeData(color: kBlack),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Stack(
                children: [
                  Card(
                    color: kWithe70,
                    margin: const EdgeInsets.all(30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              _user.displayName!,
                              style: const TextStyle(fontSize: 24.0),
                            ),
                          ),
                          dividerWidget(),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Account Information :',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          const Ksizedbox(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:
                                userInfo(icon: Icons.email, content: _user.email!),
                          ),
                          dividerWidget(),  
                     
                               Center(   
                                  child: Column(
                                    children: [
                                      TextButton.icon(
                                          onPressed: (() {
                                             Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScreenAppliedJObs()));
                                          }),
                                          icon: const Text(
                                            'Applied Jobs',
                                            style: TextStyle(color: kBlack),
                                          ),
                                          label: const FaIcon(
                                            FontAwesome.yoast,
                                            color: kBlack,
                                          )),
                                      TextButton.icon(
                                        onPressed: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ScreenPostedJObs()));
                                        }),
                                        icon: const Text(
                                          'Posted Jobs',
                                          style: TextStyle(color: kBlack),
                                        ),
                                        label: const FaIcon(
                                          FontAwesome.upload_cloud,
                                          color: kBlack,
                                        ),
                                      ),
                                      Mybutton(
                                          label: 'LogOut',
                                          ontap: () {
                                            showAlerttoUser(
                                              context,
                                              'Are You Sure Want to Logout?',
                                              onpressed: () {
                                                final provider = Provider.of<
                                                        GoogleSignProvider>(
                                                    context,
                                                    listen: false);
                                                provider.logout();

                                                Provider.of<Userdetailsvaribles>(
                                                        context,
                                                        listen: false)
                                                    .logout();
                                                Navigator.push( 
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MyApp1()));
                                              },
                                            );
                                          }),
                                    ],
                                  ),
                                )
                             
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.26,
                        height: size.width * 0.26,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black38),
                            image: DecorationImage(
                                image: NetworkImage(_user.photoURL!),
                                fit: BoxFit.fill)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
