import 'dart:async';

import 'package:eye/services/api/manager_logout_api.dart';
import 'package:eye/views/bottom_sheet_screen.dart';
import '../index.dart';

StreamController<Uint8List> streamController =
    StreamController<Uint8List>.broadcast();

Widget logoutBtn(context) => IconButton(
      onPressed: () {
        // SharedPreference.logOut().whenComplete(() {
        //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginScreen()));
        // });
        // SharedPreference.getUserId().then((userId) => logOut(context: context, userId: userId, eyeImage: eyeImage));

        EyeScannerController eyeScannerController = EyeScannerController();
        eyeScannerController.init();
                              EyeScannerController.messageChannel
                                  .receiveBroadcastStream()
                                  .listen((event) {
                                print("event: $event");
                                // setState(() {
                                //   bytes = event;
                                // });
                                streamController.add(event);
                              });
        // if(formKey.currentState!.validate()) {
        Uint8List? bytes;
        showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheetScreen(bytes: bytes)
            //     Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     Text(
            //       "Please scan your eye",
            //       style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold),
            //     ),
            //     // if (bytes != null)
            //     //   Image.memory(
            //     //     bytes!,
            //     //     width: 200,
            //     //     height: 200,
            //     //   ),
            //   ],
            // ),
            ).whenComplete(() {
          eyeScannerController.stopScan();
        });
        // }
        eyeScannerController.startScan().then((value) {
          // streamController.add(value);
          bytes = value;
          showModalBottomSheet(
              context: context,
              builder: (context) => BottomSheetScreen(bytes: value));
          // Navigator.pop(context);
          SharedPreference.getUserId().then((userId) =>
              logOut(context: context, userId: userId, eyeImage: value));
        });
      },
      icon: const Icon(
        Icons.power_settings_new_rounded,
        color: Colors.white,
      ),
    );
