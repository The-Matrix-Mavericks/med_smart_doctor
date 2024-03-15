import 'dart:async';

import 'package:demo_app/screens/authentication/loginOrSignupPage.dart';
import 'package:demo_app/screens/splash_screen/waiting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.to(() => WaitingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 124, 251),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.65,
          height: double.infinity,
          child: Image.asset(
            "assets/app_logo_white.png",
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
