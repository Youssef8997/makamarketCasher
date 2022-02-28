import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
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
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Container(),
      ),
      drawer: SafeArea(
        child: Container(
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
                  onTap: () {},
                  leading: Icon(Icons.add_business_rounded),
                  title: Text('اضافه صنف',style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  onTap: () {},
                  leading:const CircleAvatar(
                    radius:15,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: AssetImage("Asset/gard.png"),

                  ),
                  title: const Text('جرد الاصناف'),
                ),
                ListTile(
                  onTap: () {},
                  leading:const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius:15,
                    backgroundImage: AssetImage("Asset/Suppliers.png"),

                  ),
                  title: const Text('الموردين'),
                ),
                ListTile(
                  onTap: () {},
                  leading:const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor:Colors.blueGrey ,
                    radius:15,
                    backgroundImage: AssetImage("Asset/working time.png"),

                  ),
                  title: const Text('حضور وانصراف الموظفين'),
                ),
                ListTile(
                  onTap: () {},
                  leading:const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor:Colors.blueGrey ,
                    radius:15,
                    backgroundImage: AssetImage("Asset/Monny logo.jpg"),

                  ),
                  title: const Text('تصفير ورديه'),
                ),
                ListTile(
                  onTap: () {},
                  leading:const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor:Colors.blueGrey ,
                    radius:15,
                    backgroundImage: AssetImage("Asset/Admin logo.jpg"),

                  ),
                  title: const Text('Admin'),
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
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}