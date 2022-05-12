class FeesModule {
  String? name;
  int?id;
  double? TotalSuppliers;
  double? Paid;
  String? feesDate;

  FeesModule(
      {this.name, this.id, this.TotalSuppliers, this.Paid, this.feesDate});

  FeesModule.fromJson(Map<String, dynamic> json){
    name = json['name'];
    id= json['id'];
    TotalSuppliers = json['TotalSuppliers'];
    Paid = json['Paid'];
    feesDate = json['feesDate'];
  }

  Map<String, dynamic> toJson(){

    return {
      'name':name,
      'id':id,
      'TotalSuppliers':TotalSuppliers,
      'Paid':Paid,
      'feesDate':feesDate,
    };
  }
}