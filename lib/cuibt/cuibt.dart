import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/models/AddItem.dart';
import 'package:untitled6/models/Admin.dart';
import 'package:untitled6/models/Casherpage.dart';
import 'package:untitled6/models/Empoloye.dart';
import 'package:untitled6/models/Items.dart';
import 'package:untitled6/models/Money.dart';
import 'package:untitled6/models/Supplayers.dart';

class CasherCuibt extends Cubit<CasherState>{
  CasherCuibt() : super(initState());
  static CasherCuibt get(context) => BlocProvider.of(context);
  int MyIndex=0;
  List<Widget>body=[
    CasherPage(),
    AddItem(),
    Items(),
    Supplayers(),
    Empoloye(),
    Money(),
    Admin(),
  ];
  void ChangeMyIndex(value){
    MyIndex=value;
    emit(ChangeIndex());
  }
}