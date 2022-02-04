import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<JobCompletionResponse> jobCompletion(
    {required context, required int employeeId, required int jobId}) async {
  int? managerId = await SharedPreference.getUserId();
  var response = await http
      .post(Uri.parse("${AppConstants.baseUrl}jobCompletion"), body: {
    "job_id": "$jobId",
    "employee_id": "$employeeId",
    "manager_id": "$managerId"
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    int status = data['responseStatus'];
    String result = data['result'];
    int statusCode = data['statuscode'];
    showToast(msg: result);
    if (statusCode == 200) {
      Navigator.pop(context);
      return JobCompletionResponse.fromJson(json.decode(response.body));
    } else {
      print(data);
    }
    return JobCompletionResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

class JobCompletionResponse {
  JobCompletionResponse({
    required this.responseStatus,
    required this.result,
    required this.statuscode,
  });

  final int responseStatus;
  final String result;
  final int statuscode;

  factory JobCompletionResponse.fromRawJson(String str) =>
      JobCompletionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JobCompletionResponse.fromJson(Map<String, dynamic> json) =>
      JobCompletionResponse(
        responseStatus: json["responseStatus"],
        result: json["result"],
        statuscode: json["statuscode"],
      );

  Map<String, dynamic> toJson() => {
        "responseStatus": responseStatus,
        "result": result,
        "statuscode": statuscode,
      };
}
