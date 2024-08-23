import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:molty_foam/app/utils/utiles.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/local/database/database.dart';
import '../../data/model/onBoardDealerModel.dart';
import '../../data/model/postFormDataRequest/PostFormDataRequest.dart';
import '../../data/model/submissionFormInfo.dart';
import '../apiAuth.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class BackgroundServices {
  ApiServices apiServices = ApiServices();
  List<String> kpiFilePaths = [];
  List<String> osFilePaths = [];
  List<String> cwmFilePaths = [];
  final formSubmitFormInfo = <SubmitFormInfo>[];
  getFormFiles() async {

    final offLineSubmissionForm = <SubmitFormInfo>[];
    formSubmitFormInfo.addAll((await DatabaseHelper.getSubmitFormInfo()).map((e) => SubmitFormInfo.fromJson(e)));
    formSubmitFormInfo.addAll((await DatabaseHelper.getDFQRequestFormInfo()).map((e) => SubmitFormInfo.fromJson(e)));
    for (int i = 0; i < formSubmitFormInfo.length; i++) {
      if (formSubmitFormInfo[i].isSync! == 0) {
        offLineSubmissionForm.add(formSubmitFormInfo[i]);
      }
    }

    // isBack.value = false;
    // showAlertDialog(context);
    try {
      for (int i = 0; i < offLineSubmissionForm.length; i++) {
        // await getFormData(offLineSubmissionForm[i].requestFormId!);

        // formDialog.value = i + 1;
        if (offLineSubmissionForm[i].type == "DM FeedBack") {
          await getDFQForms(offLineSubmissionForm[i].requestFormId!);
        } else {
          var kpiFile = await DatabaseHelper.getDataById("kpiFormFile", offLineSubmissionForm[i].requestFormId!);
          var cWFFile = await DatabaseHelper.getDataById("CWMFormFile", offLineSubmissionForm[i].requestFormId!);
          var OSFile = await DatabaseHelper.getDataById("oSFormFile", offLineSubmissionForm[i].requestFormId!);
          bool kpiFileStatus = false;
          bool cwmFileStatus = false;
          bool osFileStatus = false;

          /// file path list

          try {
            if (kpiFile.isNotEmpty) {
              // formName.value = "KPI Form";
              List<dynamic> decodedJson = jsonDecode(kpiFile[0]["kpiFormFile"]);
              final res = await apiServices.sendFormFilesBg(await getFilePaths(List<String>.from(decodedJson)));
              if (res.message == "OK") {
                await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'kpiFormFile', isSync: 1);
                kpiFileStatus = true;
                // deleteFiles(List<String>.from(decodedJson));
                kpiFilePaths = await getFilePaths(List<String>.from(decodedJson));
              } else {
                kpiFileStatus = false;
              }
            }
          } catch (e) {
            print('Error: $e');
          }

          try {
            if (cWFFile.isNotEmpty) {
              // formName.value = "CWM  Form";
              List<dynamic> decodedJson = jsonDecode(cWFFile[0]["cWMFormFile"]);

              final res = await apiServices.sendFormFilesBg(await getFilePaths(List<String>.from(decodedJson)));
              if (res.message == "OK") {
                cwmFileStatus = true;
                await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'CWMFormFile', isSync: 1);
                cwmFilePaths = await getFilePaths(List<String>.from(decodedJson));
              } else {
                cwmFileStatus = false;
              }
            }
          } catch (e) {
            print('Error: $e');
          }

          try {
            if (OSFile.isNotEmpty) {
              // formName.value = "OS  Form";
              List<dynamic> decodedJson = jsonDecode(OSFile[0]["oSFormFile"]);

              final res = await apiServices.sendFormFilesBg(await getFilePaths(List<String>.from(decodedJson)));

              if (res.message == "OK") {
                osFileStatus = true;
                await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'oSFormFile', isSync: 1);
                osFilePaths = await getFilePaths(List<String>.from(decodedJson));
              } else {
                osFileStatus = false;
              }
            }
          } catch (e) {
            print('Error: $e');
          }
          bool isUpload = false;

          (osFileStatus && kpiFileStatus && cwmFileStatus) ? isUpload = await getFormData(offLineSubmissionForm[i].requestFormId!) : "";
          // Utils.showSnackBar("Error", "Something went wrong while uploading form ${i + 1}",color:Colors.white);

          isUpload
              ? {
                  await Utils.deleteFiles(List<String>.from(kpiFilePaths)),
                  await Utils.deleteFiles(List<String>.from(osFilePaths)),
                  await Utils.deleteFiles(List<String>.from(cwmFilePaths)),
                }
              : "";
        }
      }
    } catch (e) {
      // isBack.value = true;
      // Navigator.pop(context);
      print('Error: $e');
    }

    // Navigator.pop(context);
    // isBack.value = true;
  }

  Future<bool> getFormData(int id) async {
    try {
      // final results = await DatabaseHelper.getRequestFormData();
      var results = await DatabaseHelper.getDataById("requestForm", id);

      List<PostFormData> requestFormData = [];

      for (var result in results) {
        requestFormData.add(PostFormData.fromJson(result));
      }

      if (requestFormData.isNotEmpty) {
        // sendFormData(List<PostFormData> requestFormData) async {
        for (var i = 0; i < requestFormData.length; i++) {
          // var result = requestFormData[i];
          final val = await apiServices.formDataRequest(requestFormData[0].toJson());
          if (val.status == "true") {
            await DatabaseHelper.updateIsSync(id: requestFormData[0].id!);
            await DatabaseHelper.updateSubmitFormInfo(requestFormId: requestFormData[0].id);

            return true;
          } else {
            return false;
          }
          // }
        }
      }
      // await getDFQForms();

      // await DatabaseHelper.insertBgService(0);
    } catch (e) {
      // Handle the error here, for example, by logging it or showing a message to the user
      print('Error occurred while getting form data: $e');
      return false;
    }

    return false;
  }

  /// dfq form
  Future<void> getDFQForms(int id) async {
    try {
      List<DFQForms> requestFormData = [];
      bool dFQFileStatus = true;
      final results = await DatabaseHelper.getRequestDFQForms(id);
      var dFQFile = await DatabaseHelper.getDataById("dFQFormFile", id);
      try {
        if (dFQFile!.isNotEmpty) {
          List<dynamic> decodedJson = jsonDecode(dFQFile[0]["dFQFormFile"]);

          final res = await apiServices.sendFormFilesBg(await getFilePaths(List<String>.from(decodedJson)));
          if (res.message == "OK") {
            dFQFileStatus = true;
            await DatabaseHelper.formFilesUpdateStatus(id: dFQFile[0]["id"], tableName: 'dFQFormFile', isSync: 1);
          } else {
            dFQFileStatus = false;
          }
        }
      } catch (e) {
        dFQFileStatus = false;
        print('Error: $e');
      }
      for (var result in results) {
        requestFormData.add(DFQForms.fromJson(result));
      }
      // dFQFileStatus ?"":requestFormData=[];
      if (requestFormData.isNotEmpty) {
        for (var i = 0; i < requestFormData.length; i++) {
          // var result = requestFormData[i];
          var data = jsonDecode(requestFormData[i].dFQForms!);

          final val = await apiServices.syncDataUploadDealerFeedback(data);
          print(jsonEncode(requestFormData[i].toJson()));

          if (val.status == "true") {
            await DatabaseHelper.updateRequestFormIsSync(id: requestFormData[i].id!);
            await DatabaseHelper.updatedFQRequestFormFormInfo(requestFormId: requestFormData[i].id);
          }
        }
      }
    } catch (e) {}
  }



  getOnBoardDealer() async {
    final results = await DatabaseHelper.getOnBoardDM();
    List<OnBoardDealerManagement> onBoardDealerManagement = [];

    for (var result in results) {
      onBoardDealerManagement.add(OnBoardDealerManagement.fromJson(result));
    }

    if (onBoardDealerManagement.isNotEmpty) {
      await sentDealerData(onBoardDealerManagement);
    }
  }

  sentDealerData(List<OnBoardDealerManagement> onBoardDealerManagement) async {
    for (var i = 0; i < onBoardDealerManagement.length; i++) {
      // var result = requestFormData[i];
      onBoardDealerManagement[i].userId;
      final val = await apiServices.onBDManagement(onBoardDealerManagement[i]);

      await DatabaseHelper.updateOnBoardDM(onBoardDealerManagement[i].cnic);
    }
  }

  sendFormData(List<PostFormData> requestFormData) async {
    for (var i = 0; i < requestFormData.length; i++) {
      // var result = requestFormData[i];
      final val = await apiServices.formDataRequest(requestFormData[i].toJson());
      if (val.status == "true") {
        await DatabaseHelper.updateIsSync(id: requestFormData[i].id!);
        await DatabaseHelper.updateSubmitFormInfo(requestFormId: requestFormData[i].id);
      }
    }
  }
}

Future<List<String>> getFilePaths(List<String> fileNames) async {
  Directory directory = await getApplicationDocumentsDirectory();
  // Initialize an empty list to store the file paths
  List<String> filePaths = [];

  // Iterate over the file names and search for them in the directory
  for (String fileName in fileNames) {
    // Create the file path
    String filePath = '${directory.path}/$fileName';

    // Check if the file exists at the created file path
    if (File(filePath).existsSync()) {
      // Add the file path to the list if the file exists
      filePaths.add(filePath);
    }
  }

  return filePaths;
}

class PeriodicTask {
  Timer? _timer;

  void start() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        await _runTask();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }

  Future<void> _runTask() async {
    DateTime now = DateTime.now();
    String formattedNow = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    String? lastRunTime = await DatabaseHelper.getLastRunTime();

    if (lastRunTime != null) {
      DateTime lastRun = DateFormat('yyyy-MM-dd HH:mm:ss').parse(lastRunTime);
      Duration difference = now.difference(lastRun);

      // Check if the difference is more than 2 minutes
      if (difference.inMinutes >= 5) {
        print('Running task. Last run time was $difference ago');
        // Perform your task here
        if (now.hour == 23) {
          BackgroundServices().getFormFiles();
          // BackgroundServices().getFormData();
          BackgroundServices().getOnBoardDealer();
          // BackgroundServices().getDFQForms();
          await DatabaseHelper.insertRunTime(formattedNow);
        }
      } else {
        print('Skipping task. Last run time was only $difference ago');
      }
    } else {
      print('This is the first run');
      // Perform your task here

      // Store the current run time in the database
      await DatabaseHelper.insertRunTime(formattedNow);
    }
  }
}

void showProgressDialog() {
  showDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false, // Prevents the user from dismissing the dialog
    builder: (BuildContext context) {
      return const Dialog(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}

void dismissProgressDialog() {
  navigatorKey.currentState!.pop();
}
