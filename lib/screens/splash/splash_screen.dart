import 'dart:async';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Material(
      color: kBlack,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/splash.png"), fit: BoxFit.fitWidth),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage("images/l.png"),
                height: 100,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "CRYPTO",
                style: TextStyle(
                    fontSize: 24, color: kGreen, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
