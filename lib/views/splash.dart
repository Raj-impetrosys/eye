import 'dart:async';
import 'package:eye/views/login_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
              // height: 200,
              width: 300,
              // scale: 2,
            ),
            const Text(
              "IRIS",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
            ),
            Text(
              "SCANNER",
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
            )
          ],
        ),
      ),
    );
  }
}
