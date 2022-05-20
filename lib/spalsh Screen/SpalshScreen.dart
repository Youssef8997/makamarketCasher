import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/HomeLayout/HomeLayout.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import '../Login/Login.dart';
class Spalsh extends StatefulWidget {
  @override
  State<Spalsh> createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh>with TickerProviderStateMixin {
  late final AnimationController _controller;
  late Widget Screen ;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    if(CasherCuibt.get(context).box.get("Token")==null){
      Screen=Login();}
    else{
      Screen=HomeScreen();
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ConnectionNotifierToggler(
        connected:Center(
          child: Lottie.asset(
            'Asset/LottieAnimation.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller
                ..duration = composition.duration
                ..forward().then((value) => Nevigator(context: context,page: Screen,bool: false));

            },

          ),

        ),
          disconnected: Center(
      child: Lottie.asset(
          'Asset/LottieAnimation.json',
          controller: _controller,
          onLoaded: (composition) {
    _controller
    ..duration = composition.duration
    ..forward().then((value) => Nevigator(context: context,page: HomeScreen(),bool: false));

    },

    ),

    ),
      )
    );
  }
}
/*
*/
