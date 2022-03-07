import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/cuibt.dart';

import '../cuibt/State.dart';

class CasherPage extends StatelessWidget {
  @override
  var SearchControlar=TextEditingController();
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          return Stack(children: [

            NumberOfOrder(),
            //SearchRightBottom
            AnimatedAlign(
              duration:const Duration(milliseconds: 500) ,
             alignment:  CasherCuibt.get(context).Search ?AlignmentDirectional.center:AlignmentDirectional.centerEnd,

                child:
                    RotatedBox(
                        child: SearchButton(CasherCuibt.get(context)),
                      quarterTurns:5,

                    )
            ),
            //CashierConte
            AnimatedAlign(
              duration: const Duration(milliseconds: 700),
              curve: Curves.fastOutSlowIn,
              alignment: CasherCuibt.get(context).Search ? Alignment.centerLeft : Alignment
                  .center,
              child: AnimatedContainer(
                duration:  const Duration(milliseconds: 700),
                curve: Curves.fastLinearToSlowEaseIn,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800.withOpacity(.9),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Colors.grey.shade900,
                      width: 4,
                    )),
                height: size.height * .8,
                width: CasherCuibt.get(context).Search?size.width * .48:size.width * .9,
                child: CasherTable(context),
              ),
            ),
            //searchConte
            Padding(
                padding: const EdgeInsetsDirectional.only(end: 15),
                child: Align(child: SearchCountenar(context,size),alignment: Alignment.centerRight,)),
          ]);
        });
  }
  SearchCountenar(context,size) {
    var cuibt = CasherCuibt.get(context);
    return AnimatedOpacity(opacity: cuibt.Search ? 1 : 0,
      duration: Duration(milliseconds: 700),
      curve: Curves.fastOutSlowIn,
      child:AbsorbPointer(
        absorbing:!cuibt.Search,
        child: Container(
          padding: const EdgeInsetsDirectional.all(20),
          height: size.height * .8,
          width: size.width * .4,
          decoration: BoxDecoration(
              color: Colors.indigo.shade500.withOpacity(.8),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.grey.shade900,
                width: 4,
              )),
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: 20,
                ),
                MyTextField(
                    Controlr: SearchControlar,
                    label: "Name",
                    hint: ""
                ),
                SizedBox(height: 15,),
                MyTextField(
                    Controlr: SearchControlar,
                    label: "Code Of Item",
                    hint: "0300**************"
                ),
              ],
            ),
          ),
        ),
      )
      ,);
  }
  Positioned NumberOfOrder() {
    return Positioned(
      top: 20,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20)),
            alignment: AlignmentDirectional.center,
            child: const SelectableText(
              "1000",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  Container SearchButton(CasherCuibt cuibt) {
    return Container(
      height: 40,
      width: 100,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      alignment: AlignmentDirectional.center,
      child: MaterialButton(
        onPressed: () {
          cuibt.AddItemChangeSearch();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(cuibt.Search ? Icons.clear : Icons.search,
                    color: Colors.teal),
                const SizedBox(width: 5),
                cuibt.Search
                    ? const Text("Close",
                        style: TextStyle(color: Colors.blueGrey))
                    : const Text("Search",
                        style: TextStyle(color: Colors.blueGrey)),
              ],
            ),
          ],
        ),
        color: Colors.grey.shade900,
      ),
    );
  }

  CasherTable(context) {
    return DataTable(
        dataTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingTextStyle:
            TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
        columnSpacing: 90,
        horizontalMargin: 10,
        border: TableBorder.all(
          borderRadius: BorderRadius.circular(25),
          width: .5,
          color: Colors.white
        ),
        columns: const [
          DataColumn(
            label: Text("Code"),
          ),
          DataColumn(
            label: Text("Name"),
          ),
          DataColumn(
            label: Text("Cost"),
          ),
          DataColumn(
            label: Text("Number"),
          ),
          DataColumn(
            label: Text("total"),
          ),
        ],
        rows: [
          DataRow(cells: [
            const DataCell(
              Text("11111"),
            ),
            const DataCell(Text("name")),
            DataCell(SelectableText("cost")),
            DataCell(SelectableText("${CasherCuibt.get(context).n}"),
                onDoubleTap: () {
              CasherCuibt.get(context).d();
            }),
            const DataCell(Text("total")),
          ]),
          DataRow(cells: [
            DataCell(Text("11111")),
            DataCell(Text("name")),
            DataCell(Text("cost")),
            DataCell(Text("number")),
            DataCell(Text("total")),
          ]),
          DataRow(cells: [
            DataCell(Text("11111")),
            DataCell(Text("name")),
            DataCell(Text("cost")),
            DataCell(Text("number")),
            DataCell(Text("total")),
          ]),
        ]);
  }
}
