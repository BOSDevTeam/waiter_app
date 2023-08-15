import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:waiter_app/api/apiservice.dart';
import 'package:dio/dio.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/model/waiter_model.dart';
import 'package:waiter_app/value/app_constant.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _waiterBox=Hive.box(AppConstant.waiterBox);
  List<Map<String,dynamic>> lstWaiter=[];
  
  @override
  void initState() {
    //_getWaiter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              color: Colors.green,
            ),
            Container(
              height: MediaQuery.of(context).size.height/2,
              color: Colors.red,
            ),
          ],
        )
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

  void _getWaiter(){
    final data=_waiterBox.keys.map((key) {
        final item=_waiterBox.get(key);
        return {"key":key,"waiterId":item["waiterId"],"waiterName":item["waiterName"],"password":item["password"]};
    }).toList();
    lstWaiter=data.toList();
  }

}
