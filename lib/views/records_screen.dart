import 'package:eye/globals/index.dart';
import 'package:eye/services/api/get_attendance_records_api.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({Key? key}) : super(key: key);

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {
  Future<GetAttendanceRecordsResponse>? getAttendanceRecordsApi;

  DateTime? selectedDate = DateTime.now();

  @override
  void initState() {
    selectedDate = DateTime.now();
    getAttendanceRecordsApi =
        getAttendanceRecords(date: selectedDate.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppConstants.themeColorDarkBlue,
          child: const Icon(Icons.calendar_today),
          onPressed: () {
            showDatePicker(
                    context: context,
                    initialDate: selectedDate!,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now())
                .then((pickedDate) {
              // print(pickedDate);
              selectedDate = pickedDate!;
              getAttendanceRecordsApi =
                  getAttendanceRecords(date: selectedDate.toString())
                      .whenComplete(() {
                setState(() {});
              });
            });
            // getAttendanceRecordsApi =
            //     getAttendanceRecords(date: DateTime.now().toString());
          }),
      appBar: const CustomAppBar(
        title: 'Attendance Records',
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getAttendanceRecordsApi,
            builder: (context,
                AsyncSnapshot<GetAttendanceRecordsResponse> snapshot) {
              if (snapshot.hasData) {
                List<EmployeeList1> employeeList = snapshot.data!.employeeList;
                if (employeeList.isNotEmpty) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) =>
                          listItem(employee: employeeList[index]));
                }
                if (employeeList.isEmpty) {
                  return Center(
                    child: Text(
                        "No records for date ${selectedDate.toString().split(" ")[0]}"),
                  );
                }
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return loader();
            }),
      ),
    );
  }

  Widget listItem({required EmployeeList1 employee}) => Card(
        elevation: 5,
        child: ListTile(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => AuthenticationScreen(
            //           userId: employee.id,
            //         )));
          },
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(employee.image),
          //   backgroundColor: Colors.black26,
          // ),
          title: Text(
            employee.name,
            style: const TextStyle(fontWeight: FontWeight.w900),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "In time: ${employee.inTime}\nOut time: ${employee.outTime}",
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
            // maxLines: 2,
            // overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            "${employee.userId}",
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
}
