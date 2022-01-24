import 'package:fluttertoast/fluttertoast.dart';

showToast({msg})=>Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    // backgroundColor: Colors.black,
    // textColor: Colors.white,
    fontSize: 16.0
);