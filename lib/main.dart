
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/spalsh%20Screen/SpalshScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  // Change the default factory
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => CasherCuibt()..Crdatab())
          ],
          child:MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Maka Market Caasher",
              home:Spalsh()
          ));
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
