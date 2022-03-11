class AttendanceModel{
  int employeeId;
  String lat;
  String long;
  String type;
  String file;
  String markTime;

  AttendanceModel({required this.employeeId, required this.lat, required this.long, required this.type, required this.file,required this.markTime});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    employeeId: json["employee_id"],
    lat: json["lat"],
    long: json["long"],
    type: json["type"],
    file: json["file"],
      markTime:json["mark_time"]
  );

  Map<String, dynamic> toJson() => {
    "employee_id": employeeId,
    "lat": lat,
    "long": long,
    "type": type,
    "file": file,
    "mark_time":markTime,
  };
}