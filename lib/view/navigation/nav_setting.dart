import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../nav_drawer.dart';
import '../../provider/setting_provider.dart';
import '../../value/app_color.dart';
import '../../value/app_setting.dart';
import '../../value/app_string.dart';

class NavSetting extends StatefulWidget {
  const NavSetting({super.key});

  @override
  State<NavSetting> createState() => _NavSettingState();
}

class _NavSettingState extends State<NavSetting> {
  @override
  void initState() {
    context.read<SettingProvider>().fillGeneralSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(AppString.setting,
            style: TextStyle(color: AppColor.primary)),
        iconTheme: const IconThemeData(color: AppColor.primary),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.grey,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: AppString.general,
                    color: AppColor.primary,
                    size: 18,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.addTimeByItemInOrder,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.addTimeByItemInOrder ?? false,
                        onChanged: (value) {
                          provider.setAddTimeByItemInOrder(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.showTasteInSelectItem,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.showTasteInSelectItem ?? false,
                        onChanged: (value) {
                          provider.setShowTasteInSelectItem(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.useTasteByMenu,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.useTasteByMenu ?? false,
                        onChanged: (value) {
                          provider.setUseTasteByMenu(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.notPutItemAndTasteInOrder,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.notPutItemAndTasteInOrder ?? false,
                        onChanged: (value) {
                          provider.setNotPutItemAndTasteInOrder(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.addStartTimeInOrder,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.addStartTimeInOrder ?? false,
                        onChanged: (value) {
                          provider.setAddStartTimeInOrder(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.hideSalePriceInItem,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.hideSalePriceInItem ?? false,
                        onChanged: (value) {
                          provider.setHideSalePriceInItem(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.hideCommercialTax,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.hideCommercialTax ?? false,
                        onChanged: (value) {
                          provider.setHideCommercialTax(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.calculateAdvancedTax,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.calculateAdvancedTax ?? false,
                        onChanged: (value) {
                          provider.setCalculateAdvancedTax(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Expanded(
                        child: Text(
                      AppSetting.addCustomerByTotalPerson,
                      style: TextStyle(
                        color: AppColor.primaryDark,
                      ),
                      maxLines: null,
                    )),
                    trailing: Consumer<SettingProvider>(
                        builder: (context, provider, child) {
                      return Checkbox(
                        splashRadius: 50,
                        value: provider.addCustomerByTotalPerson ?? false,
                        onChanged: (value) {
                          provider.setAddCustomerByTotalPerson(value!);
                        },
                      );
                    }),
                  ),
                  const Divider(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: AppString.data,
                    color: AppColor.primary,
                    size: 18,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      title: Expanded(
                          child: Text(
                        AppString.localServerConnection,
                        style: TextStyle(
                          color: AppColor.primaryDark,
                        ),
                        maxLines: null,
                      )),
                      trailing: Icon(Icons.arrow_right)),
                  Divider(),
                  ListTile(
                      title: Expanded(
                          child: Text(
                        AppString.updateData,
                        style: TextStyle(
                          color: AppColor.primaryDark,
                        ),
                        maxLines: null,
                      )),
                      trailing: Icon(Icons.arrow_right)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
