import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:delight_card/colors/MyColors.dart';
import 'package:delight_card/customer/AreaList.dart';
import 'package:delight_card/customer/Login.dart';
import 'package:delight_card/Home.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(Platform.isAndroid)
    await Firebase.initializeApp();
  print("handling a background message${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if(Platform.isAndroid) {
  //   await Firebase.initializeApp();
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyColors.generateMaterialColor(MyColors.colorPrimary),
        textTheme: GoogleFonts.latoTextTheme()
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    taketo();
    super.initState();
  }

  Future<void> taketo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences != null) {
      sharedPreferences!.setBool("pop", false);
      if (sharedPreferences!.getString("status") == "logged in") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const Home()),
                (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => const Login()),
                (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}


