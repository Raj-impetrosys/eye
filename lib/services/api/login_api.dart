import 'dart:convert';
import 'package:http/http.dart' as http;

Future<LoginResponse> login(
    {required userName,
    required password,
    required eyeImage,
    required attendType}) async {
  var response = await http.post(
      Uri.parse(
          "http://ec2-3-15-212-94.us-east-2.compute.amazonaws.com:8080/managerAuth"),
      body: {
        "Username": "ss",
        "Password": "123",
        "eyeImage": "",
        "lat": "00.0000",
        "long": "00.0000",
        "attendType": "in"
      });

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data.toString());
    if (data['statusCode'] == 200) {
      print(data["result"]);
    } else {
      print(data["result"]);
    }
    return LoginResponse.fromJson(data);
  } else {
    throw Exception(response.body);
  }
}

class LoginResponse {
  dynamic result;
  int? statusCode;
  dynamic employeeInfo;

  LoginResponse({
    required this.result,
    required this.statusCode,
    required this.employeeInfo,
  });

  LoginResponse.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'];
    statusCode = json['statusCode'];
    employeeInfo = json['employeeInfo'];
  }
}
