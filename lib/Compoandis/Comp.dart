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
              Colors.  black54, BlendMode.darken),
          image:AssetImage(
            "Asset/LoginWallpapers.jpg",
          ),
        )),
  );
}