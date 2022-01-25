import 'package:eye/globals/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String status = "no status";

  static const platform = MethodChannel('irisChannel');

  init() async {
    await platform.invokeMethod('init').then((value) {
      print(value);
      setState(() {
        status = value;
      });
    });
  }

  getDeviceInfo() async {
    await platform.invokeMethod('getDeviceInfo').then((value) {
      print(value);
      setState(() {
        status = value;
      });
    });
  }

  startScan() async {
    await platform.invokeMethod('startScan').then((value) {
      print(value);
      setState(() {
        status = value;
      });
    });
  }

  stopScan() async {
    await platform.invokeMethod('stopScan').then((value) {
      print(value);
      setState(() {
        status = value;
      });
    });
  }

  unInit() async {
    await platform.invokeMethod('unInit').then((value) {
      print(value);
      setState(() {
        status = value;
      });
    });
  }

  // Future<Null> doNativeSuff() async {
  //   print("tapped");
  //   String _message;
  //   try {
  //     //modify
  //     final String result = await platform.invokeMethod('init');
  //     _message = result;
  //     print(result);
  //   } on PlatformException catch (e) {
  //     _message = "Sadly I can not vibrate: ${e.message}.";
  //   }
  //   setState(() {
  //     status = _message;
  //   });
  //   print(_message);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MIS100V2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              status.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                init();
              },
              child: const Text("init"),
            ),
            ElevatedButton(
              onPressed: () {
                getDeviceInfo();
              },
              child: const Text("getDeviceInfo"),
            ),
            ElevatedButton(
              onPressed: () {
                startScan();
              },
              child: const Text("startScan"),
            ),
            ElevatedButton(
              onPressed: () {
                stopScan();
              },
              child: const Text("stopScan"),
            ),
            ElevatedButton(
              onPressed: () {
                unInit();
              },
              child: const Text("unInit"),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}