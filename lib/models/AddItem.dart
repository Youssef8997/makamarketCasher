import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:velocity_x/velocity_x.dart';

import '../cuibt/cuibt.dart';

class AddItem extends StatelessWidget {
  var NameOfItem = TextEditingController();
  var CodeOfItem = TextEditingController();
  var PriceOfItem = TextEditingController();
  var NumberOfItem = TextEditingController();
  var SupplayerOfItem = TextEditingController();
  var winOfItem = TextEditingController();
  var NameOfSearch = TextEditingController();
  var CodeOfSearch = TextEditingController();
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
      child: Column(
        children: [
          TitleOfContenar("Add Item"),

          SizedBox(
            height: 5,
          ),
          MyTextField(
              Controlr: NameOfItem, label: "Name of item", hint: "Name"),
          SizedBox(
            height: 20,
          ),
          MyTextField(Controlr: CodeOfItem,
              label: "Code Of Item",
              hint: "003************"),
          SizedBox(
            height: 20,
          ),
          MyTextField(
              Controlr: PriceOfItem, label: "Price Of Item", hint: "15.5"),
          SizedBox(
            height: 20,
          ),
          MyTextField(
              Controlr: winOfItem, label: "net profit", hint: "win Of Item"),
          SizedBox(
            height: 20,
          ),
          MyTextField(
              Controlr: NumberOfItem, label: "Number Of Item", hint: "20"),
          SizedBox(
            height: 20,
          ),
          MyTextField(
              Controlr: SupplayerOfItem,
              label: "Supplier Of Item",
              hint: ""
          ),
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
                  onPressed: () {},
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
         Child: SingleChildScrollView(
            child: Column(
              children: [
                TitleOfContenar("Search of Item"),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                    Controlr: NameOfSearch,
                    label: "Name",
                    hint: ""
                ),
                SizedBox(height: 15,),
                MyTextField(
                    Controlr: CodeOfSearch,
                    label: "Code Of Item",
                    hint: "0300**************"
                ),
              ],
            ),
          ),
        ),
      )
      ,);
  }
}
