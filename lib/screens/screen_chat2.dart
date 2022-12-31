import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/chat_appbar.dart';
import '../widgets/message_bubble.dart';

class ChatPage2 extends StatefulWidget {
  ChatPage2({
    super.key,
    required this.receivername,
    required this.receiverimage,
    required this.receiveremail,
    required this.receiverUid,
    required this.jObid,
  });

  final String receivername;
  final String receiverimage;
  final String receiveremail;
  final String receiverUid;
  final String jObid;

  @override
  State<ChatPage2> createState() => _ChatPage2State();
}

class _ChatPage2State extends State<ChatPage2> {
  final TextEditingController _meaasgeController = TextEditingController();

  final _user = FirebaseAuth.instance.currentUser!;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          title: Chat_Title(
            applicantName: widget.receivername,
            applicantImage: widget.receiverimage,
            applicantEmail: widget.receiveremail,
          )),
      body: Column(
      
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
         
            stream: FirebaseFirestore.instance
                .collection('messages')
                .orderBy('time', descending: true)
                
                .where('chatroomId', isEqualTo: chatRoomId()
                )
              
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data?.docs.isEmpty != true) {
                  return Expanded(
                    child: ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: ((context, index) {
                          final messages1 = snapshot.data?.docs[index];
                          return MessageBubble(
                            text: messages1['text'],
                            senderUid: messages1['sender'],
                          );
                        })),
                  );
                } else {
                  return SafeArea(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Center(child: Text('NO Messages')),
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
          Container(
            color: Colors.grey.shade300,
            child: TextField(
              controller: _meaasgeController,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  hintText: 'Type your Messgae Here.....',
                  suffixIcon: InkWell(
                      onTap: (() async {
                        String chatId = chatRoomId();
                        await FirebaseFirestore.instance
                            .collection('messages')
                            .add({
                          'sender': FirebaseAuth.instance.currentUser!.uid,
                          'receiver': widget.receiverUid,
                          'sendername': _user.displayName,
                          'receivername': widget.receivername,
                          'text': _meaasgeController.text,
                          'time':Timestamp.now(),
                          'chatroomId':chatId,
                          'receiverImage':widget.receiverimage
                        });
                   
                 
                        _meaasgeController.clear();
                      }),
                      child: const Icon(Icons.send))),
            ),
          )
        ],
      ),
    );
  }

  String chatRoomId() {
    if (widget.receivername[0].toLowerCase().codeUnits[0] >
        _user.displayName![0].toLowerCase().codeUnits[0]) {
      return (widget.receiverUid + _user.uid);
    } else {
      return (_user.uid + widget.receiverUid);
    }
  }
}
