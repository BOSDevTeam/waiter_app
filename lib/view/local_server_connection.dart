import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/view/register_key.dart';

import '../provider/local_server_con_provider.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class LocalServerConnection extends StatefulWidget {
  const LocalServerConnection({super.key});

  @override
  State<LocalServerConnection> createState() => _LocalServerConnectionState();
}

class _LocalServerConnectionState extends State<LocalServerConnection> {
  @override
  void initState() {
    DatabaseHelper().getConnector().then((value) {
      if (value.isNotEmpty) {
        isRegisterSuccess().then((value) {
          if (value) {
            context.read<LocalServerConProvider>().setIsEdit(true);
          }
        });

        context.read<LocalServerConProvider>().ipAddressController.text =
            value[0]["IPAddress"];
        context.read<LocalServerConProvider>().databaseNameController.text =
            value[0]["DatabaseName"];
        context
            .read<LocalServerConProvider>()
            .databaseLoginUserController
            .text = value[0]["DatabaseLoginUser"];
        context
            .read<LocalServerConProvider>()
            .databaseLoginPasswordController
            .text = value[0]["DatabaseLoginPassword"];
      }
    });

    super.initState();
  }

  Future<bool> isRegisterSuccess() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? isRegisterSuccess = sharedPreferences.getBool("IsRegisterSuccess");
    return isRegisterSuccess ?? false;
  }

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
              controller:
                  context.read<LocalServerConProvider>().ipAddressController,
              style: const TextStyle(color: AppColor.primaryDark),
              keyboardType: TextInputType.number,
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
              controller:
                  context.read<LocalServerConProvider>().databaseNameController,
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
              controller: context
                  .read<LocalServerConProvider>()
                  .databaseLoginUserController,
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
              controller: context
                  .read<LocalServerConProvider>()
                  .databaseLoginPasswordController,
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
            Consumer<LocalServerConProvider>(
                builder: (context, provider, child) {
              return Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                    onPressed: () {
                      provider.save().then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(AppString.saved)));
                          if (!provider.isEdit) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const RegisterKey();
                            }));
                          }
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary500,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 30, left: 30),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                    child: !provider.isEdit
                        ? const Text(AppString.sContinue)
                        : const Text(AppString.save)),
              );
            }),
          ],
        ),
      ),
    );
  }
}
