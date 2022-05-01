import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/HomeLayout/HomeLayout.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Sign_up/SignUp.dart';
import '../cuibt/State.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVaildEmail = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
      listener: (context, state) {
        if (state is SignInFa) {
          isVaildEmail = false;
        }
        if (state is SignInTr) {
          setState(() {   isVaildEmail = true;
          });
          Nevigator(context: context, bool: false, page: HomeScreen());
        }
      },
      builder: (context, state) {
        var Size = MediaQuery.of(context).size;
        var cuibt = CasherCuibt.get(context);
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: _appBar(),
          body: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Wallpaper(Size),
              Align(
                alignment: AlignmentDirectional.center,
                child: Container(
                  height: Size.height * 0.8,
                  width: Size.width * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white,
                        width: 6,
                      )),
                  child: Row(
                    children: [
                      LogoCoulmn(Size, context),
                      const SizedBox(
                        width: 20,
                      ),
                      MyDiveder(Size),
                      const SizedBox(
                        width: 20,
                      ),
                      TextFiledcoulmn(context, cuibt, state),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Expanded TextFiledcoulmn(context, CasherCuibt cuibt, CasherState state) {
    return Expanded(
      child: Form(
        key: cuibt.SignInForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              Controlr: cuibt.SignEmailController,
              hint: "youssef@gmail.com",
              label: "Email Address",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Your Email';
                } else if (isVaildEmail == false) {
                  return 'This is a error in the email or password';
                }
                return null;
              },
              keybordtype: TextInputType.emailAddress,
              Prefix: const Icon(Icons.drive_file_rename_outline,
                  color: Colors.black),
               OnTap: ()=>setState(() {isVaildEmail = true;})
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(Controlr: cuibt.signPassController, hint: "*****",label: "Password", validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Your Password';
              } else if (isVaildEmail == false) {
                return 'This is a error in the email or password';
              }
              return null;
            }, keybordtype: TextInputType.visiblePassword, Prefix: const Icon(Icons.lock, color: Colors.black),
              isobsr: true,
              OnTap:()=>setState(() {isVaildEmail = true;})
            ),
            const SizedBox(
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
                    if (cuibt.SignInForm.currentState!.validate()) {
                      cuibt.SignIn(context);
                    }
                  },
                  child: const Text("Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  color: Colors.black87,
                )),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () =>
                  Nevigator(bool: true, page: signUp(), context: context),
              child: const Text(
                "don't have email yet ?",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Expanded LogoCoulmn(Size Size, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: LoginLogo(Size),
          ),
          MakaMarketName(),
          const Spacer(),
          MyName(context),
          const Text(
            "Number:01273599580",
            style: TextStyle(
                color: Colors.black, fontSize: 23, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Container MyDiveder(Size Size) {
    return Container(
      color: Colors.white10,
      height: Size.height * 0.8,
      width: 1,
    );
  }

  Text MakaMarketName() {
    return const Text(
      "Market",
      style: TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.black, blurRadius: 1, offset: Offset(0, 3))
          ]),
    );
  }

  Container LoginLogo(Size Size) {
    return Container(
      height: Size.height * .5,
      width: Size.width * .3,
      decoration: const BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.modulate),
              image: AssetImage(
                "Asset/login.png",
              ))),
    );
  }

  Widget MyName(BuildContext context) {
    return Column(
      children: [
        "Designed:Youssef Ahmed"
            .text
            .bold
            .italic
            .size(25)
            .make()
            .shimmer(
                duration: const Duration(seconds: 2),
                primaryColor: Colors.black,
                secondaryColor: Colors.white)
            .h15(context),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: "Login".text.bold.italic.size(25.0).make().shimmer(
            duration: const Duration(seconds: 2),
            primaryColor: Colors.black,
            secondaryColor: Colors.white));
  }
}
