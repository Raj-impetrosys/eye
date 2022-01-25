import 'package:eye/globals/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.projectName,
      theme: ThemeData(
        primarySwatch: Colors.blue,textTheme: GoogleFonts.lexendDecaTextTheme()
      ),
      home: const Splash(),
    );
  }
}