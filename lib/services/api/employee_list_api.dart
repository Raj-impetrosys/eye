import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<EmployeeListResponse> getEmployeeList() async {
  var response = await http.get(
      Uri.parse(
          "${AppConstants.baseUrl}all_users"), );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    int status = data['responseStatus'];
    String result = data['result'];
    // showToast(msg: result);
    // if (status == 200) {
    //   print(data);
    //   showToast(msg: result);
    //   Map employeeInfo = data['employeeInfo'];
    //   SharedPreference.saveEmployeeInfo(id: employeeInfo['id'], firstName: employeeInfo['first_name'], lastName: employeeInfo['last_name']).whenComplete((){
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashBoardScreen()));
    //   });
    //   return EmployeeListResponse.fromJson(json.decode(response.body));
    // } else {
    //   print(data);
    //   showToast(msg: result);
    // }
    return EmployeeListResponse.fromJson(data);

  } else {
    // showToast(msg: response.body);
    throw Exception(response.body);
  }
}

// class EmployeeListResponse {
//   dynamic result;
//   int? statusCode;
//   dynamic employeeInfo;
//
//   EmployeeListResponse({
//     required this.result,
//     required this.statusCode,
//     required this.employeeInfo,
//   });
//
//   EmployeeListResponse.fromJson(Map<dynamic, dynamic> json) {
//     result = json['result'];
//     statusCode = json['statusCode'];
//     employeeInfo = json['employeeInfo'];
//   }
// }

// To parse this JSON data, do
//
//     final EmployeeListResponse = EmployeeListResponseFromJson(jsonString);



class EmployeeListResponse {
  EmployeeListResponse({
    required this.employeeList,
    required this.responseStatus,
    required this.result,
  });

  final List<EmployeeList> employeeList;
  final int responseStatus;
  final String result;

  factory EmployeeListResponse.fromRawJson(String str) => EmployeeListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeListResponse.fromJson(Map<String, dynamic> json) => EmployeeListResponse(
    employeeList: List<EmployeeList>.from(json["Employee_list"].map((x) => EmployeeList.fromJson(x))),
    responseStatus: json["responseStatus"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "Employee_list": List<dynamic>.from(employeeList.map((x) => x.toJson())),
    "responseStatus": responseStatus,
    "result": result,
  };
}

class EmployeeList {
  EmployeeList({
    required this.aadhar,
    required this.address,
    required this.district,
    required this.email,
    required this.firstName,
    required this.id,
    required this.image,
    required this.lastName,
    required this.leftEye,
    required this.phone,
    required this.rightEye,
    required this.state,
    required this.type,
    required this.village,
  });

  final String aadhar;
  final String address;
  final String district;
  final String email;
  final String firstName;
  final int id;
  final String image;
  final String lastName;
  final String leftEye;
  final String phone;
  final String rightEye;
  final String state;
  final Type type;
  final String village;

  factory EmployeeList.fromRawJson(String str) => EmployeeList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeList.fromJson(Map<String, dynamic> json) => EmployeeList(
    aadhar: json["aadhar"],
    address: json["address"],
    district: json["district"],
    email: json["email"],
    firstName: json["first_name"],
    id: json["id"],
    image: json["image"],
    lastName: json["last_name"],
    leftEye: json["left_eye"],
    phone: json["phone"],
    rightEye: json["right_eye"],
    state: json["state"],
    type: typeValues.map[json["type"]]!,
    village: json["village"],
  );

  Map<String, dynamic> toJson() => {
    "aadhar": aadhar,
    "address": address,
    "district": district,
    "email": email,
    "first_name": firstName,
    "id": id,
    "image": image,
    "last_name": lastName,
    "left_eye": leftEye,
    "phone": phone,
    "right_eye": rightEye,
    "state": state,
    "type": typeValues.reverse[type],
    "village": village,
  };
}

enum Type { E }

final typeValues = EnumValues({
  "E": Type.E
});

class EnumValues<T> {
  Map<String, T> map = {};
  Map<T, String> reverseMap={};

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}