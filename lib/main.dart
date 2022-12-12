// @dart = 2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ultimatekmkfinal/firebase_options.dart';
import 'screens/home/home.dart';

const apiKey = 'AIzaSyC5K5PThexAf9Y4WyqzwbUH5qr0fX9WvMc';
const projectId = 'ultimatekmk-a3b41';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Montreal",
      ),
      home: const HomeScreen(),
    );
  }
}
