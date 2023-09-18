import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/provider/login_provider.dart';
import 'package:waiter_app/value/time_type.dart';
import 'package:waiter_app/view/customer_entry.dart';
import 'package:waiter_app/view/dialog/dialog_number.dart';
import 'package:waiter_app/value/number_type.dart';
import 'package:waiter_app/widget/app_text.dart';
import 'package:waiter_app/view/table_situation.dart';

import '../../provider/order_provider.dart';
import '../../model/menu_model.dart';
import '../../model/order_model.dart';
import '../../nav_drawer.dart';
import '../../provider/setting_provider.dart';
import '../../value/app_color.dart';
import '../../value/app_constant.dart';
import '../../value/app_string.dart';
import '../dialog/dialog_taste.dart';
import '../dialog/dialog_time.dart';

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
  bool isHideSalePriceInItem = false;

  @override
  void initState() {
    super.initState();

    context.read<SettingProvider>().getHideSalePriceInItem().then((value) {
      isHideSalePriceInItem = value ?? false;
    });

    context.read<SettingProvider>().getAddStartTimeInOrder().then((value) {
      if (value == true) {
        context.read<OrderProvider>().setIsAddStartTimeInOrder(true);
        context
            .read<OrderProvider>()
            .setStartTime(DateFormat.jm().format(DateTime.now()));
      }
    });

    DatabaseHelper().getMainMenu().then((value) {
      lstMainMenu = value;
      DatabaseHelper().getSubMenu().then((value) {
        lstSubMenu = value;
        DatabaseHelper().getItem().then((value) {
          lstItem = value;
          for (int i = 0; i < lstMainMenu.length; i++) {
            mainMenu = MenuModel(list: []);
            mainMenu.id = lstMainMenu[i]["MainMenuID"].toString();
            mainMenu.name = lstMainMenu[i]["MainMenuName"];
            mainMenu.type = 1;

            List<Map<String, dynamic>> subMenuList = lstSubMenu
                .where((element) =>
                    element["MainMenuID"] == lstMainMenu[i]["MainMenuID"])
                .toList();
            for (int j = 0; j < subMenuList.length; j++) {
              subMenu = MenuModel(list: []);
              subMenu.id = subMenuList[j]["SubMenuID"].toString();
              subMenu.name = subMenuList[j]["SubMenuName"];
              subMenu.type = 2;

              List<Map<String, dynamic>> itemList = lstItem
                  .where((element) =>
                      element["SubMenuID"] == subMenuList[j]["SubMenuID"])
                  .toList();
              for (int k = 0; k < itemList.length; k++) {
                MenuModel item = MenuModel(list: []);
                item.id = itemList[k]["ItemID"];
                item.name = itemList[k]["ItemName"];
                item.incomdId = itemList[k]["IncomeID"];
                item.salePrice = itemList[k]["SalePrice"];
                item.systemId = itemList[k]["SystemID"];
                item.counterId = itemList[k]["CounterID"];
                item.sType = itemList[k]["SType"];
                item.noDiscount = itemList[k]["NoDiscount"];
                item.itemDiscount = itemList[k]["ItemDiscount"];
                item.type = 3;

                subMenu.list.add(item);
              }

              mainMenu.list.add(subMenu);
            }
            lstMenu.add(mainMenu);
          }
          context.read<OrderProvider>().setMenu(lstMenu);
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
      endDrawer: Consumer<OrderProvider>(builder: (context, provider, child) {
        return _drawer(provider.lstMenu);
      }),
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
                                  return const TableSituation(isFromNav: false);
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
                              onTap: () {
                                if (context
                                        .read<OrderProvider>()
                                        .selectedTable["tableId"] !=
                                    0) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CustomerEntry(
                                        isFromOrderDetail: false);
                                  }));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: AppString.selectTable);
                                }
                              },
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
                        Column(
                          children: [
                            const AppText(
                              text: AppString.customers,
                              size: 16,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Consumer<OrderProvider>(
                                builder: (context, provider, child) {
                              return AppText(
                                text: provider
                                            .customerNumber["totalCustomer"] ==
                                        0
                                    ? "-"
                                    : provider.customerNumber["totalCustomer"]
                                        .toString(),
                                color: AppColor.primary,
                                size: 20,
                                fontWeight: FontWeight.bold,
                              );
                            }),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    text: AppString.orders,
                    color: AppColor.primary500,
                  ),
                  Consumer<OrderProvider>(builder: (context, provider, child) {
                    return provider.isAddStartTimeInOrder
                        ? Row(
                            children: [
                              const AppText(
                                text: AppString.startTime,
                                color: AppColor.primary500,
                                size: 14,
                              ),
                              Consumer<OrderProvider>(
                                  builder: (context, provider, child) {
                                return AppText(
                                  text: provider.startTime,
                                  color: AppColor.primary,
                                  size: 14,
                                );
                              }),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    splashColor: Colors.white,
                                    onTap: () {
                                      showDialog<void>(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const DialogTime(
                                              timeType: TimeType.orderStartTime,
                                            );
                                          });
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: AppColor.primary500,
                                      ),
                                    )),
                              )
                            ],
                          )
                        : Container();
                  }),
                ],
              ),
            ),
            const Divider(),
            Consumer<OrderProvider>(builder: (context, provider, child) {
              return Expanded(child: _order(provider));
            }),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<LoginProvider>()
                        .getLoginWaiter()
                        .then((waiterModel) {
                      context
                          .read<SettingProvider>()
                          .getAddTimeByItemInOrder()
                          .then((isAddTimeByItemInOrder) {
                        context
                            .read<SettingProvider>()
                            .getNotPutItemAndTasteInOrder()
                            .then((notPutTogetherItemNameAndTaste) {
                          if (context.read<OrderProvider>().validateOrder()) {
                            context.read<OrderProvider>().sendOrder(
                                waiterModel,
                                isAddTimeByItemInOrder ?? false,
                                notPutTogetherItemNameAndTaste ?? false);
                          }
                        });
                      });
                    });
                  },
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      data.number != 0
                          ? AppText(
                              text: "#${data.number}",
                              fontFamily: "BOS",
                              color: AppColor.primary400,
                            )
                          : const SizedBox(),
                      data.number != 0
                          ? const SizedBox(
                              width: 5,
                            )
                          : const SizedBox(),
                      Expanded(
                          child: Text(
                        data.itemName,
                        style: const TextStyle(fontFamily: "BOS"),
                        maxLines: null,
                      ))
                    ],
                  ),
                ),
                data.commonTaste.isNotEmpty || data.tasteByItem.isNotEmpty
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data.commonTaste.isNotEmpty
                              ? Expanded(
                                  child: Text(
                                  data.commonTaste.toString(),
                                  style: const TextStyle(
                                      color: AppColor.primary500,
                                      fontFamily: "BOS"),
                                  maxLines: null,
                                ))
                              : Container(),
                          data.tasteByItem.isNotEmpty
                              ? Expanded(
                                  child: Text(
                                  data.tasteByItem.toString(),
                                  style: const TextStyle(
                                      color: AppColor.primary500,
                                      fontFamily: "BOS"),
                                  maxLines: null,
                                ))
                              : Container(),
                        ],
                      )
                    : Container(),
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
                          onPressed: () {
                            showDialog<void>(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return DialogNumber(
                                    orderIndex: index,
                                    numberType: NumberType.quantityNumber,
                                  );
                                });
                          },
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
                        onTap: () {
                          Fluttertoast.showToast(msg: AppString.pressAndHoldIcon);
                        },
                        onTapDown: (details) => _getTapPosition(details),
                        onLongPress: () {
                          context
                              .read<SettingProvider>()
                              .getUseTasteByMenu()
                              .then((value) {
                            _showContextMenu(
                                context, index, data.incomdId, value ?? false);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColor.grey)),
                          child: const Icon(
                            Icons.touch_app,
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

  void _showContextMenu(BuildContext context, int index, int incomeId,
      bool isUseTasteByMenu) async {
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
          PopupMenuItem(
              enabled: isUseTasteByMenu,
              value: AppString.tasteByMenu,
              child: const Text(AppString.tasteByMenu)),
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
                incomeId: 0,
              );
            });
        break;
      case AppString.tasteByMenu:
        DatabaseHelper().isHasTasteMulti(incomeId).then((value) {
          if (value) {
            showDialog<void>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return DialogTaste(
                    orderIndex: index,
                    isTasteMulti: true,
                    incomeId: incomeId,
                  );
                });
          } else {
            Fluttertoast.showToast(msg: AppString.noTasteByMenuForItem);
          }
        });
        break;
      case AppString.numberOrderItem:
        showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return DialogNumber(
                orderIndex: index,
                numberType: NumberType.orderItemNumber,
              );
            });
        break;
      case AppString.delete:
        deleteOrder(index);
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
          title: Text(
            menuModel.name.toString(),
            style:
                const TextStyle(color: AppColor.primaryDark, fontFamily: "BOS"),
            maxLines: null,
          ),

          subtitle: !isHideSalePriceInItem && menuModel.type == 3
              ? AppText(
                  text: AppConstant.formatter.format(menuModel.salePrice),
                  size: 14,
                  color: AppColor.primary)
              : const SizedBox(),
          onTap: () {
            if (menuModel.type == 3) {
              //_key.currentState!.closeEndDrawer();
              int index = addToOrder(menuModel);
              showTasteInSelectItem(index, menuModel.incomdId ?? 0);
            }
          },
        );
      });
    } else {
      return ExpansionTile(
        leading: menuModel.type == 1
            ? const Icon(Icons.food_bank)
            : const Icon(
                Icons.menu_book,
                size: 20,
                color: AppColor.primary400,
              ),
        //textColor: _menuColor(list.type),
        title: Text(
          menuModel.name.toString(),
          style:
              const TextStyle(color: AppColor.primaryDark, fontFamily: "BOS"),
          maxLines: null,
        ),

        children: menuModel.list.map(_buildMenuList).toList(),
      );
    }
  }

  int addToOrder(MenuModel data) {
    int index = context.read<OrderProvider>().addOrder(OrderModel(
        itemId: data.id!,
        itemName: data.name!,
        quantity: 1,
        incomdId: data.incomdId ?? 0,
        salePrice: data.salePrice,
        systemId: data.systemId,
        counterId: data.counterId,
        sType: data.sType,
        noDiscount: data.noDiscount,
        itemDiscount: data.itemDiscount));

    Fluttertoast.showToast(msg: AppString.orderAdded);

    return index;
  }

  void showTasteInSelectItem(int index, int incomeId) {
    context.read<SettingProvider>().getShowTasteInSelectItem().then(
      (value) {
        if (value != null && value == true) {
          context.read<SettingProvider>().getUseTasteByMenu().then((value) {
            if (value == null || value == false) {
              showDialog<void>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return DialogTaste(
                      orderIndex: index,
                      isTasteMulti: false,
                      incomeId: 0,
                    );
                  });
            } else {
              DatabaseHelper().isHasTasteMulti(incomeId).then((value) {
                if (value) {
                  showDialog<void>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return DialogTaste(
                          orderIndex: index,
                          isTasteMulti: true,
                          incomeId: incomeId,
                        );
                      });
                } 
              });
            }
          });
        }
      },
    );
  }

  void deleteOrder(int index) {
    context.read<OrderProvider>().deleteOrder(index);
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
