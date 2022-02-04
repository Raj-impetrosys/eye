import 'dart:io';
import 'package:eye/globals/index.dart';

Future<bool> onBackButtonPressed(context) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Do you really want to exit the app?'),
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pop(context, false),
          child: Container(
            height: height * 0.0433,
            width: width * 0.166,
            child: const Center(
                child: Text(
              'No',
              style: TextStyle(color: Colors.white),
            )),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(width * 0.055),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pop(context, true);
            exit(0);
          },
          child: Container(
            height: height * 0.0433,
            width: width * 0.166,
            child: const Center(
                child: Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            )),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(width * 0.055)),
          ),
        ),
      ],
    ),
  );
}
