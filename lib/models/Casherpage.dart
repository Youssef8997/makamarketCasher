import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cuibt/cuibt.dart';

import '../cuibt/State.dart';
class CasherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt,CasherState>
      (listener: (context,state){},
        builder: (context,state){
          return Container();
        }
    );
  }
}
