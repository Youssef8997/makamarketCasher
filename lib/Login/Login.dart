import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/HomeLayout/HomeLayout.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatelessWidget {
  var UserName = TextEditingController();
  var UserPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
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
                  TextFiledcoulmn(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded TextFiledcoulmn(context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(25.0),
              border: Border.all(color:Colors.black),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              controller: UserName,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.drive_file_rename_outline,
                      color: Colors.black),
                  hintText: "User Name",
                  hintStyle: TextStyle(color: Colors.black),
                  label: Text(
                    "User Name",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 60,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(25.0),
              border: Border.all(color:Colors.black),
            ),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              controller: UserPass,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.black),
                label: Text("Password", style: TextStyle(color: Colors.black)),
              ),
              obscureText: true,
              obscuringCharacter: "*",
              maxLines: 1,
            ),
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
                  Nevigator(bool: false, page: HomeScreen(), context: context);
                },
                child: const Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                color: Colors.black87,
              ))
        ],
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
            Shadow(color: Colors.black, blurRadius:1, offset: Offset(0, 3))
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
            .shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white)
            .h15(context),
      ],
    );
  }



  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      title: "Login"
          .text
          .bold
          .italic
          .size(25.0)
          .make()
          .shimmer(duration: const Duration(seconds: 2),primaryColor: Colors.black, secondaryColor:Colors.white)
    );
  }
}
