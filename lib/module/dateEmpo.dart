//(id INTEGER,AttendanceDate TEXT,LeavingDate Text,DataTimeDay TEXT)')
class EmployeeDateModule {
  int?id;
  String? AttendanceDate;
  String? LeavingDate;
  String? DataTimeDay;

  EmployeeDateModule(
      { this.id, this.AttendanceDate, this.DataTimeDay,this.LeavingDate});

  EmployeeDateModule.fromJson(Map<String, dynamic> json){
    id= json['id'];
    AttendanceDate = json['AttendanceDate'];
    DataTimeDay = json['DataTimeDay'];
    LeavingDate = json['LeavingDate'];

  }

  Map<String, dynamic> toJson(){

    return {
      'id':id,
      'AttendanceDate':AttendanceDate,
      'DataTimeDay':DataTimeDay,
      'LeavingDate':LeavingDate,
    };
  }
}