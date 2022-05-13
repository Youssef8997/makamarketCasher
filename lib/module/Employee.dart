//(id INTEGER PRIMARY KEY,Name TEXT,Salary DOUBLE,HireDate Text,AttendanceDate Text,LeavingDate Text)');
class EmployeeModule {
  String? name;
  int?id;
  double? Salary;
  String? AttendanceDate;
  String? LeavingDate;
  String? HireDate;

  EmployeeModule(
      {this.name, this.id, this.AttendanceDate, this.Salary, this.HireDate,this.LeavingDate});

  EmployeeModule.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id= json['id'];
    AttendanceDate = json['AttendanceDate'];
    Salary = json['Salary'];
    HireDate = json['HireDate'];
    LeavingDate = json['LeavingDate'];

  }

  Map<String, dynamic> toJson(){

    return {
      'name':name,
      'id':id,
      'AttendanceDate':AttendanceDate,
      'Salary':Salary,
      'HireDate':HireDate,
      'LeavingDate':LeavingDate,
    };
  }
}