import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<EmployeeAuthResponse> employeeAuth(
    {
      required context,
      required userId,
    required Uint8List eyeImage,
    required attendType}) async {
  var request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}employeeAuth'));
  request.fields['userId'] = "$userId";
  request.fields['lat'] = "00.0000";
  request.fields['long'] = "00.0000";
  request.fields['attendType'] = attendType;
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
    String message = data['status'];

    showToast(msg: message);
    print(data);
    if (status == 200) {
      Navigator.pop(context);
    //
    //   showToast(msg: result);
    //   Map employeeInfo = data['employeeInfo'];
    //   // SharedPreference.saveEmployeeInfo(id: employeeInfo['id'], firstName: employeeInfo['first_name'], lastName: employeeInfo['last_name']).whenComplete((){
    //   //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>DashBoardScreen()));
    //   // });
    //   return EmployeeAuthResponse.fromJson(json.decode(response.body));
    } else {
    //   print(data);
    //   showToast(msg: result);
    }
    return EmployeeAuthResponse.fromJson(json.decode(response.body));

  } else {
    showToast(msg: response.body);
    throw Exception(response.body);
  }
}

class EmployeeAuthResponse {
  dynamic result;
  int? statusCode;
  dynamic employeeInfo;

  EmployeeAuthResponse({
    required this.result,
    required this.statusCode,
    required this.employeeInfo,
  });

  EmployeeAuthResponse.fromJson(Map<dynamic, dynamic> json) {
    result = json['result'];
    statusCode = json['statusCode'];
    employeeInfo = json['employeeInfo'];
  }
}