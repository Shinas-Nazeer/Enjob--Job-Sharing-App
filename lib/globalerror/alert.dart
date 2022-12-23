

// import 'package:enjobproject/screens/screen_profile.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../provider/googlesignin.dart';

// showAlerttoUser(context) => showDialog(
//     context: context,
//     builder: (context) {
//       return   AlertDialog(


//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: const [
//             Text('Are You Sure Want to logout?', style: TextStyle(color: Colors.red)),
              
//           ],
        
//         ),
//         actions: [   TextButton(onPressed: (() {
//                final provider =
//                                     Provider.of<GoogleSignProvider>(context,
//                                         listen: false);
//                                 provider.logout();
//                                 logout();   
//           logout();
           
//           }), child: const Text('Yes ')),
//           TextButton(onPressed: (() {
//             Navigator.pop(context);
//           }), child: const Text('No '))
//         ],
//       );
//     });