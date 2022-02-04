import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<ManagerEmployeesResponse> getManagerEmployeesList() async {
  int? managerId = await SharedPreference.getUserId();
  var response = await http.post(
      Uri.parse("${AppConstants.baseUrl}get_manager_employees"),
      body: {"manager_id": "$managerId"});

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    int status = data['responseStatus'];
    String result = data['result'];
    // showToast(msg: result);
    // if (status == 200) {
    print(data);
    //   showToast(msg: result);
    //   Map employeeInfo = data['employeeInfo'];
    //   SharedPreference.saveEmployeeInfo(id: employeeInfo['id'], firstName: employeeInfo['first_name'], lastName: employeeInfo['last_name']).whenComplete((){
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashBoardScreen()));
    //   });
    //   return ManagerEmployeesResponse.fromJson(json.decode(response.body));
    // } else {
    //   print(data);
    //   showToast(msg: result);
    // }
    return ManagerEmployeesResponse.fromJson(data);
  } else {
    // showToast(msg: response.body);
    throw Exception(response.body);
  }
}

class ManagerEmployeesResponse {
  ManagerEmployeesResponse({
    required this.employeeList,
    required this.responseStatus,
    required this.result,
  });

  final List<ManagerEmployeeList> employeeList;
  final int responseStatus;
  final String result;

  factory ManagerEmployeesResponse.fromJson(Map<String, dynamic> json) =>
      ManagerEmployeesResponse(
        employeeList: List<ManagerEmployeeList>.from(
            json["Employee_list"].map((x) => ManagerEmployeeList.fromJson(x))),
        responseStatus: json["responseStatus"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "Employee_list":
            List<dynamic>.from(employeeList.map((x) => x.toJson())),
        "responseStatus": responseStatus,
        "result": result,
      };
}

class ManagerEmployeeList {
  ManagerEmployeeList({
    required this.aadhar,
    required this.address,
    required this.district,
    required this.email,
    required this.firstName,
    required this.fkManagerId,
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
  final int fkManagerId;
  final int id;
  final String image;
  final String lastName;
  final String leftEye;
  final String phone;
  final String rightEye;
  final String state;
  final Type type;
  final String village;

  factory ManagerEmployeeList.fromJson(Map<String, dynamic> json) =>
      ManagerEmployeeList(
        aadhar: json["aadhar"],
        address: json["address"],
        district: json["district"],
        email: json["email"],
        firstName: json["first_name"],
        fkManagerId: json["fk_manager_id"],
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
        "fk_manager_id": fkManagerId,
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

enum Type { M, E }

final typeValues = EnumValues({"E": Type.E, "M": Type.M});

class EnumValues<T> {
  Map<String, T> map = {};
  Map<T, String> reverseMap = {};

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
