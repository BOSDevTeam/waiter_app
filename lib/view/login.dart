import 'package:flutter/material.dart';
import 'package:waiter_app/view/navigation/nav_order.dart';

import '../controller/login_controller.dart';
import '../hive/hive_db.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';
import '../widget/app_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = LoginController();

  @override
  void initState() {
    loginController.passwordController.text="1";
    loginController.lstWaiter = HiveDB.getWaiter();
    if (loginController.lstWaiter.isNotEmpty) {
      loginController.selectedWaiter = loginController.lstWaiter[0];
    }
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
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.primaryDark),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            itemHeight: 60,
                            value: loginController.selectedWaiter,
                            style: const TextStyle(
                                color: AppColor.primaryDark, fontSize: 16),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColor.primary,
                            ),
                            items: loginController.lstWaiter.map((e) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: e,
                                child: AppText(text:e["waiterName"],fontFamily: "BOS",),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                loginController.selectedWaiter = value!;
                              });
                            },
                            isExpanded: true,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: loginController.passwordController,
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
                        loginController.authenticate().then((value) {
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
          ),
        ],
      )),
    );
  }
}
