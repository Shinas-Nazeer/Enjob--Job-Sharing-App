



// ignore: camel_case_types
import 'package:flutter/material.dart';

class Chat_Title extends StatelessWidget {
  final String applicantEmail;

  const Chat_Title({
    super.key,
    required this.applicantName,
    required this.applicantImage,
    required this.applicantEmail,
  });

  final String applicantName;

  final String applicantImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {}),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 6,
                ),
                Text(
                  applicantName,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                Text(
                  applicantEmail,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}