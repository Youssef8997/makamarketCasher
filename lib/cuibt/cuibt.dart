
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

  bool ItemsSearch=false;
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
    await openDatabase("MakaMarket.db", version: 1, onCreate: (dataBase, version) {
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
  void getProductsAfterChange() {
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
  void Update(){
    if (PriceOfItem.text!=null)
    dataBase.rawUpdate(
        'UPDATE Products SET Price=? WHERE id=? ', [PriceOfItem.text, id]);
    if(NumberOfItem.text!=null)
      dataBase.rawUpdate(
          'UPDATE Products SET Number=? WHERE id=? ', [NumberOfItem.text, id]);
    if(NameOfItem.text!=null)
      dataBase.rawUpdate(
          'UPDATE Products SET Name=? WHERE id=? ', [NameOfItem.text, id]);
    if(StartDate.text!=null)
      dataBase.rawUpdate(
          'UPDATE Products SET StartDate=? WHERE id=? ', [StartDate.text, id]);
    if(EndDate.text!=null)
      dataBase.rawUpdate(
          'UPDATE Products SET EndDate=? WHERE id=? ', [EndDate.text, id]);
    getProductsAfterChange();
    emit(UpdateProducts());
  }
  void delete()async{
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
   void SureItemNotFound(){
    for (var element in Products) {
      if(element["Code"]==CodeOfItem.text){
        DisableInsertButton=false;
        print("this is ${DisableInsertButton}");
      }
      if(element["Code"]!=CodeOfItem.text)
        DisableInsertButton=false;
    }
    emit(sureItemNotFound());
  }
  void data(){
    dataBase.delete("Products");
  }
}