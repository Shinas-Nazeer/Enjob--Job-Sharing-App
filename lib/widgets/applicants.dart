
import 'package:flutter/material.dart';

import '../screens/screen_chat2.dart';

class Applicants extends StatelessWidget {
  const Applicants({
    super.key,
    required this.applicantId,
    required this.applicantEmail,
    required this.applicantName,
    required this.applicantImage,
    required this.applicantUid, required this.jobId,
  });

  final String applicantId;
  final String applicantEmail;
  final String applicantName;
  final String applicantUid;
  final String applicantImage;
final String jobId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (()  {
       

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage2(
                      receiverimage: applicantImage,
                      receivername: applicantName,
                      receiveremail: applicantEmail,
                      receiverUid: applicantUid, jObid: jobId,
                    )));
      }),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 1,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.amber,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(applicantImage), fit: BoxFit.fill)),
              )),
          const SizedBox(
            width: 6,
          ),
          Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(applicantName), Text(applicantEmail)],
              ))
        ],
      ),
    );
  }
}
