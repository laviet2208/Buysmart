import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:buysmartm/screen/before_screen/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/finaldata.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //     apiKey: "AIzaSyC6JdUqnd_7iIzehRlQ3w47j_mT7heI8no",
    //     authDomain: "ly-s-shopping.firebaseapp.com",
    //     databaseURL: "https://ly-s-shopping-default-rtdb.firebaseio.com",
    //     projectId: "ly-s-shopping",
    //     storageBucket: "ly-s-shopping.appspot.com",
    //     messagingSenderId: "217543052939",
    //     appId: "1:217543052939:web:c31f88567af02c94a40e8e",
    //     measurementId: "G-B2TH1RNX84",
    //   ),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? language = prefs.getString('language');
  if (language != null) {
    if (language == 'ENG') {
      finaldata.mainLang = finaldata.en;
    } else {
      finaldata.mainLang = finaldata.vi;
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buy Smart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const loading_screen(),
    );
  }
}
