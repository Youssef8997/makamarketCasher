
import 'dart:io';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/spalsh%20Screen/SpalshScreen.dart';
import 'package:firedart/firedart.dart';

import 'Compoandis/Comp.dart';
void main() async{
  late var tokenStore = VolatileStore();
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize(projectId);
  FirebaseAuth.initialize(webApiKey, tokenStore);
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  var path = Directory.current.path;
  Hive.init(path);
  await Hive.openBox("Token");
  await Hive.openBox("Money");
  await Hive.openBox("products");

runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      disconnectedContent: const Text("you don't have connection"),
      child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (BuildContext context) => CasherCuibt()..createDataBase()..storeMoneyValue())
            ],
            child:MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "Maka Market Caasher",
                home:Spalsh()
            )),
    );
  }
  }


// reviews selles and buys
// review the store and products
//give nitfocithion when some one get somesthing from store
//*********************** product is almost finished,from the shop or store
// review about suppliers
//review about users
//HOW many of selles and what is important products and what he do with the cashier
// review about empo
