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
      Child: EmpoloyeContent(cuibt, context),
    );
  }

  Column EmpoloyeContent(CasherCuibt cuibt, context) {
    var Size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: TitleOfContenar("Employee")),
        ListTiled(),
        if(cuibt.ShowDateEmpolye)
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
                  onChanged: (Object? value) =>
                      {cuibt.ChangeValueOFEmpo(value)},
                  value: cuibt.valueEmpo,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 30,
            ),
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
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
}
