import 'package:flutter/material.dart';
import 'package:waiter_app/value/app_string.dart';

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
            leading: const Icon(Icons.list),
            title: const Text(AppString.order),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/nav_order');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.table_restaurant),
            title: const Text(AppString.table),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/nav_table');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text(AppString.setting),
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
                    child: const Text(
                      AppString.exit,
                      style: TextStyle(color: AppColor.primaryDark),
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
