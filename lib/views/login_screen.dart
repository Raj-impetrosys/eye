import 'package:eye/services/api/login_api.dart';
import 'package:eye/views/authentication_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/login_logo.png",
            width: 200,
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          TextFormField(
            controller: _userName,
            decoration: const InputDecoration(
                hintText: "Enter Username", suffixIcon: Icon(Icons.person)),
          ),
          TextFormField(
            controller: _passWord,
            decoration: const InputDecoration(
                hintText: "Enter Password", suffixIcon: Icon(Icons.lock)),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AuthenticationScreen(
                            userName: _userName.text,
                            password: _passWord.text,
                          )));
                  // login(
                  //     userName: _userName.text,
                  //     password: _passWord.text,
                  //     eyeImage: "",
                  //     attendType: "in");
                },
                child: const Text("LOGIN")),
          )
        ],
      ),
    );
  }
}
