
import 'package:flutter/material.dart';
import 'package:untitled6/spalsh%20Screen/SpalshScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
  title: "Maka Market Caasher",
      home:Spalsh()
    );
  }
}

