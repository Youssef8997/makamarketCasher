import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/models/Supplayer/AddSublayers.dart';
import 'package:untitled6/models/Supplayer/Pay%20fees.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Compoandis/MyContenar.dart';
import 'Add Money.dart';

class Supplayers extends StatelessWidget {
  var scrolllabel = ScrollController();
int? deleteId;
int? indexl;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cuibt = CasherCuibt.get(context);
          var Size = MediaQuery.of(context).size;
          return Center(child:SupplayersContenar(Size, context, cuibt),);
        });
  }

  Widget TitleOfContenar(value) => "$value".text.size(30).make().shimmer(
      duration: const Duration(seconds: 2),
      primaryColor: Colors.black,
      secondaryColor: Colors.white);

  SupplayersContenar(Size Size, context, CasherCuibt cuibt) {
    return MyContainer(
      Height: Size.height * 0.8,
      Width: Size.width * 0.6,
      Child: Supplayerscontent(Size, context, cuibt),
    );
  }

  Column Supplayerscontent(Size Size, context, CasherCuibt cuibt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
            child: TitleOfContenar("Suppliers"),
            alignment: Alignment.topCenter),
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          height: 50,
          width: Size.width * .7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.black, width: 2)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(

              alignment: AlignmentDirectional.center,
              items: cuibt.Suppliers.map((e) {
                return DropdownMenuItem(
                  child: Text("${e["Name"]}"),
                  value: e["id"],
                );
              }).toList(),
              onChanged: (Object? value) => cuibt.ChangeValue(value),
              value: cuibt.value,
            ),
          ),
        ),
        if(cuibt.value!=null)
        Expanded(
            child: ListView.separated(
                itemBuilder: (context,index) {
                  if(cuibt.fees[index]["Name"]==cuibt.Suppliers[cuibt.value-1]["Name"]) {
                    return  feesContainer(Size, cuibt.fees[index]);
                  }
                  else {
                    return  SizedBox(height: 0,);
                  }
                },
                separatorBuilder: (context,index)=>const SizedBox(height: 10),
                itemCount: cuibt.fees.length)),
        if(cuibt.value==null)
          const Spacer(),
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
                  Nevigator(
                      bool: true, context: context, page: InputSupplayers());
                },
                child: const Text("Add Suppliers",
                    style: TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: AbsorbPointer(
                absorbing: cuibt.value == null ? true : false,
                child: MaterialButton(
                  onPressed: () {
                    Nevigator(
                        bool: true,
                        context: context,
                        page: PayFees(
                          NameOfSupllayers: cuibt.Suppliers[cuibt.value - 1]
                              ["Name"],
                          id: cuibt.value,
                        ));
                  },
                  child: const Text("Pay fees",
                      style: TextStyle(color: Colors.white)),
                  color:
                      cuibt.value == null ? Colors.grey : Colors.grey.shade900,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            AbsorbPointer(
              absorbing: cuibt.value == null ? true : false,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: MaterialButton(
                  onPressed: () {Nevigator(page: AddMoney(NameOfSupllayers: cuibt.Suppliers[cuibt.value - 1]
                  ["Name"],id: cuibt.value, ),context: context,bool: true);},
                  child: const Text("Increases money",
                      style: TextStyle(color: Colors.white)),
                  color: cuibt.value == null ? Colors.grey : Colors.grey.shade900,

                ),
              ),
            ),

          ],
        )
      ],
    );
  }

  feesContainer(Size size, e,) {
    print(e["Name"]);
    return Row(
      children: [
        RotatedBox(
            quarterTurns: 1,
            child: Text(
              "${e["LastDate"]}",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        Container(
          padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
          height: 60,
          width: size.width * .56,
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
                    "Name of Suppliers: ${e["Name"]}",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    "Last fees: ${e["Paid"]}",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    "Total money:  ${e["TotalSuppliers"]}",
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

}
