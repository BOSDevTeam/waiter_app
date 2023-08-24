import 'package:flutter/material.dart';

import '../value/app_color.dart';
import '../value/app_string.dart';

class Table extends StatefulWidget {
  const Table({super.key});

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppString.tableSituation,
        style: TextStyle(color: AppColor.primary),
      )),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
