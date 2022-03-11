import 'dart:convert';

EmployeeAuthModel employeeAuthModelFromJson(String str) => EmployeeAuthModel.fromJson(json.decode(str));

String employeeAuthModelToJson(EmployeeAuthModel data) => json.encode(data.toJson());

class EmployeeAuthModel {
  EmployeeAuthModel({
    required this.employeeId,
    required this.lat,
    required this.long,
    required this.typeInOut,
    required this.file,
    required this.markTime,
  });

  final int employeeId;
  final double lat;
  final double long;
  final String typeInOut;
  final String file;
  final DateTime markTime;

  factory EmployeeAuthModel.fromJson(Map<String, dynamic> json) => EmployeeAuthModel(
    employeeId: json["employee_id"],
    lat: json["lat"].toDouble(),
    long: json["long"].toDouble(),
    typeInOut: json["type(in/out)"],
    file: json["file"],
    markTime: DateTime.parse(json["mark_time"]),
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "lat": lat,
    "long": long,
    "type(in/out)": typeInOut,
    "file": file,
    "mark_time": markTime.toIso8601String(),
  };
}