import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/Compoandis/button.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:velocity_x/velocity_x.dart';

import '../Login/Login.dart';

class signUp extends StatefulWidget {
  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
      listener: (context, state) {
        if(state is CreateBaseUserProfileFa)
        {
          MotionToast.error(
              title:  Text("Error in SignUp"),
              description:  Text("This Email is already used"),
            enableAnimation: true,
            toastDuration:const Duration(seconds: 3) ,
          ).show(context);
        }
      },
      builder: (context, state) {
        var cuibt = CasherCuibt.get(context);
        var Size = MediaQuery.of(context).size;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Shimmer.fromColors(
                  child: const Text("SignUp"),
                  baseColor: Colors.white,
                  highlightColor: Colors.black)),
          body: Container(
            height: Size.height,
            width: Size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Asset/waaass.jpg"), fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: MyContainer(
                        Height: Size.height * .8,
                        Width: Size.width * .8,
                        Child: Row(
                          children: [
                            LogoCoulmn(Size, context),
              LoginState().MyDiveder(Size),
                            const SizedBox(width:10),
                            TextFieldColumn(cuibt,context),
                          ],
                        )))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget TextFieldColumn(CasherCuibt cuibt,context) {
    return Expanded(
      child: Form(
        key: cuibt.SignUpForm,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyTextField(
              label: "Name",
              keybordtype: TextInputType.text,
              hint: "youssef ahmed",
              Controlr: cuibt.nameController,
              validator: (value) {
                if (value.isEmpty) {
                  return "name is required";
                }
                return null;
              },
              Prefix: const Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              label: "Email",
              keybordtype: TextInputType.emailAddress,
              hint: "youssefahmed123@gmail.com",
              Controlr: cuibt.emailController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Email is required";
                }
                else if(!value.contains("@")){
                  return "Email is not valid";
                }
                return null;
              },
              Prefix: const Icon(Icons.email, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              label: "Password",
              keybordtype: TextInputType.text,
              hint: "*********",
              Controlr: cuibt.passController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Password is required";
                }
                else if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                else if (value.length > 20) {
                  return "Password must be less than 20 characters";
                }
                else if(value.contains(new RegExp(r'[0-9]')) == false){
                  return "Password must contain at least one number";
                }
                else if(value.contains(new RegExp(r'[A-Z]')) == false){
                  return "Password must contain at least one uppercase letter";
                }
                else if(value.contains(new RegExp(r'[a-z]')) == false){
                  return "Password must contain at least one lowercase letter";
                }
                return null;
              },
              Prefix: const Icon(Icons.password_outlined, color: Colors.black),
              suffix: IconButton(
                onPressed: () => cuibt.changeObs(),
                icon: cuibt.isObserer
                    ? const Icon(Icons.visibility_off, color: Colors.black): const Icon(Icons.remove_red_eye, color: Colors.black)

              ),
              isobsr: cuibt.isObserer,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                label: "confirmPass",
                keybordtype: TextInputType.text,
                hint: "********",
                Controlr: cuibt.passController2,
                validator: (value) {
                  if (value.isEmpty &&
                      cuibt.passController.text != cuibt.passController2.text) {
                    return "pass not match";
                  }
                  return null;
                },
              Prefix: const Icon(Icons.password_outlined, color: Colors.black),
              isobsr: cuibt.isObserer,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                label: "phone",
                keybordtype: TextInputType.number,
                hint: "012333*****",
                Controlr: cuibt.phoneController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "phone is required";
                  }
                  return null;
                },
            Prefix: const Icon(Icons.phone, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              label: "Shop Name",
              keybordtype: TextInputType.text,
              hint: "lord Syrian",
              Controlr: cuibt.shopNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return "phone is required";
                }
                return null;
              },
              Prefix: const Icon(Icons.store, color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
         myButton(child: const Text("Sign Up", style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),OnPreesed: () {
        if(cuibt.SignUpForm.currentState!.validate()) {
          cuibt.createNewUser(context);
        }
         }),
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
          ShopName(),
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

  Text ShopName() {
    return const Text(
      "lord Syrian",
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
                "Asset/success-work.png",
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
}
