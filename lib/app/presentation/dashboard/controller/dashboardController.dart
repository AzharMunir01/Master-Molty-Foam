import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../data/local/database/database.dart';
import '../../../data/model/fileStatus.dart';
import '../../../data/model/getSyncData.dart';
import '../../../data/model/onBoardDealerModel.dart';
import '../../../data/model/postFormDataRequest/PostFormDataRequest.dart';
import '../../../data/model/submissionFormInfo.dart';
import '../../../data/model/userModel.dart';
import '../../../netWorking/apiAuth.dart';
import '../../../routes/app_page.dart';
import '../../../theme/color.dart';
import '../../../utils/appConst.dart';
import '../../../utils/utiles.dart';
import '../../../widgets/Animations/animated_widget.dart';

class DashboardController extends GetxController {
  RxBool isBack = true.obs;
  RxString formName = "".obs;
  RxInt imageIndex = 0.obs;
  RxInt totalImage = 0.obs;
  final dealer = <Dealers>[].obs;
  final offLineDealer = <Dealers>[].obs;
  final dealerType = <DealerType>[].obs;
  final city = <Cities>[].obs;
  final todaySubmissionForm = <SubmitFormInfo>[].obs;
  final offLineSubmissionForm = <SubmitFormInfo>[].obs;
  RxInt formDialog = 0.obs;
  final categories = <Categories>[].obs;
  final formSubmitFormInfo = <SubmitFormInfo>[].obs;
  final dMFBFormSubmit = <SubmitFormInfo>[].obs;
  // final formSubmitFormInfoToday = <SubmitFormInfo>[].obs;
  // final isLoading = 1.obs;
  // final todaySubmission = <RxInt>[].obs;
  final monthlySubmission = <RxInt>[].obs;
  final offlineRequest = <RxInt>[].obs;
  final lastVisited = <RxInt>[].obs;
  RxDouble percentage = 0.0.obs;
  final user = <UserModel>[].obs;
  final currentPage = ''.obs;
  Rx<int> formIndex = 0.obs;

  final ApiServices apiServices = ApiServices();
  @override
  Future<void> onInit() async {
    super.onInit();
    // getDealer();
    await submitFormInfo();
    firstLogin();
    getcurrentPage();
    // startStart();
    // cont();
  }

  Future<void> getDealer() async {
    final result = await DatabaseHelper.getAllDealer();
    for (int i = 0; i < result.length; i++) {
      await Future.delayed(const Duration(microseconds: 1000));
      dealer.value = List.from(dealer)..add(Dealers.fromJson(result[i]));
    }
    // final todaySubmissionForm = await DatabaseHelper.getSubmitFormInfo();
  }

  getOnBoardDealer() async {
    final results = await DatabaseHelper.getOnBoardDM();
    List<OnBoardDealerManagement> onBoardDealerManagement = [];
    offLineDealer.clear();
    for (var result in results) {
      onBoardDealerManagement.add(OnBoardDealerManagement.fromJson(result));
    }

    if (onBoardDealerManagement.isNotEmpty) {
      for (int i = 0; i < onBoardDealerManagement.length; i++) {
        Dealers dealer = Dealers(
            dealershipName: onBoardDealerManagement[i].name,
            crcContact: onBoardDealerManagement[i].mobileNumber,
            cnic: onBoardDealerManagement[i].cnic,
            email: onBoardDealerManagement[i].email);
        offLineDealer.add(dealer);
        // You can add any further processing you need to do with each `dealer` here.
      }
    }
  }

  Future<void> clearFormRequest() async {
    await DatabaseHelper.insertCurrentPage(AppConst.kpiForm);
    submitFormInfo();
  }

  getcurrentPage() async {
    final data = await DatabaseHelper.getCurrentPage();

    currentPage.value = data.isNotEmpty ? data[0]["currentPage"] : "";

    // Determine the form index based on the current page
    formIndex.value = currentPage.value == AppConst.kpiForm
        ? 0
        : currentPage.value == AppConst.oSForm
            ? 1
            : currentPage.value == AppConst.cWMForm
                ? 2
                : 3;
  }

  Future<int> isSync() async {
    int? isSync = await DatabaseHelper.getBgService();

    return isSync ?? 0;
  }

  Future<void> submitFormInfo() async {
    try {
      // Clear existing data
      formSubmitFormInfo.clear();
      offlineRequest.clear();
      offLineDealer.clear();
      todaySubmissionForm.clear();
      offLineSubmissionForm.clear();
      // offLineSubmissionForm.clear();
      monthlySubmission.clear();
      formSubmitFormInfo.clear();
      dMFBFormSubmit.clear();
      categories.clear();
      user.clear();
      dealerType.clear();
      city.clear();

      // Get the current date and time
      DateTime dateTime = DateTime.now();
      final result = await DatabaseHelper.getAllDealer();
      for (int i = 0; i < result.length; i++) {
        await Future.delayed(const Duration(microseconds: 1000));
        dealer.value = List.from(dealer)..add(Dealers.fromJson(result[i]));
      }
      // Insert the current page information

      // Fetch and populate data
      dealerType.addAll((await DatabaseHelper.getDealerType()).map((e) => DealerType.fromJson(e)));
      city.addAll((await DatabaseHelper.getCity()).map((e) => Cities.fromJson(e)));
      formSubmitFormInfo.addAll((await DatabaseHelper.getSubmitFormInfo()).map((e) => SubmitFormInfo.fromJson(e)));
      formSubmitFormInfo.addAll((await DatabaseHelper.getDFQRequestFormInfo()).map((e) => SubmitFormInfo.fromJson(e)));
      // dMFBFormSubmit.addAll((await DatabaseHelper.getDFQRequestFormInfo()).map((e) => SubmitFormInfo.fromJson(e)));
      categories.addAll((await DatabaseHelper.getCategories()).map((e) => Categories.fromJson(e)));
      getOnBoardDealer();
      // Get.dialog(const RotatedImageWidget(), barrierDismissible: true);
      // Fetch and set user data
      final getUser = await DatabaseHelper.getUsers();
      user.value = getUser.map((result) => UserModel.fromJson(result)).toList();

      // Perform first login actions
      // firstLogin();
      formSubmitFormInfo.sort((a, b) {
        DateTime dateA = DateTime.parse(a.dateTime!);
        DateTime dateB = DateTime.parse(b.dateTime!);
        return dateA.compareTo(dateB);
      });

      // Get current page data and set the current page
      final data = await DatabaseHelper.getCurrentPage();

      currentPage.value = data.isNotEmpty ? data[0]["currentPage"] : "";

      // Determine the form index based on the current page
      formIndex.value = currentPage.value == AppConst.kpiForm
          ? 0
          : currentPage.value == AppConst.oSForm
              ? 1
              : currentPage.value == AppConst.cWMForm
                  ? 2
                  : 3;

      // Filter today's submissions
      for (int i = 0; i < formSubmitFormInfo.length; i++) {
        if (DateTime.parse(formSubmitFormInfo[i].dateTime!).day == dateTime.day) {
          todaySubmissionForm.add(formSubmitFormInfo[i]);
        }

        if (formSubmitFormInfo[i].isSync! == 0) {
          offLineSubmissionForm.add(formSubmitFormInfo[i]);
        }
      }
      // Get.back();
      // Set loading status to 0
      // isLoading.value = 0;
    } catch (e) {
      // Get.back();
      // Handle the error gracefully
      print("Error occurred while submitting form info: $e");
      // Optionally, set loading status to an error state
      // isLoading.value = -1;
    }
  }

  // Future<void> deleteFiles(List<String> filePaths) async {
  //   for (String filePath in filePaths) {
  //     try {
  //       // Create a File object with the specified path
  //       final file = File(filePath);
  //
  //       // Check if the file exists
  //       if (await file.exists()) {
  //         // Delete the file
  //         await file.delete();
  //
  //         print('File deleted successfully: $filePath');
  //       } else {
  //         print('File does not exist: $filePath');
  //       }
  //     } catch (e) {
  //       print('Error deleting file $filePath: $e');
  //     }
  //   }
  // }

  Future<void> syncForm(BuildContext context) async {
    isBack.value = false;
    // formUploadingPercentage(context);
    try {
      for (int i = 0; i < offLineSubmissionForm.length; i++) {
        // await getFormData(offLineSubmissionForm[i].requestFormId!);

        formDialog.value = i + 1;
        if (offLineSubmissionForm[i].type == "DM FeedBack") {
          await getDFQForms(offLineSubmissionForm[i].requestFormId!);
        } else {
          var kpiFile = await DatabaseHelper.getDataById("kpiFormFile", offLineSubmissionForm[i].requestFormId!);
          var cWFFile = await DatabaseHelper.getDataById("CWMFormFile", offLineSubmissionForm[i].requestFormId!);
          var OSFile = await DatabaseHelper.getDataById("oSFormFile", offLineSubmissionForm[i].requestFormId!);
          bool kpiFileStatus = false;
          bool cwmFileStatus = false;
          bool osFileStatus = false;

          List<String> kpiFilePaths = [];
          List<String> osFilePaths = [];
          List<String> cwmFilePaths = [];

          /// file path list
          try {
            if (kpiFile.isNotEmpty) {
              formName.value = "KPI Form";
              List<dynamic> decodedJson = jsonDecode(kpiFile[0]["kpiFormFile"]);
              final res = await apiServices.sendFormFiles(await getFilePaths(List<String>.from(decodedJson)));
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
              formName.value = "CWM  Form";
              List<dynamic> decodedJson = jsonDecode(cWFFile[0]["cWMFormFile"]);

              final res = await apiServices.sendFormFiles(await getFilePaths(List<String>.from(decodedJson)));
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
              formName.value = "OS  Form";
              List<dynamic> decodedJson = jsonDecode(OSFile[0]["oSFormFile"]);

              final res = await apiServices.sendFormFiles(await getFilePaths(List<String>.from(decodedJson)));

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

          (osFileStatus && kpiFileStatus && cwmFileStatus)
              ? isUpload = await getFormData(offLineSubmissionForm[i].requestFormId!)
              : Utils.showSnackBar("Error", "Something went wrong while uploading form ${i + 1}", color: Colors.white);

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
      isBack.value = true;
      Navigator.pop(context);
      print('Error: $e');
    }

    Navigator.pop(context);
    isBack.value = true;
  }

  Future<bool> getFormData(int id) async {
    try {
      var results = await DatabaseHelper.getDataById("requestForm", id);

      List<PostFormData> requestFormData = [];

      for (var result in results) {
        requestFormData.add(PostFormData.fromJson(result));
      }

      if (requestFormData.isNotEmpty) {
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

          final res = await apiServices.sendFormFiles(await getFilePaths(List<String>.from(decodedJson)));
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

  void logOut(BuildContext context) async {
    showProgressDialog(context);
    await DatabaseHelper.clearDatabase();
    Navigator.pushReplacementNamed(context, AppPages.loginView);
  }

  void incrementPercentage() {
    percentage.value += 0.033;
    print("percentage + ${percentage.value}");
    if (percentage.value > 1.0) {
      percentage.value = 1.0; // Cap percentage at 100%
    }
  }

  void resetPercentage() {
    percentage.value = 0.0; // Reset percentage to 0
  }

  Future<void> getSyncData(
    int userID,
  ) async {
    try {
      user.value.clear();
      final getUser = await DatabaseHelper.getUsers();
      user.value = getUser.map((result) => UserModel.fromJson(result)).toList();
      // Get.dialog(const RotatedImageWidget(), barrierDismissible: true);
      final response = await apiServices.syncData(user[0].userId!);
      incrementPercentage();
      if (response.status == "true") {
        final value = GetSyncData.fromJson(response.data);
        incrementPercentage();
        // await DatabaseHelper.insertCity(value.cities!);
        await DatabaseHelper.insertDealerType(value.dealerType!);
        await DatabaseHelper.insertAnswerType(value.answerType!);
        incrementPercentage();
        await DatabaseHelper.insertAttachmentType(value.attachmentType!);
        await DatabaseHelper.insertFeedbackType(value.feedbackType!);
        incrementPercentage();
        await DatabaseHelper.insertKPIForm(value.kPIForm!);
        incrementPercentage();
        await DatabaseHelper.insertKPIFormAnswerType(value.kPIFormAnswerType!);
        incrementPercentage();
        await DatabaseHelper.insertKPIFormQuestions(value.kPIFormQuestions!);
        incrementPercentage();
        await DatabaseHelper.insertQuestionType(value.questionType!);
        incrementPercentage();
        await DatabaseHelper.insertZones(value.zones!);
        incrementPercentage();
        await DatabaseHelper.insertDealer(value.dealers!);
        incrementPercentage();
        await DatabaseHelper.insertCategories(value.categories!);
        incrementPercentage();
        await DatabaseHelper.insertKPIFormAttachmentType(value.kPIFormAttachmentType!);
        incrementPercentage();
        await DatabaseHelper.insertOSForm(value.oSForm!);
        incrementPercentage();
        await DatabaseHelper.insertoSFormBoardDescription(value.oSFormBoardDescription!);
        incrementPercentage();
        await DatabaseHelper.insertOSFormBoardImages(value.oSFormBoardImages!);
        incrementPercentage();
        await DatabaseHelper.insertOSFormAnswerType(value.oSFormAnswerType!);
        incrementPercentage();
        await DatabaseHelper.insertOSFormAttachmentType(value.oSFormAttachmentType!);
        incrementPercentage();
        await DatabaseHelper.insertCategoryWiseModelForm(value.categoryWiseModelForm!);
        incrementPercentage();
        await DatabaseHelper.insertCategoryWiseModelFormModels(value.categoryWiseModelFormModels!);
        incrementPercentage();
        await DatabaseHelper.insertCategoryWiseModelFormAttachmentType(value.categoryWiseModelFormAttachmentType!);
        incrementPercentage();
        await DatabaseHelper.insertCategoryWiseModelFormAnswerType(value.categoryWiseModelFormAnswerType!);
        incrementPercentage();
        await DatabaseHelper.insertDealerFeedbackFormQuestions(value.dealerFeedbackFormQuestions!);
        incrementPercentage();
        await DatabaseHelper.insertDealerFeedbackFormAttachmentTypes(value.dealerFeedbackFormAttachmentTypes!);
        incrementPercentage();
        await DatabaseHelper.insertDealerFeedbackForm(value.dealerFeedbackForm!);
        incrementPercentage();
        await DatabaseHelper.insertDealerFeedbackFormAsnwerTypes(value.dealerFeedbackFormAsnwerTypes!);
        incrementPercentage();
        await DatabaseHelper.insertOSFormBoardImages(value.oSFormBoardImages!);
        incrementPercentage();
        await DatabaseHelper.insertCategoryWiseModelFormFormImages(value.categoryWiseModelFormFormImages!);
        incrementPercentage();
        await DatabaseHelper.insertCity(value.cities!);
        incrementPercentage();
        Get.back();
        resetPercentage();
        // https: //molty.bmccrm.com:442/uploadedfiles/504_3d-artwork-1.png
        // final respon = await apiServices.getFormImages("504_3d-artwork-1.png");
        Utils.showSnackBar("Success", "Data successfully Save in db");
        downloadFormImages();
      } else {
        // Navigator.pop(context)
        Get.back();
        resetPercentage();
        Utils.showSnackBar("Success", "Some thing wrong Please try again");
      }
    } catch (e) {
      resetPercentage();
      Get.back();
      Utils.showSnackBar("Error", "Refresh again ");
      print('Error: $e');
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

  Future<void> downloadFormImages() async {
    List<OSFormBoardImages> oSFormBoardImages = [];
    List<CategoryWiseModelFormFormImages> categoryWiseModelFormFormImage = [];
    oSFormBoardImages.clear();

    try {
      final oSFormBoardImage = await DatabaseHelper.getFormFiles(tableName: 'oSFormBoardImages');

      final categoryWiseModelFormFormImages = await DatabaseHelper.getFormFiles(tableName: 'categoryWiseModelFormFormImages');
      for (var result in oSFormBoardImage) {
        oSFormBoardImages.add(OSFormBoardImages.fromJson(result));
      }
      for (var result in categoryWiseModelFormFormImages) {
        categoryWiseModelFormFormImage.add(CategoryWiseModelFormFormImages.fromJson(result));
      }

      for (var i = 0; i < categoryWiseModelFormFormImage.length; i++) {
        try {
          final val = await apiServices.getFormImages(categoryWiseModelFormFormImage[i].filepath!);

          await DatabaseHelper.updateFormFilePath(
              id: categoryWiseModelFormFormImage[i].id!, path: val.toString(), tableName: 'categoryWiseModelFormFormImages', isSync: 1);
        } catch (e) {
          print('Error updating categoryWiseModelFormFormImages at index $i: $e');
        }
      }

      int i = 0;
      bool listUpdated;

      do {
        listUpdated = false; // Flag to detect if the list length changes

        while (i < oSFormBoardImages.length) {
          try {
            final val = await apiServices.getFormImages(oSFormBoardImages[i].filepath!);

            await DatabaseHelper.osUpdateFormFilePath(
              filepath: oSFormBoardImages[i].filepath!,
              path: val.toString(),
            );

            // Update the local list after updating the database
            final oSFormBoardImage = await DatabaseHelper.getFormFiles(tableName: 'oSFormBoardImages');

            if (oSFormBoardImage.length != oSFormBoardImages.length) {
              // If the length of the list changes, reset index and flag
              listUpdated = true;
              oSFormBoardImages.clear();
              for (var result in oSFormBoardImage) {
                oSFormBoardImages.add(OSFormBoardImages.fromJson(result));
              }
              i = 0; // Reset index to 0
              break; // Exit the inner while loop to start over
            } else {
              // If list length remains the same, move to the next item
              i++;
            }
          } catch (e) {
            print('Error updating oSFormBoardImages at index $i: $e');
            i++; // Move to the next item on error
          }
        }
      } while (listUpdated); // Continue looping if the list length changed
    } catch (e) {
      print('Error downloading form images: $e');
    }
  }

  Future<void> firstLogin() async {
    final result = await DatabaseHelper.getFirstLogin();
    if (result.isNull) {
      final getUser = await DatabaseHelper.getUsers();
      user.value = getUser.map((result) => UserModel.fromJson(result)).toList();
      await getSyncData(user[0].userId!);
      await DatabaseHelper.insertFirstLogin();
      // Utils.showSnackBar("su", response.data["Message"] ?? "Unknown message");
    }
  }

  void showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// syncForm(BuildContext context) async {
//   showAlertDialog(context);
//
//   try {
//     for (int i = 0; i < offLineSubmissionForm.length; i++) {
//       // await getFormData(offLineSubmissionForm[i].requestFormId!);
//
//       formDialog.value = i + 1;
//       if (offLineSubmissionForm[i].type == "DM FeedBack") {
//         await getDFQForms(offLineSubmissionForm[i].requestFormId!);
//       } else {
//         var kpiFile = await DatabaseHelper.getDataById("kpiFormFile", offLineSubmissionForm[i].requestFormId!);
//         var cWFFile = await DatabaseHelper.getDataById("CWMFormFile", offLineSubmissionForm[i].requestFormId!);
//         var OSFile = await DatabaseHelper.getDataById("oSFormFile", offLineSubmissionForm[i].requestFormId!);
//         bool kpiFileStatus = false;
//         bool cwmFileStatus = false;
//         bool osFileStatus = false;
//         try {
//           if (kpiFile.isNotEmpty) {
//             List<dynamic> decodedJson = jsonDecode(kpiFile[0]["kpiFormFile"]);
//             List<FileStatus> li = decodedJson.map((item) => FileStatus.fromJson(item)).toList();
//             int length = li.length;
//             for (var i = 0; i < length; i++) {
//               if (!li[i].status) {
//                 final res = await apiServices.sendFormFiles(await getFilePaths(List<String>.from([li[i].path])));
//                 if (res.message == "OK") {
//                   li[i].status = true;
//                 } else {
//                   li[i].status = false;
//                 }
//               }
//             }
//
//             await DatabaseHelper.updateFORMFileSTATUS(requestId: offLineSubmissionForm[i].requestFormId!,
//                 tableName: 'kpiFormFile', updatedValues: jsonEncode(li.map((item) => item.toJson()).toList()), columName: 'kpiFormFile');
//             kpiFileStatus = li.every((item) => item.status);
//             kpiFileStatus ?
//
//             await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'kpiFormFile', isSync: 1)
//                 :
//             await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'kpiFormFile', isSync: 0);
//           }
//         } catch (e) {
//           print('Error: $e');
//         }
//
//         try {
//           if (cWFFile.isNotEmpty) {
//             List<dynamic> decodedJson = jsonDecode(cWFFile[0]["cWMFormFile"]);
//             List<FileStatus> li = decodedJson.map((item) => FileStatus.fromJson(item)).toList();
//             int length = li.length;
//             for (var i = 0; i < length; i++) {
//               if (!li[i].status) {
//                 final res = await apiServices.sendFormFiles(await getFilePaths(List<String>.from([li[i].path])));
//                 if (res.message == "OK") {
//                   li[i].status = true;
//                 } else {
//                   li[i].status = false;
//                 }
//               }
//             }
//             await DatabaseHelper.updateFORMFileSTATUS(requestId: offLineSubmissionForm[i].requestFormId!,
//               tableName: 'CWMFormFile', updatedValues: jsonEncode(li.map((item) => item.toJson()).toList()), columName: 'cWMFormFile',);
//             cwmFileStatus = li.every((item) => item.status);
//             cwmFileStatus ? await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'CWMFormFile', isSync: 1) :
//             await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'CWMFormFile', isSync: 0);
//           }
//         } catch (e) {
//           print('Error: $e');
//         }
//
//         try {
//           if (OSFile.isNotEmpty) {
//             List<dynamic> decodedJson = jsonDecode(OSFile[0]["oSFormFile"]);
//             List<FileStatus> li = decodedJson.map((item) => FileStatus.fromJson(item)).toList();
//             int length = li.length;
//             for (var i = 0; i < length; i++) {
//               if (!li[i].status) {
//                 final res = await apiServices.sendFormFiles(await getFilePaths(List<String>.from([li[i].path])));
//                 if (res.message == "OK") {
//                   li[i].status = true;
//                 } else {
//                   li[i].status = false;
//                 }
//               }
//             }
//             await DatabaseHelper.updateFORMFileSTATUS(requestId: offLineSubmissionForm[i].requestFormId!,
//               tableName: 'oSFormFile', updatedValues: jsonEncode(li.map((item) => item.toJson()).toList()), columName: 'oSFormFile',);
//             osFileStatus = li.every((item) => item.status);
//             osFileStatus ? await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'oSFormFile', isSync: 1) :
//             await DatabaseHelper.formFilesUpdateStatus(id: kpiFile[0]["id"], tableName: 'oSFormFile', isSync: 0);
//           }
//         } catch (e) {
//           print('Error: $e');
//         }
//
//         (osFileStatus && kpiFileStatus && cwmFileStatus) ? await getFormData(offLineSubmissionForm[i].requestFormId!) :
//         Utils.showSnackBar("Error", "Something went wrong while uploading form $i");
//       }
//     }
//   }catch (e) {
//     Get.back();
//     print('Error: $e');
//   }
//   Get.back();
// }
