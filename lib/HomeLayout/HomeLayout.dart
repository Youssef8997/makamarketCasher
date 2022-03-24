import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/Compoandis/Comp.dart';
import 'package:untitled6/cuibt/State.dart';
import 'package:untitled6/cuibt/cuibt.dart';
import 'package:untitled6/models/Casherpage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CasherCuibt,CasherState>
      (
        listener: (context,state){

        },
        builder: (context,state){
          var size=MediaQuery.of(context).size;
          var cuibt=CasherCuibt.get(context);
          return AdvancedDrawer(
            backdropColor: Colors.blueGrey,
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            rtlOpening: false,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(20, 20)
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Shortcuts(
              shortcuts:{LogicalKeySet(LogicalKeyboardKey.tab):ReturnToPage()} ,
              child: Actions(
                actions: {ReturnToPage:CallbackAction<ReturnToPage>(onInvoke: (intent)=>cuibt.ChangePageIntoCashier())},
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      color: Colors.teal,
                      onPressed: _handleMenuButtonPressed,
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? Icons.clear : Icons.menu,
                              key: ValueKey<bool>(value.visible),
                            ),
                          );
                        },
                      ),
                    ),

                  ),
                  body: Stack(children: [
                    Wallpaper(size),
                    cuibt.body[cuibt.MyIndex]
                  ] ),
                ),
              ),
            ),
            drawer: SafeArea(
              child: ListTileTheme(
                textColor: Colors.white,
                iconColor: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius:60,
                      backgroundImage: AssetImage("Asset/Market Logo.png"),

                    ),
                    ListTile(
                      selected: cuibt.MyIndex==1?true:false,
                      selectedColor: Colors.cyan,
                      onTap: () {
                        if(cuibt.MyIndex!=1)
                        cuibt.ChangeMyIndex(1);
                      _advancedDrawerController.hideDrawer();
                      },
                      leading: Icon(Icons.add_business_rounded),
                      title: Text('اضافه صنف',style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      selected: cuibt.MyIndex==2?true:false,
                      selectedColor: Colors.cyan,
                      onTap: () {
                        if(cuibt.MyIndex!=2)
                        cuibt.ChangeMyIndex(2);
                        _advancedDrawerController.hideDrawer();
                        },

                      leading:const CircleAvatar(
                        radius:15,
                        backgroundColor: Colors.blueGrey,
                        backgroundImage: AssetImage("Asset/gard.png"),

                      ),
                      title: const Text('جرد الاصناف'),
                    ),
                    ListTile(
                      selected: cuibt.MyIndex==3?true:false,
                      selectedColor: Colors.cyan,
                      onTap: () {
                        if(cuibt.MyIndex!=3)
                        cuibt.ChangeMyIndex(3);
                        _advancedDrawerController.hideDrawer();
                        },
                      leading:const CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius:15,
                        backgroundImage: AssetImage("Asset/Suppliers.png"),

                      ),
                      title: const Text('الموردين'),
                    ),
                    ListTile(
                      selected: cuibt.MyIndex==4?true:false,
                      selectedColor: Colors.cyan,
                      onTap: () {    if(cuibt.MyIndex!=4)
                        cuibt.ChangeMyIndex(4);
                      _advancedDrawerController.hideDrawer();},
                      leading:const CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor:Colors.blueGrey ,
                        radius:15,
                        backgroundImage: AssetImage("Asset/working time.png"),

                      ),
                      title: const Text('مرتجع'),
                    ),
                    ListTile(
                      selected: cuibt.MyIndex==5?true:false,
                      selectedColor: Colors.cyan,
                      onTap: () {    if(cuibt.MyIndex!=5)
                        cuibt.ChangeMyIndex(5);
                      _advancedDrawerController.hideDrawer();},
                      leading:const CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor:Colors.blueGrey ,
                        radius:15,
                        backgroundImage: AssetImage("Asset/Monny logo.jpg"),

                      ),
                      title: const Text('تصفير ورديه'),
                    ),
                    ListTile(
                      selected: cuibt.MyIndex==6?true:false,
                      selectedColor: Colors.cyan,
                      onTap: () {    if(cuibt.MyIndex!=6)
                        cuibt.ChangeMyIndex(6);
                      _advancedDrawerController.hideDrawer();},
                      leading:const CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        foregroundColor:Colors.blueGrey ,
                        radius:15,
                        backgroundImage: AssetImage("Asset/Store.jpg"),

                      ),
                      title: const Text('مخزن'),
                    ),
                    ListTile(
                      onTap: () {},
                      leading:const Icon(Icons.exit_to_app),
                      title: const Text('تسجيل خروج'),
                    ),


                  ],
                ),
              ),
            ),
          );
        }
    );


  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
class ReturnToPage extends Intent{}