import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:waiter_app/view/local_server_connection.dart';
import 'package:waiter_app/view/login.dart';
import 'package:waiter_app/view/navigation/nav_order.dart';
import 'package:waiter_app/view/navigation/nav_setting.dart';
import 'package:waiter_app/view/navigation/nav_table.dart';
import 'package:waiter_app/view/register_key.dart';

import 'value/app_color.dart';
import 'value/app_constant.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(AppConstant.waiterBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const Login(),
      routes: {
        '/nav_order': (BuildContext ctx) => const NavOrder(),
        '/nav_table': (BuildContext ctx) => const NavTable(),
        '/nav_setting': (BuildContext ctx) => const NavSetting()
      },
    );
  }
}

