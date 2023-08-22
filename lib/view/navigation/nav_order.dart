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
  MenuModel mainMenu = MenuModel(list: []);
  MenuModel subMenu = MenuModel(list: []);

  @override
  void initState() {
    super.initState();
    lstMainMenu = HiveDB.getMainMenu();
    lstSubMenu = HiveDB.getSubMenu();
    lstItem = HiveDB.getItem();

    for (int i = 0; i < lstMainMenu.length; i++) {
      mainMenu = MenuModel(list: []);
      mainMenu.id = lstMainMenu[i]["mainMenuId"].toString();
      mainMenu.name = lstMainMenu[i]["mainMenuName"];
      mainMenu.type = 1;

      List<Map<String, dynamic>> subMenuList = lstSubMenu
          .where((element) =>
              element["mainMenuId"] == lstMainMenu[i]["mainMenuId"])
          .toList();
      for (int j = 0; j < subMenuList.length; j++) {
        subMenu = MenuModel(list: []);
        subMenu.id = subMenuList[j]["subMenuId"].toString();
        subMenu.name = subMenuList[j]["subMenuName"];
        subMenu.type = 2;

        List<Map<String, dynamic>> itemList = lstItem
            .where((element) =>
                element["subMenuId"] == subMenuList[j]["subMenuId"])
            .toList();
        for (int k = 0; k < itemList.length; k++) {
          MenuModel item = MenuModel(list: []);
          item.id = itemList[k]["itemId"];
          item.name = itemList[k]["itemName"];
          item.type = 3;
          subMenu.list.add(item);
        }

        mainMenu.list.add(subMenu);
      }
      lstMenu.add(mainMenu);
    }
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
      body: Container(
        color: AppColor.grey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Material(
                            shape: const CircleBorder(
                                side: BorderSide(
                                    width: 2, color: AppColor.primary)),
                            child: InkWell(
                              splashColor: AppColor.primary300,
                              onTap: () {},
                              child: const SizedBox(
                                width: 60,
                                height: 60,
                                child: Icon(
                                  Icons.table_bar,
                                  color: AppColor.primary500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          children: [
                            AppText(
                              text: AppString.table,
                              size: 16,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AppText(
                              text: "12",
                              color: AppColor.primary,
                              size: 20,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: AppColor.grey,
                    width: 1,
                    height: 60,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Material(
                            shape: const CircleBorder(
                                side: BorderSide(
                                    width: 2, color: AppColor.primary)),
                            child: InkWell(
                              splashColor: AppColor.primary300,
                              onTap: () {},
                              child: const SizedBox(
                                width: 60,
                                height: 60,
                                child: Icon(
                                  Icons.people,
                                  color: AppColor.primary500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          children: [
                            AppText(
                              text: AppString.customers,
                              size: 16,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AppText(
                              text: "-",
                              color: AppColor.primary,
                              size: 20,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: const AppText(
                  text: AppString.orders,
                  color: AppColor.primary500,
                )),
            const Divider()
          ],
        ),
      ),
    );
  }

  Widget _drawer(List<MenuModel> data) {
    return Drawer(
      shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
            ),
        child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const AppText(text:AppString.menu),
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
    if (list.list.isEmpty) {
      return Builder(builder: (context) {
        return ListTile(
            leading: const SizedBox(width: 10),
            //textColor: _menuColor(list.type),
            title: Text(list.name.toString()));
      });
    } else {
      return ExpansionTile(
        leading: const Icon(Icons.food_bank),
        //textColor: _menuColor(list.type),
        title: Text(list.name.toString()),
        children: list.list.map(_buildMenuList).toList(),
      );
    }
  }

  Color _menuColor(int? type) {
    if (type == 1) {
      return Colors.red;
    } else if (type == 2) {
      return Colors.green;
    } else if (type == 3) {
      return Colors.blue;
    }
    return Colors.yellow;
  }
}
