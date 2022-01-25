import 'package:eye/globals/index.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<EmployeeListResponse> getEmployeeListApi;

  @override
  void initState() {
    getEmployeeListApi = getEmployeeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Employee List',),
      body: SafeArea(
        child: FutureBuilder(
            future: getEmployeeListApi,
            builder: (context, AsyncSnapshot<EmployeeListResponse> snapshot) {
              if (snapshot.hasData) {
                List<EmployeeList> employeeList = snapshot.data!.employeeList;
                return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: employeeList.length,
                    itemBuilder: (context, index) => listItem(employee: employeeList[index])
                );
              }
              return loader();
            }),
      ),
    );
  }

  Widget listItem({required EmployeeList employee})=>Card(
    elevation: 5,
    child: ListTile(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthenticationScreen(userId: employee.id,)));
      },
      leading: CircleAvatar(
          backgroundImage:
          NetworkImage(employee.image),backgroundColor: Colors.black26,),
      title: Text(
        "${employee.firstName} ${employee.lastName}",
        style: const TextStyle(fontWeight: FontWeight.w900),maxLines: 2,overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        employee.phone,
        style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xff6A6F7C)),maxLines: 2,overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        "${employee.id}",
        style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xff6A6F7C)),maxLines: 1,overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}