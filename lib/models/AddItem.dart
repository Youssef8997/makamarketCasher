import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:velocity_x/velocity_x.dart';

import '../cuibt/cuibt.dart';

class AddItem extends StatelessWidget {
  var NameOfItem = TextEditingController();
  var CodeOfItem = TextEditingController();
  var PriceOfItem = TextEditingController();
  var NumberOfItem = TextEditingController();
  var SupplayerOfItem = TextEditingController();
  var winOfItem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AddItiemWallpapper(size),
              Container(
                height: size.height * .75,
                width: size.width * .5,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.8),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.grey.shade900,
                      width: 4,
                    )),
                child: AddItemCountenar(),
              )
            ],
          );
        });
  }

  SizedBox AddItiemWallpapper(Size Size) {
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

  Stepper buildStepper() {
    return Stepper(
      currentStep: 1,
      type: StepperType.horizontal,
      steps: [
        Step(
          title: Text("Name", style: TextStyle(color: Colors.white)),
          content: MyTextField(
              hint: "Write Name of item......", Controlr: NameOfItem),
          /*state: cuibt.currentStep > 0 ? StepState.complete : StepState.indexed,*/
        ),
        Step(
          title: Text("Code", style: TextStyle(color: Colors.white)),
          content: MyTextField(
              hint: "Write Code of item......", Controlr: CodeOfItem),
          /*  state: cuibt.currentStep > 1 ? StepState.complete : StepState.indexed,*/
        ),
        Step(
          title: Text("Price", style: TextStyle(color: Colors.white)),
          content: MyTextField(
              hint: "Write Code of item......", Controlr: PriceOfItem),
          /*state: cuibt.currentStep > 2 ? StepState.complete : StepState.indexed,*/
        ),
        Step(
          title: Text("How many of this product",
              style: TextStyle(color: Colors.white)),
          content: MyTextField(
              hint: "Write Number of item......", Controlr: NumberOfItem),
          /*state: cuibt.currentStep > 3 ? StepState.complete : StepState.indexed,*/
        ),
        Step(
          title: const Text("repeat", style: TextStyle(color: Colors.white)),
          content: DropdownButton(
            hint: Text("f repeat", style: TextStyle(color: Colors.black)),
            items: [
              DropdownMenuItem(
                child: const Text("5 Min"),
                value: "5 Min",
                enabled: true,
              ),
              DropdownMenuItem(
                child: const Text("10 Min"),
                value: "10 Min",
                enabled: true,
              ),
              DropdownMenuItem(
                child: const Text("30 Min"),
                value: "30 Min",
                enabled: true,
              ),
              DropdownMenuItem(
                child: const Text("1 hour"),
                value: "1 hour",
                enabled: true,
              ),
              DropdownMenuItem(
                child: const Text("Daily"),
                value: "Daily",
                enabled: true,
              ),
            ],
            value: "Daily",
            onChanged: (String?
                value) {}, /*onChanged: (Object? value) => cuibt.changevaluerepeat(value)*/
          ),
          /*   state: cuibt.currentStep > 4 ? StepState.complete : StepState.indexed,*/
        ),
        Step(
          title: Text("Suplayers", style: TextStyle(color: Colors.white)),
          content: DropdownButton(
            hint: Text("f Suplayers", style: TextStyle(color: Colors.black)),
            items: [
              DropdownMenuItem(
                child: const Text("high,"),
                value: "high",
                enabled: true,
              ),
              DropdownMenuItem(
                child: const Text("medium"),
                value: "medium",
                enabled: true,
              ),
              DropdownMenuItem(
                child: const Text("low"),
                value: "low",
                enabled: true,
              ),
            ],
            value: "low",
            onChanged: (String?
                value) {}, /*onChanged: (Object? value) => cuibt.changevaluepri(value)*/
          ),
          /*state: cuibt.currentStep > 5 ? StepState.complete : StepState.indexed,*/
        ),
      ],
/*      onStepContinue: () => cuibt.OnPressedContStepper(context),
      onStepCancel: () => cuibt.OnPressedcacselStepper(context),*/
    );
  }

  AddItemCountenar() {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.all(20),
      child: Column(
        children: [
          TitleOfContenar(),
          SizedBox(
            height: 5,
          ),
          MyTextField(Controlr: NameOfItem, hint: "Name of item"),
          SizedBox(
            height: 20,
          ),
          MyTextField(Controlr: CodeOfItem, hint: "Name of item"),
          SizedBox(
            height: 20,
          ),
          MyTextField(Controlr: PriceOfItem, hint: "Name of item"),
          SizedBox(
            height: 20,
          ),
          MyTextField(Controlr: winOfItem, hint: "Name of item"),
          SizedBox(
            height: 20,
          ),
          MyTextField(Controlr: NumberOfItem, hint: "Name of item"),
          SizedBox(
            height: 20,
          ),
          MyTextField(Controlr: SupplayerOfItem, hint: "Name of item"),
          MaterialButton(
            onPressed: () {},
            child: Text("Insert", style: TextStyle(color: Colors.white)),
            color: Colors.grey.shade900,


          )
        ],
      ),
    );
  }

  Widget TitleOfContenar() => "Add Item".text.size(25).make().shimmer();
}
