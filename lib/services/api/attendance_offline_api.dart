import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<AttendanceSyncResponse> attendanceSync(
    {required context,
    required List<Map<String, dynamic>> employeeList}) async {
  // print(employeeList);
  int? managerId = await SharedPreference.getUserId();
  var headers = {'Content-Type': 'application/json'};
  // print(managerId);
  var response = await http.post(
      Uri.parse("${AppConstants.baseUrl}attendanceOffline"),
      headers: headers,
      body: json
          .encode({"manager_id": "$managerId", "employeeList": employeeList}));

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    int status = data['responseStatus'];
    String result = data['result'];
    int statusCode = data['statusCode'];
    showToast(msg: result);
    // if (statusCode == 200) {
    //   Navigator.pop(context);
    //   return AttendanceSyncResponse.fromJson(json.decode(response.body));
    // } else {
    //   print(data);
    // }
    return AttendanceSyncResponse.fromJson(data);
  } else {
    showToast(msg: "Server error");
    throw Exception(response.body);
  }
}

class AttendanceSyncResponse {
  AttendanceSyncResponse({
    required this.responseStatus,
    required this.result,
    required this.statusCode,
  });

  final int responseStatus;
  final String result;
  final int statusCode;

  factory AttendanceSyncResponse.fromRawJson(String str) =>
      AttendanceSyncResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceSyncResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceSyncResponse(
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
