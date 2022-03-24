import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/models/AddItem.dart';
import '../cuibt/State.dart';

class CasherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var cuibt = CasherCuibt.get(context);
          return Stack(children: [
            NumberOfOrder(),
            TotalOfMoney(cuibt),
            //SearchRightBottom
            Padding(
              padding:  EdgeInsets.only(right:10,left:CasherCuibt.get(context).Search?30:0),
              child: AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  alignment: CasherCuibt.get(context).Search
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerEnd,
                  child: RotatedBox(
                    child: SearchButton(CasherCuibt.get(context)),
                    quarterTurns: 5,
                  )),
            ),
            //CashierConte
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 700),
                curve: Curves.fastOutSlowIn,
                alignment: CasherCuibt.get(context).Search
                    ? Alignment.centerLeft
                    : Alignment.center,
                child: AnimatedContainer(
                  padding: const EdgeInsetsDirectional.all(10),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.fastLinearToSlowEaseIn,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white54,
                        width: 3,
                      )),
                  height: size.height * .76,
                  width: CasherCuibt.get(context).Search
                      ? size.width * .48
                      : size.width * .9,
                  child: CasherTable(context, cuibt),
                ),
              ),
            ),
            //searchConte
            Padding(
                padding: const EdgeInsetsDirectional.only(end: 15,bottom: 20),
                child: Align(
                  child: SearchCountenar(context, size),
                  alignment: Alignment.centerRight,
                )),
            //bottom Container
            BottomContainer(size, context, cuibt)
          ]);
        });
  }

  Padding BottomContainer(Size size, BuildContext context, CasherCuibt cuibt) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: MyContainer(
          Height: size.height * .118,
          Width: CasherCuibt.get(context).Search
              ? (size.width) - 10
              : size.width * .9,
          Child: TextFormRow(cuibt,context),
        ),
      ),
    );
  }

  Shortcuts TextFormRow(CasherCuibt cuibt,context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.enter): EnterButton(),
        LogicalKeySet(LogicalKeyboardKey.space): EnterButton(),
        LogicalKeySet(LogicalKeyboardKey.equal): RemoveItem(),
      },
      child: Actions(
        actions: {
          EnterButton:
              CallbackAction<EnterButton>(onInvoke: (intent) {
                cuibt.GetItem();
                cuibt.NInserted=false;
                cuibt.cahnge();
                if(cuibt.AlertChangeNum) {
              settingDialog(context,"This item is found,Change the number of this item",cuibt);
              cuibt.AlertChangeNum=false;
              cuibt.NInserted=false;
              cuibt.cahnge();
            }
                if(cuibt.AlertItemNFound) {
              settingDialog(context,"This item not found",cuibt);
              cuibt.AlertItemNFound=false;
              cuibt.cahnge();
                }
          }),
          RemoveItem: CallbackAction<RemoveItem>(onInvoke: (intent)=>cuibt.delete())
        },
        child: Row(
          children: [
            const Text("Code:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                    fontStyle: FontStyle.italic)),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: MyTextField(
              Controlr: cuibt.CodeOfProduct,
              hint: "Write code of Product",
            )),
            const SizedBox(width: 5),
            const Text("Name:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                    fontStyle: FontStyle.italic)),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: MyTextField(
                    Controlr: cuibt.NameOfProduct,
                    hint: "Write name of Product")),
            const SizedBox(width: 5),
            const Text("Number:",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                    fontStyle: FontStyle.italic)),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: MyTextField(
                    Controlr: cuibt.NumberOfProduct,
                    hint: "Write number of Product")),
          ],
        ),
      ),
    );
  }

  SearchCountenar(context, Size size) {
    var cuibt = CasherCuibt.get(context);
    return AnimatedOpacity(
      opacity: cuibt.Search ? 1 : 0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.fastOutSlowIn,
      child: MyContainer(
          Height: size.height * .76,
          Width: size.width * .4,
          Child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                    Controlr: cuibt.NameOfProduct, label: "Name", hint: ""),
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                    Controlr: cuibt.CodeOfProduct,
                    label: "Code Of Item",
                    hint: "0300**************"),
              ],
            ),
          )),
    );
  }

  Positioned NumberOfOrder() {
    return Positioned(
      left: 50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(20)),
            alignment: AlignmentDirectional.center,
            child: const SelectableText(
              "1000",
              style: TextStyle(
                  fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
            )),
      ),
    );
  }

  Positioned TotalOfMoney(CasherCuibt cuibt) {
    return Positioned(
      right: 50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(20)),
            alignment: AlignmentDirectional.center,
            child: Text(
              "${cuibt.total}",
              style: TextStyle(
                  fontWeight: FontWeight.w800, fontStyle: FontStyle.italic),
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
                    color: Colors.grey[900]),
                const SizedBox(width: 5),
                cuibt.Search
                    ? const Text("Close", style: TextStyle(color: Colors.black))
                    : const Text("Search",
                        style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
        color: Colors.white70,
      ),
    );
  }

  CasherTable(context, CasherCuibt cuibt) {
    return DataTable(
        dataTextStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
        columnSpacing: 90,
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
            label: Text("Cost"),
          ),
          DataColumn(
            label: Text("Number"),
          ),
          DataColumn(
            label: Text("total"),
          ),
        ],
        rows: cuibt.orders.asMap().entries.map((r) {
          var e=r.value;
          int index=r.key;
          return DataRow(
              onSelectChanged: (select){
                cuibt.InsertValueItem(
                  codeOFItem: "${e["Code"]}",
                  NameOFItem: "${e["Name"]}",
                  NumberOFItem: "${e["Num"]}",
                  id: e["id"],
                  Price:e["Price"],
                  index: index,
                );
              },
              cells: [
                DataCell(Text("${e["Code"]}")),
                DataCell(Text("${e["Name"]}")),
                DataCell(
                  Text("${e["Price"]}"),
                ),
                DataCell(Text("${e["Num"]}")),
                DataCell(Text("${e["TotalMoney"]}")),
              ]);
        }).toList());
  }
   settingDialog(context,text,CasherCuibt cuibt) {
    return showDialog(

        context: context,
        builder: (context) {
          return BlurryContainer(
            height: 800,
            width: 300,
            blur: 6,
            child: AlertDialog(
actionsAlignment: MainAxisAlignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.white60,
              elevation: 2,
              content: Text("$text",style: TextStyle(fontWeight: FontWeight.w900)),
              actions: [
                MaterialButton(
                  color: Colors.blueGrey[700],
                  onPressed: (){
                  Navigator.pop(context);
                },child:const Text("Okay",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),),
                if(text=="This item not found")
                  MaterialButton(
                    color: Colors.blueGrey[700],
                    onPressed: (){
                      cuibt.ChangePageIntoAddItem();
                      Navigator.pop(context);
                    },child:const Text("Add item",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,)),),

              ],
            ),
          );
        });
  }

}

class EnterButton extends Intent {}
class RemoveItem extends Intent {}
