import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/widgets/jobwidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        leading: InkWell(
          onTap: (() {
            showcatDialogtoUser(context, size);
          }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                backgroundColor: kBlack,
                child: Icon(
                  Icons.sort_rounded,
                  color:
                      (jobcategoryfilter == null) ? Colors.white : Colors.red,
                )),
          ),
        ),
       
      ),
      backgroundColor: kWhite,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('jobs')
            // .where('jobtitle')
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children:const [
                        SizedBox(width: 10,),
                       Text('Find Your \nPerfect job', style: TextStyle(fontSize:40),),
                      ],
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
                              ),
                              userUID: jobdetails['uploadedby'],
                              jobId: jobdetails['jobId'],
                              applicants: jobdetails['applicants'],
                              joblocation: jobdetails['joblocation'], uploaderEmail: jobdetails['email'],
                            );
                          })),
                    ),
                  ],
                ),
              );
            } else {
              return SafeArea(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [

                    const Center(child: Text('NO jobs Available for this Category')),
                  ],
                ),
              );
            }
          }
          return const Center(
            child: Text('Something Went Wrong'),
          );
        },
      ),
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
