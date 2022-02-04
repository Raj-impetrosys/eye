import 'package:eye/globals/functions/on_back_button_pressed.dart';
import 'package:eye/globals/index.dart';
import 'package:eye/views/employee_list_for_assign_jobs_screen.dart';
import 'package:eye/views/records_screen.dart';
import 'get_employee_jobs_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String? firstName;
  String? lastName;

  getEmployeeInfo() {
    SharedPreference.getFirstName().then((value) {
      setState(() {
        firstName = value;
      });
    });
    SharedPreference.getLastName().then((value) {
      setState(() {
        lastName = value;
      });
    });
  }

  @override
  void initState() {
    getEmployeeInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onBackButtonPressed(context),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    height: 220,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                          Color(0xff19319F),
                          Color(0xff79CEFB),
                        ])),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: logoutBtn(context)),
                        const Text(
                          "Hello",
                          style: TextStyle(color: Colors.white30),
                        ),
                        Text(
                          "$firstName $lastName",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const Text(
                          "What you choose to do today?",
                          style: TextStyle(color: Colors.white30),
                        )
                      ],
                    ),
                  ),
                  Container()
                ],
              ),
              Positioned(
                top: 190,
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const EmployeeListScreen()));
                          },
                          child: menuItem(
                              title: 'Employee List',
                              image: 'menu_employee_list'),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const GetEmployeeJobsScreen()));
                          },
                          child: menuItem(
                              title: 'Get Employee Jobs',
                              image: 'menu_iris_enrolment'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const EmployeeListForAssignJobsScreen()));
                          },
                          child: menuItem(
                              title: 'Assign Jobs',
                              image: 'menu_authentication'),
                        ),
                        InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const RecordsScreen()));
                            },
                            child: menuItem(
                                title: 'Record', image: 'menu_record')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget menuItem({required String image, required String title}) => SizedBox(
      width: 180,
      height: 180,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/$image.png",
                height: 100,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
