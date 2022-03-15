import 'package:eye/globals/index.dart';
import 'package:eye/globals/widgets/custom_btn.dart';
import 'package:eye/models/attendance_model.dart';
import 'package:eye/services/api/attendance_offline_api.dart';

enum AttendType { goingIn, goingOut }

class AuthenticationScreen extends StatefulWidget {
  // final String userName, password;
  final int userId;
  const AuthenticationScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  AttendType attendType = AttendType.goingIn;
  EyeScannerController eyeScannerController = EyeScannerController();
  DbController dbController = DbController();

  Uint8List? bytes;

  TextEditingController employeeName = TextEditingController();

  bool isLoading = false;
  Uint8List? event;
  String tableName = "attendance";

  @override
  void initState() {
    dbController
        .openDb(tableName: tableName, tableType: TableType.attendance)
        .whenComplete(() {
      // setState(() {
      // });
      // dbController.deleteTable(tableName: tableName);
      // try {
      //   dbController.createTable(tableName: tableName, tableType: TableType.attendance);
      // } on DatabaseException{
      //   print("table already exist");
      // }
      // dbController.addColumn(tableName: tableName, columnDefinition: "(name TEXT)");
    });
    eyeScannerController.init();
    EyeScannerController.messageChannel
        .receiveBroadcastStream()
        .listen((event) {
      print("event: $event");
      setState(() {
        bytes = event;
      });
    });

    // eyeScannerController.getEvents.listen((event) {
    //   print("event: $event");
    //   setState(() {
    //     this.event = event.toString();
    //   });
    // });

    // eyeScannerController.messageStream.listen((event) {
    //   print(event);
    //   setState(() {
    //     this.event = event.toString();
    //   });
    //   showToast(msg: event);
    // });
    super.initState();
  }

  @override
  void dispose() {
    dbController.closeDb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Authentication',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      radioButton(
                          text: "In",
                          value: AttendType.goingIn,
                          groupValue: attendType,
                          onChanged: (value) {
                            setState(() {
                              attendType = value;
                            });
                          }),
                      const SizedBox(
                        width: 5,
                      ),
                      radioButton(
                          text: "Out",
                          value: AttendType.goingOut,
                          groupValue: attendType,
                          onChanged: (value) {
                            setState(() {
                              attendType = value;
                            });
                          }),
                    ],
                  ),
                  // customTextField(suffixIcon: 'person-100', controller: employeeName, fieldName: 'Employee Name'),
                  // (event != null)
                  //     ? Image.memory(
                  //         event!,
                  //         width: 200,
                  //         height: 200,
                  //       )
                  //     : Image.asset(
                  //         "assets/images/user-500.png",
                  //         width: 50,
                  //       ),
                  // Text(event),
                  (bytes != null)
                      ? Image.memory(
                          bytes!,
                          width: 200,
                          height: 200,
                        )
                      : Image.asset(
                          "assets/images/user-500.png",
                          width: 200,
                        ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       setState(() {
                  //         print(bytes);
                  //       });
                  //     },
                  //     child: const Text("set")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            eyeScannerController.startScan().then((value) {
                              setState(() {
                                bytes = value;
                              });
                            });
                          },
                          child: Image.asset(
                            "assets/images/scan-btn-100.png",
                            width: 80,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            eyeScannerController.stopScan().then((value) {
                              setState(() {
                                bytes = value;
                              });
                            });
                          },
                          child: Image.asset(
                            "assets/images/stop-scan-btn-100.png",
                            width: 80,
                          )),
                    ],
                  ),
                  customBtn(
                      btnText: 'Submit',
                      onTap: () {
                        if (bytes != null) {
                          setState(() {
                            isLoading = true;
                          });
                          employeeAuth(
                                  context: context,
                                  userId: widget.userId,
                                  eyeImage: bytes!,
                                  attendType: (attendType == AttendType.goingIn)
                                      ? "in"
                                      : "out")
                              .whenComplete(() {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        } else {
                          showToast(msg: "complete eye scan then try again");
                        }
                      }),
                  // FutureBuilder(builder: builder)
                  customBtn(
                      btnText: 'Mark Offline',
                      onTap: () async {
                        if (bytes != null) {
                          // if(true) {
                          setState(() {
                            isLoading = true;
                          });
                          var location = await getLocation();
                          // dbController.deleteTable(tableName: tableName);
                          dbController
                              .insertData(
                                  data: AttendanceModel(
                                          employeeId: widget.userId,
                                          lat: location.latitude.toString(),
                                          long: location.longitude.toString(),
                                          type:
                                              (attendType == AttendType.goingIn)
                                                  ? "in"
                                                  : "out",
                                          file: base64Encode(bytes!),
                                          markTime: DateTime.now()
                                              .toString()
                                              .split('.')[0])
                                      .toJson(),
                                  tableName: "attendance",
                                  tableType: TableType.attendance)
                              .whenComplete(() {
                            setState(() {
                              isLoading = false;
                            });
                          });
                          dbController.getAttendanceData(tableName: tableName);
                        } else {
                          showToast(msg: "complete eye scan then try again");
                        }
                      }),
                  customBtn(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        // dbController.deleteTable(tableName: tableName);
                        dbController
                            .getAttendanceData(tableName: tableName)
                            .then((employeeList) => attendanceSync(
                                        context: context,
                                        employeeList: employeeList)
                                    .then((value) {
                                  if (value.statusCode == 200) {
                                    // showToast(msg: "Successfully synced");
                                    dbController.deleteTableData(
                                        tableName: tableName);
                                  }
                                }).whenComplete(() {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }));
                      },
                      btnText: "Sync Attendance")
                  // ElevatedButton(
                  //     onPressed: () {
                  //       employeeAuth(
                  //           context: context,
                  //           userId: widget.userId,
                  //           eyeImage: bytes!,
                  //           attendType:
                  //               (attendType == AttendType.goingIn) ? "in" : "out");
                  //     },
                  //     child: const Text("Submit"))
                ],
              ),
            ),
            if (isLoading) loader()
          ],
        ),
      ),
    );
  }
}
