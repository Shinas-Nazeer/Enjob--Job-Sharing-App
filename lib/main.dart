import 'package:enjobproject/constants/constants.dart';
import 'package:enjobproject/provider/create_account.dart';
import 'package:enjobproject/provider/googlesignin.dart';
import 'package:enjobproject/provider/onoff_notifier.dart';

import 'package:enjobproject/provider/passwordhider.dart';

import 'package:enjobproject/screens/screen_login.dart';
import 'package:enjobproject/widgets/bottom_navrbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GoogleSignProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordHider(),
        ),
        ChangeNotifierProvider(
          create: (_) => Userdetailsvaribles(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReccuritmentOnoff(),
        ),
      ],
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: kWhite, elevation: 0, iconTheme: IconThemeData(color: kBlack)),
            fontFamily: ('Popins'),
            inputDecorationTheme: const InputDecorationTheme(
                filled: true, fillColor: Colors.white)),
        home: const MyApp1(),
      ),
    );
  }
}

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const BottomNavbarwidget();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('sonmetinhg wrong'),
              );
            } else {
              return ScreenLoginPage();
            }
          }),
    );
  }
}
