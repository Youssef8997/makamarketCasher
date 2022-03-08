import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';

class Items extends StatelessWidget {
  var CodeController = TextEditingController();
  var NameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var cuibt = CasherCuibt.get(context);

          return Center(child:ItemsOfContenar(size, cuibt) ,);
        });
  }



  Widget SearchButton(CasherCuibt cuibt) {
    return cuibt.ItemsSearch
        ? Row(
      children: [
        Expanded(
            child: MyTextField(
              Controlr: NameController,
              hint: "",
              label: "Search",
            )),
        SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            cuibt.ItemSChangeSearch();
            NameController.clear();
          },
          child:
          const Text("Enter", style: TextStyle(color: Colors.white)),
          color: Colors.grey,
        )
      ],
    ):Positioned(
            top: 40,
            right: 30,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: MaterialButton(
                onPressed: () {
                  cuibt.ItemSChangeSearch();
                },
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.search, color: Colors.teal),
                        SizedBox(width: 5),
                        Text("Search",
                            style: TextStyle(color: Colors.blueGrey)),
                      ],
                    ),
                  ],
                ),
                color: Colors.grey.shade900,
              ),
            ),
          )
        ;
  }

  ItemsOfContenar(Size, cuibt) {
    return MyContainer(
      Height: Size.height * 0.9,
      Width: Size.width * 0.9,
     Child: Column(
        children: [SearchButton(cuibt)],
      ),
    );
  }
}
