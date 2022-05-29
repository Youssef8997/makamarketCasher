import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/MyContenar.dart';
import 'package:untitled6/Compoandis/MyTextForm.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import '../cuibt/State.dart';

class CasherPage extends StatelessWidget {
  var scrolllabel = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt, CasherState>(
        listener: (context, state) {},
        builder: (context, state) {
          var size = MediaQuery.of(context).size;
          var cuibt = CasherCuibt.get(context);
          return Stack(children: [
            NumberOfOrder(cuibt),
            TotalOfMoney(cuibt),
            //SearchRightBottom
            Padding(
              padding: EdgeInsets.only(
                  left: CasherCuibt.get(context).Search ? 100 : 10,
                  bottom: 10,
                  top: 10,
                  right: 10),
              child: AnimatedAlign(
                  duration: const Duration(milliseconds: 500),
                  alignment: CasherCuibt.get(context).Search
                      ? AlignmentDirectional.center
                      : AlignmentDirectional.centerStart,
                  child: RotatedBox(
                    quarterTurns: 5,
                    child: SearchButton(CasherCuibt.get(context)),
                  )),
            ),
            //CashierConte
            Padding(
              padding:  EdgeInsets.only(bottom: 20,top:CasherCuibt.get(context).Search?180:0),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 700),
                curve: Curves.fastOutSlowIn,
                alignment: CasherCuibt.get(context).Search
                    ? Alignment.centerLeft
                    : Alignment.bottomCenter,
                child: AnimatedContainer(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
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
                  child: casherTable(context, cuibt),
                ),
              ),
            ),
            //searchConte
            Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 20, top: 180),
                child: Align(
                  child: SearchCountenar(context, size),
                  alignment: Alignment.centerRight,
                )),
            //Top  Container
            topContainer(size, context, cuibt)
          ]);
        });
  }

  Padding topContainer(Size size, BuildContext context, CasherCuibt cuibt) {
    return Padding(
      padding: const EdgeInsets.only(top: 70,bottom: 5),
      child: Align(
        alignment: AlignmentDirectional.topCenter,
        child: MyContainer(
          Height: size.height * .118,
          Width: CasherCuibt.get(context).Search
              ? (size.width) - 10
              : size.width * .9,
          Child: TextFormRow(cuibt, context),
        ),
      ),
    );
  }

  Shortcuts TextFormRow(CasherCuibt cuibt, context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.delete): RemoveItem(),
        LogicalKeySet(LogicalKeyboardKey.insert): RecordOrder(),
      },
      child: Actions(
        actions: {
          RemoveItem: CallbackAction<RemoveItem>(onInvoke: (intent) {
            cuibt.deleteItemFOrders(context);
          }),
          RecordOrder: CallbackAction<RecordOrder>(onInvoke: (intent) {
            cuibt.RecordOrder();
          }),
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
                    auto: true,
                    Focusnode: cuibt.foucsCode,
                    Controlr: cuibt.CodeOfProduct,
                    hint: "Write code of Product",
                    OnSubmitted: (_) {
                      cuibt.GetItem(context);
                      cuibt.NameOfProduct.clear();
                    },
                onChanged: (value){
                  cuibt.getItemProducts(cuibt.dataBase, value).then((value) {
                    print(value);
                    if(value.length==1){
                      cuibt.NameOfProduct.text = value[0]['Name'];
                    }
                    else{

                      cuibt.NameOfProduct.clear();
                    }
                  });
                }
                ))

            ,
            const SizedBox(width: 40),
            const Text("Item Name:",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 19,
                    fontStyle: FontStyle.italic)),
            const SizedBox(
              width: 5,
            ),
            Expanded(
                child: MyTextField(
                  enabled: false,
                    Controlr: cuibt.NameOfProduct,
                    hint: "",
                    OnSubmitted: (Text) {
                      cuibt.getRecite(Text);
                      if (cuibt.recordedOrders.isNotEmpty) {
                        orderDialog(context, cuibt);
                      }
                    })),

            if(CasherCuibt.get(context).Search)
                const Text("ReciteNum:",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 19,
                    fontStyle: FontStyle.italic)),
            if(CasherCuibt.get(context).Search)
              const SizedBox(
              width: 5,
            ),
            if(CasherCuibt.get(context).Search)
            Expanded(
                child: MyTextField(
                    Controlr: cuibt.NumOrders,
                    hint: "150",
                    OnSubmitted: (Text) {
                      cuibt.getRecite(Text);
                      if (cuibt.recordedOrders.isNotEmpty) {
                        orderDialog(context, cuibt);
                      }
                    })),
          ],
        ),
      ),
    );
  }

  Positioned NumberOfOrder(CasherCuibt cuibt) {
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
            child: SelectableText(
              "${cuibt.NumberOfOrder}",
              style: const TextStyle(
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
            height: 50,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(20)),
            alignment: AlignmentDirectional.center,
            child: Text(
              "${cuibt.total}",
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  fontSize: 19),
            )),
      ),
    );
  }

  Widget SearchButton(CasherCuibt cuibt) {
    return InkWell(
      onTap: () {
        cuibt.AddItemChangeSearch();
      },
      child: Container(
        height: 40,
        width: 100,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white70,
        ),
        alignment: AlignmentDirectional.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(cuibt.Search ? Icons.clear : Icons.search,
                color: Colors.grey[900]),
            const SizedBox(width: 5),
            cuibt.Search
                ? const Text("Close",
                    style: TextStyle(
                      color: Colors.black,
                    ))
                : const Text("Search", style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  casherTable(context, CasherCuibt cuibt) {
    return DataTable(
        showCheckboxColumn: false,
        dataTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          color: Colors.black,
          fontSize: 20,
          fontStyle: FontStyle.italic,
        ),
        columnSpacing: 50,
        horizontalMargin: 10,
        border: TableBorder.all(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
            width: 2),
        columns: const [
          DataColumn(
            label: Text("num"),
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
          DataColumn(
            label: Text("Notes"),
          ),
        ],
        rows: cuibt.orders.asMap().entries.map((r) {
          var e = r.value;
          int index = r.key;
          return DataRow(
              onSelectChanged: (_) {
                FocusScope.of(context).requestFocus(cuibt.foucsCode);
                cuibt.InsertValueItem(
                  codeOFItem: "${e["Code"]}",
                  NameOFItem: "${e["Name"]}",
                  NumberOFItem: "${e["Num"]}",
                  id: e["id"],
                  Price: e["Price"],
                  index: index,
                );
              },
              cells: [
                DataCell(Text("${index + 1}")),
                DataCell(Text("${e["Name"]}")),
                DataCell(
                  Text("${e["Price"]}"),
                ),
                DataCell(
                  TextFormField(
                      onChanged: (_) {
                        cuibt.InsertValueItem(
                          codeOFItem: "${e["Code"]}",
                          NameOFItem: "${e["Name"]}",
                          NumberOFItem: "${e["Num"]}",
                          id: e["id"],
                          Price: e["Price"],
                          index: index,
                        );
                      },
                      autofocus: true,
                      cursorColor: Colors.green,
                      cursorRadius: const Radius.circular(10),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: cuibt.QuintteyControllers[e["Code"]],
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(cuibt.FocusControllers[e["Code"]]);
                      }),
                ),
                DataCell(Text("${e["TotalMoney"]}")),
                DataCell(TextFormField(
                  controller: cuibt.NoteControllers[e["Code"]],
                  decoration: InputDecoration(border: InputBorder.none),
                  focusNode: cuibt.FocusControllers[e["Code"]],
                  onFieldSubmitted: (_) {
                    cuibt.UpdeteNumAfterChange(context);
                    FocusScope.of(context).requestFocus(cuibt.foucsCode);
                  },
                ))
              ]);
        }).toList());
  }

  settingDialog(context, text, CasherCuibt cuibt) {
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
              content:
                  Text("$text", style: TextStyle(fontWeight: FontWeight.w900)),
              actions: [
                MaterialButton(
                  color: Colors.blueGrey[700],
                  onPressed: () {
                    Navigator.pop(context);
                    if (text == "This item not found")
                      cuibt.AlertItemNFound = false;
                    cuibt.cahnge();
                  },
                  child: const Text("Okay",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                if (text == "This item not found")
                  MaterialButton(
                    color: Colors.blueGrey[700],
                    onPressed: () {
                      cuibt.ChangePageIntoAddItem();
                      Navigator.pop(context);
                    },
                    child: const Text("Add item",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
              ],
            ),
          );
        });
  }

  orderDialog(context, CasherCuibt cuibt) {
    return showDialog(
        context: context,
        builder: (context) {
          return BlurryContainer(
            height: 800,
            width: 300,
            blur: 6,
            child: AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.white60,
              elevation: 30,
              title: Text("Number Order: ${cuibt.NumOrders.text}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontStyle: FontStyle.italic)),
              content: DataTable(
                  dataTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                  columnSpacing: 40,
                  horizontalMargin: 10,
                  border: TableBorder.all(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      width: 2),
                  columns: const [
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
                      label: Text("Total money"),
                    ),
                  ],
                  //for each and put what give true in another list and show it
                  rows: cuibt.recordedOrders.map((e) {
                    return DataRow(onLongPress: () {}, cells: [
                      DataCell(
                        Text("${e["Name"]}"),
                      ),
                      DataCell(
                        Text("${e["Price"]}"),
                      ),
                      DataCell(Text("${e["Num"]}")),
                      DataCell(Text("${e["TotalMoney"]}")),
                    ]);
                  }).toList()),
              actions: [
                MaterialButton(
                  color: Colors.blueGrey[700],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  width: 80,
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadiusDirectional.circular(20),
                  ),
                  child: Text("Total:${cuibt.TotalOfRecite}",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          );
        });
  }

  searchCasherTable(context) {
    var cuibt = CasherCuibt.get(context);
    return DataTable(
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
        //for each and put what give true in another list and show it
        rows: cuibt.SearchProducts.map((e) {
          return DataRow(
              onLongPress: () {
                cuibt.insertValueIntoControlar(e);
              },
              cells: [
                DataCell(Text("${e["Code"]}")),
                DataCell(
                  Text("${e["Name"]}"),
                ),
                DataCell(
                  Text("${e["Price"]}"),
                ),
                DataCell(Text("${e["QuantityInStore"]}")),
                DataCell(Text("${e["EndDate"]}")),
              ]);
        }).toList());
  }

  SearchCountenar(context, size) {
    var cuibt = CasherCuibt.get(context);
    return AnimatedOpacity(
      opacity: cuibt.Search ? 1 : 0,
      duration: Duration(milliseconds: 600),
      child: AbsorbPointer(
        absorbing: !cuibt.Search,
        child: MyContainer(
          Height: size.height * .75,
          Width: size.width * .4,
          Child: Scrollbar(
            controller: scrolllabel,
            child: ListView(
              physics: BouncingScrollPhysics(),
              controller: scrolllabel,
              children: [
                MyTextField(
                    Controlr: cuibt.NameOfSearch,
                    label: "Name",
                    hint: "Pepsi",
                    onChanged: (value) {
                      cuibt.getSearchItem(value);
                    }),
                SizedBox(
                  height: 30,
                ),
                searchCasherTable(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EnterButton extends Intent {}

class RemoveItem extends Intent {}

class RecordOrder extends Intent {}
