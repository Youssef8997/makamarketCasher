//' (id INTEGER PRIMARY KEY,Name TEXT,LastPaid DOUBLE,TotalSuppliers DOUBLE,LastDate Text)');
class SuppliersModule {
  String? name;
  int?id;
  double? LastPaid;
  double? TotalSuppliers;
  String? feesDate;

  SuppliersModule(
      {this.name, this.id, this.LastPaid, this.TotalSuppliers, this.feesDate});

  SuppliersModule.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id= json['id'];
    LastPaid = json['LastPaid'];
    TotalSuppliers = json['TotalSuppliers'];
    feesDate = json['feesDate'];
  }

  Map<String, dynamic> toJson(){

    return {
      'name':name,
      'id':id,
      'LastPaid':LastPaid,
      'TotalSuppliers':TotalSuppliers,
      'feesDate':feesDate,
    };
  }
}