class OrdersModule {
  String? name;
  String?code;
  double? quantity;

  OrdersModule(
      {this.name, this.code ,this.quantity,});

  OrdersModule.fromJson(Map<String, dynamic> json){
    name = json['name'];
    code = json['code'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson(){

    return {
      'name':name,
      'code':code,
      'quantity':quantity,
    };
  }
}