import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:velocity_x/velocity_x.dart';

import '../cuibt/cuibt.dart';

class AddItem extends StatelessWidget {

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
      child: Image.asset(
        "Asset/wallpaper.jpg",
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }

/*  Stepper buildStepper() {
    return Stepper(
      currentStep: cuibt.currentStep,
      type: StepperType.vertical,
      steps: [
        Step(
          title: Text("title", style: TextStyle(color: Colors.white)),
          content: Mytextfield(
              hint: "Write title of your task......", Controlr: title),
          *//*state: cuibt.currentStep > 0 ? StepState.complete : StepState.indexed,*//*
        ),
        Step(
          title: Text("description"),
          content: Mytextfield(
              hint: "Write description of your task......", Controlr: desc),
          state: cuibt.currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text("Time"),
          content: InkWell(
            onTap: () {
              showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input)
                  .then((value) {
                time.text = value!.format(context).toString();
              });
            },
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.access_time)),
                SizedBox(
                  width: 10,
                ),
                Text("Enter time "),
              ],
            ),
          ),
          state: cuibt.currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text("date"),
          content: InkWell(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.parse('2022-11-07'),
              ).then((value) {
                date.text = DateFormat.yMMMd().format(value!);
              });
            },
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("Enter date "),
              ],
            ),
          ),
          state: cuibt.currentStep > 3 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text("repeat"),
          content: DropdownButton(
              hint: Text("${cuibt.firstvalue} repeat",
                  style: TextStyle(color: Colors.black)),
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
              value: cuibt.firstvalue,
              onChanged: (Object? value) => cuibt.changevaluerepeat(value)),
          state: cuibt.currentStep > 4 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text("priority"),
          content: DropdownButton(
              hint: Text("${cuibt.Scondvalue} priority",
                  style: TextStyle(color: Colors.black)),
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
              value: cuibt.Scondvalue,
              onChanged: (Object? value) => cuibt.changevaluepri(value)),
          state: cuibt.currentStep > 5 ? StepState.complete : StepState.indexed,
        ),
      ],
      onStepContinue: () => cuibt.OnPressedContStepper(context),
      onStepCancel: () => cuibt.OnPressedcacselStepper(context),
    );
  }*/

  AddItemCountenar() {
    return Column(
      children: [
        TitleOfContenar(),
      ],
    );
  }

  Widget TitleOfContenar() => "Add Item".text.size(25).make().shimmer();
}