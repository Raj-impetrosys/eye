import 'package:eye/globals/index.dart';
import 'package:eye/globals/widgets/custom_btn.dart';

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
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
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
                        if(value!.trim().isEmpty){
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
                  customBtn(btnText: 'LOGIN', onTap: () {
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
                      login(context: context,
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
                  }),
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