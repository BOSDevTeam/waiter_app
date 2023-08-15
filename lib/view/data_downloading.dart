import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:waiter_app/view/login.dart';

import '../api/apiservice.dart';
import '../value/app_color.dart';
import '../value/app_constant.dart';
import '../value/app_string.dart';

class DataDownloading extends StatefulWidget {
  const DataDownloading({super.key});

  @override
  State<DataDownloading> createState() => _DataDownloadingState();
}

class _DataDownloadingState extends State<DataDownloading> {
  var apiService =
      ApiService(dio: Dio(BaseOptions(baseUrl: AppConstant.baseUrl)));
  final _waiterBox = Hive.box(AppConstant.waiterBox);
  bool _isDownloadComplete = false;
  String _currentDownloadData = "";

  @override
  void initState() {
    setState(() {
      _currentDownloadData = AppString.waiter;
    });
    apiService.getWaiter(AppConstant.connectorModel).then((lstWaiter) {
      for (int i = 0; i < lstWaiter.length; i++) {
        _insertWaiter({
          "waiterId": lstWaiter[i].waiterId,
          "waiterName": lstWaiter[i].waiterName,
          "password": lstWaiter[i].password
        });
      }
      setState(() {
        _isDownloadComplete = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          AppString.download,
          style: TextStyle(color: AppColor.primary),
        )),
        body: !_isDownloadComplete
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${AppString.downloading} $_currentDownloadData"),
                  const SizedBox(
                    height: 30,
                  ),
                  const CircularProgressIndicator()
                ],
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppString.downloadCompleted),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const Login();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                        child: const Text(AppString.sContinue)),
                  ],
                ),
              ));
  }

  Future<void> _insertWaiter(Map<String, dynamic> waiter) async {
    await _waiterBox.add(waiter);
  }
}
