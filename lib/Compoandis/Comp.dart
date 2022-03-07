import 'package:flutter/material.dart';

Future Nevigator({ page, context, bool=false}){
  return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> page),(Route route)=>bool);
}
Container Wallpaper(Size Size) {
  return Container(
    width: Size.width,
    height: Size.height,
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
          colorFilter: ColorFilter.mode(
              Colors.  black87, BlendMode.modulate),
          image:NetworkImage(
            "https://i.pinimg.com/736x/d1/fc/2e/d1fc2e90f30c4f353cb7f588a1854bc0.jpg",
          ),
        )),
  );
}