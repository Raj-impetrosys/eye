import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<JobInformationResponse> getJobInformation(
    {required String state}) async {
  var response = await http.post(
      Uri.parse("${AppConstants.baseUrl}get_job_information"),
      body: {"state": state});

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    int status = data['responseStatus'];
    String result = data['result'];
    print(data);
    return JobInformationResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

class JobInformationResponse {
  JobInformationResponse({
    required this.employeeList,
    required this.responseStatus,
    required this.result,
    required this.statusCode,
  });

  final List<Job> employeeList;
  final int responseStatus;
  final String result;
  final int statusCode;

  factory JobInformationResponse.fromJson(Map<String, dynamic> json) =>
      JobInformationResponse(
        employeeList:
            List<Job>.from(json["Employee_list"].map((x) => Job.fromJson(x))),
        responseStatus: json["responseStatus"],
        result: json["result"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "Employee_list":
            List<dynamic>.from(employeeList.map((x) => x.toJson())),
        "responseStatus": responseStatus,
        "result": result,
        "statusCode": statusCode,
      };
}

class Job {
  Job({
    required this.city,
    required this.jobDescription,
    required this.jobDurationInDays,
    required this.jobId,
    required this.jobName,
    required this.mandal,
    required this.numberPeopleNeeded,
    required this.state,
  });

  final String city;
  final String jobDescription;
  final int jobDurationInDays;
  final int jobId;
  final String jobName;
  final String mandal;
  final int numberPeopleNeeded;
  final String state;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        city: json["city"],
        jobDescription: json["job_description"],
        jobDurationInDays: json["job_duration_in_days"],
        jobId: json["job_id"],
        jobName: json["job_name"],
        mandal: json["mandal"],
        numberPeopleNeeded: json["number_people_needed"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "job_description": jobDescription,
        "job_duration_in_days": jobDurationInDays,
        "job_id": jobId,
        "job_name": jobName,
        "mandal": mandal,
        "number_people_needed": numberPeopleNeeded,
        "state": state,
      };
}
