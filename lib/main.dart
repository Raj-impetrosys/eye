import 'package:eye/globals/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eye/views/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.projectName,
      theme: ThemeData(
        primarySwatch: Colors.blue,textTheme: GoogleFonts.poppinsTextTheme()
      ),
      home: const Splash(),
    );
  }
}
