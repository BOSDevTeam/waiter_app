import 'package:flutter/material.dart';

import '../../nav_drawer.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';

class NavSetting extends StatefulWidget {
  const NavSetting({super.key});

  @override
  State<NavSetting> createState() => _NavSettingState();
}

class _NavSettingState extends State<NavSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(AppString.setting, style: TextStyle(color: AppColor.primary)),
        iconTheme: const IconThemeData(color: AppColor.primary),
      ),
    );
  }
}