import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Compoandis/MyTextForm.dart';

class AddMoney extends StatelessWidget {
  final String NameOfSupllayers;
final int id;
  const AddMoney({required this.NameOfSupllayers,required this.id}) ;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<CasherCuibt,CasherState>
      (
        listener: (context,state){},
      builder: (context,state)
      {
        var Size = MediaQuery.of(context).size;
        var cuibt=CasherCuibt.get(context);
       return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _appBar(),
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Wallpaper(Size),
              MyContainer(
                  Height: Size.height * .8,
                  Width: Size.width * .6,
                  Child: addMoneyContact(cuibt,context))
            ],
          ),
        );
      },
        );
  }

  AppBar _appBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: "Add money".text.bold.italic.size(25.0).make().shimmer(
            duration: const Duration(seconds: 2),
            primaryColor: Colors.black,
            secondaryColor: Colors.white));
  }

  addMoneyContact(cuibt,context) {
    return Form (
      key: cuibt.increesKeyForm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20,),
          Container(
            alignment: AlignmentDirectional.center,
            height: 50,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(NameOfSupllayers,style: const TextStyle(color: Colors.black,fontSize: 19,fontWeight: FontWeight.bold)),
          ),
          MyTextField(
              Controlr: cuibt.paidOfFees,
              hint: "400 LE",
              label:"fees",
              validator: (value){
                if(value!.isEmpty){
                  return "Paid must not be Empty";
                }
                return null;
              }
          ),
          MyTextField(
              Controlr: cuibt.dateOfFees,
              hint: "3/10/2022",
              label: "Date of fees ",
              validator: (value){
                if(value!.isEmpty){
                  return "date must not be Empty";
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
                  if (cuibt.increesKeyForm.currentState!.validate()) {
                    cuibt.updateSuppliersAfterAdd(id);
                    Navigator.pop(context);

                    }

                },
                child:const Text("Increase money", style:  TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
          )
        ],
      ),
    );
  }
}
