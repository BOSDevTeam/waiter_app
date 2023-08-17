import 'package:flutter/material.dart';

import '../../nav_drawer.dart';
import '../../value/app_string.dart';

class NavTable extends StatefulWidget {
  const NavTable({super.key});

  @override
  State<NavTable> createState() => _NavTableState();
}

class _NavTableState extends State<NavTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(title: const Text(AppString.table)),
    );
  }
}