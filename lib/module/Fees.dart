//' (id INTEGER PRIMARY KEY,Name TEXT,LastPaid DOUBLE,TotalSuppliers DOUBLE,LastDate Text)');
class FeesModule {
  String? name;
  int?id;
  double? LastPaid;
  double? TotalFees;
  String? feesDate;

  FeesModule(
      {this.name, this.id, this.LastPaid, this.TotalFees, this.feesDate});

  FeesModule.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id= json['id'];
    LastPaid = json['LastPaid'];
    TotalFees = json['TotalFees'];
    feesDate = json['feesDate'];
  }

  Map<String, dynamic> toJson(){

    return {
      'name':name,
      'id':id,
      'LastPaid':LastPaid,
      'TotalFees':TotalFees,
      'feesDate':feesDate,
    };
  }
}