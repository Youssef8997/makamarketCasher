
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


