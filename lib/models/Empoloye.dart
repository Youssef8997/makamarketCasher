import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/Compoandis/button.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Compoandis/MyContenar.dart';

class Empoloye extends StatefulWidget {
  @override
  State<Empoloye> createState() => _EmpoloyeState();
}

class _EmpoloyeState extends State<Empoloye> {
  int ListTileSelect = 1;
  var AttdintgtimeControlar = TextEditingController();
  var LeavetimeControlar = TextEditingController();
  var value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AttdintgtimeControlar.text=DateFormat.jm().format(DateTime.now());
    LeavetimeControlar.text=DateFormat.jm().format(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          return Center(
           child:EmpoloyeContainer(size),
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

  EmpoloyeContainer(Size Size) {
    return MyContainer(

      Height: Size.height * 0.8,
     Width: Size.width * 0.6,

     Child: EmpoloyeContent(),
    );
  }

  Column EmpoloyeContent() {
    var Size=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: TitleOfContenar("Employee")),
        ListTiled(),
        if (ListTileSelect == 1)
          Column(
            children: [
            const SizedBox(height: 20,),
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                height: 50,
                width: Size.width*.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(color: Colors.black,
                        width: 2
                    )
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items:const [
                      DropdownMenuItem(child: Text("dffddf"),value: "ddd",)
                    ],onChanged: (Object? value)=>{},value: value,),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  Controlr: AttdintgtimeControlar,
                  hint: AttdintgtimeControlar.text,
                  label: "Time of Attending",
                  Prefix: const Icon(Icons.watch_later)),
              const SizedBox(
                height: 30,
              ),
              MyTextField(
                  Controlr: LeavetimeControlar,
                  hint: LeavetimeControlar.text,
                  label: "Time of Attending",
                  Prefix: const Icon(Icons.watch_later)),

            ],
          )
        else
          Column(),
Spacer(),
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [
            myButton(child:const  Text("Add employee",style: TextStyle(color: Colors.white)),OnPreesed:{},),
            myButton(child:const  Text("Remove employee",style: TextStyle(color: Colors.white)),OnPreesed:{},),
           myButton(child:const Text("Edit Information",style: TextStyle(color: Colors.white)),OnPreesed:{},),
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
            ListTile(
              selected: ListTileSelect == 1 ? false : true,
              selectedColor: Colors.amber,
              style: ListTileStyle.list,
              title: const Text(
                "Rating",
              ),
              leading: const Icon(
                Icons.star,
              ),
              onTap: () {
                setState(() {
                  if (ListTileSelect == 1) ListTileSelect = 2;
                });
              },
            ),
          ],
        ));
  }
  Widget TitleOfContenar(value) => "$value".text.size(25).make().shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white);

}
