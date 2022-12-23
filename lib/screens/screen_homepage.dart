import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/constants/constants.dart';

import 'package:enjobproject/widgets/jobwidget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

import '../jobcategory/jobcatlist.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenHomePage> createState() => _ScreenHomePageState();
}

final user = FirebaseAuth.instance.currentUser!;
String? jobcategoryfilter;

class _ScreenHomePageState extends State<ScreenHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            .where('jobcategory', isEqualTo: jobcategoryfilter)
            .where('requirement', isEqualTo: true)
            .orderBy('createdat', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isEmpty != true) {
              return SafeArea(
                child: Column(
                  children: [

                                       AnimatedTextKit(
                      animatedTexts: [

                         TypewriterAnimatedText('Find Your PerFect Job', textStyle: const TextStyle(fontSize: 30, color: Colors.black26),
  ),
                      ],
                      isRepeatingAnimation: true,
                      totalRepeatCount: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: topSearchbar(context, size),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: ((context, index) {
                            final jobdetails = snapshot.data?.docs[index];
                            return Jobwidget(
                              jobtitle: jobdetails['jobtitle'],
                              jobdescriptions: jobdetails['jobdescription'],
                              uploadedby: jobdetails['name'],
                              lastdate: jobdetails['deadlinedate'],
                              image: jobdetails['userimage'],
                              trailing: const Icon(
                                Icons.keyboard_arrow_right,
                                size: 40,
                                color: kBlack,
                              ), userUID: jobdetails['uploadedby'], jobId: jobdetails['jobId'], applicants: jobdetails['applicants'],
                            );
                          })),
                    ),
                  ],
                ),
              );
            } else {
              return SafeArea(
                child: Column(
                  children: [
                    topSearchbar(context, size),
                    const Center(
                        child: Text('NO Jobs Available for this Filter')),
                  ],
                ),
              );
            }
          }
          return const Center(
            child: Text('Somethinf Went Wrong'),
          );
        },
      ),
    );
  }

  SearchBarAnimation topSearchbar(BuildContext context, Size size) {
    return SearchBarAnimation(
      searchBoxBorderColour: Colors.black26,
      buttonShadowColour: Colors.black26,
      cursorColour: Colors.black26,
      trailingWidget: InkWell(
          onTap: () {
            showcatDialogtoUser(context, size);
          },
          child: Icon(
            Icons.sort_sharp,
            color: (jobcategoryfilter == null) ? Colors.black26 : Colors.red,
          )),
      textEditingController: TextEditingController(),
      isOriginalAnimation: false,
      buttonBorderColour: Colors.black26,
      buttonWidget: const Icon(
        Icons.search,
        color: Colors.black26,
      ),
      onFieldSubmitted: (String value) {
        debugPrint('onFieldSubmitted value $value');
      },
      secondaryButtonWidget: InkWell(
          onTap: (() {
            //navigate to search screen
          }),
          child: const Icon(
            Icons.search,
            color: Colors.black26,
          )),
    );
  }

  showcatDialogtoUser(context, Size size) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text('Select Job Category', style: TextStyle(fontSize: 18)),
          content: SizedBox(
            width: size.width * 0.9,
            child: ListView.builder(
                itemCount: Jobcategory.jobcategorylist.length,
                shrinkWrap: true,
                itemBuilder: ((ctx, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        jobcategoryfilter = Jobcategory.jobcategorylist[index];
                      });
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.play_arrow_rounded),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Jobcategory.jobcategorylist[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
          actions: [
            TextButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: (() {
                  setState(() {
                    jobcategoryfilter = null;
                  });
                  Navigator.pop(context);
                }),
                child: const Text(
                  'Cancel Filter',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        );
      });
}
