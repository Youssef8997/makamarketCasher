import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
const String projectId="dashboard-cashier";
const String projectApiKey="AIzaSyD9TjXbudtAzUMXfsXYM-PNk6KswEE2upE";
Future Nevigator({ page, context, bool=false}){
  return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> page),(Route route)=>bool);
}
Container Wallpaper(Size Size) {
  return   Container(
    width: Size.width,
    height: Size.height,
    decoration:const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
          colorFilter: ColorFilter.mode(
              Colors.grey, BlendMode.modulate),
          image: AssetImage(
            "Asset/waaass.jpg",
          ),
        )),
  );
}
Widget TitleOfContenar(value) => "$value".text.size(30).make().shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white);
