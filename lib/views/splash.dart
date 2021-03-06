import 'package:eye/globals/index.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // SharedPreference.saveEmployeeInfo(
    //     id: 16, firstName: "Raj", lastName: "patel");
    SharedPreference.getIsLogin().then((isLogin) {
      Future.delayed(const Duration(seconds: 3)).whenComplete(() =>
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  (isLogin) ? const DashBoardScreen() : const LoginScreen())));
    });
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
              'assets/images/logo-trans-1024.png',
              // height: 200,
              width: 250,
              // scale: 2,
            ),
            const Text(
              "IRIS",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800),
            ),
            const Text(
              "SCANNER",
              style: TextStyle(fontSize: 16, color: Color(0xff32426E)),
            )
          ],
        ),
      ),
    );
  }
}
