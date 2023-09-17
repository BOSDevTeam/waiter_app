import 'package:flutter/material.dart';
import 'package:waiter_app/controller/register_controller.dart';
import 'package:waiter_app/view/data_downloading.dart';

import '../value/app_color.dart';
import '../value/app_string.dart';

class RegisterKey extends StatefulWidget {
  const RegisterKey({super.key});

  @override
  State<RegisterKey> createState() => _RegisterKeyState();
}

class _RegisterKeyState extends State<RegisterKey> {
  final registerController = RegisterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppString.registerKey,
        style: TextStyle(color: AppColor.primary),
      )),
      body: Container(
        color: AppColor.grey,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
        child: Column(
          children: [
            TextFormField(
              controller: registerController.macAddressController,
              style: const TextStyle(color: AppColor.primaryDark),
              enabled: false,
              decoration: const InputDecoration(
                  labelText: AppString.macAddress,
                  labelStyle: TextStyle(color: AppColor.primary500),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: registerController.keyController,
              style: const TextStyle(color: AppColor.primaryDark),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: AppString.enterKey,
                  labelStyle: TextStyle(color: AppColor.primary500),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                  onPressed: () {  
                    Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const DataDownloading();
                          }), (route) => false);                                   
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 30, left: 30),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                  child: const Text(AppString.confirm)),
            )
          ],
        ),
      ),
    );
  }
}
