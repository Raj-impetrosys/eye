import 'package:eye/services/api/manager_logout_api.dart';
import '../index.dart';

Widget logoutBtn(context)=>IconButton(
  onPressed: (){
    // SharedPreference.logOut().whenComplete(() {
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginScreen()));
    // });
    // SharedPreference.getUserId().then((userId) => logOut(context: context, userId: userId, eyeImage: eyeImage));

    EyeScannerController eyeScannerController = EyeScannerController();
    eyeScannerController.init();
    // if(formKey.currentState!.validate()) {
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
    // }
    eyeScannerController.startScan().then((value) {
      // Navigator.pop(context);
      SharedPreference.getUserId().then((userId) => logOut(context: context, userId: userId, eyeImage: value));
    });
  },
  icon: const Icon(
    Icons.power_settings_new_rounded,
    color: Colors.white,
  ),
);