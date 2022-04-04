import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';

class Items extends StatelessWidget {

  var scrolllabel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var cuibt = CasherCuibt.get(context);

          return Center(
            child: ItemsOfContenar(size, cuibt,context ),
          );
        });
  }

  Widget SearchButton(CasherCuibt cuibt) {
    return cuibt.ItemsSearch
        ? Row(
            children: [
              Expanded(
                  child: MyTextField(
                Controlr: cuibt.NameController,
                hint: "",
                label: "Search",
                    onChanged: (value){
                  cuibt.getSearchItem(value);}


              )),
              SizedBox(
                width: 20,
              ),
              MaterialButton(
                onPressed: () {
                  cuibt.ItemSChangeSearch();
                  cuibt.NameController.clear();
                },
                child:
                    const Text("Enter", style: TextStyle(color: Colors.white)),
                color: Colors.grey,
              )
            ],
          )
        : Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: MaterialButton(
            color: Colors.blueGrey[700],
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
          ),
        );
  }

  ItemsOfContenar(Size,CasherCuibt cuibt,context ) {
    return MyContainer(
      Height: Size.height * 0.9,
      Width: Size.width * 0.9,
      Child: Scrollbar(
        controller:scrolllabel,
        child: ListView(
          controller:scrolllabel ,
        children: [
          SearchButton(cuibt),
          const SizedBox(height: 30),
          CasherTable(context,Size)
        ],
        ),
      ),
    );
  }

  CasherTable(context,Size size) {
    var cuibt=CasherCuibt.get(context);
    return Container(
      height:size.height*.7,
      width: size.width*.9,
      child: DataTable(

          dataTextStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.black,
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
          columnSpacing: 60,
          horizontalMargin: 10,
          border: TableBorder.all(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15),
              width: 2),
          columns: const [
            DataColumn(
              label: Text("Code"),
            ),
            DataColumn(
              label: Text("Name"),
            ),
            DataColumn(
              label: Text("Price"),
            ),
            DataColumn(
              label: Text("Number"),
            ),
            DataColumn(
              label: Text("EndDate"),
            ),
          ],
          rows:cuibt.SearchProducts.map((e){
            return DataRow(cells: [
              DataCell(Text("${e["Code"]}")),
              DataCell(Text("${e["Name"]}")),
              DataCell(Text("${e["Price"]}")),
              DataCell(Text("${e["NumberInStore"]}")),
              DataCell(Text("${e["EndDate"]}")),
            ]);
          } ).toList()


      ),
    );
  }
 
}
