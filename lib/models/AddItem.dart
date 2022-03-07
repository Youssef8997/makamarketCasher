import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              AddItiemWallpapper(size),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    MyName(context),
                    SizedBox(height: 30,),
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
                child: Container(

                  height: size.height * .75,
                  width: size.width * .5,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade500.withOpacity(.8),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey.shade900,
                        width: 4,
                      )),
                  child: AddItemCoulmn(context),
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
                          Icon(cuibt.Search?Icons.clear:Icons.search, color: Colors.teal),
                          const SizedBox(width: 5),
                          cuibt.Search?const Text(
                              "Close", style: TextStyle(color: Colors.blueGrey)):const Text(
                              "Search", style: TextStyle(color: Colors.blueGrey)),
                        ],
                      ),
                    ],
                  ),
                  color: Colors.grey.shade900,
                ),
              ),
            );
  }

  SizedBox AddItiemWallpapper(Size Size) {
    return SizedBox(
      width: Size.width,
      height: Size.height,
      child: Image.network(
        "https://i.pinimg.com/564x/3f/0f/60/3f0f604cf81d704324992ea79854bce9.jpg",
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
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

  Widget TitleOfContenar(value) => "$value".text.size(25).make().shimmer();
  Widget MyName(BuildContext context) {
    return Column(
      children: [
        "Mada By:Youssef Ahmed"
            .text
            .bold
            .italic
            .size(25)
            .make()
            .shimmer(primaryColor:Colors.teal, secondaryColor: Colors.grey[900])
            .h10(context),
      ],
    );
  }
  Text MakaMarketName() {
    return const Text(
      "Maka Market",
      style: TextStyle(
          color: Colors.grey,
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.black, blurRadius: .5, offset: Offset(0, 3.5))
          ]),
    );
  }
  SearchCountenar(context,size) {
    var cuibt = CasherCuibt.get(context);
    return AnimatedOpacity(opacity: cuibt.Search ? 1 : 0,
      duration: Duration(milliseconds: 600),
      child:AbsorbPointer(
        absorbing:!cuibt.Search,
        child: Container(
          padding: const EdgeInsetsDirectional.all(20),
          height: size.height * .75,
          width: size.width * .4,
          decoration: BoxDecoration(
              color: Colors.indigo.shade500.withOpacity(.8),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.grey.shade900,
                width: 4,
              )),
          child: SingleChildScrollView(
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
