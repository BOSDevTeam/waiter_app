import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/view/navigation/nav_order.dart';

import '../provider/login_provider.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';
import '../widget/app_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    context.read<LoginProvider>().passwordController.text = "1";

    DatabaseHelper().getWaiter().then((value) {
      context.read<LoginProvider>().setWaiterList(value);
      context.read<LoginProvider>().setSelectedWaiter(value[0]);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/images/background.jpg",
                fit: BoxFit.fill,
                opacity: const AlwaysStoppedAnimation(80),
              ),
              Column(
                children: [
                  Image.asset("assets/images/launcher.png",
                      height: 100,
                      width: 100,
                      opacity: const AlwaysStoppedAnimation(30)),
                  const Text(
                    AppString.welcomeToThe,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  const Text(
                    AppString.appName,
                    style: TextStyle(
                        color: AppColor.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: Container(
              color: AppColor.grey,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppString.waiterLogin,
                      style:
                          TextStyle(color: AppColor.primaryDark, fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<LoginProvider>(builder: (context, provider, child) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primaryDark),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4))),
                          child: AppText(
                              text: provider.selectedWaiter["WaiterName"])

                          /* DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              itemHeight: 60,
                              value: isGotWaiter ? _selectedWaiter : null,
                              style: const TextStyle(
                                  color: AppColor.primaryDark, fontSize: 16),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.primary,
                              ),
                              items: _lstWaiter.map((e) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: e,
                                  child: AppText(
                                    text: e["WaiterName"].toString(),
                                    fontFamily: "BOS",
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                _selectedWaiter = value!;
                                /* context
                                      .read<LoginProvider>()
                                      .setSelectedWaiter(value!); */
                                /* setState(() {
                                  provider.selectedWaiter = value!;
                                }); */
                              },
                              isExpanded: true,
                            )),
                      ), */
                          ),
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller:
                        context.read<LoginProvider>().passwordController,
                    style: const TextStyle(color: AppColor.primaryDark),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                        labelText: AppString.password,
                        labelStyle: TextStyle(color: AppColor.primary500),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context
                            .read<LoginProvider>()
                            .authenticate()
                            .then((value) {
                          if (value) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const NavOrder();
                            }));
                          }
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const NavOrder();
                          }));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary500,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero))),
                      child: const Text(AppString.login)),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
