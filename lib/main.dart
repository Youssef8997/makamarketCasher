
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/spalsh%20Screen/SpalshScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      return MultiBlocProvider(
          providers: [
            BlocProvider(create: (BuildContext context) => CasherCuibt())
          ],
          child:MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Maka Market Caasher",
              home:Spalsh()
          ));
  }
  }


