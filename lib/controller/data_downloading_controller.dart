class DataDownloadingController{
  bool isDownloadComplete = false;
  String currentDownloadData = "";
  List<Map<String, dynamic>> lstBaseUrl = [];
  List<Map<String, dynamic>> lstConnector = [];
  dynamic connectorModel;
}