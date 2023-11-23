import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/provider/password_provider.dart';

import '../../value/app_color.dart';
import '../../value/app_string.dart';
import '../../value/password_type.dart';
import '../../widget/app_text.dart';
import '../local_server_connection.dart';

class DialogPassword extends StatefulWidget {
  final PasswordType passwordType;
  const DialogPassword({super.key, required this.passwordType});

  @override
  State<DialogPassword> createState() =>
      _DialogPasswordState(this.passwordType);
}

class _DialogPasswordState extends State<DialogPassword> {
  PasswordType passwordType;

  _DialogPasswordState(this.passwordType);

  @override
  void initState() {
    context.read<PasswordProvider>().passwordController.text="";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const AppText(text: AppString.enterPassword),
        content: TextFormField(
          controller: context.read<PasswordProvider>().passwordController,
          style: const TextStyle(color: AppColor.primaryDark),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
              labelText: AppString.password,
              labelStyle: TextStyle(color: AppColor.primary500),
              border: OutlineInputBorder()),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(AppString.cancel)),
              ElevatedButton(
                  onPressed: () {
                    if (context.read<PasswordProvider>().isValidateControl()) {
                      if (passwordType == PasswordType.settingPassword) {
                        DatabaseHelper().getSystemSetting().then((value) {
                          String adminPassword = value[0]["AdminPassword"];
                          if (context
                                  .read<PasswordProvider>()
                                  .passwordController
                                  .text ==
                              adminPassword) {
                            Navigator.pop(context);
                            Navigator.of(context)
                                .pushReplacementNamed('/nav_setting');
                          } else {
                            Fluttertoast.showToast(
                                msg: AppString.invalidPassword);
                          }
                        });
                      } else if (passwordType ==
                          PasswordType.localServerPassword) {
                        DatabaseHelper().getSystemSetting().then((value) {
                          String userPassword = value[0]["UserPassword"];
                          if (context
                                  .read<PasswordProvider>()
                                  .passwordController
                                  .text ==
                              userPassword) {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LocalServerConnection();
                            }));
                          } else {
                            Fluttertoast.showToast(
                                msg: AppString.invalidPassword);
                          }
                        });
                      }
                    }
                  },
                  child: Text(AppString.ok.toUpperCase()))
            ],
          )
        ],
      );
    });
  }
}
