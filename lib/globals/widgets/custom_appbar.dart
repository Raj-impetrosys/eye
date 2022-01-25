import 'package:eye/globals/index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) => AppBar(
    leading: InkWell(
      borderRadius: BorderRadius.circular(500),
        onTap: (){
      Navigator.pop(context);
    },child: Image.asset("assets/images/back-100.png")),
    centerTitle: true,
    title: Text(title),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Color(0xff19319F), Color(0xff6DC6F6)]),
      ),
    ),
    actions: [logoutBtn(context)],
  );
}