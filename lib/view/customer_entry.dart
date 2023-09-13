import 'package:flutter/material.dart';

import '../value/app_color.dart';
import '../value/app_string.dart';

class CustomerEntry extends StatefulWidget {
  const CustomerEntry({super.key});

  @override
  State<CustomerEntry> createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.addCustomerNumber,
            style: TextStyle(color: AppColor.primary)),
      ),
    );
  }
}