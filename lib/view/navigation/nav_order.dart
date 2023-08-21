import 'package:flutter/material.dart';
import 'package:waiter_app/hive/hive_db.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../model/item_model.dart';
import '../../model/main_menu_model.dart';
import '../../model/menu_model.dart';
import '../../model/sub_menu_model.dart';
import '../../nav_drawer.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';

class NavOrder extends StatefulWidget {
  const NavOrder({super.key});

  @override
  State<NavOrder> createState() => _NavOrderState();
}

class _NavOrderState extends State<NavOrder> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<Map<String, dynamic>> lstMainMenu = [];
  List<Map<String, dynamic>> lstSubMenu = [];
  List<Map<String, dynamic>> lstItem = [];
  List<MenuModel> lstMenu = [];
  MenuModel mainMenu = MenuModel();
  MenuModel subMenu = MenuModel();

  /* List<Map<String, dynamic>> listMenu = [
    {
      "id": 1,
      "name": "Hair",
      "subMenu": [
        {"id": 1, "name": "ညှပ်", "subMenu": []},
        {"id": 2, "name": "လျှော်", "subMenu": []},
        {"id": 3, "name": "ဆေးဆိုး", "subMenu": []},
        {"id": 4, "name": "ဆံပင်ဖြောင့်", "subMenu": []}
      ]
    },
    {
      "id": 2,
      "name": "Face",
      "subMenu": [
        {"id": 5, "name": "Face", "subMenu": []}
      ]
    }
  ]; */

  @override
  void initState() {
    lstMainMenu = HiveDB.getMainMenu();
    lstSubMenu = HiveDB.getSubMenu();
    lstItem = HiveDB.getItem();

    for (int i = 0; i < lstMainMenu.length; i++) {
      mainMenu = MenuModel();
      mainMenu.id = lstMainMenu[i]["mainMenuId"].toString();
      mainMenu.name = lstMainMenu[i]["mainMenuName"];

      List<Map<String, dynamic>> subMenuList = lstSubMenu
          .where((element) =>
              element["mainMenuId"] == lstMainMenu[i]["mainMenuId"])
          .toList();
      for (int j = 0; j < subMenuList.length; j++) {
        subMenu = MenuModel();
        subMenu.id = subMenuList[j]["subMenuId"].toString();
        subMenu.name = subMenuList[j]["subMenuName"];
        
        List<Map<String, dynamic>> itemList = lstItem
            .where((element) =>
                element["subMenuId"] == subMenuList[j]["subMenuId"])
            .toList();
        for (int k = 0; k < itemList.length; k++) {
          MenuModel item = MenuModel();
          item.id = itemList[k]["itemId"];
          item.name = itemList[k]["itemName"];
          subMenu.list!.add(item);
        }

        mainMenu.list!.add(subMenu);

        lstMenu.add(mainMenu);

      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(AppString.order,
            style: TextStyle(color: AppColor.primary)),
        iconTheme: const IconThemeData(color: AppColor.primary),
        actions: [
          TextButton(
            onPressed: () {
              _key.currentState!.openEndDrawer();
            },
            child: const AppText(text: AppString.menu, size: 20),
          ),
        ],
      ),
      endDrawer: _drawer(lstMenu),
    );
  }

  Widget _drawer(List<MenuModel> data) {
    return Drawer(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(AppString.menu),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _buildMenuList(data[index]);
              },
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildMenuList(MenuModel list) {
    if (list.list!.isEmpty) {
      return Builder(builder: (context) {
        return ListTile(
            leading: const SizedBox(width: 10),
            title: Text(list.name.toString()));
      });
    } else {
      return ExpansionTile(
        leading: const Icon(Icons.arrow_drop_down),
        title: Text(list.name.toString()),
        children: list.list!.map(_buildMenuList).toList(),
      );
    }
  }
}
