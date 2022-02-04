import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<AssignJobResponse> assignJob(
    {required context,
    required int employeeId,
    required int jobId,
    required String startDate,
    required String endDate}) async {
  int? managerId = await SharedPreference.getUserId();
  var response = await http
      .post(Uri.parse("${AppConstants.baseUrl}set_job_employee"), body: {
    "job_id": "$jobId",
    "employee_id": "$employeeId",
    "manager_id": "$managerId",
    "start_date": startDate,
    "end_date": endDate,
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    int status = data['responseStatus'];
    String result = data['result'];
    int statusCode = data['statusCode'];
    showToast(msg: result);
    if (statusCode == 200) {
      Navigator.pop(context);
      return AssignJobResponse.fromJson(json.decode(response.body));
    } else {
      print(data);
    }
    return AssignJobResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

class AssignJobResponse {
  AssignJobResponse({
    required this.responseStatus,
    required this.result,
    required this.statusCode,
  });

  final int responseStatus;
  final String result;
  final int statusCode;

  factory AssignJobResponse.fromRawJson(String str) =>
      AssignJobResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssignJobResponse.fromJson(Map<String, dynamic> json) =>
      AssignJobResponse(
        responseStatus: json["responseStatus"],
        result: json["result"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseStatus": responseStatus,
        "result": result,
        "statusCode": statusCode,
      };
}
