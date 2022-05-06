// ignore_for_file: non_constant_identifier_names
import 'dart:developer';

import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/models/AddItem.dart';
import 'package:untitled6/models/Store.dart';
import 'package:untitled6/models/Casherpage.dart';
import 'package:untitled6/models/Empoloyee/AttindANDLivingEmpo.dart';
import 'package:untitled6/models/Items.dart';
import 'package:untitled6/models/Money.dart';
import 'package:untitled6/models/Supplayer/Supplayers.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:untitled6/module/user_module.dart';

import '../HomeLayout/HomeLayout.dart';

class CasherCuibt extends Cubit<CasherState> {
  CasherCuibt() : super(initState());
  static CasherCuibt get(context) => BlocProvider.of(context);
  var databaseFactory = databaseFactoryFfi;
  late Database dataBase;
  List Products = [];
  List SearchProducts = [];
  List Supplayer = [];
  List orders = [];
  List recordedOrders = [];
  List employee = [];
  List DateEmployee = [];
  double TotalOfRecite = 0.0;
  List fees = [];
  int bodyIndex = 0;
  bool Search = false;
  var value;
  var storeValue;
  bool ItemsSearch = false;
  bool isMoreThanTotalMoney = false;
  bool DisableInsertButton = true;

  //Controller of AddItem Screen
  var NameOfItem = TextEditingController();
  var CodeOfItem = TextEditingController();
  var PriceOfItem = TextEditingController();
  var NumberOfItem = TextEditingController();
  var StartDate = TextEditingController();
  var EndDate = TextEditingController();
  var NameOfSearch = TextEditingController();
  var CodeOfSearch = TextEditingController();
  var NumberInPlace = TextEditingController();
  var kayform = GlobalKey<FormState>();
  int? id;

  //controller of Items Screen
  var NameController = TextEditingController();

  //Controller Of AddInvoice
  var NameOfSupllayers = TextEditingController();
  var CostOfInvoice = TextEditingController();
  var PaidOfInvoice = TextEditingController();
  double TotalOfInvoice = 0;
  double TotalOfSupllayers = 0.0;
  var DateOfSupllayers = TextEditingController();
  var SublayersKeyForm = GlobalKey<FormState>();

  //Pay Fees
  var totalFees = TextEditingController();
  var paidOfFees = TextEditingController();
  var dateOfFees = TextEditingController();
  var feesKeyForm = GlobalKey<FormState>();
  double payedMoney = 0.0;

  //Add money
  var increesKeyForm = GlobalKey<FormState>();

  // CashierPage
  var NameOfProduct = TextEditingController();
  var NumberOfProduct = TextEditingController();
  var CodeOfProduct = TextEditingController();
  var NumOrders = TextEditingController();
  bool DChangeNumberItem = true;
  bool AlertChangeNum = false;
  bool AlertItemNFound = false;
  int? idOfChange;
  double? price;
  int? Index;
  double AllMoneyGet = 0.0;
  double totalMoney = 0.0;
  FocusNode foucs = FocusNode();
  double total = 0.0;
  bool selected = false;
  bool NInserted = true;
  var NumberOfOrder = 1;

  //Add Employee
  var NameOfEmpolyees = TextEditingController();
  var SalaryOfEmpolyees = TextEditingController();
  var HireDateOfEmpolyees = TextEditingController();
  var AttendanceDateOfEmpolyees = TextEditingController();
  var LeavingDateOfEmpolyees = TextEditingController();
  var AddEmpoKey = GlobalKey<FormState>();

  //employee
  var AttendanceDate = TextEditingController();
  var delayTime = TextEditingController();
  var LeavingDate = TextEditingController();
  var OverTime = TextEditingController();
  var DataTimeDay = TextEditingController();
  var ShowDateEmpolye = true;
  double Sallry = 0;
//Sign up
  var SignUpForm = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var passController2 = TextEditingController();
  var phoneController = TextEditingController();
  var shopNameController = TextEditingController();
  bool isObserer = true;
//Sign in
  var SignInForm = GlobalKey<FormState>();
  var SignEmailController = TextEditingController();
  var signPassController = TextEditingController();
  var box = Hive.box("Token");
  String? Token;
  //UI
  List<Widget> body = [
    CasherPage(),
    AddItem(),
    Items(),
    Supplayers(),
    Empoloye(),
    Money(),
    Store(),
  ];
  void changeObs() {
    isObserer = !isObserer;
    emit(ChangeObs());
  }

  void ChangeMyIndex(value) {
    bodyIndex = value;
    emit(ChangeIndex());
  }

  void AddItemChangeSearch() {
    Search = !Search;
    emit(ChangeSearchAbilty());
  }

  void ItemSChangeSearch() {
    ItemsSearch = !ItemsSearch;
    emit(ChangeSearchAbilty());
  }

  void ChangeValue(valuee) {
    value = valuee;
    emit(ChangeValuee());
  }

  void ChangeStoreValue(valuee) {
    storeValue = valuee;
    emit(ChangeValuee());
  }

  void Crdatab() async {
    dataBase =
        await openDatabase("kk.db", version: 1, onCreate: (dataBase, version) {
      print("create data base");
      dataBase.execute(
          'CREATE TABLE Orders (Name Text,Code TEXT,Price DOUBLE,OrderDate Text,Num DOUBLE,TotalMoney DOUBLE,NumberOrder INTEGER,AllMoney DOUBLE)');
      dataBase.execute(
          'CREATE TABLE Products (Name Text,Code TEXT  PRIMARY KEY,Price DOUBLE,NumberInStore INTEGER,NumberInPlace INTEGER,StartDate Text,EndDate Text,Num DOUBLE,TotalMoney DOUBLE)');
      dataBase.execute(
          'CREATE TABLE Suppliers (id INTEGER PRIMARY KEY,Name TEXT,LastPaid DOUBLE,TotalSuppliers DOUBLE,LastDate Text)');
      dataBase.execute(
          'CREATE TABLE Fees (id INTEGER PRIMARY KEY,Name TEXT,Paid DOUBLE,TotalSuppliers DOUBLE,LastDate Text)');
      dataBase.execute(
          'CREATE TABLE Employee (id INTEGER PRIMARY KEY,Name TEXT,Salary DOUBLE,HireDate Text,AttendanceDate Text,LeavingDate Text)');
      dataBase
          .execute(
              'CREATE TABLE EmployeeAttendance (id INTEGER,AttendanceDate TEXT,LeavingDate Text,DataTimeDay TEXT)')
          .then((value) {
        print("Table is created");
        emit(CreateDataBaseSuccessfully());
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
      });
      getDataFees(dataBase).then((value) {
        fees = [];
        fees = value;
      });
      getAllOrders(dataBase).then((value) {
        recordedOrders = [];
        recordedOrders = value;
        if (value.isNotEmpty)
          NumberOfOrder = ((recordedOrders[recordedOrders.length - 1]
                      ["NumberOrder"]) +
                  1) ??
              1;
      });
      GetDataEmpolyee(dataBase);

      emit(GetDataProductsSuccessfully());
    }).catchError((Error) {
      print("the error is ${Error.toString()}");
      emit(GetDataProductsBaseError());
    });
  }

  Future<List<Map>> getDataProducts(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Products');
  }

  Future<List<Map>> getItemProducts(dataBase, key) async {
    return await dataBase.rawQuery('SELECT*FROM Products WHERE Code=?', [key]);
  }

  Future<List<Map>> getItemSProductsSearch(dataBase, value) async {
    return await dataBase
        .rawQuery('SELECT*FROM Products WHERE Name like ?', ["${value}%"]);
  }

  Future<List<Map>> getOrders(value) async {
    return await dataBase
        .rawQuery('SELECT*FROM Orders WHERE NumberOrder = ?', ["$value"]);
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

  Future<List<Map>> getDataEmployee(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Employee');
  }

  Future<List<Map>> getDataEmployeeEspcially(dataBase, id) async {
    return await dataBase.rawQuery('SELECT*FROM Employee WHERE id=?', [id]);
  }

  void GetDataEmpolyee(dataBase) {
    getDataEmployee(dataBase).then((value) {
      employee = [];
      employee = value;
      emit(GetEmployeeSuccessfully());
    });
  }

  Future<List<Map>> getdateAttendEmployee(id, date) async {
    return await dataBase
        .rawQuery('SELECT*FROM EmployeeAttendance WHERE id = ?', ["$id"]);
  }

  void getEmployeeDate(id, date) {
    print("im in getEmployeeDate");
    getdateAttendEmployee(id, date).then((value) {
      DateEmployee = [];
      DateEmployee = value;
      print(DateEmployee);
      emit(InsertDateEmployeeError());
    });
  }

  Future insertIntoProducts() async {
    SureItemNotFound().then((value) async {
      if (DisableInsertButton) {
        await dataBase.transaction((txn) {
          txn
              .rawInsert(
                  'INSERT INTO Products(Name,Code,Price,NumberInStore,StartDate,EndDate,Num,TotalMoney,NumberInPlace)VALUES("${NameOfItem.text}","${CodeOfItem.text}","${PriceOfItem.text}","${NumberOfItem.text}","${StartDate.text}","${EndDate.text}","1","${double.parse(PriceOfItem.text)}","${NumberInPlace.text}")')
              .then((value) {
            emit(InsertProductSuccessfully());
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
      } else {
        print("I cant do this");
      }
    });
  }

  Future RecordOrder() async {
    AllMoneyGet = AllMoneyGet + total;
    totalMoney = AllMoneyGet - payedMoney;
    for (var e in orders) {
      await dataBase.transaction((txn) {
        txn
            .rawInsert(
                'INSERT INTO Orders(Name,Code,Price,OrderDate,Num,TotalMoney,NumberOrder,AllMoney)VALUES("${e["Name"]}","${e["Code"]}","${e["Price"]}","${DateTime.now()}","${e["Num"]}","${e["TotalMoney"]}","$NumberOfOrder","$AllMoneyGet")')
            .then((value) {
          updateProdctsARecord(
              Code: e["code"],
              Number: e["NumberInStore"] - e["Num"],
              price: e["price"]);
          orders = [];
          total = 0.0;
          emit(RecordOrderSuccessfullyl());
        }).catchError((error) {
          print(" the error is ${error.toString()}");
          emit(RecordOrderError());
        });
        return getname();
      });
    }
    getAllOrders(dataBase).then((value) {
      recordedOrders = [];
      recordedOrders = value;
      NumberOfOrder =
          (recordedOrders[recordedOrders.length - 1]["NumberOrder"]) + 1;
    });

    emit(RecordOrderSuccessfullyl());
  }

  Future insertIntoSupplayers() async {
    TotalOfSupllayers = double.parse(CostOfInvoice.text);
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Suppliers(Name,LastPaid,TotalSuppliers,LastDate)VALUES("${NameOfSupllayers.text}","${PaidOfInvoice.text}","$TotalOfSupllayers","${DateOfSupllayers.text}")')
          .then((value) {
        print("$value insertetd sucsseffly");
        emit(InsertProductSuccessfully());
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
    payedMoney = payedMoney + double.parse(paidOfFees.text);
    totalMoney = AllMoneyGet - payedMoney;
    TotalOfSupllayers =
        Supplayer[id - 1]["TotalSuppliers"] - double.parse(paidOfFees.text);
    if (TotalOfSupllayers >= 0) {
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
          emit(InsertProductSuccessfully());
        }).catchError((error) {
          print(" the error is ${error.toString()}");
          emit(InsertProductError());
        });
        return getname();
      });
    } else {
      isMoreThanTotalMoney = true;
      emit(InsertProductError());
    }
  }

  Future insertIntoEmpolyees() async {
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Employee(Name,Salary,HireDate,AttendanceDate,LeavingDate)VALUES("${NameOfEmpolyees.text}","${SalaryOfEmpolyees.text}","${HireDateOfEmpolyees.text}","${AttendanceDateOfEmpolyees.text}","${LeavingDateOfEmpolyees.text}")')
          .then((value) {
        print("$value insertetd sucsseffly");
        GetDataEmpolyee(dataBase);
        NameOfEmpolyees.clear();
        SalaryOfEmpolyees.clear();
        HireDateOfEmpolyees.clear();
        emit(InsertEmployeeSuccessfully());
      }).catchError((error) {
        print(" the error is ${error.toString()}");
        emit(InsertEmployeeError());
      });
      return getname();
    });
  }

  Future insertIntoEmployeeAttendance({required id}) async {
    return dataBase.transaction((txn) {
      txn
          .rawInsert(
              //(
              // (id INTEGER,AttendanceDate TEXT,delayTime TEXT,LeavingDate Text,OverTime TEXT,TotalTime TEXT,TotalSalary DOUBLE,DataTimeDay TEXT)')
              'INSERT INTO EmployeeAttendance(id,AttendanceDate,LeavingDate,DataTimeDay)VALUES'
              '("$id","${AttendanceDate.text}","${LeavingDate.text}","${DateFormat.yMMMd().format(DateTime.now())}")')
          .then((value) {
        print("$value insertetd sucsseffly");
        getEmployeeDate(id, DateTime.now());
        emit(InsertDateEmployeeSuccessfully());
      }).catchError((error) {
        print(" the error is ${error.toString()}");
        emit(InsertDateEmployeeError());
      });
      return getname();
    });
  }

  void getProductsAfterChange() {
    getDataProducts(dataBase).then((value) {
      Products = [];
      Products = value;
      print(Products);
      emit(GetDataProductsSuccessfully());
    });
  }

  void getSuppliersAfterChange() {
    getDataSupplayers(dataBase).then((value) {
      Supplayer = [];
      Supplayer = value;
      print(Supplayer);
      emit(GetDataSupplayersSuccessfully());
    });
  }

  void getFeesAfterChange() {
    getDataFees(dataBase).then((value) {
      fees = [];
      fees = value;
      print(fees);
      emit(GetDataSupplayersSuccessfully());
    });
  }

  Future<String> getname() async => ("youssef ahmed ");

  void cahnge() {
    emit(SetState());
  }

  void insertValueIntoControlar(e) {
    NameOfItem.text = e["Name"];
    CodeOfItem.text = e["Code"];
    PriceOfItem.text = e["Price"].toString();
    NumberOfItem.text = e["NumberInStore"].toString();
    StartDate.text = e["StartDate"].toString();
    EndDate.text = e["EndDate"].toString();
    id = e["id"];

    emit(InsertValueIntoControlar());
  }

  void updateProdcts() {
    dataBase.rawUpdate('UPDATE Products SET Price=? WHERE Code=? ',
        [PriceOfItem.text, CodeOfItem.text]);
    dataBase.rawUpdate('UPDATE Products SET NumberInStore=? WHERE Code=? ',
        [NumberOfItem.text, CodeOfItem.text]);
    dataBase.rawUpdate('UPDATE Products SET Name=? WHERE Code=? ',
        [NameOfItem.text, CodeOfItem.text]);
    dataBase.rawUpdate('UPDATE Products SET StartDate=? WHERE Code=? ',
        [StartDate.text, CodeOfItem.text]);
    dataBase.rawUpdate('UPDATE Products SET EndDate=? WHERE Code=? ',
        [EndDate.text, CodeOfItem.text]);
    getProductsAfterChange();
    getSearchItem(NameOfSearch.text);
    emit(UpdateProducts());
  }

  void updateProdctsARecord({Number, Code, price}) {
    dataBase.rawUpdate('UPDATE Products SET Num=? WHERE Code=? ', [1, Code]);
    dataBase.rawUpdate(
        'UPDATE Products SET NumberInStore=? WHERE Code=? ', [Number, Code]);
    dataBase.rawUpdate(
        'UPDATE Products SET TotalMoney=? WHERE Code=? ', [price, Code]);
    getProductsAfterChange();
    emit(UpdateProducts());
  }

  void updateSuppliers(id) {
    dataBase.rawUpdate('UPDATE Suppliers SET TotalSuppliers=? WHERE id=? ',
        [TotalOfSupllayers, id]);
    dataBase.rawUpdate('UPDATE Suppliers SET LastPaid=? WHERE id=? ',
        [double.parse(paidOfFees.text), id]);
    dataBase.rawUpdate(
        'UPDATE Suppliers SET LastDate=? WHERE id=? ', [dateOfFees.text, id]);
    getFeesAfterChange();
    getSuppliersAfterChange();
    emit(UpdateProducts());
  }

  void updateSuppliersAfterAdd(id) {
    var totalSuppliersAfterAdd =
        Supplayer[id - 1]["TotalSuppliers"] + double.parse(paidOfFees.text);
    dataBase.rawUpdate('UPDATE Suppliers SET TotalSuppliers=? WHERE id=? ',
        [totalSuppliersAfterAdd, id]);
    paidOfFees.clear();
    dateOfFees.clear();
    getSuppliersAfterChange();
    emit(UpdateProducts());
  }

  void deleteProducts() async {
    await dataBase.rawDelete(
        'DELETE FROM Products WHERE Code=? ', [CodeOfItem.text]).then((value) {
      getProductsAfterChange();
      getSearchItem(NameOfSearch.text);
    });
    CodeOfItem.clear();
    NameOfItem.clear();
    NumberOfItem.clear();
    PriceOfItem.clear();
    EndDate.clear();
    StartDate.clear();
    id = null;
    emit(DeleteProducts());
  }

  Future SureItemNotFound() async {
    getItemProducts(dataBase, CodeOfItem.text).then((value) {
      if (value.isNotEmpty) {
        DisableInsertButton = false;
        print("$DisableInsertButton it isss");
        emit(SureItemFound());
      } else {
        DisableInsertButton = true;
      }
      emit(SureItemFound());
    });
  }

  void ChangePageIntoCashier() {
    bodyIndex = 0;
    emit(returnToPage());
  }

  void ChangePageIntoAddItem() {
    bodyIndex = 1;
    AlertItemNFound = false;
    emit(returnToPage());
  }

  void GetItem() {
    if (DChangeNumberItem) {
      if (orders.isEmpty ||
          orders
              .every((element) => "${element["Code"]}" != CodeOfProduct.text)) {
        getItemProducts(dataBase, CodeOfProduct.text).then((value) {
          if (value.isNotEmpty) {
            if (Index == null) {
              orders.add(value.single);
              total = value.single["TotalMoney"] + total;
              CodeOfProduct.clear();
              NameOfProduct.clear();
              NumberOfProduct.clear();
              emit(InsertIntoOrder());
            } else if (Index != null) {
              orders.insert(Index!, value.single);
              total = value.single["TotalMoney"] + total;
              NInserted = false;
              CodeOfProduct.clear();
              NameOfProduct.clear();
              NumberOfProduct.clear();
              Index = null;
              emit(InsertIntoOrder());
            }
          } else {
            print("item not found");
            AlertItemNFound = true;
            emit(ErrorInsertIOrder());
          }
        });
      } else {
        AlertChangeNum = true;
        emit(InsertIntoOrder());
      }
    } else {
      UpdeteNumAfterChange();
    }
  }

  void InsertValueItem(
      {NameOFItem, codeOFItem, NumberOFItem, Price, id, index}) {
    NameOfProduct.text = NameOFItem;
    CodeOfProduct.text = codeOFItem;
    DChangeNumberItem = false;
    idOfChange = id;
    price = Price;
    Index = index;
    emit(InsertIntoCashier());
  }

  void deleteItemFOrders(context) {
    orders.removeAt(Index!);
    DChangeNumberItem = true;
    total = 0.0;
    for (int l = 0; l < orders.length; l++) {
      total = orders[l]["TotalMoney"] + total;
    }
    CodeOfProduct.clear();
    NameOfProduct.clear();
    NumberOfProduct.clear();
    emit(DeleteItemOrder());
  }

  void UpdeteNumAfterChange() {
    dataBase.rawUpdate('UPDATE Products SET Num=? WHERE Code=? ',
        [NumberOfProduct.text, CodeOfProduct.text]);
    dataBase.rawUpdate('UPDATE Products SET TotalMoney=? WHERE Code=? ',
        [double.parse(NumberOfProduct.text) * price!, CodeOfProduct.text]);
    total = total - orders[Index!]["TotalMoney"];
    orders.removeAt(Index!);
    DChangeNumberItem = true;
    GetItem();
    emit(UpdateNumItem());
  }

  void changeSelected(bool) {
    selected = bool;
    emit(ChangeSelected());
  }

  void getSearchItem(valuee) {
    getItemSProductsSearch(dataBase, valuee).then((value) {
      SearchProducts = [];
      SearchProducts = value;
      emit(GetSearchItem());
    });
  }

  void calcTotalOfRecite() {
    TotalOfRecite = 0.0;
    for (var element in recordedOrders) {
      TotalOfRecite = element["TotalMoney"] + TotalOfRecite;
    }
    emit(calcRiciet());
  }

  void getRecite(Text) {
    getOrders(Text).then((value) {
      recordedOrders = [];
      recordedOrders = value;
      calcTotalOfRecite();
      emit(GetRecites());
    });
  }

  var valueEmpo;

  void ChangeValueOFEmpo(value) {
    valueEmpo = value;
    print("$valueEmpo");
    emit(ChangeEmpo());
  }

  void DeleteEmpo(id) async {
    print("value");

    await dataBase
        .rawDelete('DELETE FROM Employee WHERE id=? ', [id]).then((value) {
      print("$value");
      DeleteEmpoAttends(id);
      emit(deleteEmpo());
    }).catchError((error) {
      print(error);
    });
  }

  void DeleteEmpoAttends(id) async {
    await dataBase
        .rawDelete('DELETE FROM EmployeeAttendance WHERE id=? ', [id])
        .then((value) {})
        .catchError((error) {
          print(error);
        });
  }

  void createUserProfile({
    required String name,
    required String email,
    required String phone,
    required String pass,
    required String uid,
    required String nameShop,
  }) {
    UserModule? user = UserModule(
        phone: phone,
        name: name,
        email: email,
        shopName: nameShop,
        uid: uid,
        password: pass);
    Firestore.instance
        .collection("Users")
        .document(uid)
        .set(user.toJson())
        .then((value) {
      log("create New user");
      emit(CreateBaseUserProfileTr());
    }).catchError((onError) {
      print(onError);
      emit(CreateBaseUserProfileFa(onError.toString()));
    });
  }

  void createNewUser(context) {
    FirebaseAuth.instance
        .signUp(emailController.text, passController.text)
        .then((value) {
      createUserProfile(
          email: emailController.text,
          name: nameController.text,
          uid: value.id,
          phone: phoneController.text,
          pass: passController.text,
          nameShop: shopNameController.text);
      emailController.clear();
      nameController.clear();
      phoneController.clear();
      passController.clear();
      passController.clear();
      shopNameController.clear();
      Nevigator(bool: false, page: HomeScreen(), context: context);
    }).catchError((onError) {
      print(onError);
      emit(CreateBaseUserProfileFa(onError.toString()));
    });
  }

  void SignIn(context) {
    FirebaseAuth.instance
        .signIn(SignEmailController.text, signPassController.text)
        .then((value) {
      Token = value.id;
      box.put("Token", value.id);
      Nevigator(bool: false, page: HomeScreen(), context: context);
      emit(SignInTr());
    }).catchError((onError) {
      Token = null;
      print(onError);
      emit(SignInFa(onError.toString()));
    });
  }
void RessetPassword() {
}
  void Logout() {
    Hive.box("Token").delete("Token");
    emit(SignOut());
  }
}
