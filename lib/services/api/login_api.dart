import 'package:eye/globals/index.dart';
import 'package:http/http.dart' as http;

Future<LoginResponse> login(
    {
      required context,
      required userName,
    required password,
    required Uint8List eyeImage,
    required attendType}) async {
  var location = await getLocation();
  var request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}managerAuth'));
  request.fields['Username'] = userName;
  request.fields['Password'] = password;
  request.fields['lat'] = location.latitude.toString();
  request.fields['long'] = location.longitude.toString();
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
      Map employeeInfo = data['employeeInfo'];
      SharedPreference.saveEmployeeInfo(id: employeeInfo['id'], firstName: employeeInfo['first_name'], lastName: employeeInfo['last_name']).whenComplete((){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const DashBoardScreen()));
      });
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      print(data);
      showToast(msg: result);
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