



import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12),
      decoration: const BoxDecoration(
          border: Border(
        right: BorderSide(width: 1),
      )),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Image.network(image)),
    );
  }
}