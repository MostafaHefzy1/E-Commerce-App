import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../resource/constants-manager.dart';
import '../resource/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: timeDelay), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.homeLayoutScreen);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          width: size.width * 1,
          height: size.height * 1,
          child: Center(
              child: Lottie.asset(
                  'assets/animation-file/35633-google-icons-my-business.json'))),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
