import 'package:flutter/material.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../nav_drawer.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';

class NavOrder extends StatefulWidget {
  const NavOrder({super.key});

  @override
  State<NavOrder> createState() => _NavOrderState();
}

class _NavOrderState extends State<NavOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(AppString.order, style: TextStyle(color: AppColor.primary)),
        iconTheme: const IconThemeData(color: AppColor.primary),
        actions: [
          TextButton(
                    onPressed: () {},
                    child: const AppText(
                     text: AppString.menu,
                     size: 20
                    ),
                  ),
        ],
      ),
    );
  }
}
