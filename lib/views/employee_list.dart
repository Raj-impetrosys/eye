import 'package:eye/controllers/db_controller.dart';
import 'package:eye/globals/index.dart';
import 'package:eye/services/api/get_manager_employees_api.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<ManagerEmployeesResponse> getEmployeeListApi;
  DbController dbController = DbController();
  @override
  void initState() {
    dbController.openDb(tableName: "employee_list", tableType: TableType.employeeList).whenComplete((){
      setState(() {
      });
      });
    super.initState();
  }
  
  @override
  void didChangeDependencies() {
    // Future.delayed(const Duration(seconds: 2)).whenComplete(() => showFetchDataDialog());
    super.didChangeDependencies();
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
        title: 'Employee List',
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
              // builder:
            //     (context, AsyncSnapshot<ManagerEmployeesResponse> snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
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
                builder: (context) => AuthenticationScreen(
                      userId: employee.id,
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
}

class DBExampleScreen extends StatefulWidget {
  const DBExampleScreen({Key? key}) : super(key: key);

  @override
  _DBExampleScreenState createState() => _DBExampleScreenState();
}

class _DBExampleScreenState extends State<DBExampleScreen> {
  DbController dbController = DbController();

  @override
  void initState() {
    dbController.openDb(tableName: "employee_list", tableType: TableType.employeeList);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ElevatedButton(onPressed: (){
            //   dbController.getDbPath();
            // }, child: const Text("Get DB Path"),),
            ElevatedButton(onPressed: (){
              dbController.openDb(tableName: "employee_list", tableType: TableType.employeeList);
            }, child: const Text("Open DB"),),
            ElevatedButton(onPressed: (){
              dbController.createTable(tableName: "employee_list", tableType: TableType.employeeList);
            }, child: const Text("Create Table"),),
            ElevatedButton(onPressed: (){
              dbController.insertData(tableName: "employee_list",data: ManagerEmployeeList(aadhar: "aadhar", address: "address", district: "district", email: "email", firstName: "firstName", fkManagerId: 0, id: 0, image: "image", lastName: "lastName", leftEye: "leftEye", phone: "phone", rightEye: "rightEye", state: "state", type: Type.M, village: "village").toJson(), tableType: TableType.employeeList);
            }, child: const Text("Insert Data"),),
            ElevatedButton(onPressed: (){
              dbController.deleteTableData(tableName: "employee_list");
            }, child: const Text("Delete Table Data"),),
            ElevatedButton(onPressed: (){
              dbController.deleteTable(tableName: "employee_list");
            }, child: const Text("Delete Table"),),
            ElevatedButton(onPressed: (){
              dbController.getData(tableName: "employee_list");
            }, child: const Text("Get Data"),),
          ],
        ),
      ),
    );
  }
}
