
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/lib/Shered%20preference/Shered.dart';
import 'package:untitled6/models/AddItem.dart';
import 'package:untitled6/models/Store.dart';
import 'package:untitled6/models/Casherpage.dart';
import 'package:untitled6/models/Empoloye.dart';
import 'package:untitled6/models/Items.dart';
import 'package:untitled6/models/Money.dart';
import 'package:untitled6/models/Supplayer/Supplayers.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'lib/Shered preference/Shered.dart';
class CasherCuibt extends Cubit<CasherState>{
  CasherCuibt() : super(initState());
  static CasherCuibt get(context) => BlocProvider.of(context);
  var databaseFactory = databaseFactoryFfi;
  late Database dataBase;
  List Products=[];
  List SearchProducts=[];
  List Supplayer=[];
  List orders=[];
  List Recordedorders=[];
  List fees=[];
  int bodyIndex=0;
  bool Search=false;
  var value;
  var storeValue;
  bool ItemsSearch=false;
  bool isMoreThanTotalMoney=false;
  bool DisableInsertButton=true;
  //Controller of AddItem Screen
  var NameOfItem = TextEditingController();
  var CodeOfItem = TextEditingController();
  var PriceOfItem = TextEditingController();
  var NumberOfItem = TextEditingController();
  var StartDate = TextEditingController();
  var EndDate = TextEditingController();
  var NameOfSearch = TextEditingController();
  var CodeOfSearch = TextEditingController();
  var kayform = GlobalKey<FormState>();
  int? id;
  //controller of Items Screen
  var NameController = TextEditingController();
  //Controller Of AddInvoice
  var NameOfSupllayers=TextEditingController();
  var CostOfInvoice=TextEditingController();
  var PaidOfInvoice=TextEditingController();
  double TotalOfInvoice=0;
  double TotalOfSupllayers=0.0;
  var DateOfSupllayers=TextEditingController();
  var SublayersKeyForm = GlobalKey<FormState>();
  //Pay Fees
  var totalFees=TextEditingController();
  var paidOfFees=TextEditingController();
  var dateOfFees=TextEditingController();
  var feesKeyForm = GlobalKey<FormState>();
  //Add money
  var increesKeyForm = GlobalKey<FormState>();
  // CashierPage
  var NameOfProduct = TextEditingController();
  var NumberOfProduct = TextEditingController();
  var CodeOfProduct = TextEditingController();
  bool DChangeNumberItem=true;
  bool AlertChangeNum=false;
  bool AlertItemNFound=false;
  int? idOfChange;
double? price;
int? Index=null;
FocusNode foucs=FocusNode();
  double total=0.0;
  bool selected=false;
  bool NInserted=true;
  var NumberOfOrder=1;
  List<Widget>body=[
    CasherPage(),
    AddItem(),
    Items(),
    Supplayers(),
    Empoloye(),
    Money(),
    Store(),
  ];
  void ChangeMyIndex(value){
    bodyIndex=value;
    emit(ChangeIndex());
  }
  void AddItemChangeSearch(){
    Search=!Search;

    emit(ChangeSearchAbilty());
  }
  void ItemSChangeSearch(){
    ItemsSearch=!ItemsSearch;
    emit(ChangeSearchAbilty());
  }
  void ChangeValue(valuee){
    value=valuee;
    emit(ChangeValuee());
  }
  void ChangeStoreValue(valuee){
    storeValue=valuee;
    emit(ChangeValuee());
  }
  void Crdatab() async {
   dataBase =
    await openDatabase("ccc.db", version: 1, onCreate: (dataBase, version) {
      print("create data base");
      dataBase.execute(
          'CREATE TABLE Orders (Name Text,Code TEXT,Price DOUBLE,OrderDate Text,Num DOUBLE,TotalMoney DOUBLE,NumberOrder INTEGER)');
      dataBase.execute(
          'CREATE TABLE Products (Name Text,Code TEXT  PRIMARY KEY,Price DOUBLE,NumberInStore INTEGER,StartDate Text,EndDate Text,Num DOUBLE,TotalMoney DOUBLE)');
      dataBase.execute(
          'CREATE TABLE Suppliers (id INTEGER PRIMARY KEY,Name TEXT,LastPaid DOUBLE,TotalSuppliers DOUBLE,LastDate Text)');
      dataBase.execute(
          'CREATE TABLE Fees (id INTEGER PRIMARY KEY,Name TEXT,Paid DOUBLE,TotalSuppliers DOUBLE,LastDate Text)')
      .then((value) {
         print("Table is created");
        emit(CreateDataBaseSucssesful());
      }).catchError((error) {
        print("error is${error.toString()}");
        emit(CreateDataBaseError());
      });
    }, onOpen: (dataBase) {

      getDataSupplayers(dataBase).then((value) {
        Supplayer = [];
        Supplayer = value;
       });
      getDataProducts(dataBase).then((value) {
        Products = [];
        Products = value;
        print(Products);});
      getDataFees(dataBase).then((value) {
        fees = [];
        fees = value;
        });
      getAllOrders(dataBase).then((value) {
        Recordedorders=[];
        Recordedorders=value;
        print(Recordedorders);
        NumberOfOrder=(Recordedorders[Recordedorders.length-1]["NumberOrder"])+1;
      });
      print("open data base");
        emit(GetDataProductsSucssesful());
      }).catchError((Error) {
        print("the error is ${Error.toString()}");
        emit(GetDataProductsBaseError());
      });

  }
  Future<List<Map>> getDataProducts(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Products');
  }
  Future<List<Map>> getItemProducts(dataBase,key) async {
    return await dataBase.rawQuery('SELECT*FROM Products WHERE Code=?',[key]);
  }
  Future<List<Map>> getItemSProductsSearch(dataBase,value) async {
    return await dataBase.rawQuery('SELECT*FROM Products WHERE Name like ?',["${value}%"]);
  }
  Future<List<Map>> getOrders(dataBase,value) async {
    return await dataBase.rawQuery('SELECT*FROM Orders WHERE NumberOrder = ?',["$value"]);
  }
  Future<List<Map>> getAllOrders(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Orders');
  }

  Future<List<Map>> getDataSupplayers(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Suppliers');
  }
  Future<List<Map>> getDataFees(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Fees');
  }
  Future insertIntoProducts() async {
     SureItemNotFound().then((value) async{
       if(DisableInsertButton) {
         await dataBase.transaction((txn) {
           txn
               .rawInsert(
               'INSERT INTO Products(Name,Code,Price,NumberInStore,StartDate,EndDate,Num,TotalMoney)VALUES("${NameOfItem.text}","${CodeOfItem.text}","${PriceOfItem.text}","${NumberOfItem.text}","${StartDate.text}","${EndDate.text}","1","${double.parse(PriceOfItem.text)}")')
               .then((value) {
             emit(InsertProductSucssesful());
             getProductsAfterChange();
             NameOfItem.clear();
             CodeOfItem.clear();
             PriceOfItem.clear();
             NumberOfItem.clear();
             StartDate.clear();
             EndDate.clear();
           }).catchError((error) {
             print(" the error is ${error.toString()}");
             emit(InsertProductError());
           });
           return getname();
         });
       }else {
         print("I cant do this");
       }
     });

  }
  Future RecordOrder() async {
    for (var e in orders) {
      await dataBase.transaction((txn) {
        txn
            .rawInsert(
          //          'CREATE TABLE Orders (Name Text,Code TEXT,Price DOUBLE,OrderDate Text,Num DOUBLE,TotalMoney DOUBLE,NumberOrder INTEGER)');
            'INSERT INTO Orders(Name,Code,Price,OrderDate,Num,TotalMoney,NumberOrder)VALUES("${e["Name"]}","${e["Code"]}","${e["Price"]}","${DateTime.now()}","${e["Num"]}","${"TotalMoney"}","$NumberOfOrder")')
            .then((value) {
          updateProdctsARecord(Code: e["code"],Number: e["NumberInStore"]-e["Num"],price: e["price"]);
          orders=[];
          emit(RecordOrderSucssful());
        }).catchError((error) {
          print(" the error is ${error.toString()}");
          emit(RecordOrderError());
        });
        return getname();
      });
    }
    getAllOrders(dataBase).then((value) {
      Recordedorders=[];
      Recordedorders=value;
      NumberOfOrder=(Recordedorders[Recordedorders.length-1]["NumberOrder"])+1;
    });

    emit(RecordOrderSucssful());
  }
  Future insertIntoSupplayers() async {
    TotalOfSupllayers=double.parse(CostOfInvoice.text);
    await dataBase.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO Suppliers(Name,LastPaid,TotalSuppliers,LastDate)VALUES("${NameOfSupllayers.text}","${PaidOfInvoice.text}","$TotalOfSupllayers","${DateOfSupllayers.text}")')
          .then((value) {
        print("$value insertetd sucsseffly");
        emit(InsertProductSucssesful());
        getSuppliersAfterChange();
        NameOfSupllayers.clear();
        CostOfInvoice.clear();
        PaidOfInvoice.clear();
        DateOfSupllayers.clear();
      }).catchError((error) {
        print(" the error is ${error.toString()}");
        emit(InsertProductError());
      });
      return getname();
    });
  }
  Future insertIntoFees(id) async {
    TotalOfSupllayers=Supplayer[id-1]["TotalSuppliers"]-double.parse(paidOfFees.text);
    if(TotalOfSupllayers>=0) {
      await dataBase.transaction((txn) {
        txn
            .rawInsert(
                'INSERT INTO Fees(Name,Paid,TotalSuppliers,LastDate)VALUES("${Supplayer[value - 1]["Name"]}","${paidOfFees.text}","$TotalOfSupllayers","${dateOfFees.text}")')
            .then((value) {
          getFeesAfterChange();
          updateSuppliers(id);
          paidOfFees.clear();
          dateOfFees.clear();

          print("$value insertetd sucsseffly");
          emit(InsertProductSucssesful());
        }).catchError((error) {
          print(" the error is ${error.toString()}");
          emit(InsertProductError());
        });
        return getname();
      });
    }else {
      isMoreThanTotalMoney=true;
      emit(InsertProductError());
    }

  }
  void getProductsAfterChange() {
    getDataProducts(dataBase).then((value) {
      Products = [];
      Products = value;
      print(Products);
      emit(GetDataProductsSucssesful());
    });
  }
  void getSuppliersAfterChange() {
    getDataSupplayers(dataBase).then((value) {
      Supplayer = [];
      Supplayer = value;
      print(Supplayer);
      emit(GetDataSupplayersSucssesful());
    });
  }
  void getFeesAfterChange() {
    getDataFees(dataBase).then((value) {
      fees = [];
      fees = value;
      print(fees);
      emit(GetDataSupplayersSucssesful());
    });
  }
  Future<String> getname() async => ("youssef ahmed ");
  void cahnge(){
   emit(SetState());
  }
  void insertValueIntoControlar(e){
    NameOfItem.text=e["Name"];
    CodeOfItem.text=e["Code"];
    PriceOfItem.text=e["Price"].toString();
    NumberOfItem.text=e["NumberInStore"].toString();
    StartDate.text=e["StartDate"].toString();
    EndDate.text=e["EndDate"].toString();
    id=e["id"];

    emit(InsertValueIntoControlar());
  }
  void updateProdcts(){
    dataBase.rawUpdate(
        'UPDATE Products SET Price=? WHERE Code=? ', [PriceOfItem.text, CodeOfItem.text]);
      dataBase.rawUpdate(
          'UPDATE Products SET NumberInStore=? WHERE Code=? ', [NumberOfItem.text, CodeOfItem.text]);
      dataBase.rawUpdate(
          'UPDATE Products SET Name=? WHERE Code=? ', [NameOfItem.text, CodeOfItem.text]);
      dataBase.rawUpdate(
          'UPDATE Products SET StartDate=? WHERE Code=? ', [StartDate.text, CodeOfItem.text]);
      dataBase.rawUpdate(
          'UPDATE Products SET EndDate=? WHERE Code=? ', [EndDate.text, CodeOfItem.text]);
    getProductsAfterChange();
    getSearchItem(NameOfSearch.text);
    emit(UpdateProducts());
  }
  void updateProdctsARecord({Number,Code,price}){
    dataBase.rawUpdate(
        'UPDATE Products SET Num=? WHERE Code=? ', [1, Code]);
      dataBase.rawUpdate(
          'UPDATE Products SET NumberInStore=? WHERE Code=? ', [Number, Code]);
    dataBase.rawUpdate(
        'UPDATE Products SET TotalMoney=? WHERE Code=? ', [price, Code]);
    getProductsAfterChange();
    emit(UpdateProducts());
  }
  void updateSuppliers(id){
      dataBase.rawUpdate('UPDATE Suppliers SET TotalSuppliers=? WHERE id=? ',
          [TotalOfSupllayers, id]);
    dataBase.rawUpdate(
        'UPDATE Suppliers SET LastPaid=? WHERE id=? ', [double.parse(paidOfFees.text), id]);
    dataBase.rawUpdate(
        'UPDATE Suppliers SET LastDate=? WHERE id=? ', [dateOfFees.text, id]);
    getFeesAfterChange();
    getSuppliersAfterChange();
    emit(UpdateProducts());
  }
  void updateSuppliersAfterAdd(id){
    var totalSuppliersAfterAdd=Supplayer[id-1]["TotalSuppliers"]+double.parse(paidOfFees.text);
      dataBase.rawUpdate('UPDATE Suppliers SET TotalSuppliers=? WHERE id=? ', [totalSuppliersAfterAdd, id]);
    paidOfFees.clear();
    dateOfFees.clear();
    getSuppliersAfterChange();
    emit(UpdateProducts());
  }
  void deleteProducts()async{
    await dataBase.rawDelete('DELETE FROM Products WHERE Code=? ', [CodeOfItem.text]).then((value) {
      getProductsAfterChange();
      getSearchItem(NameOfSearch.text);
    });
   CodeOfItem.clear();
    NameOfItem.clear();
    NumberOfItem.clear();
   PriceOfItem.clear();
   EndDate.clear();
    StartDate.clear();
    id=null;
    emit(DeleteProducts());
  }
  Future SureItemNotFound()async{
    getItemProducts(dataBase,CodeOfItem.text).then((value) {

      if(value.isNotEmpty)
        {
          DisableInsertButton=false;
          print("$DisableInsertButton it isss");
          emit(SureItemFound());
        }
      else {
        DisableInsertButton=true;
      }
      emit(SureItemFound());
    });



  }
void ChangePageIntoCashier(){
    bodyIndex=0;
    emit(ReturnToPage());
}
void ChangePageIntoAddItem(){
    bodyIndex=1;
    AlertItemNFound=false;
    emit(ReturnToPage());
}
void GetItem(){
    if(DChangeNumberItem) {
        if (orders.isEmpty||orders.every((element) =>"${element["Code"]}"!=CodeOfProduct.text)){
        getItemProducts(dataBase,CodeOfProduct.text).then((value){
          if(value.isNotEmpty) {
            if (Index == null) {
              orders.add(value.single);
              CodeOfProduct.clear();
              NameOfProduct.clear();
              NumberOfProduct.clear();
              emit(InsertIntoOrder());
            } else if (Index != null) {
              orders.insert(Index!, value.single);
              NInserted = false;
              CodeOfProduct.clear();
              NameOfProduct.clear();
              NumberOfProduct.clear();
              Index=null;
              emit(InsertIntoOrder());
            }
          }else {
            AlertItemNFound=true;
          emit(InsertIntoOrder());
          }
        });
        }else{
          AlertChangeNum=true;
          emit(InsertIntoOrder());
        }
    }
    else{
      UpdeteNumAfterChange();
    }
    for (int l = 0; l<orders.length; l++) {
      total = orders[l]["TotalMoney"]+total;
    }
  }
void InsertValueItem({NameOFItem, codeOFItem, NumberOFItem,Price,id,index}){
NameOfProduct.text=NameOFItem;
CodeOfProduct.text=codeOFItem;
DChangeNumberItem=false;
idOfChange=id;
price=Price;
Index=index;
emit(InsertIntoCashier());
}
  void deleteItemFOrders(context){
    orders.removeAt(Index!);
    DChangeNumberItem=true;
    total = 0.0;
    for (int l = 0; l < orders.length; l++) {
      total = orders[l]["TotalMoney"] + total;
    }
    CodeOfProduct.clear();
    NameOfProduct.clear();
    NumberOfProduct.clear();
    emit(DeleteItemOrder());
  }
void UpdeteNumAfterChange(){
  dataBase.rawUpdate(
      'UPDATE Products SET Num=? WHERE Code=? ', [NumberOfProduct.text,CodeOfProduct.text]);
  dataBase.rawUpdate(
      'UPDATE Products SET TotalMoney=? WHERE Code=? ',[double.parse(NumberOfProduct.text)*price!, CodeOfProduct.text]);
      orders.removeAt(Index!);
  DChangeNumberItem=true;
  getDataProducts(dataBase).then((value) {
    Products = [];
    Products = value;
    GetItem();
  });
  emit(UpdateNumItem());
}
void changeSelected(bool){
    selected=bool;
    emit(ChangeSelected());

}
void getSearchItem(valuee){
  getItemSProductsSearch(dataBase, valuee).then((value)
      {
        SearchProducts=[];
        SearchProducts=value;
        emit(GetSearchItem());
      }
  );
}

}