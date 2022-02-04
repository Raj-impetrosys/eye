import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<GetAttendanceRecordsResponse> getAttendanceRecords(
    {required String date}) async {
  print("date: $date");
  int? managerId = await SharedPreference.getUserId();
  var response = await http.post(
      Uri.parse("${AppConstants.baseUrl}get_attendance_records"),
      body: {"date": date.split(" ")[0], "manager_id": "$managerId"});

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    // int status = data['responseStatus'];
    // String result = data['result'];
    // int statusCode = data['statuscode'];
    // showToast(msg: result);
    // if (status == 200) {
    print(data);
    //   showToast(msg: result);
    //   Map employeeInfo = data['employeeInfo'];
    //   SharedPreference.saveEmployeeInfo(id: employeeInfo['id'], firstName: employeeInfo['first_name'], lastName: employeeInfo['last_name']).whenComplete((){
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashBoardScreen()));
    //   });
    //   return GetAttendanceRecordsResponse.fromJson(json.decode(response.body));
    // } else {
    //   print(data);
    //   showToast(msg: result);
    // }
    return GetAttendanceRecordsResponse.fromJson(data);
  } else {
    // showToast(msg: response.body);
    throw Exception(response.body);
  }
}

class GetAttendanceRecordsResponse {
  GetAttendanceRecordsResponse({
    required this.employeeCount,
    required this.employeeList,
    required this.responseStatus,
    required this.result,
    required this.statusCode,
  });

  final int employeeCount;
  List<EmployeeList1> employeeList = [];
  final int responseStatus;
  final String result;
  final int statusCode;

  factory GetAttendanceRecordsResponse.fromJson(Map<String, dynamic> json) =>
      GetAttendanceRecordsResponse(
        employeeCount: json["employee_count"],
        employeeList: List<EmployeeList1>.from(
            json["employee_list"].map((x) => EmployeeList1.fromJson(x))),
        responseStatus: json["responseStatus"],
        result: json["result"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "employee_count": employeeCount,
        "employee_list":
            List<dynamic>.from(employeeList.map((x) => x.toJson())),
        "responseStatus": responseStatus,
        "result": result,
        "statusCode": statusCode,
      };
}

class EmployeeList1 {
  EmployeeList1({
    required this.inTime,
    required this.inTimeLat,
    required this.inTimeLong,
    required this.name,
    required this.outTime,
    required this.outTimeLat,
    required this.outTimeLong,
    required this.userId,
  });

  final String inTime;
  final dynamic inTimeLat;
  final dynamic inTimeLong;
  final String name;
  final String outTime;
  final dynamic outTimeLat;
  final dynamic outTimeLong;
  final int userId;

  factory EmployeeList1.fromJson(Map<String, dynamic> json) => EmployeeList1(
        inTime: json["in_time"],
        inTimeLat: json["in_time_lat"],
        inTimeLong: json["in_time_long"],
        name: json["name"],
        outTime: json["out_time"],
        outTimeLat: json["out_time_lat"],
        outTimeLong: json["out_time_long"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "in_time": inTime,
        "in_time_lat": inTimeLat,
        "in_time_long": inTimeLong,
        "name": name,
        "out_time": outTime,
        "out_time_lat": outTimeLat,
        "out_time_long": outTimeLong,
        "user_id": userId,
      };
}
