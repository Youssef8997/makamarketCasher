import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Compoandis/MyTextForm.dart';
class PayFees extends StatelessWidget {
  const PayFees({required this.NameOfSupllayers,required this.id});
final String NameOfSupllayers;
final int id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt,CasherState>
      (
        listener: (context,state){},
        builder:  (context,state){
          var size=MediaQuery.of(context).size;
          var cuibt=CasherCuibt.get(context);
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: _appBar(),
            body: Body(size,cuibt,context),
          );
        }
    );
  }
  AppBar _appBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: "Pay fees".text.bold.italic.size(25.0).make().shimmer(
            duration: const Duration(seconds: 2),
            primaryColor: Colors.black,
            secondaryColor: Colors.white));
  }

  Body(Size size,CasherCuibt cuibt,context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Wallpaper(size),
        MyContainer(
            Height: size.height * .8,
            Width: size.width * .6,
            Child: FeesContant(cuibt,context))

      ],
    );
  }

  FeesContant(CasherCuibt cuibt,context) {
    return Form(
      key: cuibt.feesKeyForm,
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
                  if (cuibt.feesKeyForm.currentState!.validate()) {
                    cuibt.insertIntoFees(id).then((value)
                    {
                      if(cuibt.isMoreThanTotalMoney) {
                        settingDialog(context, cuibt);
                      }else {
                        Navigator.pop(context);
                      }
                    });
                  }

                },
                child:const Text("Pay Fees", style:  TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
          )
        ],
      ),
    );
  }
  settingDialog(context,CasherCuibt cuibt) {
    var size=MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          return BlurryContainer(
            height: 100,
            width: 100,
            blur: 6,
            child: AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.white,
              elevation: 0,
              content:Center(

                  child:Text("You cant pay more than debit money ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),)

              ),
              actions: [
                MaterialButton(onPressed: (){Navigator.pop(context);cuibt.isMoreThanTotalMoney=false;},child: const Text("Okay"),)
              ],
            ),
          );
        });
  }

}
