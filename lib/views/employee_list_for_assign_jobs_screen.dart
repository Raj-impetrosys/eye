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
  DbController dbController = DbController();

  @override
  void initState() {
    // getEmployeeListApi = getManagerEmployeesList();
    dbController.openDb(tableName: "employee_list", tableType: TableType.employeeList).whenComplete((){
      setState(() {
      });
    });
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
        title: 'Assign Jobs',
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: (){
          showFetchDataDialog();
        },
      ),
      body: SafeArea(
        child: FutureBuilder(
            // future: getEmployeeListApi,
            future: dbController.getData(tableName: "employee_list"),
            builder:
                (context, AsyncSnapshot<List<ManagerEmployeeList>> snapshot) {
              if (snapshot.hasData) {
                List<ManagerEmployeeList> employeeList =
                    snapshot.data!;
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


  void showFetchDataDialog(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Sync employee list from server"),
      actions: [
        ElevatedButton(onPressed: (){
          syncEmployeeListFromServer()
            ..catchError((e)=>showToast(msg: e))
            ..onError((error, stackTrace) => showToast(msg: error))
            ..whenComplete(() => Navigator.pop(context));
        }, child: const Text("Ok")),
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancel")),
      ],
    ));
  }

  Future syncEmployeeListFromServer() async{
    getEmployeeListApi = getManagerEmployeesList().then((value){
      dbController.openDb(tableName: "employee_list", tableType: TableType.employeeList).whenComplete((){
        dbController.deleteTableData(tableName: "employee_list");
        for(var employee in value.employeeList) {
          dbController.insertData(data: employee.toJson(),tableName: "employee_list", tableType: TableType.employeeList);
        }
        setState(() {
        });
        showToast(msg: "Refreshed");
        // dbController.getData().then((value){
        //   for(var employee in value) {
        //     managerEmployeeList.add(ManagerEmployeeList.fromJson(employee));
        //   }
        //   print(managerEmployeeList);
        // });
      });
      return value;
    });
  }
}
