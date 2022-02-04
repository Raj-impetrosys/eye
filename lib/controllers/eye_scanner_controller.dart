import 'package:eye/globals/index.dart';

class EyeScannerController {
  String status = "no status";
  Uint8List? bytes;

  static const MethodChannel platform = MethodChannel('irisChannel');
  static const EventChannel messageChannel = EventChannel('eventChannelStream');

  // Stream<String> get messageStream async* {
  //   await for (String message
  //       in messageChannel.receiveBroadcastStream().map((message) => message)) {
  //     yield message;
  //   }
  // }

  // Stream<dynamic> get getEvents {
  //   return messageChannel.receiveBroadcastStream().cast();
  // }

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
