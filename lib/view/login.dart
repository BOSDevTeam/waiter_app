import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/view/navigation/nav_order.dart';

import '../provider/login_provider.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';
import '../widget/app_text.dart';
import 'data_updating.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Offset _tapPosition = Offset.zero;

  @override
  void initState() {
    DatabaseHelper().getWaiter().then((value) {
      if (value.isNotEmpty) {
        context.read<LoginProvider>().setWaiterList(value);
        context.read<LoginProvider>().setSelectedWaiter(value[0]);
      }
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
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTapUp: (details) => _getTapPosition(details),
                        onTap: () {
                          _showContextMenu(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.settings,
                            color: AppColor.primaryDark,
                          ),
                        )),
                  ),
                  Image.asset("assets/images/launcher.png",
                      height: 100,
                      width: 100,
                      opacity: const AlwaysStoppedAnimation(30)),
                  const Text(
                    AppString.welcomeToThe,
                    style: TextStyle(
                        color: Color.fromARGB(255, 85, 34, 7), fontSize: 25),
                  ),
                  const Text(
                    AppString.appName,
                    style: TextStyle(
                        color: Color.fromARGB(255, 85, 34, 7),
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
                    return TextFormField(
                      onTap: () => _waiterDialog(provider.lstWaiter),
                      readOnly: true,
                      controller: provider.nameController,
                      style: const TextStyle(
                          fontFamily: "BOS", color: AppColor.primaryDark),
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                _waiterDialog(provider.lstWaiter);
                              },
                              icon: const Icon(Icons.arrow_drop_down))),
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
                    obscureText: true,
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

  void _getTapPosition(TapUpDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    final result = await showMenu(
        context: context,

        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: AppString.updateData,
            child: Text(AppString.updateData),
          ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case AppString.updateData:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const DataUpdating();
        }));
        break;
    }
  }

  Future<void> _waiterDialog(List<Map<String, dynamic>> lstWaiter) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              title: const AppText(text: AppString.waiter),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                    itemCount: lstWaiter.length,
                    itemBuilder: ((context, index) {
                      Map<String, dynamic> waiter = lstWaiter[index];
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          context
                              .read<LoginProvider>()
                              .setSelectedWaiter(waiter);
                        },
                        leading: const Icon(Icons.person),
                        title: Text(waiter["WaiterName"],
                            style: const TextStyle(
                                fontFamily: 'BOS',
                                color: AppColor.primaryDark,
                                fontSize: 16),
                            maxLines: null),
                      );
                    })),
              ));
        });
  }
}
