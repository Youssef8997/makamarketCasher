import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

class InputSupplayers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cuibt = CasherCuibt.get(context);
          var size = MediaQuery.of(context).size;
          return AddSup(size, cuibt,context);
        });
  }

  Widget AddSup(Size size, CasherCuibt cuibt,context) {
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
              Child: AddSuplayyerContant(cuibt,context))
        ],
      ),
    );
  }

  Widget AddSuplayyerContant(CasherCuibt cuibt,context) {
    return Form(
      key: cuibt.SublayersKeyForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20,),
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
          ),
            MyTextField(
              Controlr: cuibt.CostOfInvoice,
              hint: "650 LE",
            label:"Total money",
            validator: (value){
              if(value!.isEmpty){
                return "Cost must not be Empty";
              }
               return null;
            }
          ),
          MyTextField(
              Controlr: cuibt.PaidOfInvoice,
              hint: "400 LE",
            label:"Last fees",
            validator: (value){
              if(value!.isEmpty){
                return "Paid must not be Empty";
              }
               return null;
            }
          ),
          MyTextField(
              Controlr: cuibt.DateOfSupllayers,
              hint: "3/10/2022",
            label: "First date ",
            validator: (value){
              if(value!.isEmpty){
                return "First date must not be Empty";
              }
               return null;
            }
          ),
          Center(
            child: Container(

              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (cuibt.SublayersKeyForm.currentState!.validate()) {
                    cuibt.insertIntoSupplayers().then((value) => Navigator.pop(context));
                  }

                },
                child:const Text("Add Suppliers", style:  TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
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
        title: "Add Suppliers".text.bold.italic.size(25.0).make().shimmer(
            duration: const Duration(seconds: 2),
            primaryColor: Colors.black,
            secondaryColor: Colors.white));
  }
}
