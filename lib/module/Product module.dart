class ProductsModule {
  String? name;
  String?code;
  double? price;
  int? quantityInShop;
  int? quantityInStore;
  String? startDate;
  String? endDate;

  ProductsModule(
      {this.name, this.code, this.price, this.quantityInShop, this.quantityInStore, this.startDate, this.endDate});

  ProductsModule.fromJson(Map<String, dynamic> json){
    name = json['name'];
    code = json['code'];
    price = json['price'];
    quantityInShop = json['quantityInShop'];
    quantityInStore = json['quantityInStore'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson(){

  return {
  'name':name,
  'code':code,
  'price':price,
  'quantityInShop':quantityInShop,
  'quantityInStore':quantityInStore,
  'startDate':startDate,
  'endDate':endDate,
  };
}
}