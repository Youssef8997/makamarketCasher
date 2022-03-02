import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';

class Items extends StatelessWidget {
  var CodeControlar = TextEditingController();
  var NameControlar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var cuibt = CasherCuibt.get(context);

          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              ItemsWallpapers(size),
              ItemsOfContenar(size, cuibt),
            ],
          );
        });
  }

  ItemsWallpapers(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
              colorFilter:
                  ColorFilter.mode(Colors.blueGrey, BlendMode.modulate),
              image: NetworkImage(
                "https://i.pinimg.com/564x/4c/55/9b/4c559b82bae97c0a4031eab5fd4ae36c.jpg",
              ))),
    );
  }

  Widget SearchButton(CasherCuibt cuibt) {
    return cuibt.ItemsSearch
        ? Positioned(
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
        : Row(
            children: [
              Expanded(
                  child: MyTextField(
                Controlr: NameControlar,
                hint: "",
                label: "Search",
              )),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                onPressed: () {
                  cuibt.ItemSChangeSearch();
                  NameControlar.clear();
                },
                child:
                    const Text("Enter", style: TextStyle(color: Colors.white)),
                color: Colors.grey,
              )
            ],
          );
  }

  ItemsOfContenar(Size, cuibt) {
    return Container(
      padding: EdgeInsetsDirectional.all(30),
      height: Size.height * 0.9,
      width: Size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.8),
          borderRadius: BorderRadiusDirectional.circular(30.0),
          border: Border.all(color: Colors.grey.shade700, width: 5)),
      child: Column(
        children: [SearchButton(cuibt)],
      ),
    );
  }
}
