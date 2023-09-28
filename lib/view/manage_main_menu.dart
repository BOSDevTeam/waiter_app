import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/manage_main_menu_provider.dart';
import 'package:waiter_app/widget/app_text.dart';
import '../database/database_helper.dart';

import '../model/main_menu_model.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class ManageMainMenu extends StatefulWidget {
  const ManageMainMenu({super.key});

  @override
  State<ManageMainMenu> createState() => _ManageMainMenuState();
}

class _ManageMainMenuState extends State<ManageMainMenu> {
  @override
  void initState() {
    DatabaseHelper().getMainMenu().then((value) {
      if (value.isNotEmpty) {
        List<MainMenuModel> lstMainMenu = [];
        for (int i = 0; i < value.length; i++) {
          lstMainMenu.add(MainMenuModel(
              mainMenuId: value[i]["MainMenuID"],
              mainMenuName: value[i]["MainMenuName"],
              counterId: value[i]["CounterID"],
              isOpen: value[i]["IsOpen"]));
        }
        context.read<ManageMainMenuProvider>().setMainMenu(lstMainMenu);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppString.manageMainMenu,
        style: TextStyle(color: AppColor.primary),
      )),
      body: Container(
        color: AppColor.grey,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: AppString.mainMenu,
                    color: AppColor.primary500,
                  ),
                  AppText(
                    text: AppString.openClose,
                    color: AppColor.primary400,
                    size: 14,
                  )
                ],
              ),
            ),
            const Divider(),
            Consumer<ManageMainMenuProvider>(
                builder: (context, provider, child) {
              return Expanded(child: _mainMenu(provider));
            }),
          ],
        ),
      ),
    );
  }

  Widget _mainMenu(ManageMainMenuProvider provider) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.lstMainMenu.length,
        itemBuilder: (context, index) {
          MainMenuModel data = provider.lstMainMenu[index];
          return ListTile(
            title: Text(
              data.mainMenuName,
              style: const TextStyle(
                  color: AppColor.primaryDark, fontFamily: "BOS", fontSize: 16),
              maxLines: null,
            ),
            trailing: Switch(
                value: data.isOpen == null || data.isOpen == 1 ? true : false,
                onChanged: (result) {
                  DatabaseHelper().updateMainMenu({
                    "MainMenuID": data.mainMenuId,
                    "MainMenuName": data.mainMenuName,
                    "CounterID": data.counterId,
                    "IsOpen": result ? 1 : 0
                  }).then((value) {
                    if (value != 0) {
                      result
                          ? Fluttertoast.showToast(msg: AppString.openedMenu)
                          : Fluttertoast.showToast(msg: AppString.closedMenu);
                      context
                          .read<ManageMainMenuProvider>()
                          .updateOpenClose(index, result ? 1 : 0);
                    } else {
                      Fluttertoast.showToast(msg: AppString.somethingWentWrong);
                    }
                  });
                }),
          );
        });
  }
}
