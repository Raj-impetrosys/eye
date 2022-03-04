import 'package:eye/globals/index.dart';

class BottomSheetScreen extends StatefulWidget {
  final Uint8List? bytes;
  const BottomSheetScreen({Key? key, required this.bytes}) : super(key: key);

  @override
  _BottomSheetScreenState createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  Uint8List? bytes;

  @override
  void initState() {
    bytes = widget.bytes;
    streamController.stream.listen((event) {
      setState(() {
        bytes = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 2,
            color: Colors.grey,
          ),
          const Text(
            "Scanning started...",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          (bytes != null)
              ? Image.memory(
                  bytes!,
                  width: 200,
                  height: 200,
                )
              : Image.asset(
                  'assets/images/user-500.png',
                  width: 200,
                ),
        ],
      ),
    );
  }
}
