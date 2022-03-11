import 'package:eye/globals/index.dart';
import 'package:eye/models/attendance_model.dart';
import 'package:sqflite/sqflite.dart';
import '../services/api/get_manager_employees_api.dart';

enum TableType{
  employeeList, attendance
}

class DbController {
  Database? db ;
  late String dbPath;

  // Future<void> getDbPath() async{
  //    dbPath = await getDatabasesPath();
  //   print(dbPath);
  // }

  openDb({required String tableName, required TableType tableType}) async{
    dbPath = await getDatabasesPath();
    Database database = await openDatabase("$dbPath/$tableName.db", version: 1,
        onCreate: (Database db, int version) async {
      this.db = db;
          print("onCreate:$db");
          print(version);

          // switch(tableType){
          //
          //   case TableType.employeeList:
          //     createTable(tableName: tableName, tableType: TableType.attendance);
          //     break;
          //   case TableType.attendance:
          //     // TODO: Handle this case.
          //     break;
          // }
        },
      onUpgrade: (db,i,j){
        this.db = db;
        print("onUpgrade:$db");
        },
    onDowngrade: (db,i,j){
      print("onDowngrade:$db");
    },
      onOpen: (db){
        this.db = db;
        print("onOpen:$db");
        // createTable();
      },onConfigure: (db){
        this.db = db;
        print("onConfigure:$db");
        // createTable(tableName: tableName, tableType: tableType);
      },
    );
    // print(database);
  }

  closeDb() async{
    await db!.close();
  }

  createTable({required String tableName, required TableType tableType}) async{
    switch (tableType){
      case TableType.employeeList:
        await db!.execute(
            'CREATE TABLE $tableName (id INTEGER, aadhar TEXT,address TEXT,district TEXT,email TEXT,first_name TEXT, fk_manager_id INTEGER, image TEXT,last_name TEXT,left_eye TEXT,phone TEXT,right_eye TEXT, state TEXT,type TEXT, village TEXT)');
        break;
      case TableType.attendance:
        await db!.execute(
            'CREATE TABLE $tableName (employee_id INTEGER, lat TEXT,long TEXT,type TEXT,file TEXT,mark_time TEXT)');
        break;
    }
    // await db.execute(
    //     // 'CREATE TABLE employee_list (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
    //     'CREATE TABLE $tableName (id INTEGER, aadhar TEXT,address TEXT,district TEXT,email TEXT,first_name TEXT, fk_manager_id INTEGER, image TEXT,last_name TEXT,left_eye TEXT,phone TEXT,right_eye TEXT, state TEXT,type TEXT, village TEXT)');
  }

  addColumn({required String tableName, required String columnDefinition}){
  "ALTER TABLE $tableName ADD $columnDefinition";
  }

  insertData({required Map<String, dynamic> data,required String tableName, required TableType tableType}) async{
    // await db.insert("employee_list", {
    //   "name":"Raj"
    // });
    try{
      int code = await db!.insert(tableName, data);
      print(code);
      showToast(msg: "Successfully marked attendance in offline mode");
      // if(code==1){
      //   createTable(tableName: tableName, tableType: tableType);
      // }
    }catch (e){
      showToast(msg: e);
      createTable(tableName: tableName, tableType: tableType);
    }

    // await db.insert(tableName,
    //     EmployeeList(aadhar: "aadhar", address: "address", district: "district", email: "email", firstName: "firstName", fkManagerId: 0, id: 0, image: "image", lastName: "lastName", leftEye: "leftEye", phone: "phone", rightEye: "rightEye", state: "state", type: Type.M, village: "village").toJson());
  }

  deleteTableData({required String tableName}) async{
    await db!.delete(tableName);
  }

  deleteTable({required String tableName}) async{
    await db!.execute(
      'DROP TABLE $tableName');
      //   'CREATE TABLE employee_list (id INTEGER PRIMARY KEY, aadhar TEXT,address TEXT,district TEXT,email TEXT,firstName TEXT, fkManagerId INTEGER, image TEXT,lastName TEXT,leftEye TEXT,phone TEXT,rightEye TEXT, state TEXT,type TEXT, village TEXT)');
  }

  Future<List<ManagerEmployeeList>> getData({required String tableName}) async{
    List<Map<String,dynamic>> list = await db!.rawQuery('SELECT * FROM $tableName');
    List<ManagerEmployeeList> finalList = [];
    for(Map<String,dynamic> employeeList in list) {
      finalList.add(ManagerEmployeeList.fromJson(employeeList));
    }
    print(finalList);
    return finalList;
  }

  Future<List<Map<String,dynamic>>> getAttendanceData({required String tableName}) async{
    List<Map<String,dynamic>> list = await db!.rawQuery('SELECT * FROM $tableName');
    List<AttendanceModel> finalList = [];
    for(Map<String,dynamic> employeeList in list) {
      finalList.add(AttendanceModel.fromJson(employeeList));
    }
    print(list);
    return list;
  }

}