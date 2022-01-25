import 'package:eye/globals/index.dart';

class EyeScannerController {
  String status = "no status";
  Uint8List? bytes;

  static const platform = MethodChannel('irisChannel');

  init() async {
    await platform.invokeMethod('init').then((value) {
      print(value);
      status = value;
    });
  }

  getDeviceInfo() async {
    await platform.invokeMethod('getDeviceInfo').then((value) {
      print(value);
      status = value;
    });
  }

  Future<Uint8List> startScan() async {
    await platform.invokeMethod('startScan').then((value) {
      print(value);
      if (value is! String) {
        bytes = value;
      } else {
        status = value;
      }
    });
    return bytes!;
  }

  stopScan() async {
    await platform.invokeMethod('stopScan').then((value) {
      print(value);
      status = value;
    });
  }

  unInit() async {
    await platform.invokeMethod('unInit').then((value) {
      print(value);
      status = value;
    });
  }
}