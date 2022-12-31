import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/widgets/divider.dart';
import 'package:enjobproject/widgets/sizedbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OtherUserProfileScreen extends StatelessWidget {
  OtherUserProfileScreen(
      {super.key,
      required this.imageUrl,
      required this.userEmail,
      required this.userName,
      required this.userId});

  final String imageUrl;
  final String userEmail;
  final String userName;
  final String userId;
  final user = FirebaseAuth.instance.currentUser!;

  Widget userInfo({required IconData icon, required String content}) {
    return Row(
      children: [
        Icon(
          icon,color: Colors.red,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
      body: SingleChildScrollView(
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
                          userName,
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
                        child: InkWell(
                          onTap: () {
                             _mailTo(userEmail);
                          },
                          child: userInfo(icon: FontAwesome.mail_squared, content: userEmail)),
                      ),
                      dividerWidget(),
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
                            image: NetworkImage(imageUrl), fit: BoxFit.fill)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  
  void _mailTo(email) async{

final Uri params = Uri(
scheme: 'mailto',

path: email,
query: 'subject= Write Subject  here, please&body=Hello, please write details here'
);
final url= params.toString();
launchUrlString(url);
}
}
