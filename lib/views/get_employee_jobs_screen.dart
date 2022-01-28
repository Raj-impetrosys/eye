import 'package:eye/globals/index.dart';
import 'package:eye/views/get_employee_jobs_detail_screen.dart';

class GetEmployeeJobsScreen extends StatefulWidget {
  const GetEmployeeJobsScreen({Key? key}) : super(key: key);

  @override
  State<GetEmployeeJobsScreen> createState() => _GetEmployeeJobsScreenState();
}

class _GetEmployeeJobsScreenState extends State<GetEmployeeJobsScreen> {
  late Future<EmployeeListResponse> getEmployeeListApi;

  @override
  void initState() {
    getEmployeeListApi = getEmployeeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Get Employee Jobs',),
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GetEmployeeJobsDetailScreen(employeeId: employee.id,)));
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