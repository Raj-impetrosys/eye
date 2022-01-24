import 'dart:typed_data';
import 'package:eye/controllers/eye_scanner_controller.dart';
import 'package:eye/globals/functions/validator.dart';
import 'package:eye/globals/widgets/loading_indicator.dart';
import 'package:eye/services/api/login_api.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _passWord = TextEditingController();
  EyeScannerController eyeScannerController = EyeScannerController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Uint8List? bytes;

  bool isLoading = false;

  @override
  void initState() {
    eyeScannerController.init();
    super.initState();
  }

  @override
  void dispose() {
    eyeScannerController.unInit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/eye-500.png",
                    width: 250,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text("Username")),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffE2EAFC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _userName,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Username",
                          suffixIcon: Image.asset(
                            "assets/images/person-100.png",
                            width: 60,
                          )),
                      validator: (value) {
                        // isValid(value, fieldName: "Username");
                        if(value!.trim().isEmpty && value==null){
                          return 'Username is required';
                        }
                          return null;

                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Align(
                        alignment: Alignment.centerLeft, child: Text("Password")),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xffE2EAFC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _passWord,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Password",
                          suffixIcon: Image.asset("assets/images/lock-100.png",
                              width: 60)),
                      validator: (value) {
                        isValid(value, fieldName: "Username");
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Please scan your eye",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // if (bytes != null)
                                  //   Image.memory(
                                  //     bytes!,
                                  //     width: 200,
                                  //     height: 200,
                                  //   ),
                                ],
                              )).whenComplete((){
                                eyeScannerController.stopScan();
                        });
                      }
                      eyeScannerController.startScan().then((value) {
                        // if(bytes==value){
                        //   print("same");
                        // }else{
                        //   print("different");
                        // }
                        // print(value.last);
                        setState(() {
                          bytes = value;
                          isLoading = true;
                        });
                        Navigator.pop(context);
                        login(
                                userName: _userName.text,
                                password: _passWord.text,
                                eyeImage: value,
                                attendType: "in")
                            .whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xff19319F),
                                Color(0xff85CEFA),
                              ])),
                      child: const Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (isLoading) loader()
          ],
        ),
      ),
    );
  }
}
