
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/models/AddItem.dart';
import 'package:untitled6/models/Store.dart';
import 'package:untitled6/models/Casherpage.dart';
import 'package:untitled6/models/Empoloye.dart';
import 'package:untitled6/models/Items.dart';
import 'package:untitled6/models/Money.dart';
import 'package:untitled6/models/Supplayer/Supplayers.dart';
import 'package:sqflite_common/sqlite_api.dart';
class CasherCuibt extends Cubit<CasherState>{
  CasherCuibt() : super(initState());
  static CasherCuibt get(context) => BlocProvider.of(context);
  var databaseFactory = databaseFactoryFfi;
  late Database dataBase;
  List Products=[];
  List Supplayer=[];
  List fees=[];
  int MyIndex=0;
  bool Search=false;
  var value;
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
    MyIndex=value;
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
  void Crdatab() async {
   dataBase =
    await openDatabase("yoyo.db", version: 2, onCreate: (dataBase, version) {
      print("create data base");
      dataBase.execute(
          'CREATE TABLE Products (id INTEGER PRIMARY KEY,Name INTEGER,Code TEXT,Price DOUBLE,Number INTEGER,StartDate Text,EndDate Text)');
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
        print(Supplayer);});
      getDataProducts(dataBase).then((value) {
        Products = [];
        Products = value;
        print(Products);});
      getDataFees(dataBase).then((value) {
        fees = [];
        fees = value;
        print(fees);});
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
  Future<List<Map>> getDataSupplayers(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Suppliers');
  }
  Future<List<Map>> getDataFees(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Fees');
  }
  Future insertIntoProducts() async {
    await dataBase.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO Products(Name,Code,Price,Number,StartDate,EndDate)VALUES("${NameOfItem.text}","${CodeOfItem.text}","${PriceOfItem.text}","${NumberOfItem.text}","${StartDate.text }","${EndDate.text}")')
          .then((value) {
        print("$value insertetd sucsseffly");
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
   emit(setstate());
  }
var n;
  void d(){
    n=2;
    emit(ChangeSearchAbilty());
  }
  void insertValueIntoControlar(e){
    NameOfItem.text=e["Name"];
    CodeOfItem.text=e["Code"];
    PriceOfItem.text=e["Price"].toString();
    NumberOfItem.text=e["Number"].toString();
    StartDate.text=e["StartDate"].toString();
    EndDate.text=e["EndDate"].toString();
    id=e["id"];

    emit(InsertValueIntoControlar());
  }
  void updateProdcts(){
    dataBase.rawUpdate(
        'UPDATE Products SET Price=? WHERE id=? ', [PriceOfItem.text, id]);
      dataBase.rawUpdate(
          'UPDATE Products SET Number=? WHERE id=? ', [NumberOfItem.text, id]);
      dataBase.rawUpdate(
          'UPDATE Products SET Name=? WHERE id=? ', [NameOfItem.text, id]);
      dataBase.rawUpdate(
          'UPDATE Products SET StartDate=? WHERE id=? ', [StartDate.text, id]);
      dataBase.rawUpdate(
          'UPDATE Products SET EndDate=? WHERE id=? ', [EndDate.text, id]);
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
  void updateSuppliersAfterDelete(id){
      dataBase.rawUpdate('UPDATE Suppliers SET TotalSuppliers=? WHERE id=? ',
          [fees[id-1]["TotalSuppliers"], id]);
    dataBase.rawUpdate(
        'UPDATE Suppliers SET LastPaid=? WHERE id=? ', [fees[id-1]["Paid"], id]);
    dataBase.rawUpdate(
        'UPDATE Suppliers SET LastDate=? WHERE id=? ', [fees[id-1]["LastDate"], id]);
    getFeesAfterChange();
    getSuppliersAfterChange();
    emit(UpdateProducts());
  }
  void deleteProducts()async{
    await dataBase.rawDelete('DELETE FROM Products WHERE id=? ', [id]).then((value) =>getProductsAfterChange());
   CodeOfItem.clear();
    NameOfItem.clear();
    NumberOfItem.clear();
   PriceOfItem.clear();
   EndDate.clear();
    StartDate.clear();
    id=null;
    emit(DeleteProducts());
  }
  void deleteFees(id)async{
    await dataBase.rawDelete('DELETE FROM fees WHERE id=? ', [id]).then((value)
    {
      getFeesAfterChange();
      updateSuppliersAfterDelete(id);
    });
    id=null;
    emit(DeleteProducts());
  }

   Future SureItemNotFound()async{
    for (var element in Products) {
      if("${element["Code"]}".contains("${CodeOfItem.text}")){
        DisableInsertButton=false;
        print("this is cuibt $DisableInsertButton");
        emit(sureItemNotFound());
      }else {
        DisableInsertButton = true;
      }

      emit(sureItemNotFound());
    }

  }

}