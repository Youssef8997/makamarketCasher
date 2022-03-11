
import 'package:flutter/foundation.dart';
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
import 'package:untitled6/models/Supplayers.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
class CasherCuibt extends Cubit<CasherState>{
  CasherCuibt() : super(initState());
  static CasherCuibt get(context) => BlocProvider.of(context);
  var databaseFactory = databaseFactoryFfi;
  late Database dataBase;
  List Products=[];
  int MyIndex=0;
  bool Search=false;
  bool boolen=false;
  bool ItemsSearch=false;
  //Controller of AddItem Screen
  var NameOfItem = TextEditingController();
  var CodeOfItem = TextEditingController();
  var PriceOfItem = TextEditingController();
  var NumberOfItem = TextEditingController();
  var FirstDate = TextEditingController();
  var EndDate = TextEditingController();
  var NameOfSearch = TextEditingController();
  var CodeOfSearch = TextEditingController();
  var kayform = GlobalKey<FormState>();
  //controller of Items Screen
  var NameController = TextEditingController();
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
  void Crdatab() async {
   dataBase =
    await openDatabase("MakaMarketCashier.db", version: 2, onCreate: (dataBase, version) {
      print("create data base");
      dataBase.execute(
          'CREATE TABLE Products (id INTEGER PRIMARY KEY,Name TEXT,Code TEXT,Price DOUBLE,Number INTEGER,StartDate Text,EndDate Text)')
          .then((value) {
         print("Table is created");
        emit(CreateDataBaseSucssesful());
      }).catchError((error) {
        print("error is${error.toString()}");
        emit(CreateDataBaseError());
      });
    }, onOpen: (dataBase) {
      boolen=true;
      print("the bool  = $boolen");
      print("open data base");
     getDataProducts(dataBase).then((value) {
       Products = value;
       Products.forEach((element) {
        });
        print(Products);
        emit(GetDataProductsSucssesful());
      }).catchError((Error) {
        print("the error is ${Error.toString()}");
        emit(GetDataProductsBaseError());
      });

    });
  }
  Future<List<Map>> getDataProducts(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Products');
  }
  Future insert() async
  {
    await dataBase.transaction((txn) {
      txn.rawInsert(
          'INSERT INTO Products(Name,Code,Price,Number,StartDate,EndDate)VALUES("${NameOfItem.text}","${CodeOfItem.text}","${PriceOfItem.text}","${NumberOfItem.text}","${FirstDate.text }","${EndDate.text}")')
          .then((value) {
        print("$value insertetd sucsseffly");
        emit(InsertProductSucssesful());
        getUsersAfterChange();
        NameOfItem.clear();
        CodeOfItem.clear();
        PriceOfItem.clear();
        NumberOfItem.clear();
        FirstDate.clear();
        EndDate.clear();
      }).catchError((error) {
        print(" the error is ${error.toString()}");
        emit(InsertProductError());
      });
      return getname();
    });
  }
  void getUsersAfterChange() {
    getDataProducts(dataBase).then((value) {
      Products = [];
      Products = value;
      print(Products);
      emit(GetDataProductsSucssesful());
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
}