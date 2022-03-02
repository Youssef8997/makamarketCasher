import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget MyTextField({required Controlr,required String hint,label,Prefix,suffix,keybordtype,isobsr=false,validator,OnEditng}) {
  return Container(
    height: 50,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: TextFormField(
      onFieldSubmitted: OnEditng,
       autovalidateMode: AutovalidateMode.always,
      style: TextStyle(color: Colors.white),
      controller: Controlr,
      keyboardType: keybordtype,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.fromSTEB(20, 0, 0,0),
          hintText: hint,
          hintStyle:TextStyle(color: Colors.grey),
label: Text("$label"),

          labelStyle: TextStyle(color: Colors.white),
          prefixIcon: Prefix,
          suffixIcon: suffix,
          border: InputBorder.none
      ),
      obscureText: isobsr,
      validator: validator,

    ),
  );
}
