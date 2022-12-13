import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../constants/constants.dart';

class ScreenJobProfile extends StatelessWidget {
  const ScreenJobProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kThemecolor),
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: kThemecolor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  ListTile(
                    leading: Image.asset(
                      'images/png-apple-logo-9707.png',
                      width: 48,
                      height: 48,
                    ),
                    title: Text('Sr.developer', style: TextStyle(fontSize: 30)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Apple'),
                        Text(
                          'California United States',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(color: Colors.black, fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    height: 10,
                    thickness: 2,
                  ),
                  Text(
                    '3 Applicants',
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    height: 10,
                    thickness: 2,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('Job Discription:'),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'It l. The point of using L is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.It is a long established fact that a reader will be distracted by t at its layout. The point of using L is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English.',
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                        height: 130,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: kThemecolor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NiceButtons(
                          height: 30,
                          width: 150,
                         
                          onTap: (){}, child: Text('Apply Now',  style: const TextStyle(
                        fontSize: 15, color: Colors.white),),
                          stretch: false,),
                      ),
                     const Divider(
                    indent: 20,
                    endIndent: 20,
                    height: 10,
                    thickness: 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
    
                      Text('Uploaded On:         2022-7-7'),
                       Text('Deadline   :                2022-7-7'),
                    ],
                  ),
                      const Divider(
                    indent: 20,
                    endIndent: 20,
                    height: 10,
                    thickness: 2,
                  ),
                    ],
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
               height: 70,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: kThemecolor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
    
                    Icon(Icons.add_circle, size: 50, color: Colors.white,),
                    Icon(Icons.chat, size: 50, color: Colors.white,)
                    ],
                  ),
            )
          ],
        ),
      ),
    );
  }
}
