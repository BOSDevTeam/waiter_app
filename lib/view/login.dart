import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:waiter_app/api/apiservice.dart';
import 'package:dio/dio.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/model/waiter_model.dart';
import 'package:waiter_app/value/app_constant.dart';
import 'package:waiter_app/view/navigation/nav_order.dart';

import '../controller/login_controller.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginController = LoginController();
  final _waiterBox = Hive.box(AppConstant.waiterBox);
  List<Map<String, dynamic>> lstWaiter = [];

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void initState() {
    //_getWaiter();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        border: Border.all(color: Colors.green),
                        borderRadius: const BorderRadius.all(Radius.circular(4))),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            value: dropdownvalue,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black87,
                            ),
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropdownvalue = value!;
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const NavOrder();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary500,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.only(top: 20,bottom: 20,left: 50,right: 50),
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

  Widget _waiter() {
    return ListView.builder(
        itemCount: lstWaiter.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lstWaiter[index]["waiterName"]),
          );
        });
  }

  void _getWaiter() {
    final data = _waiterBox.keys.map((key) {
      final item = _waiterBox.get(key);
      return {
        "key": key,
        "waiterId": item["waiterId"],
        "waiterName": item["waiterName"],
        "password": item["password"]
      };
    }).toList();
    lstWaiter = data.toList();
  }
}
