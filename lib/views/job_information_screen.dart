import 'package:eye/globals/index.dart';
import 'package:eye/services/api/assign_job_to_employee.dart';
import 'package:eye/services/api/get_job_information_api.dart';
import 'package:eye/services/api/get_manager_employees_api.dart';
import 'package:csc_picker/csc_picker.dart';

class GetJobInformation extends StatefulWidget {
  final ManagerEmployeeList employee;
  const GetJobInformation({Key? key, required this.employee}) : super(key: key);

  @override
  State<GetJobInformation> createState() => _GetJobInformationState();
}

class _GetJobInformationState extends State<GetJobInformation> {
  late Future<JobInformationResponse> getJobInformationApi;

  bool loading = false;

  String? countryValue;

  String? stateValue = "Maharashtra";

  String? cityValue;
  DateTimeRange? dateTimeRange;

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    getJobInformationApi = getJobInformation(state: stateValue!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Assign Jobs',
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CSCPicker(
                  defaultCountry: DefaultCountry.India,
                  currentState: stateValue,
                  stateDropdownLabel: stateValue!,
                  disableCountry: false,
                  showCities: false,
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      // loading = true;
                      if (value != null) {
                        stateValue = value;
                        if (stateValue != null) {
                          setState(() {
                            loading = true;
                            getJobInformationApi =
                                getJobInformation(state: stateValue!)
                                    .whenComplete(() {
                              setState(() {
                                loading = false;
                              });
                            });
                          });
                        }
                      }
                      print("state changed $value");
                      // getJobInformationApi =
                      //     getJobInformation(
                      //         state: stateValue!);
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       if (stateValue != null) {
                //         setState(() {
                //           loading = true;
                //           getJobInformationApi =
                //               getJobInformation(state: stateValue!)
                //                   .whenComplete(() {
                //             setState(() {
                //               loading = false;
                //             });
                //           });
                //         });
                //       }
                //     },
                //     child: const Text("Search Jobs")),

                Expanded(
                  child: FutureBuilder(
                      future: getJobInformationApi,
                      builder: (context,
                          AsyncSnapshot<JobInformationResponse> snapshot) {
                        if (snapshot.hasData) {
                          List<Job> employeeList = snapshot.data!.employeeList;
                          if (employeeList.isNotEmpty) {
                            return ListView.builder(
                                padding: const EdgeInsets.all(10),
                                itemCount: employeeList.length,
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        // if (index == 0)
                                        // Text(
                                        //     "search results for $stateValue"),
                                        listItem(detail: employeeList[index])
                                      ],
                                    ));
                          }
                          if (employeeList.isEmpty) {
                            return const Center(
                              child: Text("No Jobs"),
                            );
                          }
                        }
                        return loader();
                      }),
                ),
              ],
            ),
            if (loading) loader()
          ],
        ),
      ),
    );
  }

  listItem({required Job detail}) => Card(
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
              "City: ${detail.city}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "State: ${detail.state}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Mandal: ${detail.mandal}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "No. of people needed: ${detail.numberPeopleNeeded}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Text(
            //   "End date: ${detail.endDate}",
            //   style: const TextStyle(
            //       fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
            Text(
              "Job duration in days: ${detail.jobDurationInDays}",
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Color(0xff6A6F7C)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            TextFormField(
              controller: dateController,
              readOnly: true,
              onTap: () {
                showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate:
                            DateTime.now().add(const Duration(days: 10000)))
                    .then((value) {
                  setState(() {
                    dateTimeRange = value;
                    dateController.text =
                        "${value!.start.toString().split(' ')[0]} to ${value.end.toString().split(' ')[0]}";
                  });
                });
              },
              decoration: const InputDecoration(
                  hintText: "Select date range", border: InputBorder.none),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: (dateTimeRange == null || stateValue == null)
                      ? null
                      : () {
                          setState(() {
                            loading = true;
                          });
                          assignJob(
                                  context: context,
                                  employeeId: widget.employee.id,
                                  jobId: detail.jobId,
                                  startDate: dateTimeRange!.start.toString(),
                                  endDate: dateTimeRange!.end.toString())
                              .whenComplete(() {
                            setState(() {
                              loading = false;
                            });
                          });
                          // jobCompletion(
                          //         context: context,
                          //         employeeId: widget.employeeId,
                          //         jobId: detail.jobId)
                          //     .whenComplete(() {
                          //   setState(() {
                          //     loading = false;
                          //   });
                          // });
                        },
                  child:
                      Text("Assign this Job to ${widget.employee.firstName}")),
            ),
          ],
        ),
      ));
}
