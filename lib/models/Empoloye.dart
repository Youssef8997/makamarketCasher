import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

class Empoloye extends StatefulWidget {
  @override
  State<Empoloye> createState() => _EmpoloyeState();
}

class _EmpoloyeState extends State<Empoloye> {
  int ListTileSelect = 1;
  var timeControlar = TextEditingController(text:DateFormat.jm().toString());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeControlar.text=DateFormat.jm().format(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          return Stack(
            alignment: Alignment.center,
            children: [LoginWallpapper(size), EmpoloyeContenar(size)],
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

  EmpoloyeContenar(Size Size) {
    return Container(
      padding: EdgeInsetsDirectional.all(20),
      height: Size.height * 0.8,
      width: Size.width * 0.6,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.8),
          borderRadius: BorderRadiusDirectional.circular(30.0),
          border: Border.all(color: Colors.grey.shade700, width: 5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: TitleOfContenar("Employee")),
          ListTiled(),
          if (ListTileSelect == 1)
            Column(
              children: [

                MyTextField(

                    Controlr: timeControlar,
                    hint: "${timeControlar.text}",
                    label: "Time of Attending",

                    Prefix: const Icon(Icons.watch_later))

              ],
            )
          else
            Column()
        ],
      ),
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
              title: Text(
                "Time", /*style: TextStyle(color: Colors.white*/
              ),
              leading: Icon(
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
              title: Text(
                "Rating",
              ),
              leading: Icon(
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

  Widget TitleOfContenar(value) =>
      "$value".text.center.size(25).make().shimmer();
}
