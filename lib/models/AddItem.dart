import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:velocity_x/velocity_x.dart';

import '../cuibt/cuibt.dart';

class AddItem extends StatelessWidget {

  var scrolllabel=ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery
              .of(context)
              .size;
          var cuibt = CasherCuibt.get(context);
          return Stack(

            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    MyName(context),
                    SizedBox(height: 30,),
                  if(!cuibt.Search)
                  MakaMarketName()
                  ],
                ),
              ),
              SizedBox(height: 20,),
              SearchButton(cuibt),
               Padding(
                   padding: const EdgeInsetsDirectional.only(end: 15),
                   child: Align(child: SearchCountenar(context,size),alignment: Alignment.centerRight,)),
              //Add Item Container
              AnimatedAlign(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,

                alignment: cuibt.Search ? Alignment.centerLeft : Alignment
                    .center,
                child: MyContainer(
                  Height: size.height * .75,
                  Width: size.width * .5,
                  Child: AddItemCoulmn(context),
                ),
              )
            ],
          );
        });
  }

  Positioned SearchButton(CasherCuibt cuibt) {
    return Positioned(
              top: 40,
              right: 30,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: MaterialButton(
                  onPressed: () {
                    cuibt.AddItemChangeSearch();
                  },
                  child: Column(

                    children: [
                      Row(
                        children:  [
                          Icon(cuibt.Search?Icons.clear:Icons.search, color: Colors.black),
                          const SizedBox(width: 5),
                          cuibt.Search?const Text(
                              "Close", style: TextStyle(color: Colors.grey)):const Text(
                              "Search", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  color: Colors.grey.shade200,
                ),
              ),
            );
  }
  AddItemCoulmn(context) {
    var cuibt=CasherCuibt.get(context);
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.all(20),
      child: Form(
      key:cuibt.kayform ,
        child:  Column(
          children: [
            TitleOfContenar("Add Item"),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
                Controlr: cuibt.NameOfItem, label: "Name of item", hint: "Name",validator: (value) {
              if (value!.isEmpty) {
                return " Name must not be empty";
              }
              return null;
            }),
            const SizedBox(
              height: 20,
            ),
            MyTextField(Controlr: cuibt.CodeOfItem,
                label: "Code Of Item",
                hint: "003************",
            validator: (value) {
              if (value!.isEmpty) {
                return "      Code must not be empty";
              }
              return null;
            }
            ),
            const  SizedBox(
              height: 20,
            ),
            MyTextField(
                Controlr: cuibt.PriceOfItem, label: "Price Of Item", hint: "15.5",validator: (value) {
              if (value!.isEmpty) {
                return "     Price must not be empty";
              }
              return null;
            }),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                Controlr: cuibt.NumberOfItem, label: "Number Of Item", hint: "20",validator: (value) {
              if (value!.isEmpty) {
                return "      Number must not be empty";
              }
              return null;
            }),
            SizedBox(
              height: 20,
            ),
            MyTextField(
                Controlr:cuibt. FirstDate,
                label: "data Of firstdata",
                hint: "3-10-2022",
              validator: (value) {
                if (value!.isEmpty) {
                  return "      data Of firstdata must not be empty";
                }
                return null;
              }
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                Controlr:cuibt.EndDate, label: "EndDate", hint: "3-10-2023",validator:(value) {
              if (value!.isEmpty) {
                return "      data Of EndDate must not be empty";
              }
              return null;
            } ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (cuibt.kayform.currentState!.validate()){
                        cuibt.insert();
                      }
                    },
                    child: Text("Insert", style: TextStyle(color: Colors.white)),
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(width: 20,),
                Visibility(
                  visible:cuibt.Search ,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child:const  Text("Edit", style: TextStyle(color: Colors.white)),
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Visibility(
                  visible:cuibt.Search ,
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child:const  Text("Delete", style: TextStyle(color: Colors.white)),
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget TitleOfContenar(value) => "$value".text.size(25).make().shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white);
  Widget MyName(BuildContext context) {
    return Column(
      children: [
        "Designed By:Youssef Ahmed"
            .text
            .bold
            .italic
            .size(25)
            .make()
            .shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white)
            .h10(context),
      ],
    );
  }
  Text MakaMarketName() {
    return const Text(
      "Maka Market",
      style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.black, blurRadius:1, offset: Offset(0, 3))
          ]),
    );
  }
  SearchCountenar(context,size) {
    var cuibt = CasherCuibt.get(context);
    return AnimatedOpacity(opacity: cuibt.Search ? 1 : 0,
      duration: Duration(milliseconds: 600),
      child:AbsorbPointer(
        absorbing:!cuibt.Search,
        child: MyContainer(
          Height: size.height * .75,
         Width: size.width * .4,
         Child: Scrollbar(
           controller: scrolllabel,
            isAlwaysShown: true,

            child: ListView(
              physics: BouncingScrollPhysics(),

              controller:scrolllabel ,
              children: [
                Center(child: TitleOfContenar("Search of Item")),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                    Controlr: cuibt.NameOfSearch,
                    label: "Name",
                    hint: "",
                  onChanged: (value){
                    cuibt.cahnge();
                  }

                ),
                SizedBox(height: 15,),
                MyTextField(
                    Controlr: cuibt.CodeOfSearch,
                    label: "Code Of Item",
                    hint: "0300**************",
                    onChanged: (value){
                      cuibt.cahnge();
                    }
                ),
                SizedBox(height: 30,),
                CasherTable(context)

              ],
            ),
          ),
        ),
      )
      ,);
  }
  CasherTable(context) {
    var cuibt=CasherCuibt.get(context);
    return DataTable(

        dataTextStyle:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
        columnSpacing: 60,
        horizontalMargin: 10,
        border: TableBorder.all(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
            width: 2),
        columns: const [
          DataColumn(
            label: Text("Code"),
          ),
          DataColumn(
            label: Text("Name"),
          ),
          DataColumn(
            label: Text("Price"),
          ),
          DataColumn(
            label: Text("Number"),
          ),
          DataColumn(
            label: Text("EndDate"),
          ),
        ],
        rows: cuibt.Products.map((e){
          if("${e["Name"]}"==cuibt.NameOfSearch.text||e["Code"]==cuibt.CodeOfSearch.text) {
            print("${e["Name"]}".matchAsPrefix(cuibt.NameOfSearch.text)?.groupCount.toString());
            return DataRow(cells: [
            DataCell(Text("${e["Code"]}")),
            DataCell(Text("${e["Name"]}")),
            DataCell(Text("${e["Price"]}")),
            DataCell(Text("${e["Number"]}")),
            DataCell(Text("${e["EndDate"]}")),
          ]);
          } else {
            return const DataRow(cells: [
              DataCell(Text("")),
              DataCell(Text("")),
              DataCell(Text("")),
              DataCell(Text("")),
              DataCell(Text("")),
            ]);
          }
        } ).toList()


        );
  }
}
