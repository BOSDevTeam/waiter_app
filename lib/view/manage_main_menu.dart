import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/manage_main_menu_provider.dart';
import 'package:waiter_app/widget/app_text.dart';
import '../database/database_helper.dart';

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
      context.read<ManageMainMenuProvider>().setMainMenu(value);
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
          Map<String, dynamic> data = provider.lstMainMenu[index];
          return ListTile(
            title: AppText(text: data["MainMenuName"]),
            trailing: Switch(
                value: data["IsOpen"] == null || data["IsOpen"] == 1
                    ? true
                    : false,
                onChanged: (result) {
                  Map<String, dynamic> mainMenu = {
                    'MainMenuID': data["MainMenuID"],
                    'MainMenuName': data["MainMenuName"],
                    'CounterID': data["CounterID"],
                    'IsOpen': result,
                  };
                  context
                      .read<ManageMainMenuProvider>()
                      .updateOpenClose(index, mainMenu);
                }),
          );
        });
  }
}
