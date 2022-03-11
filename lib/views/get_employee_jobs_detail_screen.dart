import 'package:eye/globals/index.dart';
import 'package:eye/services/api/get_employee_job_api.dart';
import 'package:eye/services/api/job_completion_api.dart';

class GetEmployeeJobsDetailScreen extends StatefulWidget {
  final int employeeId;
  const GetEmployeeJobsDetailScreen({Key? key, required this.employeeId})
      : super(key: key);

  @override
  State<GetEmployeeJobsDetailScreen> createState() =>
      _GetEmployeeJobsDetailScreenState();
}

class _GetEmployeeJobsDetailScreenState
    extends State<GetEmployeeJobsDetailScreen> {
  late Future<GetEmployeeJobResponse> getEmployeeJobApi;
  bool loading = false;

  @override
  void initState() {
    getEmployeeJobApi =
        getEmployeeJob(context: context, employeeId: widget.employeeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Get Employee Jobs',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
                future: getEmployeeJobApi,
                builder:
                    (context, AsyncSnapshot<GetEmployeeJobResponse> snapshot) {
                  if (snapshot.hasData) {
                    List<Detail> detail = snapshot.data!.details;
                    if (detail.isNotEmpty) {
                      return ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: detail.length,
                          itemBuilder: (context, index) =>
                              listItem(detail: detail[index]));
                    }
                    if (detail.isEmpty) {
                      return const Center(
                        child: Text("No job details for the employee"),
                      );
                    }
                  }
                  if(snapshot.hasError){
                    return Center(
                      child: Text(snapshot.error.toString())
                    );
                  }
                  return loader();
                }),
            if (loading) loader()
          ],
        ),
      ),
    );
  }

//   Widget listItem({required Detail detail})=>Card(
//     elevation: 5,
//     child: ListTile(
//       onTap: (){
//         // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AuthenticationScreen(userId: employee.id,)));
//       },
//       // leading: CircleAvatar(
//       //   backgroundImage:
//       //   NetworkImage(detail.image),backgroundColor: Colors.black26,),
//       title: Text(
//         "${detail.jobName}",
//         style: const TextStyle(fontWeight: FontWeight.w900),maxLines: 2,overflow: TextOverflow.ellipsis,
//       ),
//       subtitle: Text(
//         detail.jobDescription,
//         style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             color: Color(0xff6A6F7C)),maxLines: 2,overflow: TextOverflow.ellipsis,
//       ),
//       trailing: Text(
//         "${detail.city}",
//         style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             color: Color(0xff6A6F7C)),maxLines: 1,overflow: TextOverflow.ellipsis,
//       ),
//     ),
//   );

  listItem({required Detail detail}) => Card(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detail.jobName,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              detail.jobDescription,
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "District: ${detail.district}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Block: ${detail.block}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Start date: ${detail.startDate}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "End date: ${detail.endDate}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Job duration in days: ${detail.jobDurationInDays}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    jobCompletion(
                            context: context,
                            employeeId: widget.employeeId,
                            jobId: detail.jobId)
                        .whenComplete(() {
                      setState(() {
                        loading = false;
                      });
                    });
                  },
                  child: const Text("Mark Complete")),
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: IconButton(
            //       onPressed: () {
            //         setState(() {
            //           loading = true;
            //         });
            //         jobCompletion(
            //                 context: context,
            //                 employeeId: widget.employeeId,
            //                 jobId: detail.jobId)
            //             .whenComplete(() {
            //           setState(() {
            //             loading = false;
            //           });
            //         });
            //       },
            //       icon: const Icon(
            //         Icons.approval,
            //         color: Colors.green,
            //       )),
            // )
          ],
        ),
      ));
}
