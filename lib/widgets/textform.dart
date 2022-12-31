import 'package:enjobproject/constants/constants.dart';
import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Function validator;
  final TextEditingController textEditingController;
 final int length;
 final bool enabled;
  const CommonTextFormField(
      {super.key,
      required this.label,
      this.keyboardType = TextInputType.emailAddress,
      required this.validator,
      required this.textEditingController,  this.length=1,  this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
      child: TextFormField(
        enabled: enabled,
        maxLines: length,
          cursorColor: kBlack,
          keyboardType: keyboardType,
          validator: (value) => validator(value),
          controller: textEditingController,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: label,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kBlack, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: kBlack, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          )),
    );
  }
}
