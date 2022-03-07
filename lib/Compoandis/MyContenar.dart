import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
Widget MyContenar({required Height,required Width,Widget? Child}){
  return AnimatedContainer(
    padding: const EdgeInsetsDirectional.all(10),
    duration:  const Duration(milliseconds: 700),
    curve: Curves.fastLinearToSlowEaseIn,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
        color: Colors.white70,

        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color:Colors.white,
          width: 4,
        )),
    height:Height,
    width:Width,
    child: Child,
  );
}