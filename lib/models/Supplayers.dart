import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';
class Supplayers extends StatelessWidget {
  @override
  var value;
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt,CasherState>
      (listener: (context,state){},
        builder: (context,state){
        var Size=MediaQuery.of(context).size;
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              LoginWallpapper(Size),
              SupplayersContenar(Size)
            ],
          );
        }
    );
  }
  SizedBox LoginWallpapper(Size Size) {
    return SizedBox(
      width: Size.width,
      height: Size.height,
      child: Image.network(
        "https://i.pinimg.com/736x/1d/fa/80/1dfa80166c5aba41aee1dad05edd1e7f.jpg",
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }
  Widget TitleOfContenar(value) => "$value".text.center.size(30).make().shimmer();
  SupplayersContenar(Size Size) {
    return Container(
      height: Size.height * 0.8,
      width: Size.width * 0.6,
      padding: EdgeInsetsDirectional.all(20),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.8),
          borderRadius: BorderRadiusDirectional.circular(30.0),
          border: Border.all(color: Colors.grey.shade700, width: 5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(child: TitleOfContenar("Suppliers"),alignment: Alignment.topCenter),
          Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            height: 50,
            width: Size.width*.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Colors.white,
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
          Spacer(),
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
                  child:const  Text("Add invoice", style: TextStyle(color: Colors.white)),
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
                  child:const  Text("Edit invoice", style: TextStyle(color: Colors.white)),
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
      ),
    );
  }

}
