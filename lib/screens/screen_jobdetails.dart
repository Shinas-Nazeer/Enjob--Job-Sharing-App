import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/globalerror/errormessage.dart';
import 'package:enjobproject/screens/applicantlist_screen.dart';
import 'package:enjobproject/screens/screen_chat2.dart';
import 'package:enjobproject/widgets/bottom_navrbar.dart';
import 'package:enjobproject/widgets/button.dart';
import 'package:enjobproject/widgets/comments.dart';
import 'package:enjobproject/widgets/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uuid/uuid.dart';
import '../widgets/divider.dart';

class ScreenJobdetails extends StatefulWidget {
  const ScreenJobdetails({
    super.key,
    required this.uploadedby,
    required this.image,
    required this.jobTitle,
    required this.userUId,
    required this.jobId,
    required this.jobdescription,
    required this.lastdate1,
    required this.applicants,
    required this.jobLoaction,
    required this.uploaderEmail,
  });

  final String uploadedby;
  final String image;
  final String jobTitle;
  final String userUId;
  final String jobId;
  final String jobdescription;
  final String lastdate1;
  final int applicants;
  final String jobLoaction;
  final String uploaderEmail;

  @override
  State<ScreenJobdetails> createState() => _ScreenJobdetailsState();
}

class _ScreenJobdetailsState extends State<ScreenJobdetails> {
  final user = FirebaseAuth.instance.currentUser!;
  bool recuirement1 = true;
  bool isCommenting = false;

  final TextEditingController _commentController = TextEditingController();

  getjobdetail() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('jobs')
        .doc(widget.jobId)
        .get();

    setState(() {
      recuirement1 = userDoc.get('requirement');
    });
  }

  @override
  void initState() {
    getjobdetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        leading: IconButton(
          color: kBlack54,
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => const BottomNavbarwidget())));
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: kWithe70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          widget.jobTitle,
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Colors.grey,
                              ),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(widget.image),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          //image
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.uploadedby,
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      dividerWidget(),
                      user.uid == widget.userUId
                          ? InkWell(
                              onTap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ApplicantListScreen(
                                              jobId: widget.jobId,
                                            )));
                              }),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'LIst of Applicants',
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.how_to_reg_sharp)
                                ],
                              ),
                            )
                          : Text(
                              'JobLocation: ${widget.jobLoaction}',
                            ),
                      user.uid != widget.userUId
                          ? dividerWidget()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dividerWidget(),
                                const Text('Recuritment'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Switch(
                                        activeColor: Colors.green,
                                        value: recuirement1,
                                        onChanged: (newValue) {
                                          setState(() {
                                            recuirement1 = newValue;
                                            FirebaseFirestore.instance
                                                .collection('jobs')
                                                .doc(widget.jobId)
                                                .update({
                                              'requirement': recuirement1
                                            });
                                          });
                                        })
                                  ],
                                ),
                              ],
                            ),
                      const Text('Job Description: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.jobdescription,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14),
                      ),
                      dividerWidget(),
                    ]),
              ),
            ),
          ),
          user.uid == widget.userUId
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: kWithe70,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                //deadline condition
                                Center(
                                  child: Text(
                                    'Actively Recuriting, send Cv/Resume',
                                    style: TextStyle(
                                      color: kBlack,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          user.uid == widget.userUId
                              ? Container()
                              : Mybutton(
                                  label: 'Apply Now',
                                  ontap: () async {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('jobs')
                                          .doc(widget.jobId)
                                          .update({
                                        'listofapplicants':
                                            FieldValue.arrayUnion([
                                          {
                                            'ApplicantId': FirebaseAuth
                                                .instance.currentUser!.uid,
                                            'ApplicantEmail': user.email,
                                            'ApplicantImage': user.photoURL,
                                            'Applicantname': user.displayName,
                                          },
                                        ])             
                                      });
                                      await FirebaseFirestore.instance          
                                          .collection('jobs')
                                          .doc(widget.jobId)
                                          .update({'applicantslist': FieldValue.arrayUnion([user.uid])});   
                                      _mailTo(widget.uploaderEmail);
     
                                      globalMessage(
                                          color: Colors.green,
                                          messgae: 'Applied Sucessfully');
                                    } catch (e) {}
                                  }),
                          dividerWidget(),
                          user.uid == widget.userUId
                              ? Container()
                              : Mybutton(
                                  label: 'Chat With Recuiter',
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatPage2(
                                                  receiverimage: widget.image,
                                                  receivername:
                                                      widget.uploadedby,
                                                  receiveremail:
                                                      widget.uploaderEmail,
                                                  receiverUid: widget.userUId,
                                                  jObid: widget.jobId,
                                                )));
                                  }),
                          dividerWidget(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Last date: '),
                              Text(widget.lastdate1),
                            ],
                          ),
                          dividerWidget()
                        ],
                      ),
                    ),
                  ),
                ),
          //comment section
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSwitcher(
                        duration: const Duration(microseconds: 500),
                        child: isCommenting
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                      flex: 3,
                                      child: CommonTextFormField(
                                          length: 3,
                                          label: 'Add Comment',
                                          validator: () {},
                                          textEditingController:
                                              _commentController)),
                                  Column(
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            final generatedId = Uuid().v4();

                                            if (_commentController
                                                .text.isEmpty) {
                                              await Fluttertoast.showToast(
                                                  msg: 'Empty',
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  backgroundColor: Colors.red,
                                                  fontSize: 18.0);
                                            } else {
                                              await FirebaseFirestore.instance
                                                  .collection('jobs')
                                                  .doc(widget.jobId)
                                                  .update({
                                                'jobcomments':
                                                    FieldValue.arrayUnion([
                                                  {
                                                    'userId': FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid,
                                                    'commenterEmail':
                                                        user.email,
                                                    'commnetId': generatedId,
                                                    'name': user.displayName,
                                                    'userImageUrl':
                                                        user.photoURL,
                                                    'commentBody':
                                                        _commentController.text,
                                                    'time': Timestamp.now()
                                                  }
                                                ])
                                              });

                                              await Fluttertoast.showToast(
                                                  msg:
                                                      'Commengt Added  SuceesFuly',
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  backgroundColor: Colors.green,
                                                  fontSize: 18.0);
                                              _commentController.clear();
                                            }
                                          },
                                          child: const Text('Post')),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              isCommenting = !isCommenting;
                                            });
                                          },
                                          child: const Text('Cancel')),
                                    ],
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isCommenting = !isCommenting;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_comment,
                                        size: 40,
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('jobs')
                            .doc(widget.jobId)
                            .get(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            if (snapshot.data == null) {
                              const Center(child: Text('No Comments'));
                            }
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final comment =
                                  snapshot.data!['jobcomments'][index];
                              return Comments(
                                commentId: comment['commnetId'],
                                commenterId: comment['userId'],
                                commentName: comment['name'],
                                commentBody: comment['commentBody'],
                                commenterImage: comment['userImageUrl'],
                                commentterEmail: comment['commenterEmail'],
                              );
                            },
                            itemCount: snapshot.data!['jobcomments'].length,
                            separatorBuilder: ((context, index) {
                              return const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              );
                            }),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          // comment section
        ],
      )),
    );
  }

  void _mailTo(email) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: email,
        query:
            'subject= Write Subject  here, please&body=Hello, please write details here');
    final url = params.toString();
    launchUrlString(url);
  }
}
