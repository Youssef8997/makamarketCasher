// ignore_for_file: non_constant_identifier_names
import 'dart:developer';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Login/Login.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/models/AddItem.dart';
import 'package:untitled6/models/Store.dart';
import 'package:untitled6/models/Casherpage.dart';
import 'package:untitled6/models/Empoloyee/AttindANDLivingEmpo.dart';
import 'package:untitled6/models/Items.dart';
import 'package:untitled6/models/Money.dart';
import 'package:untitled6/models/Supplayer/Supplayers.dart';
import 'package:untitled6/module/Employee.dart';
import 'package:untitled6/module/Suppliers.dart';
import 'package:untitled6/module/user_module.dart';
import '../Compoandis/MyTextForm.dart';
import '../HomeLayout/HomeLayout.dart';
import '../module/Fees.dart';
import '../module/OrdersMoudle.dart';
import '../module/Product module.dart';
import '../module/dateEmpo.dart';

class CasherCuibt extends Cubit<CasherState> {
  CasherCuibt() : super(intState());
  static CasherCuibt get(context) => BlocProvider.of(context);
  var databaseFactory = databaseFactoryFfi;
  late Database dataBase;
  List Products = [];
  List NewProducts = [];
  List SearchProducts = [];
  List Suppliers = [];
  List NewSuppliers = [];
  List orders = [];
  List recordedOrders = [];
  List MapOrders = [];
  List employee = [];
  List NewEmployee = [];
  List DateEmployee = [];
  List NewDateEmployee = [];
  double TotalOfRecite = 0.0;
  List fees = [];
  List NewFees = [];
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
  var QuantityInStore = TextEditingController();
  var StartDate = TextEditingController();
  var EndDate = TextEditingController();
  var NameOfSearch = TextEditingController();
  var CodeOfSearch = TextEditingController();
  var QuantityInShop = TextEditingController();
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
  FocusNode foucsCode = FocusNode();
  Map<String, TextEditingController> QuintteyControllers = Map();
  Map<String, TextEditingController> NoteControllers = Map();
  Map<String, FocusNode> FocusControllers = Map();
  double total = 0.0;
  bool selected = false;
  bool NInserted = true;
  var NumberOfOrder = 1;
  var Notes = TextEditingController(text: "dddddd");
  var shopNameController = TextEditingController();
  var passWordController = TextEditingController();
  bool unKnownName = true;
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
  var valueEmpo;
  var valueRate;
  var nameOfEmpolyees;
  List EmpolyeesRate = [1, 2, 3, 4, 5];
  List RateColors = [
    Colors.black,
    Colors.red[900],
    Colors.redAccent,
    Colors.orange[900],
    Colors.yellow,
    Colors.green
  ];

//Sign up
  var SignUpForm = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var passController2 = TextEditingController();
  var phoneController = TextEditingController();
  bool isObserer = true;

//Sign in
  var SignInForm = GlobalKey<FormState>();
  var SignEmailController = TextEditingController();
  var signPassController = TextEditingController();

  String? Token;

  //Rest Password
  var RestPasswordForm = GlobalKey<FormState>();
  var RestEmailController = TextEditingController();
//Store
  var Quantity = TextEditingController();
  //Hive box
  var box = Hive.box("Token");
  var money = Hive.box("Money");
  var productsBox = Hive.box("products");
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
  final advancedDrawerController = AdvancedDrawerController();

  void sureUser(Number, context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlurryContainer(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            blur: 6,
            child: AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.white,
              elevation: 0,
              content: Container(
                  height: 150,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        " Enter password of your current shop ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextField(
                          Controlr: passWordController,
                          hint: "*****",
                          isobsr: true),
                    ],
                  )),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (passWordController.text == box.get("Password")) {
                      if (bodyIndex != Number) {
                        ChangeMyIndex(Number);
                      }
                    }
                    passWordController.clear();
                  },
                  child: const Text("Okay"),
                )
              ],
            ),
          );
        });

    advancedDrawerController.hideDrawer();
  }

  void cahnge() {
    emit(SetState());
  }

  void handleMenuButtonPressed() {
    advancedDrawerController.showDrawer();
  }

  void insertValueIntoControlar(e) {
    NameOfItem.text = e["Name"];
    CodeOfItem.text = e["Code"];
    PriceOfItem.text = e["Price"].toString();
    QuantityInStore.text = e["QuantityInStore"].toString();
    StartDate.text = e["StartDate"].toString();
    EndDate.text = e["EndDate"].toString();
    id = e["id"];

    emit(InsertValueIntoControlar());
  }

  Future<String> getName() async => ("youssef ahmed ");

  void ChangePageIntoCashier() {
    bodyIndex = 0;
    emit(returnToPage());
  }

  void ChangePageIntoAddItem() {
    bodyIndex = 1;
    AlertItemNFound = false;
    emit(returnToPage());
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

  void changeSelected(bool) {
    selected = bool;
    emit(ChangeSelected());
  }

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

  void createDataBase() async {
    dataBase = await openDatabase("bobo.db", version: 1,
        onCreate: (dataBase, version) {
      print("create data base");
      dataBase.execute(
          'CREATE TABLE Orders (Name Text,Code TEXT,Price DOUBLE,OrderDate Text,Num DOUBLE,TotalMoney DOUBLE,NumberOrder INTEGER,AllMoney DOUBLE,Notes Text)');
      dataBase.execute(
          'CREATE TABLE Products (Name Text,Code TEXT  PRIMARY KEY,Price DOUBLE,QuantityInStore INTEGER,QuantityInShop INTEGER,StartDate Text,EndDate Text,Num DOUBLE,TotalMoney DOUBLE,Notes Text)');
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
      getDataSuppliers(dataBase).then((value) {
        Suppliers = [];
        Suppliers = value;
      });
      getDataProducts(dataBase).then((value) {
        Products = [];
        Products = value;
        print("products is ${Products}");
      });
      getDataFees(dataBase).then((value) {
        fees = [];
        fees = value;
      });
      getAllOrders(dataBase).then((value) {
        recordedOrders = [];
        recordedOrders = value;
        if (value.isNotEmpty) {
          NumberOfOrder = ((recordedOrders[recordedOrders.length - 1]
                      ["NumberOrder"]) +
                  1) ??
              1;
        }
      });
      GetDataEmployee(dataBase);

      emit(GetDataProductsSuccessfully());
    }).catchError((Error) {
      print("the error is ${Error.toString()}");
      emit(GetDataProductsBaseError());
    });
  }

//// products Methods{
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

  void getProductsAfterChange() {
    getDataProducts(dataBase).then((value) {
      Products = [];
      Products = value;
      emit(GetDataProductsSuccessfully());

    });
  }

  Future insertIntoProducts() async {
    SureItemNotFound().then((value) async {
      if (DisableInsertButton) {
        await dataBase.transaction((txn) {
          txn
              .rawInsert(
                  'INSERT INTO Products(Name,Code,Price,QuantityInStore,StartDate,EndDate,Num,TotalMoney,QuantityInShop)VALUES("${NameOfItem.text}","${CodeOfItem.text}","${PriceOfItem.text}","${QuantityInStore.text}","${StartDate.text}","${EndDate.text}","1","${double.parse(PriceOfItem.text)}","${QuantityInShop.text}")')
              .then((value) {
            getItemProducts(dataBase, CodeOfItem.text).then((value) {
              print("this is item $value");
              productsBox.put(value.single["Code"], 0);
              NewProducts.add(value.single);
            });
            getProductsAfterChange();
            NameOfItem.clear();
            CodeOfItem.clear();
            PriceOfItem.clear();
            QuantityInStore.clear();
            StartDate.clear();
            EndDate.clear();
          }).catchError((error) {
            print(" the error is ${error.toString()}");
            emit(InsertProductError());
          });
          return getName();
        });
      } else {
        print("I cant do this");
      }
    });
  }

  void updateProducts() {
    dataBase.rawUpdate('UPDATE Products SET Price=? WHERE Code=? ',
        [PriceOfItem.text, CodeOfItem.text]);
    dataBase.rawUpdate('UPDATE Products SET QuantityInStore=? WHERE Code=? ',
        [QuantityInStore.text, CodeOfItem.text]);
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

  void WithdrawFromStore(String number) {
    getItemProducts(dataBase, storeValue).then((value) {
      dataBase.rawUpdate(
          'UPDATE Products SET QuantityInStore=? WHERE Code=? ', [
        value.single["QuantityInStore"] - int.parse(Quantity.text),
        storeValue
      ]);
      dataBase.rawUpdate('UPDATE Products SET QuantityInShop=? WHERE Code=? ', [
        value.single["QuantityInShop"] + int.parse(Quantity.text),
        storeValue
      ]);
      getProductsAfterChange();
      print(
          "the number is ${value.single["QuantityInStore"] - int.parse(Quantity.text)}");
    });

    emit(UpdateProducts());
  }

  void updateProductsARecord({Number, Code, price}) {
    dataBase.rawUpdate('UPDATE Products SET Num=? WHERE Code=? ', [1, Code]);
    dataBase.rawUpdate(
        'UPDATE Products SET QuantityInStore=? WHERE Code=? ', [Number, Code]);
    dataBase.rawUpdate(
        'UPDATE Products SET TotalMoney=? WHERE Code=? ', [price, Code]);
    getProductsAfterChange();
    print("the number is ${price}");
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
    QuantityInStore.clear();
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

  void UpdeteNumAfterChange(contetx) {
    print("index is $Index");
    dataBase.rawUpdate('UPDATE Products SET Notes=? WHERE Code=? ',
        [NoteControllers[CodeOfProduct.text]!.text, CodeOfProduct.text]);
    dataBase.rawUpdate('UPDATE Products SET Num=? WHERE Code=? ',
        [QuintteyControllers[CodeOfProduct.text]!.text, CodeOfProduct.text]);
    dataBase.rawUpdate('UPDATE Products SET TotalMoney=? WHERE Code=? ', [
      double.parse(QuintteyControllers[CodeOfProduct.text]!.text) * price!,
      CodeOfProduct.text
    ]);
    total = total - orders[Index!]["TotalMoney"];
    orders.removeAt(Index!);
    GetItem(contetx);
    emit(UpdateNumItem());
  }

  void getSearchItem(valuee) {
    getItemSProductsSearch(dataBase, valuee).then((value) {
      SearchProducts = [];
      SearchProducts = value;
      emit(GetSearchItem());
    });
  }

//firebase
  void uploadNewProduct() {
    print("this is upload $NewProducts");
    for (var element in NewProducts) {
      ProductsModule? product = ProductsModule(
        name: element["Name"],
        price: element["Price"],
        code: element["Code"],
        quantityInShop: element["QuantityInShop"],
        quantityInStore: element["QuantityInStore"],
        startDate: element["StartDate"],
        endDate: element["EndDate"],
      );
      Firestore.instance
          .collection("Users")
          .document(box.get("Token"))
          .collection("Shops")
          .document(box.get("shopName"))
          .collection("products")
          .document("${element["Code"]}")
          .set(product.toJson())
          .then((value) {
        NewProducts.remove(element);
        emit(InsertProductTr());
      }).catchError((onError) {
        emit(InsertProductFa(onError.toString()));
      });
    }
  }

  //employee Methods
  Future<List<Map>> getDataEmployee(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Employee');
  }

  Future<List<Map>> getDataEmployeeEspcially(dataBase, id) async {
    return await dataBase.rawQuery('SELECT*FROM Employee WHERE id=?', [id]);
  }

  void GetDataEmployee(dataBase) {
    getDataEmployee(dataBase).then((value) {
      employee = [];
      employee = value;
      emit(GetEmployeeSuccessfully());
    });
  }

  void getEmployeeDate(id) {
    getdateAttendEmployee(id).then((value) {
      DateEmployee = [];
      DateEmployee = value;
      print(DateEmployee);
      emit(InsertDateEmployeeError());
    });
  }

  Future insertIntoEmployee() async {
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Employee(Name,Salary,HireDate,AttendanceDate,LeavingDate)VALUES("${NameOfEmpolyees.text}","${SalaryOfEmpolyees.text}","${HireDateOfEmpolyees.text}","${AttendanceDateOfEmpolyees.text}","${LeavingDateOfEmpolyees.text}")')
          .then((value) {
        getDataEmployeeEspcially(dataBase, value).then((value) {
          NewEmployee.add(value.single);
        });
        GetDataEmployee(dataBase);
        NameOfEmpolyees.clear();
        SalaryOfEmpolyees.clear();
        HireDateOfEmpolyees.clear();
        emit(InsertEmployeeSuccessfully());
      }).catchError((error) {
        print(" the error is ${error.toString()}");
        emit(InsertEmployeeError());
      });
      return getName();
    });
  }

  Future insertIntoEmployeeAttendance({required id}) async {
    return dataBase.transaction((txn) {
      txn
          .rawInsert(
              //(
              'INSERT INTO EmployeeAttendance(id,AttendanceDate,LeavingDate,DataTimeDay)VALUES'
              '("$id","${AttendanceDate.text}","${LeavingDate.text}","${DateFormat.yMMMd().format(DateTime.now())}")')
          .then((value) {
        getdateAttendEmployee(id).then((value) {
          NewDateEmployee.add(value.last);
        });
        getEmployeeDate(id);
        emit(InsertDateEmployeeSuccessfully());
      }).catchError((error) {
        print(" the error is ${error.toString()}");
        emit(InsertDateEmployeeError());
      });
      return getName();
    });
  }

  Future<List<Map>> getdateAttendEmployee(id) async {
    return await dataBase
        .rawQuery('SELECT*FROM EmployeeAttendance WHERE id = ?', ["$id"]);
  }

  void DeleteEmployee(id) async {
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

  void ChangeValueOfEmployee(value) {
    valueEmpo = value;
    print("$valueEmpo");
    emit(ChangeEmpo());
  }

  void ChangeRateOfEmployee(value) {
    valueRate = value;
    print("$valueRate");
    emit(ChangeEmpo());
  }

  void insertNameOfEmployee(name) {
    nameOfEmpolyees = name;
    emit(ChangeEmpo());
  }

  //Fire base
  void uploadNewEmployee() {
    print("this is upload $NewEmployee");
    for (var element in NewEmployee) {
      EmployeeModule? Employee = EmployeeModule(
        name: element["Name"],
        id: element["id"],
        Salary: element["Salary"],
        HireDate: element["HireDate"],
        LeavingDate: element["LeavingDate"],
        AttendanceDate: element["AttendanceDate"],
      );
      Firestore.instance
          .collection("Users")
          .document(box.get("Token"))
          .collection("Shops")
          .document(box.get("shopName"))
          .collection("Employee")
          .document("${element["id"]}")
          .set(Employee.toJson())
          .then((value) {
        NewEmployee.remove(element);
        emit(InsertEmployeeTr());
      }).catchError((onError) {
        emit(InsertEmployeeFa(onError.toString()));
      });
    }
  }

  void uploadNewAttendedEmployee() {
    print("this is upload $NewDateEmployee");
    for (var element in NewDateEmployee) {
      EmployeeDateModule? employeeDateModule = EmployeeDateModule(
        id: element["id"],
        LeavingDate: element["LeavingDate"],
        AttendanceDate: element["AttendanceDate"],
        DataTimeDay: element["DataTimeDay"],
      );
      Firestore.instance
          .collection("Users")
          .document(box.get("Token"))
          .collection("Shops")
          .document(box.get("shopName"))
          .collection("Employee")
          .document("${element["id"]}")
          .collection("Attendance,Leaving Date")
          .document(element["DataTimeDay"])
          .set(employeeDateModule.toJson())
          .then((value) {
        NewDateEmployee.remove(element);
        emit(InsertDateEmployeeTr());
      }).catchError((onError) {
        emit(InsertDateEmployeeFa(onError.toString()));
      });
    }
  }

  void uploadRateEmployee(id) {
    Firestore.instance
        .collection("Users")
        .document(box.get("Token"))
        .collection("Shops")
        .document(box.get("shopName"))
        .collection("Employee")
        .document("${id}")
        .collection("Rate")
        .document(DateFormat.yMMMd().format(DateTime.now()))
        .set({"Rate": valueRate}).then((value) {
      emit(InsertDateEmployeeTr());
    }).catchError((onError) {
      emit(InsertDateEmployeeFa(onError.toString()));
    });
  }

  ///Suppliers Methods
  Future<List<Map>> getDataSuppliers(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Suppliers');
  }

  Future insertIntoSuppliers() async {
    TotalOfSupllayers = double.parse(CostOfInvoice.text);
    await dataBase.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Suppliers(Name,LastPaid,TotalSuppliers,LastDate)VALUES("${NameOfSupllayers.text}","${PaidOfInvoice.text}","$TotalOfSupllayers","${DateOfSupllayers.text}")')
          .then((value) {
        getDataSuppliersEspcially(dataBase, value).then((value) {
          NewSuppliers.add(value.single);
        });
        getSuppliersAfterChange();
        NameOfSupllayers.clear();
        CostOfInvoice.clear();
        PaidOfInvoice.clear();
        DateOfSupllayers.clear();
      }).catchError((error) {
        print(" the error is ${error.toString()}");
        emit(InsertProductError());
      });
      return getName();
    });
  }

  Future<List<Map>> getDataFees(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Fees');
  }

  Future insertIntoFees(id) async {
    payedMoney = payedMoney + double.parse(paidOfFees.text);
    box.put("payedMoney", payedMoney);
    totalMoney = AllMoneyGet - payedMoney;
    TotalOfSupllayers =
        Suppliers[id - 1]["TotalSuppliers"] - double.parse(paidOfFees.text);
    if (TotalOfSupllayers >= 0) {
      await dataBase.transaction((txn) {
        txn
            .rawInsert(
                'INSERT INTO Fees(Name,Paid,TotalSuppliers,LastDate)VALUES("${Suppliers[value - 1]["Name"]}","${paidOfFees.text}","$TotalOfSupllayers","${dateOfFees.text}")')
            .then((value) {
          getDataFessEspcially(dataBase, value).then((value) {
            NewFees.add(value.single);
            uploadNewFess(id: id);
          });
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
        return getName();
      });
    } else {
      isMoreThanTotalMoney = true;
      emit(InsertProductError());
    }
  }

  void getSuppliersAfterChange() {
    getDataSuppliers(dataBase).then((value) {
      Suppliers = [];
      Suppliers = value;
      print(Suppliers);
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
        Suppliers[id - 1]["TotalSuppliers"] + double.parse(paidOfFees.text);
    dataBase.rawUpdate('UPDATE Suppliers SET TotalSuppliers=? WHERE id=? ',
        [totalSuppliersAfterAdd, id]).then((value) {
      getDataSuppliersEspcially(dataBase, value).then((value) {
        NewSuppliers.add(value.single);
        uploadNewSuppliers();
      });
    });

    paidOfFees.clear();
    dateOfFees.clear();
    getSuppliersAfterChange();
    emit(UpdateProducts());
  }

  Future<List<Map>> getDataSuppliersEspcially(dataBase, id) async {
    return await dataBase.rawQuery('SELECT*FROM Suppliers WHERE id=?', [id]);
  }

  Future<List<Map>> getDataFessEspcially(dataBase, id) async {
    return await dataBase.rawQuery('SELECT*FROM Fees WHERE id=?', [id]);
  }

  //Fire base
  void uploadNewSuppliers() {
    log("this is upload $NewSuppliers");
    for (var element in NewSuppliers) {
      SuppliersModule? Suppliers = SuppliersModule(
        name: element["Name"],
        id: element["id"],
        TotalSuppliers: element["TotalSuppliers"],
        LastPaid: element["LastPaid"],
        feesDate: element["LastDate"],
      );
      Firestore.instance
          .collection("Users")
          .document(box.get("Token"))
          .collection("Shops")
          .document(box.get("shopName"))
          .collection("Suppliers")
          .document("${element["Name"]}")
          .set(Suppliers.toJson())
          .then((value) {
        NewSuppliers.remove(element);
        emit(InsertSuppliersTr());
      }).catchError((onError) {
        emit(InsertSuppliersFa(onError.toString()));
      });
    }
  }

  void updateNewSuppliers({FeesModule? feesModule, int? id}) {
    SuppliersModule? Suppliers = SuppliersModule(
      name: feesModule!.name,
      id: id,
      TotalSuppliers: feesModule.TotalSuppliers,
      LastPaid: feesModule.Paid,
      feesDate: feesModule.feesDate,
    );
    Firestore.instance
        .collection("Users")
        .document(box.get("Token"))
        .collection("Shops")
        .document(box.get("shopName"))
        .collection("Suppliers")
        .document("${feesModule.name}")
        .set(Suppliers.toJson())
        .then((value) {
      emit(InsertSuppliersTr());
    }).catchError((onError) {
      emit(InsertSuppliersFa(onError.toString()));
    });
  }

  void uploadNewFess({id}) {
    print("this is upload $NewFees");
    for (var element in NewFees) {
      FeesModule? Fess = FeesModule(
        name: element["Name"],
        id: element["id"],
        TotalSuppliers: element["TotalSuppliers"],
        Paid: element["Paid"],
        feesDate: element["LastDate"],
      );
      Firestore.instance
          .collection("Users")
          .document(box.get("Token"))
          .collection("Shops")
          .document(box.get("shopName"))
          .collection("Suppliers")
          .document("${element["Name"]}")
          .collection("Fees")
          .document(element["id"].toString())
          .set(Fess.toJson())
          .then((value) {
        updateNewSuppliers(feesModule: Fess, id: id);
        NewFees.remove(element);
        emit(InsertFeesTr());
      }).catchError((onError) {
        emit(InsertFeesFa(onError.toString()));
      });
    }
  }

  //Orders Methods
  Future<List<Map>> getOrders(value) async {
    return await dataBase
        .rawQuery('SELECT*FROM Orders WHERE NumberOrder = ?', ["$value"]);
  }

  Future<List<Map>> getAllOrders(dataBase) async {
    return await dataBase.rawQuery('SELECT*FROM Orders');
  }

  Future RecordOrder() async {
    box.put("NumberOrders", NumberOfOrder + 1);
    AllMoneyGet = AllMoneyGet + total;
    box.put("AllMoneyGet", AllMoneyGet);
    totalMoney = AllMoneyGet - payedMoney;
    box.put("totalMoney", totalMoney);
    for (var e in orders) {
      await dataBase.transaction((txn) {
        txn
            .rawInsert(
                'INSERT INTO Orders(Name,Code,Price,OrderDate,Num,TotalMoney,NumberOrder,AllMoney)VALUES("${e["Name"]}","${e["Code"]}","${e["Price"]}","${DateTime.now()}","${e["Num"]}","${e["TotalMoney"]}","$NumberOfOrder","$AllMoneyGet")')
            .then((value) {
          productsBox.put(
              "${e["Code"]}", (productsBox.get("${e["Code"]}") + e["Num"]));
          updateProductsARecord(
              Code: e["code"],
              Number: e["QuantityInStore"] - e["Num"],
              price: e["price"]);
          orders = [];
          total = 0.0;
          emit(RecordOrderSuccessfullyl());
        }).catchError((error) {
          print(" the error is ${error.toString()}");
          emit(RecordOrderError());
        });
        return getName();
      });
    }
    getOrders(NumberOfOrder).then((value) {
      MapOrders = [];
      MapOrders = value;
      uploadOrders();
    });
    NumberOfOrder = box.get("NumberOrders") ?? 1;
    emit(RecordOrderSuccessfullyl());
  }

  void deleteItemFOrders(context) {
    orders.removeAt(Index!);
    DChangeNumberItem = true;
    total = 0.0;
    for (int l = 0; l < orders.length; l++) {
      total = orders[l]["TotalMoney"] + total;
    }
    QuintteyControllers[CodeOfProduct.text]!.text="";
    NoteControllers[CodeOfProduct.text]!.text="";
    CodeOfProduct.clear();
    NameOfProduct.clear();
    emit(DeleteItemOrder());
  }

  void GetItem(context) {
    if
    (orders.every((element) => "${element["Code"]}" != CodeOfProduct.text)) {
      getItemProducts(dataBase, CodeOfProduct.text).then((value) {
        if (value.isNotEmpty) {
          if (Index == null) {
            orders.add(value.single);
            QuintteyControllers[value.single["Code"]] = TextEditingController();
            NoteControllers[value.single["Code"]] = TextEditingController();
            FocusControllers[value.single["Code"]] = FocusNode();
            total = value.single["TotalMoney"] + total;
            CodeOfProduct.clear();
            emit(InsertIntoOrder());
          } else if (Index != null) {
            orders.insert(Index!, value.single);
            total = value.single["TotalMoney"] + total;
            CodeOfProduct.clear();
            Index = null;
            emit(InsertIntoOrder());
          }
        } else {
          print("item not found");
          settingDialog(context, "Item Not Found");
          CodeOfProduct.clear();
          emit(ErrorInsertIOrder());
        }
      });
    }
    else {
      settingDialog(context, "Item Already Exist");
      CodeOfProduct.clear();
      emit(ErrorInsertIOrder());
    }
  }
  settingDialog(context,text,) {
    return showDialog(

        context: context,
        builder: (context) {
          return BlurryContainer(
            height: 800,
            width: 300,
            blur: 6,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.white60,
              elevation: 2,
              content: Text("$text",style: TextStyle(fontWeight: FontWeight.w900)),
              actions: [
                MaterialButton(
                  color: Colors.blueGrey[700],
                  onPressed: (){
                    Navigator.pop(context);
                  },child:const Text("Okay",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),),
                if(text=="Item Not Found")
                  MaterialButton(
                    color: Colors.blueGrey[700],
                    onPressed: (){
                   ChangePageIntoAddItem();
                      Navigator.pop(context);
                    },child:const Text("Add item",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),),

              ],
            ),
          );
        });
  }

  void getRecite(Text) {
    getOrders(Text).then((value) {
      recordedOrders = [];
      recordedOrders = value;
      calcTotalOfRecite();
      emit(GetRecites());
    });
  }

  void calcTotalOfRecite() {
    TotalOfRecite = 0.0;
    for (var element in recordedOrders) {
      TotalOfRecite = element["TotalMoney"] + TotalOfRecite;
    }
    emit(calcRiciet());
  }

  void storeMoneyValue() {
    payedMoney = box.get("payedMoney") ?? 0.0;
    totalMoney = box.get("totalMoney") ?? 0.0;
    AllMoneyGet = box.get("AllMoneyGet") ?? 0.0;
  }

//firebase
  void uploadOrders() {
    for (var e in MapOrders) {
      OrdersModule Order = OrdersModule(
          code: e["Code"],
          name: e["Name"],
          quantity: productsBox.get(e["Code"]));
      Firestore.instance
          .collection("Users")
          .document(box.get("Token"))
          .collection("Shops")
          .document(box.get("shopName"))
          .collection("Orders")
          .document("${e["Code"]}")
          .set(Order.toJson())
          .then((value) {
        MapOrders.remove(e);
        emit(InsertOrdersTr());
      }).catchError((onError) {
        emit(InsertOrdersFa(onError.toString()));
      });
    }
  }

// end shift methods
  void uploadMoney() {
    Firestore.instance
        .collection("Users")
        .document(box.get("Token"))
        .collection("Shops")
        .document(box.get("shopName"))
        .collection("Money")
        .document("${DateFormat.yMMMd().format(DateTime.now())}")
        .set(
      {
        "AllMoneyGet": AllMoneyGet,
        "payedMoney": payedMoney,
        "totalMoney": totalMoney,
        "Date": DateTime.now(),
      },
    ).then((value) {
      emit(InsertMoneyTr());
    }).catchError((onError) {
      emit(InsertMoneyFa(onError.toString()));
    });
  }

  void EndShift() {
    uploadNewProduct();
    uploadNewEmployee();
    uploadNewAttendedEmployee();
    uploadNewSuppliers();
    uploadMoney();
    box.put("NumberOrders", 0.0);
    box.put("AllMoneyGet", 0.0);
    box.put("totalMoney", 0.0);
    box.put("payedMoney", 0.0);
    storeMoneyValue();
    emit(endshitf());
  }

  //Firebase auth
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
      emit(SignInTr());
    }).catchError((onError) {
      Token = null;
      print(onError);
      emit(SignInFa(onError.toString()));
    });
  }

  void RessetPassword(context) {
    FirebaseAuth.instance.resetPassword(RestEmailController.text).whenComplete(
        () => Nevigator(bool: false, context: context, page: Login()));
  }

  void Logout() {
    Hive.box("Token").delete("Token");
    Hive.box("Token").delete("shopName");
    emit(SignOut());
  }
}
