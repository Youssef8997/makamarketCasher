import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

class InputSupplayers extends StatelessWidget {
  const InputSupplayers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cuibt = CasherCuibt.get(context);
          var size = MediaQuery.of(context).size;
          return AddSup(size, cuibt);
        });
  }

  Widget AddSup(Size size, CasherCuibt cuibt) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Wallpaper(size),
          MyContainer(
              Height: size.height * .8,
              Width: size.width * .6,
              Child: AddSuplayyerContant(cuibt))
        ],
      ),
    );
  }

  Widget AddSuplayyerContant(CasherCuibt cuibt) {
    return Form(
      child: Column(
        children: [
          MyTextField(
              Controlr: cuibt.NameOfSupllayers,
              hint: "Pepsi Company",
            label: "Name of Sublayer",
            validator: (value){
              if(value!.isEmpty){
                return "Name must not be Empty";
              }
               return null;
            }
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: "AddInvoice".text.bold.italic.size(25.0).make().shimmer(
            duration: const Duration(seconds: 2),
            primaryColor: Colors.black,
            secondaryColor: Colors.white));
  }
}
