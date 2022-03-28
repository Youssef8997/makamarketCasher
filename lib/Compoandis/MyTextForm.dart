import 'package:flutter/material.dart';

Widget MyTextField({required Controlr,required String hint,label,Prefix,suffix,keybordtype,isobsr=false,validator,OnTap,enabled,onChanged,Focusnode}) {
  return Container(
    height: 50,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: TextFormField(
      focusNode: Focusnode,
      enabled: enabled,
      onTap: OnTap,
onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      controller: Controlr,
      keyboardType: keybordtype,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.fromSTEB(20, 0, 0,0),
          hintText: hint,
          hintStyle:TextStyle(color: Colors.black),
label: label!=null?Text("$label"):null,

          labelStyle: TextStyle(color: Colors.black),
          prefixIcon: Prefix,
          suffixIcon: suffix,
          border: InputBorder.none
      ),
      obscureText: isobsr,
      validator: validator,

    ),
  );
}
