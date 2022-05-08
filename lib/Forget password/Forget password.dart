import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';

import '../Login/Login.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
      listener: (context, state) {},
      builder: (context, state) {
        var Size = MediaQuery.of(context).size;
        var cuibt=CasherCuibt.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Shimmer.fromColors(
                  child: const Text("Forget Password"),
                  baseColor: Colors.white,
                  highlightColor: Colors.black)),
          body: Container(
            height: Size.height,
            width: Size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Asset/waaass.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyContainer(
                    Height: Size.height * .8,
                    Width: Size.width * .7,
                    Child: Row(
                      children: [
                        LogoColumn(
                          Size,
                        ),
                        LoginState().MyDiveder(Size),
                        SizedBox(width: 15,),
                        TextFormColumn(cuibt,context)
                      ],
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  TextFormColumn(CasherCuibt cuibt,context) {
    return Expanded(
      child: Form
        (
        key: cuibt.RestPasswordForm,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextField(
                Controlr: cuibt.RestEmailController,
                hint: "youssef111@gmail.com",
                Prefix: const Icon(Icons.email,color: Colors.black),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter your email";
                  } else {
                    return null;
                  }
                },

              ),
             const  SizedBox(
                height: 20,
              ),
              Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20.0),
                  ),
                  child: MaterialButton(
                    minWidth: 150,
                    onPressed: () {
                      if (cuibt.RestPasswordForm.currentState!.validate()) {
                        cuibt.RessetPassword(context);
                      }
                    },
                    child: const Text("Reset Password",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    color: Colors.black87,
                  )),

            ],
          ),
        ),
      ),
    );
  }

  Expanded LogoColumn(Size Size) {
    return Expanded(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: Size.height * .5,
          width: Size.width * .3,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("Asset/3d-flame-258.png"),
          )),
        )
      ]),
    );
  }
}
