import 'package:flutter/material.dart';
import 'package:waiter_app/view/login.dart';

import '../controller/local_server_con_controller.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class LocalServerConnection extends StatefulWidget {
  const LocalServerConnection({super.key});

  @override
  State<LocalServerConnection> createState() => _LocalServerConnectionState();
}

class _LocalServerConnectionState extends State<LocalServerConnection> {
  final localServerConController = LocalServerConController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text(
        AppString.localServerConnection,
        style: TextStyle(color: AppColor.primary),
      )),
      body: Container(
        color: AppColor.grey,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
        child: Column(
          children: [
            TextFormField(
              controller: localServerConController.ipAddressController,
              style: const TextStyle(color: AppColor.primaryDark),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: AppString.ipAddress,
                  labelStyle: TextStyle(color: AppColor.primary500),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: localServerConController.databaseNameController,
              style: const TextStyle(color: AppColor.primaryDark),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: AppString.databaseName,
                  labelStyle: TextStyle(color: AppColor.primary500),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: localServerConController.databaseLoginUserController,
              style: const TextStyle(color: AppColor.primaryDark),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: AppString.databaseLoginUser,
                  labelStyle: TextStyle(color: AppColor.primary500),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller:
                  localServerConController.databaseLoginPasswordController,
              style: const TextStyle(color: AppColor.primaryDark),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: AppString.databaseLoginPassword,
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
                    localServerConController.save().then((connector) {
                      SnackBar(content: Text(AppString.saved));
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Login(connectorModel: connector,);
                      }));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                  child: const Text(AppString.sContinue)),
            )
          ],
        ),
      ),
    );
  }
}
