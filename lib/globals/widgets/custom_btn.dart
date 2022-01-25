import '../index.dart';

Widget customBtn({required void Function() onTap, required String btnText})=>InkWell(
  borderRadius: const BorderRadius.all(Radius.circular(10)),
  onTap: onTap,
  child: Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff19319F),
              Color(0xff85CEFA),
            ])),
    child: Center(
      child: Text(
        btnText,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    ),
  ),
);