import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';

import '../../Compoandis/MyTextForm.dart';

class SignUpEmpo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>
      (
      listener: (context, state) {},
      builder: (context, state) {
        var size=MediaQuery.of(context).size;
        var cuibt=CasherCuibt.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: const Text('Sign Up Empo',style: TextStyle( fontWeight: FontWeight.w900),)),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Wallpaper(size),
              MyContainer(Height: size.height*.8, Width:size.width*.7,
              Child: AddEmpoContant(cuibt,context)
              )
            ],
          ),
        );
      },

    );
  }
  Widget AddEmpoContant(CasherCuibt cuibt,context) {
    return Form(
      key: cuibt.AddEmpoKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20,),
          MyTextField(
              Controlr: cuibt.NameOfEmpolyees,
              hint: "Mohamed Khaled",
              label: "Name Of employee",
              validator: (value){
                if(value!.isEmpty){
                  return "Name must not be Empty";
                }
                return null;
              }
          ),
          MyTextField(
              Controlr: cuibt.SalaryOfEmpolyees,
              hint: "2500 LE",
              label:"Salary Of employee",
              validator: (value){
                if(value!.isEmpty){
                  return "Salary must not be Empty";
                }
                return null;
              }
          ),
          MyTextField(
              OnTap: (){
                showDatePicker(
                  confirmText: "Confirm",
                  initialDatePickerMode: DatePickerMode.year,
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate:DateTime.parse('2015-01-01'),
                  lastDate:DateTime.now(),
                ).then((value) {
                  value ??= DateTime.now();
                  cuibt.HireDateOfEmpolyees.text =DateFormat.yMMMd().format(value);

                });
              },
              Controlr: cuibt.HireDateOfEmpolyees,
              hint: "30/1/2020",
              label:"Hire date of employee",
              validator: (value){
                if(value!.isEmpty){
                  return "Paid must not be Empty";
                }
                return null;
              }
          ),
          MyTextField(
              OnTap: () {
                showTimePicker(
                  confirmText: "Confirm",
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  cuibt.AttendanceDateOfEmpolyees.text = value!.format(context);
                });
              },
              Controlr: cuibt.AttendanceDateOfEmpolyees,
              hint: cuibt.AttendanceDateOfEmpolyees.text,
              label: "Time of Attending",
              Prefix: const Icon(Icons.watch_later)),
          MyTextField(
              OnTap: () {
                showTimePicker(
                  confirmText: "Confirm",
                  context: context,
                  initialTime: TimeOfDay.now(),
                ).then((value) {
                  cuibt.LeavingDateOfEmpolyees.text = value!.format(context);
                });
              },
              Controlr: cuibt.LeavingDateOfEmpolyees,
              hint: cuibt.LeavingDateOfEmpolyees.text,
              label: "Time of Leaving",
              Prefix: const Icon(Icons.watch_later)),

          Center(
            child: Container(

              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: MaterialButton(
                onPressed: () {
                  if (cuibt.AddEmpoKey.currentState!.validate()) {
                    cuibt.insertIntoEmployee().then((value) => Navigator.pop(context));
                  }

                },
                child:const Text("Add employee", style:  TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
          )
        ],
      ),
    );
  }

}
