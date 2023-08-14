import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../api/apiservice.dart';
import '../value/app_constant.dart';

class DataDownloading extends StatefulWidget {
  const DataDownloading({super.key});

  @override
  State<DataDownloading> createState() => _DataDownloadingState();
}

class _DataDownloadingState extends State<DataDownloading> {

  var apiService = ApiService(dio: Dio(BaseOptions(baseUrl: AppConstant.baseUrl)));

  @override
  void initState() {
    apiService.getWaiter(AppConstant.connectorModel).then((lstWaiter){
        // save to Hive db
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CircularProgressIndicator(),
    );
  }

  /* Future<void> _insertWaiter(Map<String,dynamic> waiters){

  } */
}