// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:enjobproject/constants/constants.dart';
// import 'package:enjobproject/screens/screen_chat2.dart';
// import 'package:flutter/material.dart';

// import '../widgets/applicants.dart';

// class ChatList extends StatelessWidget {
//   const ChatList({
//     super.key,
   
//   });

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Chat List',
//           style: TextStyle(color: kBlack),
//         ),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: kBlack),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//             stream: FirebaseFirestore.instance
//                 .collection('messages')
//                 .orderBy('time', descending: true)
//                 .snapshots(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.active) {
//                 if (snapshot.data?.docs.isEmpty != true) {
//                   return ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final applicant =
//                             snapshot.data?.docs[index];
//                             return ChatListof(applicantEmail: applicant['receivername'],
//                              applicantName: applicant['receivername'],
//                               applicantImage: applicant['receiverImage'], 
//                               applicantUid: applicant['receiver'],
//                                jobId: '');
//                     },
//                     itemCount: snapshot.data?.docs.length,
//                     separatorBuilder: ((context, index) {
//                       return const Divider(
//                         thickness: 1,
//                         color: Colors.grey,
//                       );
//                     }),
//                   );
//                 } else {
//                   return SafeArea(
//                     child: Column(
//                       // ignore: prefer_const_literals_to_create_immutables
//                       children: [
//                         const Center(child: Text('NO Messages')),
//                       ],
//                     ),
//                   );
//                 }
//               }
//               return const Center(
//                 child: Text('Something Went Wrong'),
//               );
//             }),
//       ),
//     );
//   }
// }

// class ChatListof extends StatelessWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   ChatListof({
//     super.key,
//     // required this.applicantId,
//     required this.applicantEmail,
//     required this.applicantName,
//     required this.applicantImage,
//     required this.applicantUid,
//     required this.jobId,
//   });

//   // final String applicantId;
//   final String applicantEmail;
//   final String applicantName;
//   final String applicantUid;
//   final String applicantImage;
//   final String jobId;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ChatPage2(
//                       receiverimage: applicantImage,
//                       receivername: applicantName,
//                       receiveremail: applicantEmail,
//                       receiverUid: applicantUid,
//                       jObid: jobId,
//                     )));
//       }),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Flexible(
//               flex: 1,
//               child: Container(
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 2,
//                       color: Colors.amber,
//                     ),
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                         image: NetworkImage(applicantImage), fit: BoxFit.fill)),
//               )),
//           const SizedBox(
//             width: 6,
//           ),
//           Flexible(
//               flex: 5,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [Text(applicantName), const Text('Tap to chat')],
//               ))
//         ],
//       ),
//     );
//   }
// }
