import 'package:enjobproject/screens/screen_jobdetails.dart';
import 'package:enjobproject/widgets/userimage.dart';
import 'package:flutter/material.dart';

class Jobwidget extends StatelessWidget {
  final String jobtitle;
  final String jobdescriptions;
  final String uploadedby;
  final String lastdate;
  final String image;
  final Widget trailing;
  final String userUID;
  final String jobId;
  final int applicants;
  const Jobwidget(
      {super.key,
      required this.jobtitle,
      required this.jobdescriptions,
      required this.uploadedby,
      required this.lastdate,
      required this.image,
      required this.trailing, required this.userUID, required this.jobId, required this.applicants});

  @override
  Widget build(BuildContext context) {
    return Card(
   
           color: Colors.white70,
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
          onTap: (() {
            Navigator.pushReplacement(context, MaterialPageRoute
            (builder: ((context) =>  ScreenJobdetails(image: image, uploadedby: uploadedby, jobTitle: jobtitle, userUId: userUID, jobId: jobId, jobdescription: jobdescriptions, lastdate1: lastdate, applicants: applicants,))));
          }),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          leading: UserImage(image: image),
          title: Text(
            jobtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade900, fontSize: 18),
          ),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Uploaded by: $uploadedby',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 10),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobdescriptions,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 12),
                    ),
                    Text(
                      'Last date: $lastdate.',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 10),
                    )
                  ],
                ),
              ]),
          trailing: trailing),
    );
  }
}


