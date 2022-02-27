import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled6/Compoandis/Comp.dart';

import '../Login/Login.dart';

class Spalsh extends StatefulWidget {
  @override
  State<Spalsh> createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh>with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
      child: Center(
         child: Lottie.asset(
              'Asset/LottieAnimation.json',
           controller: _controller,
           onLoaded: (composition) {
             _controller
               ..duration = composition.duration
               ..forward().then((value) => Nevigator(context: context,page: Login(),bool: false));

           },

         ),

      ),
    );
  }
}
