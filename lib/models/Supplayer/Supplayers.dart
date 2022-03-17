import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/models/Supplayer/AddSublayers.dart';
import 'package:untitled6/models/Supplayer/Pay%20fees.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Compoandis/MyContenar.dart';
class Supplayers extends StatelessWidget {
  var scrolllabel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt,CasherState>
      (listener: (context,state){},
        builder: (context,state){
        var cuibt=CasherCuibt.get(context);
        var Size=MediaQuery.of(context).size;
          return Center(
            child:SupplayersContenar(Size,context,cuibt),
          );
        }
    );
  }

  Widget TitleOfContenar(value) => "$value".text.size(30).make().shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white);
  SupplayersContenar(Size Size,context,CasherCuibt cuibt) {
    return MyContainer(
      Height: Size.height * 0.8,
      Width: Size.width * 0.6,
      Child: Supplayerscontent(Size,context,cuibt),
    );
  }

  Column Supplayerscontent(Size Size,context,CasherCuibt cuibt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(child: TitleOfContenar("Suppliers"),alignment: Alignment.topCenter),
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
              alignment: AlignmentDirectional.center,
              items: cuibt.Supplayer.map((e) {
                return DropdownMenuItem(child:Text("${e["Name"]}"),value:e["id"],);
              }).toList(),
              onChanged: (Object? value)=>cuibt.ChangeValue(value),value: cuibt.value,),
          ),
        ),
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
                onPressed: () {Nevigator(bool: true,context: context,page:  InputSupplayers());},
                child: const Text("Add Suppliers", style:  TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(width: 10,),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: MaterialButton(
                onPressed: () {
                  Nevigator(bool: true,context: context,page:  PayFees(NameOfSupllayers:cuibt.Supplayer[cuibt.value-1]["Name"],id:cuibt.value,));
                },
                child:const  Text("Pay fees", style: TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(width: 10,),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: MaterialButton(
                onPressed: () {},
                child:const  Text("Delete invoice", style: TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(width: 10,),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: MaterialButton(
                onPressed: () {},
                child:const  Text("print invoice", style: TextStyle(color: Colors.white)),
                color: Colors.grey.shade900,
              ),
            ),

          ],
        )
      ],
    );
  }
/*feesContainer(){
    return
}*/
}
