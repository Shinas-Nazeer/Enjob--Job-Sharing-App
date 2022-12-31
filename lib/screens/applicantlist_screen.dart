import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/widgets/applicants.dart';
import 'package:flutter/material.dart';

class ApplicantListScreen extends StatelessWidget {
  const ApplicantListScreen({
    super.key,
    required this.jobId,
  });

  final String jobId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Applicants List',
          style: TextStyle(color: kBlack),
        ),
        elevation: 0,
        backgroundColor: kWhite,
        iconTheme: const IconThemeData(color: kBlack),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance.collection('jobs').doc(jobId).get(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data == null) {
                const Center(
                    child: Text(
                  'No Applicant ',
                  style: TextStyle(color: Colors.red),
                ));
              }
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final applicant = snapshot.data!['listofapplicants'][index];
                return Applicants(
                    applicantId: applicant['ApplicantId'],
                    applicantEmail: applicant['ApplicantEmail'],
                    applicantName: applicant['Applicantname'],
                    applicantImage: applicant['ApplicantImage'], applicantUid: applicant['ApplicantId'], jobId: jobId,);
              },
              itemCount: snapshot.data!['listofapplicants'].length,
              separatorBuilder: ((context, index) {
                return const Divider(
                  thickness: 1,
                  color: Colors.grey,
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
