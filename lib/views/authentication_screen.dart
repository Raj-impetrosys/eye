import 'package:eye/globals/index.dart';
import 'package:eye/globals/widgets/custom_btn.dart';
import 'package:eye/globals/widgets/textfield.dart';

enum AttendType { goingIn, goingOut }

class AuthenticationScreen extends StatefulWidget {
  // final String userName, password;
  final int userId;
  const AuthenticationScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  AttendType attendType = AttendType.goingIn;
  EyeScannerController eyeScannerController = EyeScannerController();

  Uint8List? bytes;

  TextEditingController employeeName = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    eyeScannerController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Authentication',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  // customTextField(suffixIcon: 'person-100', controller: employeeName, fieldName: 'Employee Name'),
                  // Text(eyeScannerController.status),
                  (bytes != null)
                      ? Image.memory(
                          bytes!,
                          width: 200,
                          height: 200,
                        )
                      : Image.asset("assets/images/user-500.png",width: 200,),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         print(bytes);
                  //       });
                  //     },
                  //     child: const Text("set")),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            eyeScannerController.startScan().then((value) {
                              setState(() {
                                bytes = value;
                              });
                            });
                          },
                          child: Image.asset(
                            "assets/images/scan-btn-100.png",
                            width: 80,
                          )),
                      SizedBox(width: 10,),
                      GestureDetector(
                          onTap: () {
                            eyeScannerController.stopScan().then((value) {
                              setState(() {
                                bytes = value;
                              });
                            });
                          },
                          child: Image.asset(
                            "assets/images/stop-scan-btn-100.png",
                            width: 80,
                          )),
                    ],
                  ),
                  customBtn(btnText: 'Submit', onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                          employeeAuth(
                              context: context,
                              userId: widget.userId,
                              eyeImage: bytes!,
                              attendType:
                                  (attendType == AttendType.goingIn) ? "in" : "out").whenComplete(() {
                            setState(() {
                              isLoading = false;
                            });
                          });
                  })
                  // ElevatedButton(
                  //     onPressed: () {
                  //       employeeAuth(
                  //           context: context,
                  //           userId: widget.userId,
                  //           eyeImage: bytes!,
                  //           attendType:
                  //               (attendType == AttendType.goingIn) ? "in" : "out");
                  //     },
                  //     child: const Text("Submit"))
                ],
              ),
            ),
            if(isLoading)loader()
          ],
        ),
      ),
    );
  }
}