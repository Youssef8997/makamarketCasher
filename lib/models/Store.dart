import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

class Store extends StatelessWidget {
  var value;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>
      (listener: (context, state) {},
        builder: (context, state) {
        var size=MediaQuery.of(context).size;
          return Center(
            child: MyContainer(
                Height: size.height*.8,
                Width: size.width*.8,
              Child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Center(child: TitleOfContenar("Store")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const[
                     Text("اذن سحب من المخزن ",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,)
                  ],

                ),
                  const SizedBox(height: 50,),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 50,
                    width: size.width*.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(color: Colors.black,
                            width: 2
                        )
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: [
                          DropdownMenuItem(child: Text("dffddf"),value: "ddd",)
                        ],onChanged: (Object? value)=>{},value: value,),
                    ),
                  ),

              ],)
            ),
          );

        }
    );
  }
  Widget TitleOfContenar(value) => "$value".text.size(25).make().shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white);

}
