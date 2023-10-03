import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/register_provider.dart';
import 'package:waiter_app/view/data_downloading.dart';

import '../value/app_color.dart';
import '../value/app_string.dart';

class RegisterKey extends StatefulWidget {
  const RegisterKey({super.key});

  @override
  State<RegisterKey> createState() => _RegisterKeyState();
}

class _RegisterKeyState extends State<RegisterKey> {
  static const channel = MethodChannel('com.example.getmac');

  @override
  void initState() {
    getMacAddress().then((value) {
      context.read<RegisterProvider>().key = generateKey(value);
      context.read<RegisterProvider>().macAddressController.text = value;
    });

    super.initState();
  }

  Future<String> getMacAddress() async {
    return await channel.invokeMethod('getMAC'); // a method that calls android code
  }

  String generateKey(String macAddress) {
    String key = "";
    if (macAddress.isNotEmpty) {
      List<String> list = macAddress.split(":");
      String strMacAddress = list.join("");
      String keyMacAddress = "blue${strMacAddress}ocean016";
      String reverseKeyMacAddress = reverseString(keyMacAddress);
      String firstKey = reverseKeyMacAddress.substring(0, 4);
      String secondKey = reverseKeyMacAddress.substring(4, 8);
      String thirdKey = reverseKeyMacAddress.substring(8, 12);
      String fourthKey = reverseKeyMacAddress.substring(12, 16);
      String fifthKey = reverseKeyMacAddress.substring(16, 20);
      String sixKey = reverseKeyMacAddress.substring(20, 24);
      key = "$firstKey-$secondKey-$thirdKey-$fourthKey-$fifthKey-$sixKey";
    }

    return key;
  }

  String reverseString(String input) {
    String reversed = '';
    for (int i = input.length - 1; i >= 0; i--) {
      reversed += input[i];
    }
    return reversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              controller: context.read<RegisterProvider>().macAddressController,
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
              controller: context.read<RegisterProvider>().keyController,
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
                    if (context.read<RegisterProvider>().isValidateKey()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(AppString.successfullyKeyRegistered)));
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const DataDownloading();
                      }), (route) => false);
                    }
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
