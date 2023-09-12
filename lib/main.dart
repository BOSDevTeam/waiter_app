import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/provider/login_provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/provider/number_provider.dart';
import 'package:waiter_app/provider/order_provider.dart';
import 'package:waiter_app/provider/setting_provider.dart';
import 'package:waiter_app/provider/table_situation_provider.dart';
import 'package:waiter_app/provider/taste_provider.dart';
import 'package:waiter_app/provider/time_provider.dart';
import 'package:waiter_app/view/data_downloading.dart';
import 'package:waiter_app/view/dialog/dialog_number.dart';
import 'package:waiter_app/view/dialog/dialog_taste.dart';
import 'package:waiter_app/value/number_type.dart';
import 'package:waiter_app/view/dialog/dialog_time.dart';
import 'package:waiter_app/view/local_server_connection.dart';
import 'package:waiter_app/view/login.dart';
import 'package:waiter_app/view/navigation/nav_order.dart';
import 'package:waiter_app/view/navigation/nav_setting.dart';
import 'package:waiter_app/view/order_detail.dart';
import 'package:waiter_app/view/table_situation.dart';

import 'provider/order_detail_provider.dart';
import 'value/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool? isRegisterSuccess = sharedPreferences.getBool("IsRegisterSuccess");

  runApp(MyApp(
    isRegisterSuccess: isRegisterSuccess,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isRegisterSuccess;

  const MyApp({super.key, required this.isRegisterSuccess});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
          child: const Login(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
          child: const NavOrder(),
        ),
        ChangeNotifierProvider<TableSituationProvider>(
          create: (context) => TableSituationProvider(),
          child: const TableSituation(
            isFromNav: false,
          ),
        ),
        ChangeNotifierProvider<TasteProvider>(
          create: (context) => TasteProvider(),
          child: const DialogTaste(
            orderIndex: -1,
            isTasteMulti: false,
            incomeId: 0,
          ),
        ),
        ChangeNotifierProvider<SettingProvider>(
          create: (context) => SettingProvider(),
          child: const NavSetting(),
        ),
        ChangeNotifierProvider<NumberProvider>(
          create: (context) => NumberProvider(),
          child: const DialogNumber(orderIndex: -1,numberType: NumberType.quantityNumber,),
        ),
        ChangeNotifierProvider<TimeProvider>(
          create: (context) => TimeProvider(),
          child: const DialogTime(),
        ),
        ChangeNotifierProvider<OrderDetailProvider>(
          create: (context) => OrderDetailProvider(),
          child: const OrderDetail(tableId: 0,tableName: "",),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
          useMaterial3: true,
        ),
         home: AnimatedSplashScreen(
            backgroundColor: AppColor.primary,
            splash: 'assets/images/foreground.png',
            nextScreen: _startWidget()),
        //home: Login(),
        routes: {
          '/nav_order': (BuildContext ctx) => const NavOrder(),
          '/nav_table': (BuildContext ctx) => const TableSituation(
                isFromNav: true,
              ),
          '/nav_setting': (BuildContext ctx) => const NavSetting()
        },
        builder: EasyLoading.init(),
      ),
    );
  }

  Widget _startWidget() {
    if (isRegisterSuccess == null || isRegisterSuccess == false) {
      DatabaseHelper().deleteAllData();
      return const LocalServerConnection();
    } else {
      return const Login();
    }
  }
}
