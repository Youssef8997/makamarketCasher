import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';

class Money extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var cuibt=CasherCuibt.get(context);
          return Center(
              child: MyContainer(
                  Height: size.height * .8,
                  Width: size.width * .7,
                  Child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      ShowMoney(money:cuibt.AllMoneyGet,size: size,text:"Money input",boolen: false ),
                      const SizedBox(height: 10),
                      ShowMoney(money:cuibt.payedMoney,size: size,text:"Money out",boolen: true ),
                      const SizedBox(height: 10),
                      ShowMoney(money:cuibt.totalMoney,size: size,text:"Money In box",boolen: false ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          botton("Details", onPressed: (){}),
                          const SizedBox(width: 20,),
                          botton("Print",onPressed: ()=>cuibt.EndShift()),

                        ],
                      )

                    ],
                  )));
        });
  }

  Container botton(text, { onPressed}) {
    return Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: MaterialButton(
                            onPressed: onPressed,
                            child:  Text("$text", style: const TextStyle(color: Colors.white)),
                            color: Colors.grey.shade900,
                          ),
                        );
  }
  Widget ShowMoney({
    required Size size,
    required text,
    required money,
    required boolen
  }){
    return Column(
      children: [
         Text(
          "$text:",
          style: const TextStyle(
              fontSize: 21.0,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap:boolen?(){}:null,
          child: MyContainer(
              Height: 50.0,
              Width: size.width - 30,
              Child: Row(
                children: [
                  const  Icon(Icons.attach_money_outlined,color: Colors.green,),
                  const Spacer(),
                  Text("$money LE",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,),),
                  const Spacer(),
                ],
              )
          ),
        )
      ],
    );
  }
}
