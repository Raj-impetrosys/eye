import 'dart:typed_data';

import 'package:eye/controllers/eye_scanner_controller.dart';
import 'package:eye/globals/widgets/radio_button.dart';
import 'package:eye/services/api/login_api.dart';
import 'package:flutter/material.dart';

enum AttendType { goingIn, goingOut }

class AuthenticationScreen extends StatefulWidget {
  final String userName, password;
  const AuthenticationScreen(
      {Key? key, required this.userName, required this.password})
      : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  AttendType attendType = AttendType.goingIn;
  EyeScannerController eyeScannerController = EyeScannerController();

  Uint8List? bytes;

  @override
  void initState() {
    eyeScannerController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              radioButton(
                  text: "In",
                  value: AttendType.goingIn,
                  groupValue: attendType,
                  onChanged: (value) {
                    setState(() {
                      attendType = value;
                    });
                  }),
              const SizedBox(
                width: 5,
              ),
              radioButton(
                  text: "Out",
                  value: AttendType.goingOut,
                  groupValue: attendType,
                  onChanged: (value) {
                    setState(() {
                      attendType = value;
                    });
                  }),
            ],
          ),
          Text(eyeScannerController.status),
          if (bytes != null)
            Image.memory(
              bytes!,
              width: 200,
              height: 200,
            ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  print(bytes);
                });
              },
              child: const Text("set")),
          GestureDetector(
              onTap: () {
                eyeScannerController.startScan().then((value) {
                  setState(() {
                    bytes = value;
                  });
                });
              },
              child: Image.asset(
                "assets/images/scan_btn.png",
                width: 80,
              )),
          ElevatedButton(
              onPressed: () {
                login(
                    userName: widget.userName,
                    password: widget.password,
                    eyeImage: bytes!,
                    attendType: attendType);
              },
              child: const Text("Submit"))
        ],
      ),
    );
  }
}
