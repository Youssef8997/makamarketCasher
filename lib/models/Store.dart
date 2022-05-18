import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/Compoandis/button.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

class Store extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>
      (listener: (context, state) {},
        builder: (context, state) {
        var size=MediaQuery.of(context).size;
        var cuibt=CasherCuibt.get(context);
          return Center(
            child: MyContainer(
                Height: size.height*.8,
                Width: size.width*.8,
              Child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Center(child: TitleOfContenar("Store")),
            const  SizedBox(height: 50,),
              Text(" withdraw from the store",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900,color:Colors.grey[900]!,fontStyle: FontStyle.italic),),
                  const SizedBox(height: 20,),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 50,
                    width: size.width*.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        border: Border.all(color: Colors.black,
                            width: 2
                        )
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: cuibt.Products.map((e) {
                          return DropdownMenuItem(child: Text("   ${e["Name"]}"),value:e["Code"].toString(),);
                        }).toList(),onChanged: (Object? value)=>cuibt.ChangeStoreValue(value),value: cuibt.storeValue,),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Padding(
                    padding:EdgeInsets.symmetric(horizontal:size.width*.2),
                    child: MyTextField(Controlr: cuibt.Quantity, hint: "20 packages",label: "Quantity",Prefix: Icon(Icons.sync_alt,color: Colors.grey[900]!,),),
                  ),
                  const Spacer(),
                  Center(child: myButton(child: Text("Withdraw"),OnPreesed: ()=>cuibt.WithdrawFromStore(),)),

              ],)
            ),
          );

        }
    );
  }
  Widget TitleOfContenar(value) => "$value".text.size(25).make().shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white);

}
