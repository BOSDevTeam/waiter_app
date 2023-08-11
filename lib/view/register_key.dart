import 'package:flutter/material.dart';

import '../value/app_color.dart';
import '../value/app_string.dart';

class RegisterKey extends StatefulWidget {
  const RegisterKey({super.key});

  @override
  State<RegisterKey> createState() => _RegisterKeyState();
}

class _RegisterKeyState extends State<RegisterKey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppString.registerKey,
        style: TextStyle(color: AppColor.primary),
      )),
    );
  }
}
