import 'package:flutter/material.dart';

Widget myButton({OnPreesed,required child,enabled=true}) {
  return  Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: AbsorbPointer(
      absorbing: !enabled,
      child: MaterialButton(
        onPressed:OnPreesed,
        child:child,
        color: Colors.grey.shade900,
      ),
    ),
  );

}