import 'package:enjobproject/screens/screen_login.dart';
import 'package:flutter/material.dart';

class KButton extends StatelessWidget {
  const KButton({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ScreenLoginPage()));
      },
      child: PhysicalModel(
        elevation: 8,
        color: const Color.fromARGB(156, 41, 182, 246),
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
            width: 200.0,
            height: 50,
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                    fontSize: 25, fontFamily: ('Popins'), color: Colors.white),
              ),
            )),
      ),
    );
  }
}
