import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<GetEmployeeJobResponse> getEmployeeJob(
    {required context, required int employeeId}) async {
  int? managerId = await SharedPreference.getUserId();
  var response = await http.post(
      Uri.parse("${AppConstants.baseUrl}getemployeejobs"),
      body: {"employee_id": "$employeeId", "manager_id": "$managerId"});

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    int status = data['responseStatus'];
    String result = data['result'];
    int statusCode = data['statuscode'];
    // showToast(msg: result);
    // if (status == 200) {
    //   print(data);
    //   showToast(msg: result);
    //   Map employeeInfo = data['employeeInfo'];
    //   SharedPreference.saveEmployeeInfo(id: employeeInfo['id'], firstName: employeeInfo['first_name'], lastName: employeeInfo['last_name']).whenComplete((){
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashBoardScreen()));
    //   });
    //   return GetEmployeeJobResponse.fromJson(json.decode(response.body));
    // } else {
    //   print(data);
    //   showToast(msg: result);
    // }
    return GetEmployeeJobResponse.fromJson(data);
  } else {
    // showToast(msg: response.body);
    throw Exception(response.body);
  }
}

// class GetEmployeeJobResponse {
//   dynamic result;
//   int? statusCode;
//   dynamic employeeInfo;
//
//   GetEmployeeJobResponse({
//     required this.result,
//     required this.statusCode,
//     required this.employeeInfo,
//   });
//
//   GetEmployeeJobResponse.fromJson(Map<dynamic, dynamic> json) {
//     result = json['result'];
//     statusCode = json['statusCode'];
//     employeeInfo = json['employeeInfo'];
//   }
// }

class GetEmployeeJobResponse {
  GetEmployeeJobResponse({
    required this.details,
    required this.responseStatus,
    required this.result,
    required this.statuscode,
  });

  final List<Detail> details;
  final int responseStatus;
  final String result;
  final int statuscode;

  factory GetEmployeeJobResponse.fromRawJson(String str) =>
      GetEmployeeJobResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetEmployeeJobResponse.fromJson(Map<String, dynamic> json) =>
      GetEmployeeJobResponse(
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        responseStatus: json["responseStatus"],
        result: json["result"],
        statuscode: json["statuscode"],
      );

  Map<String, dynamic> toJson() => {
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
        "responseStatus": responseStatus,
        "result": result,
        "statuscode": statuscode,
      };
}

class Detail {
  Detail({
    required this.city,
    required this.endDate,
    required this.jobDescription,
    required this.jobDurationInDays,
    required this.jobId,
    required this.jobName,
    required this.mandal,
    required this.startDate,
    required this.state,
  });

  final String city;
  final String endDate;
  final String jobDescription;
  final int jobDurationInDays;
  final int jobId;
  final String jobName;
  final String mandal;
  final String startDate;
  final String state;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        city: json["city"],
        endDate: json["end_date"],
        jobDescription: json["job_description"],
        jobDurationInDays: json["job_duration_in_days"],
        jobId: json["job_id"],
        jobName: json["job_name"],
        mandal: json["mandal"],
        startDate: json["start_date"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "end_date": endDate,
        "job_description": jobDescription,
        "job_duration_in_days": jobDurationInDays,
        "job_id": jobId,
        "job_name": jobName,
        "mandal": mandal,
        "start_date": startDate,
        "state": state,
      };
}
