import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cuibt/State.dart';

import '../cuibt/cuibt.dart';

class AddItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AddItemWallpepers(size),
              Container(

                height: size.height*.75,
                width: size.width*.5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600.withOpacity(.8),
                  borderRadius: BorderRadius.circular(25)

                ),

              )
            ],
          );
        });
  }

  SizedBox AddItemWallpepers(Size size) {
    return SizedBox(
              height: size.height,
              width: size.width,
              child: Image.network(
                "https://i.pinimg.com/736x/5f/86/91/5f86919c8539bde2d297ed7db5a4151c.jpg",
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.multiply,
                filterQuality: FilterQuality.high,
              ),
            );
  }
}
