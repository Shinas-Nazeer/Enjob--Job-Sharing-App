import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/constants/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/jobwidget.dart';

class ScreenSearchJob extends StatefulWidget {
  const ScreenSearchJob({super.key});

  @override
  State<ScreenSearchJob> createState() => _ScreenSearchJobState();
}

class _ScreenSearchJobState extends State<ScreenSearchJob> {
  String serachQuery = '';

  Widget _buildSearchFied() {
    return TextField(
        cursorColor: kBlack,
        autocorrect: true,
        decoration: const InputDecoration(
          hintText: 'Search for Jobs...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: kBlack),
        ),
        style: const TextStyle(color: kBlack, fontSize: 16.0),
        onChanged: (query) {
          setState(() {
            serachQuery = query;
       
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchFied(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  FirebaseFirestore.instance.collection('jobs').where('requirement', isEqualTo: true).snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  ):
         SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: ((context, index) {
                            var jobdetails = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                         
                          if(serachQuery.isEmpty){ return Jobwidget(
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
                            );}
                            if (jobdetails['jobtitle']
                          .toString()
                          .toLowerCase()
                          .startsWith(serachQuery.toLowerCase())){
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
                          }
                           return Center(
                            
                           );
                          })),
                    ),
                  ],
                ),
              );


        }));
  }
}
