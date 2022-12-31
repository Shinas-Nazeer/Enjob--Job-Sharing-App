import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({
    super.key,
    required this.text,
    required this.senderUid,
  });

  final String text;
  final String senderUid;
  final _user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: _user.uid == senderUid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 5.0,
            borderRadius: _user.uid == senderUid
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0)),
            color:
                _user.uid == senderUid ? Colors.lightBlueAccent : Colors.amber,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
