import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/widget/app_text.dart';
import 'package:waiter_app/view/table_situation.dart';

import '../../provider/order_provider.dart';
import '../../model/item_model.dart';
import '../../model/main_menu_model.dart';
import '../../model/menu_model.dart';
import '../../model/order_model.dart';
import '../../model/sub_menu_model.dart';
import '../../nav_drawer.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';
import '../dialog/dialog_taste.dart';

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
  Offset _tapPosition = Offset.zero;

  @override
  void initState() {
    super.initState();

    DatabaseHelper().getMainMenu().then((value) {
      lstMainMenu = value;
      DatabaseHelper().getSubMenu().then((value) {
        lstSubMenu = value;
        DatabaseHelper().getItem().then((value) {
          lstItem = value;
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
        });
      });
    });
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
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const TableSituation();
                                }));
                              },
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
                        Flexible(
                          child: Column(
                            children: [
                              const AppText(
                                text: AppString.table,
                                size: 16,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Consumer<OrderProvider>(
                                  builder: (context, provider, child) {
                                return AppText(
                                  text: provider.selectedTable["tableName"],
                                  color: AppColor.primary,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BOS",
                                );
                              }),
                            ],
                          ),
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
            const Divider(),
            Consumer<OrderProvider>(builder: (context, provider, child) {
              return Expanded(child: _order(provider));
            }),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 20, bottom: 20),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                  child: const Text(AppString.sendOrder)),
            )
          ],
        ),
      ),
    );
  }

  Widget _order(OrderProvider provider) {
    return ListView.builder(
        itemCount: provider.lstOrder.length,
        itemBuilder: (context, index) {
          OrderModel data = provider.lstOrder[index];
          return Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    AppText(
                      text: data.itemName,
                      fontFamily: "BOS",
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    AppText(
                        text: data.commonTaste.toString(),
                        fontFamily: "BOS",
                        size: 14,
                        color: Colors.blue),
                    const SizedBox(
                      width: 5,
                    ),
                    AppText(
                        text: data.tasteByItem.toString(),
                        fontFamily: "BOS",
                        size: 14,
                        color: Colors.green)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              context
                                  .read<OrderProvider>()
                                  .decreaseQuantity(index);
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: AppColor.primary400,
                            ),
                            style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side:
                                        const BorderSide(color: AppColor.grey),
                                    borderRadius: BorderRadius.circular(5)))),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                              side: MaterialStatePropertyAll(
                                  BorderSide(color: AppColor.grey)),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(10))),
                          child: Text(data.quantity.toString()),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<OrderProvider>()
                                  .increaseQuantity(index);
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side:
                                        const BorderSide(color: AppColor.grey),
                                    borderRadius: BorderRadius.circular(5)),
                                backgroundColor: AppColor.primary400))
                      ],
                    ),
                    InkWell(
                        onTapDown: (details) => _getTapPosition(details),
                        onLongPress: () => _showContextMenu(context, index),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColor.grey)),
                          child: const Icon(
                            Icons.more_horiz,
                            color: AppColor.primary400,
                          ),
                        )),
                  ],
                )
              ],
            ),
          );
        });
  }

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context, int index) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    final result = await showMenu(
        context: context,

        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: AppString.commonTaste,
            child: Text(AppString.commonTaste),
          ),
          const PopupMenuItem(
            value: AppString.tasteByItem,
            child: Text(AppString.tasteByItem),
          ),
          const PopupMenuItem(
            value: AppString.numberOrderItem,
            child: Text(AppString.numberOrderItem),
          ),
          const PopupMenuItem(
            value: AppString.delete,
            child: Text(AppString.delete),
          ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case AppString.commonTaste:
        showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return DialogTaste(
                orderIndex: index,
                isTasteMulti: false,
              );
            });
        break;
      case AppString.tasteByItem:
        showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return DialogTaste(
                orderIndex: index,
                isTasteMulti: true,
              );
            });
        break;
      case AppString.numberOrderItem:
        debugPrint('number order item');
        break;
      case AppString.delete:
        debugPrint('delete');
        break;
    }
  }

  Widget _drawer(List<MenuModel> data) {
    return Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const AppText(text: AppString.menu),
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

  Widget _buildMenuList(MenuModel menuModel) {
    if (menuModel.list.isEmpty) {
      return Builder(builder: (context) {
        return ListTile(
          leading: const SizedBox(width: 10),
          //textColor: _menuColor(list.type),
          title: AppText(
            text: menuModel.name.toString(),
            fontFamily: "BOS",
          ),
          onTap: () {
            if (menuModel.type == 3) {
              addToOrder(menuModel);
            }
          },
        );
      });
    } else {
      return ExpansionTile(
        leading: const Icon(Icons.food_bank),
        //textColor: _menuColor(list.type),
        title: AppText(
          text: menuModel.name.toString(),
          fontFamily: "BOS",
        ),
        children: menuModel.list.map(_buildMenuList).toList(),
      );
    }
  }

  void addToOrder(MenuModel data) {
    context.read<OrderProvider>().addOrder(
        OrderModel(itemId: data.id!, itemName: data.name!, quantity: 1));
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
