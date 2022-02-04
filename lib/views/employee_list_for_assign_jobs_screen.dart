import 'package:eye/globals/index.dart';
import 'package:eye/services/api/get_manager_employees_api.dart';
import 'package:eye/views/job_information_screen.dart';

class EmployeeListForAssignJobsScreen extends StatefulWidget {
  const EmployeeListForAssignJobsScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListForAssignJobsScreen> createState() =>
      _EmployeeListForAssignJobsScreenState();
}

class _EmployeeListForAssignJobsScreenState
    extends State<EmployeeListForAssignJobsScreen> {
  late Future<ManagerEmployeesResponse> getEmployeeListApi;

  @override
  void initState() {
    getEmployeeListApi = getManagerEmployeesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Assign Jobs',
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: getEmployeeListApi,
            builder:
                (context, AsyncSnapshot<ManagerEmployeesResponse> snapshot) {
              if (snapshot.hasData) {
                List<ManagerEmployeeList> employeeList =
                    snapshot.data!.employeeList;
                if (employeeList.isNotEmpty) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) =>
                          listItem(employee: employeeList[index]));
                }
                if (employeeList.isEmpty) {
                  return const Center(
                    child: Text("No employees"),
                  );
                }
              }
              return loader();
            }),
      ),
    );
  }

  Widget listItem({required ManagerEmployeeList employee}) => Card(
        elevation: 5,
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GetJobInformation(
                      employee: employee,
                    )));
          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(employee.image),
            backgroundColor: Colors.black26,
          ),
          title: Text(
            "${employee.firstName} ${employee.lastName}",
            style: const TextStyle(fontWeight: FontWeight.w900),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            employee.phone,
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            "${employee.id}",
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
}
