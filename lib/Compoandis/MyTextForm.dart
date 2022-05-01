import 'package:flutter/material.dart';

Widget MyTextField({required Controlr,required String hint,label,Prefix,suffix,keybordtype,isobsr=false,validator,OnTap,enabled,onChanged,Focusnode}) {
  return TextFormField(
    obscuringCharacter: "*",
    focusNode: Focusnode,
    enabled: enabled,
    onTap: OnTap,
onChanged: onChanged,
    style: const TextStyle(color: Colors.black),
    controller: Controlr,
    keyboardType: keybordtype,
    decoration: InputDecoration(
      contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0,0),
        hintText: hint,
        hintStyle:const TextStyle(color: Colors.black),
label: label!=null?Text("$label"):null,

        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: Prefix,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.black,),
        ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.red,),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.black,),
      ),
       focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.black,),)
    ),
    obscureText: isobsr,
    validator: validator,

  );
}
