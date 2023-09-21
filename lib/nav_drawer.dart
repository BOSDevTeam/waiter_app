import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/value/app_string.dart';
import 'package:waiter_app/value/password_type.dart';
import 'package:waiter_app/view/dialog/dialog_password.dart';
import 'package:waiter_app/widget/app_text.dart';

import 'value/app_color.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String _waiterName = "";

  @override
  void initState() {
    getWaiterName().then((value) {
      if (value != null) {
        setState(() {
          _waiterName = value;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(""),
            accountEmail: AppText(
              text: _waiterName,
              fontFamily: "BOS",
              color: Colors.white,
            ),
            currentAccountPicture: Image.asset(
              "assets/images/launcher.png",
              height: 100,
              width: 100,
            ),
            decoration: const BoxDecoration(
              color: AppColor.primary,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.list,
              color: AppColor.primaryDark,
            ),
            title: const AppText(text: AppString.order),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/nav_order');
            },
          ),
          const Divider(),
          ListTile(
            leading:
                const Icon(Icons.table_restaurant, color: AppColor.primaryDark),
            title: const AppText(text: AppString.table),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/nav_table');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColor.primaryDark),
            title: const AppText(text: AppString.setting),
            onTap: () {
              showDialog<void>(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return const DialogPassword(
                      passwordType: PasswordType.settingPassword,
                    );
                  });
            },
          ),
          const Divider(),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const AppText(
                      text: AppString.exit,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String?> getWaiterName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("WaiterName");
  }
}
