import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cuibt/cuibt.dart';

import '../cuibt/State.dart';

class CasherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size=MediaQuery.of(context).size;
          return Column(
              children: [
          NumberOfOrder(),
           Align(
             alignment: AlignmentDirectional.center,
             child: Container(
               color: Colors.grey[300],
               height: size.height*.8,
               width: size.width*.9,
               child: Ta,

             ),
           )

          ]);
        });
  }

  Align NumberOfOrder() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(20)
            ),
alignment: AlignmentDirectional.center,
child: SelectableText("1000",style: TextStyle(fontWeight: FontWeight.bold),)
        ),
      ),
    );
  }
}
