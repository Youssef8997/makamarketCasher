import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/Compoandis/button.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/models/Empoloyee/Sign%20up%20Empo.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Compoandis/MyContenar.dart';

class Empoloye extends StatefulWidget {
  @override
  State<Empoloye> createState() => _EmpoloyeState();
}

class _EmpoloyeState extends State<Empoloye> {
  int ListTileSelect = 1;
double Sallry=0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var cuibt = CasherCuibt.get(context);
          return Center(
            child: EmpoloyeContainer(size, cuibt, context),
          );
        });
  }

  SizedBox LoginWallpapper(Size Size) {
    return SizedBox(
      width: Size.width,
      height: Size.height,
      child: Image.asset(
        "Asset/LoginWallpapers.jpg",
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }

  EmpoloyeContainer(Size Size, CasherCuibt cuibt, context) {
    return MyContainer(
      Height: Size.height * 0.8,
      Width: Size.width * 0.6,
      Child: EmpoloyeContent(cuibt, context,Size),
    );
  }

  Column EmpoloyeContent(CasherCuibt cuibt, context,Size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: TitleOfContenar("Employee")),
        ListTiled(),
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 50,
              width: Size.width * .7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.black, width: 2)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  items: cuibt.employee.map((e) {
                    return DropdownMenuItem<String>(
                      value: e["id"].toString(),
                      child: Text("  ${e["Name"]}"),
                    );
                  }).toList(),
                  onChanged: (Object? value)
                      {
                        cuibt.ChangeValueOFEmpo(value);
                        cuibt.getDataEmployeeEspcially(cuibt.dataBase, value).then((value){
                          Sallry=value.single["Sallry"];
                        });
                      },
                  value: cuibt.valueEmpo,

                ),
              ),
            ),
            if(cuibt.ShowDateEmpolye)
              const SizedBox(
              height: 30,
            ),
            if(cuibt.ShowDateEmpolye)
              MyTextField(
                OnTap: () {
                  showTimePicker(
                    confirmText: "Confirm",
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    cuibt.AttendanceDate.text = value!.format(context);
                  });
                },
                Controlr: cuibt.AttendanceDate,
                hint: cuibt.AttendanceDate.text,
                label: "Time of Attending",
                Prefix: const Icon(Icons.watch_later)),
            if(cuibt.ShowDateEmpolye)
              const SizedBox(
              height: 30,
            ),
            if(cuibt.ShowDateEmpolye)
              MyTextField(
                OnTap: () {
                  showTimePicker(
                    confirmText: "Confirm",
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    cuibt.LeavingDate.text = value!.format(context);
                  });
                },
                Controlr: cuibt.LeavingDate,
                hint: cuibt.LeavingDate.text,
                label: "Time of Attending",
                Prefix: const Icon(Icons.watch_later)),
          ],
        ),
        if(!cuibt.ShowDateEmpolye)
          Expanded(
            child: ListView.separated(
              itemBuilder: (context,index)=>AttendanceContainer(Size,cuibt.DateEmployee[index]),
              separatorBuilder:(context,index)=>const  SizedBox(height: 10,),
              itemCount:cuibt.DateEmployee.length,
            ),
          ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            myButton(
              child: const Text("Record Attendance",
                  style: TextStyle(color: Colors.white)),
              OnPreesed: () {cuibt.insertIntoEmployeeAttendance(id:cuibt.valueEmpo, salary:Sallry);},
            ),
            myButton(
              child:
                  Text("Add employee", style: TextStyle(color: Colors.white)),
              OnPreesed: () {
                Nevigator(bool: true, page: SignUpEmpo(), context: context);
              },
            ),
            myButton(
              child: const Text("Remove employee",
                  style: TextStyle(color: Colors.white)),
              OnPreesed: () {},
            ),
            myButton(
              child: const Text("Edit Information",
                  style: TextStyle(color: Colors.white)),
              OnPreesed: () {},
            ),
            myButton(
              child: const Text("Show last date",
                  style: TextStyle(color: Colors.white)),
              OnPreesed: () {
                print(cuibt.valueEmpo);
                cuibt.getEmployeeDate(cuibt.valueEmpo,DateTime.now());

                setState(() {
                  cuibt.ShowDateEmpolye = !cuibt.ShowDateEmpolye;
                });
              },
            ),
          ],
        )
      ],
    );
  }

  ListTileTheme ListTiled() {
    return ListTileTheme(
        style: ListTileStyle.list,
        textColor: Colors.white,
        iconColor: Colors.grey,
        child: Column(
          children: [
            ListTile(
              selected: ListTileSelect == 1 ? true : false,
              selectedColor: Colors.teal,
              style: ListTileStyle.list,
              title: const Text(
                "Time", /*style: TextStyle(color: Colors.white*/
              ),
              leading: const Icon(
                Icons.watch_later, /*color: Colors.blueGrey*/
              ),
              onTap: () {
                setState(() {
                  if (ListTileSelect == 2) ListTileSelect = 1;
                });
              },
            ),
          ],
        ));
  }

  Widget TitleOfContenar(value) => "$value".text.size(25).make().shimmer(
      duration: const Duration(seconds: 2),
      primaryColor: Colors.black,
      secondaryColor: Colors.white);
  AttendanceContainer(Size size,e) {
    return Row(
      children: [
        RotatedBox(
            quarterTurns: 1,
            child: Text(
              "${e["DataTimeDay"]}",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Container(
          padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
          height: 60,
          width: size.width * 0.56,
          decoration: BoxDecoration(
              color:Colors.grey[500],
              borderRadius: BorderRadiusDirectional.circular(50.0),
              border: Border.all(
                color: Colors.grey,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 5),
                  color: Colors.grey[800]!,
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ]),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Attendance time: ${e["AttendanceDate"]}",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
             const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "Leaving time: ${e["LeavingDate"]}",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
             
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

}
