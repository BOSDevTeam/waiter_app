import 'package:flutter/material.dart';
import 'package:waiter_app/value/app_string.dart';
import 'package:waiter_app/widget/app_text.dart';

import 'value/app_color.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(""),
            accountEmail: Text("Waiter Name"),
            currentAccountPicture: Image.asset(
              "assets/images/launcher.png",
              height: 100,
              width: 100,
            ),
            decoration: const BoxDecoration(
              color: AppColor.primary,
            ),
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: AppColor.primary300,
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
              Navigator.of(context).pushReplacementNamed('/nav_setting');
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
                    onPressed: () {},
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
}
