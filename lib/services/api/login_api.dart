import 'dart:convert';
import 'dart:typed_data';
import 'package:eye/globals/widgets/toast.dart';
import 'package:http/http.dart' as http;

Future<LoginResponse> login(
    {required userName,
    required password,
    required Uint8List eyeImage,
    required attendType}) async {
  // var response = await http.post(
  //     Uri.parse(
  //         "http://ec2-3-15-212-94.us-east-2.compute.amazonaws.com:8080/managerAuth"),
  //     body: {
  //       "Username": "ss",
  //       "Password": "123",
  //       "eyeImage": "",
  //       "lat": "00.0000",
  //       "long": "00.0000",
  //       "attendType": "in"
  //     });
  //
  // if (response.statusCode == 200) {
  //   var data = json.decode(response.body);
  //   print(data.toString());
  //   if (data['statusCode'] == 200) {
  //     print(data["result"]);
  //   } else {
  //     print(data["result"]);
  //   }
  //   return LoginResponse.fromJson(data);
  var request = http.MultipartRequest('POST', Uri.parse('http://ec2-3-15-212-94.us-east-2.compute.amazonaws.com:8080/managerAuth'));
  request.fields['Username'] = userName;
  request.fields['Password'] = password;
  request.fields['lat'] = "00.0000";
  request.fields['long'] = "00.0000";
  request.fields['attendType'] = 'in';
  // request.files.add(await http.MultipartFile.fromPath('profilepic', _image.path,
  //     filename: _image.path.split('/').last));

  request.files.add(http.MultipartFile.fromBytes("eyeImage",eyeImage,filename: "iris.bmp"));
  // request.files.add(await http.MultipartFile.fromPath("eyeImage", eyeImage));

  // (eyeImage != null)
  //     ? request.files.add(await http.MultipartFile.fromPath(
  //     'profilepic', (eyeImage != null) ? eyeImage.path : '',
  //     filename:
  //     (eyeImage != null) ? eyeImage.path.split('/').last : ''))
  //     : request.fields['profilepic'] = '';

  var streamResponse = await request.send();
  var response = await http.Response.fromStream(streamResponse);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    int status = data['statusCode'];
    String result = data['result'];
    showToast(msg: result);
    if (status == 200) {
      print(data);
      showToast(msg: result);
      // Toast.show(message, context, duration: 4, gravity: Toast.BOTTOM);
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      print(data);
      showToast(msg: result);
      // Toast.show(data['message'], context, duration: 4, gravity: Toast.BOTTOM);
    }
    return LoginResponse.fromJson(json.decode(response.body));

  } else {
    showToast(msg: response.body);
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
