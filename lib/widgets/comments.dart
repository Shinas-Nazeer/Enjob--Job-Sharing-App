import 'package:enjobproject/screens/otheruser.dart';
import 'package:enjobproject/screens/profle.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  Comments(
      {super.key,
      required this.commentId,
      required this.commenterId,
      required this.commentName,
      required this.commentBody,
      required this.commenterImage,
      required this.commentterEmail});

  final String commentId;

  final String commenterId;
  final String commentterEmail;
  final String commentName;

  final String commentBody;

  final String commenterImage;

  final List<Color> _colors = [
    Colors.amber,
    Colors.orange,
    Colors.red,
    Colors.brown,
    Colors.brown,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    _colors.shuffle;
    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtherUserProfileScreen(
                      imageUrl: commenterImage,
                      userEmail: commentterEmail,
                      userName: commentName,
                      userId: commenterId,
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
                      color: _colors[1],
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(commenterImage), fit: BoxFit.fill)),
              )),
          const SizedBox(
            width: 6,
          ),
          Flexible(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(commentName),
                  Text(
                    commentBody,
                    maxLines: 5,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
