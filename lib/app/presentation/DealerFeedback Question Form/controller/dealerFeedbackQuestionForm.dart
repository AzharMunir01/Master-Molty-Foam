import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path/path.dart' as path;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/local/database/database.dart';
import '../../../data/model/feddbackModle/feedbackModel.dart';
import '../../../data/model/getSyncData.dart';
import '../../../data/model/submissionFormInfo.dart';
import '../../../data/model/userModel.dart';
import '../../../routes/app_page.dart';
import '../../../utils/alertDialog.dart';
import '../../../utils/appConst.dart';
import '../../../utils/changeFilePath.dart';
import '../../../utils/getLatLon.dart';
import '../../../utils/utiles.dart';
import '../../KPI Questions Form/ui/KPI Questions Form.dart';
import '../ui/dealerFeedbackQuestionForm.dart';

class DealerFeedbackQuestionFormController extends GetxController {
  final isLoading = 0.obs;
  final fileBaseUrl = "/uploadedfiles/".obs;
  final saveFile = <String>[].obs;
  final dFQFormFileId = RxInt(-1);
  final dealerType = <DealerType>[].obs;
  final dealer = <Dealers>[].obs;
  final dealerId = RxInt(-1);
  final dealerTypeID = RxInt(0);
  final requestID = RxInt(0);
  final DFQFormId = RxInt(0);
  final dealerFeedbackForm = <DealerFeedbackForm>[].obs;
  final dealerFeedbackFormAttachmentTypes = <DealerFeedbackFormAttachmentTypes>[].obs;
  final dealerFeedbackFormQuestions = <DealerFeedbackFormQuestions>[].obs;
  final dealerFeedbackFormAsnwerTypes = <DealerFeedbackFormAsnwerTypes>[].obs;
  final feedbackModels = <FeedbackModels>[].obs;
  final feedbackModelsSave = <FeedbackModels>[].obs;
  final isValidState = false.obs;
  final checkValidationState = false.obs;
  final lat = RxString("");
  final lon = RxString("");
  final oSFileId = RxInt(-1);
  RxInt kpiFileID = (-1).obs;
  RxInt cWMFileID = (-1).obs;
  final selectedId =RxInt(-1);
  RxList<int> todayDealerIds = <int>[].obs;
  final dMFBFormSubmit = <SubmitFormInfo>[].obs;
  final user = <UserModel>[].obs;
  void onInit() {
    super.onInit();
    getDealerType();
    // getDealer();
  }
  bool isValidMobileNumber(String number) {
    // Define the regex pattern for validating mobile numbers
    final RegExp regex = RegExp(r"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$");

    // Check if the number matches the regex pattern
    return regex.hasMatch(number);
  }
  // id INTEGER PRIMARY KEY,
  //     dealerTypeID INTEGER,
  // dealerID INTEGER,
  //     cWMFileID INTEGER,
  // oSFileID INTEGER,
  //     kpiFileID INTEGER,
  // requestFormID INTEGER
  Future<void> getDealerType() async {
    final results = await DatabaseHelper.getDealerType();
    dealerType.clear();
    for (var result in results) {
      dealerType.add(DealerType.fromJson(result));
    }
    final getUser = await DatabaseHelper.getUsers();
    user.clear();
    for (var result in getUser) {
      user.add(UserModel.fromJson(result));
    }

    final currentDate = DateTime.now();
    final currentDay = DateFormat('yyyy-MM-dd').format(currentDate); // Format should match the date format in formSubmitFormInfo
    dMFBFormSubmit.addAll((await DatabaseHelper.getDFQRequestFormInfo()).map((e) => SubmitFormInfo.fromJson(e)));
    for(int i=0; i<dMFBFormSubmit.length; i++){
      DateFormat('yyyy-MM-dd').format(DateTime.parse(dMFBFormSubmit[i].dateTime!))==currentDay?
      todayDealerIds.add(dMFBFormSubmit[i].dealerId!):"";
    }



  }
  Future<void> getDealer(int id) async {
    // await clearField();
    dealerId.value=-1;
    dealerTypeID.value=id;
    // await DatabaseHelper.insertCurrentPage(AppConst.dFBForm);

    /// get kpi form ids

    // final kpiFormIds = await DatabaseHelper.getCwFormIDS();
    // dealerTypeID.value = await kpiFormIds[0]["dealerTypeID"];
    // dealerId.value = await kpiFormIds[0]["dealerID"];
    // requestID.value = await kpiFormIds[0]["requestFormID"];
    // oSFileId.value = await kpiFormIds[0]["oSFileID"];
    // kpiFileID.value = await kpiFormIds[0]["kpiFileID"];
    // cWMFileID.value = await kpiFormIds[0]["cWMFileID"];
    // final results = await DatabaseHelper.getDealerType();
    // dealerType.clear();
    // for (var result in results) {
    //   dealerType.add(DealerType.fromJson(result));
    // }
    dealer.value=[];
    dealer.refresh();
    final result = await DatabaseHelper.getDealer(dealerTypeID.value);

    for (var result in result) {
      dealer.add(Dealers.fromJson(result));
    }

    /// get categoris
    getFeedbackForm();
  }

  getFeedbackForm() async {
    try {
      dealerFeedbackForm.clear();

      dealerFeedbackForm.addAll((await DatabaseHelper.getDealerFeedbackForm()).map((value) => DealerFeedbackForm.fromJson(value)));
      dealerFeedbackFormQuestions.clear();

      dealerFeedbackFormQuestions.addAll((await DatabaseHelper.getDealerFeedbackFormQuestions(dfqformId: dealerFeedbackForm[0].id))
          .map((value) => DealerFeedbackFormQuestions.fromJson(value)));

      dealerFeedbackFormAsnwerTypes.clear();
      dealerFeedbackFormAsnwerTypes.addAll((await DatabaseHelper.getDealerFeedbackFormAsnwerTypes(dfqformId: dealerFeedbackForm[0].id))
          .map((value) => DealerFeedbackFormAsnwerTypes.fromJson(value)));

      dealerFeedbackFormAttachmentTypes.clear();

      dealerFeedbackFormAttachmentTypes.addAll((await DatabaseHelper.getDealerFeedbackFormAttachmentTypes(dfqformId: dealerFeedbackForm[0].id))
          .map((value) => DealerFeedbackFormAttachmentTypes.fromJson(value)));
      feedbackModels.clear();
      feedbackModelsSave.clear();
      DFQFormId.value = dealerFeedbackForm[0].id!;
      for (var i = 0; i < dealerFeedbackFormQuestions.length; i++) {
        FeedbackModels data = FeedbackModels(
            // dealerId: dealerId,
            // dealerType: dealerType,
            // dfqformId: dealerFeedbackForm[0].id,
            questionId: dealerFeedbackFormQuestions[i].id.toString(),
            value: dealerFeedbackFormAsnwerTypes.isNotEmpty
                ? (getAnswerType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(2) ? "" : "false")
                : "false",
            // kPIFormAnswerType
            evaluation: dealerFeedbackFormAsnwerTypes.isNotEmpty
                ? (getAnswerType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(1) ? "" : "false")
                : "false",
            feedback: dealerFeedbackFormAsnwerTypes.isNotEmpty
                ? (getAnswerType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(3) ? "" : "false")
                : "false",
            uploadImage: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(1) ? "" : "false")
                : "false",
            uploadAudio: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(2) ? "" : "false")
                : "false",
            uploadVideo: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(3) ? "" : "false")
                : "false",
            contactNo: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(4) ? "" : "false")
                : "false",
            remarks: dealerFeedbackFormQuestions[i].remarks == 1 ? "" : "false");

        FeedbackModels data1 = FeedbackModels(
            // dealerId: dealerId,
            // dealerType: dealerType,
            // dfqformId: dealerFeedbackForm[0].id,
            questionId: dealerFeedbackFormQuestions[i].id.toString(),
            value: dealerFeedbackFormAsnwerTypes.isNotEmpty
                ? (getAnswerType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(2) ? "" : "false")
                : "false",
            // kPIFormAnswerType
            evaluation: dealerFeedbackFormAsnwerTypes.isNotEmpty
                ? (getAnswerType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(1) ? "" : "false")
                : "false",
            feedback: dealerFeedbackFormAsnwerTypes.isNotEmpty
                ? (getAnswerType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(3) ? "" : "false")
                : "false",
            uploadImage: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(1) ? "" : "false")
                : "false",
            uploadAudio: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(2) ? "" : "false")
                : "false",
            uploadVideo: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(3) ? "" : "false")
                : "false",
            contactNo: dealerFeedbackFormAttachmentTypes.isNotEmpty
                ? (getAttachmentType(id: dealerFeedbackFormQuestions[i].id!, osformId: dealerFeedbackForm[0].id!).contains(4) ? "" : "false")
                : "false",
            remarks: dealerFeedbackFormQuestions[i].remarks == 1 ? "" : "false");
        feedbackModels.add(data);
        feedbackModelsSave.add(data1);
      }
      isLoading.value = 0;
    } catch (e) {}
  }

  List<int?> getAttachmentType({required int id, required int osformId}) {
    return dealerFeedbackFormAttachmentTypes
        .where(
          (element) => element.questionid == id && element.dfqformId == osformId,
        )
        .map((element) => element.attachmentType)
        .toList();
  }

  List<int?> getAnswerType({required int id, required int osformId}) {
    return dealerFeedbackFormAsnwerTypes
        .where(
          (element) => element.questionid == id && element.dfqformId == osformId,
        )
        .map((element) => element.answerType)
        .toList();
  }

  Future<void> openFilePicker({
    var allow,
    String? value,
    required int index,
  }) async {
    final result = await Utils.filePicker(allow);
    if (result == null) return;

    final newName = "${Utils.getTimeForImageName().toString().trim()}-${user[0].userId.toString()}";
    final filePath = result.paths[0]!;
    final newFilePath = await renameAndSaveImage(imageFile: File(filePath), newName: newName);

    final fileName = fileBaseUrl + path.basename(newFilePath!);
    switch (value) {
      case "Image":
        questionFile(feedbackModelsSave[index].uploadImage, path.basename(newFilePath));
        feedbackModelsSave[index].uploadImage = fileName;
        break;

      case "Audio":
        questionFile(feedbackModelsSave[index].uploadAudio, path.basename(newFilePath));
        feedbackModelsSave[index].uploadAudio = fileName;
        break;

      default:
        questionFile(feedbackModelsSave[index].uploadVideo, path.basename(newFilePath));
        feedbackModelsSave[index].uploadVideo = fileName;
        break;
    }

    checkFeedbackModel();
  }

  Future<void> questionFile(String? oldVal, String newVal) async {
    try {
      if (oldVal == null || oldVal.isEmpty) {
        saveFile.add(newVal);
      } else {
        final index = saveFile.indexOf(oldVal);
        if (index != -1) {
          saveFile[index] = newVal;
        } else {
          throw Exception('$oldVal not found in saveFile list.');
        }
      }
    } catch (e) {
      // Handle the error here
      print('Error: $e');
      // You can add more specific error handling or logging here if needed
    }
  }

  bool checkFeedbackModel() {
    for (var model in feedbackModelsSave) {
      feedbackModelsSave.refresh();
      if (model.value == "" ||
          model.evaluation == "" ||
          model.uploadVideo == "" ||
          model.uploadAudio == "" ||
          model.uploadImage == "" ||
          model.feedback == "" ||
          // model.remarks == "" ||
          model.contactNo == "") {
        isValidState.value = false;
        feedbackModelsSave;

        return false;
      }
    }
    feedbackModelsSave;
    isValidState.value = true;

    return true;
  }

  fdFormSaveData(BuildContext context) async {
    try {
      isLoading.value = 2;
      await getCurrentPosition(context).then((value) {
        lat.value = value!.latitude.toString();
        lon.value = value.longitude.toString();

        if (lat.value != "") {
          isLoading.value = 0;
          Utils.showAlertDialog(
              context: context,
              callback: () async {
                Get.back();
                isLoading.value = 2;
                FeedbackModelsRequest data = FeedbackModelsRequest(
                    lat: lat.value,
                    lon: lon.value,
                    userId:user[0].userId.toString(),
                    DFQFormId: DFQFormId.value.toString(),
                    dealerType: dealerTypeID.value.toString(),
                    dealerId: dealerId.value.toString(),
                    feedbackModels: feedbackModelsSave);
                // .toJson() as KpiFormRequest;
                print(jsonEncode(data.toJson()));

                // var formData = {
                //   "isSync": 0,
                //   "DFQForms":jsonEncode(data.toJson()),
                // };
                Map<String, dynamic> jsonData = {
                  "isSync": 0,
                  "DFQForms": jsonEncode(data.toJson()), // Call toJson() to get the map
                };
             int id=   await DatabaseHelper.insertDFQRequestForm(data:jsonData);
                // await DatabaseHelper.formRequestUpdate(id: requestID.value, columnName: "DFQForms", val: jsonEncode(data.toJson()));
                if (dFQFormFileId.value != -1) {
                  await DatabaseHelper.dFQFormFileUpdate(id: dFQFormFileId.value, val: jsonEncode(saveFile));
                } else {
                  List formFile=[];

                  for(int i=0; i<saveFile.length; i++){
                    formFile.add({
                      "status":false,
                      "path":saveFile[i]
                    });
                  }
                  // dFQFormFileId.value = await DatabaseHelper.insertDFQFormFile(jsonEncode(formFile),id);
                  dFQFormFileId.value = await DatabaseHelper.insertDFQFormFile(jsonEncode(saveFile),id);
                }
                DateTime now = DateTime.now();
                final subInfo = SubmitFormInfo(type: "DM FeedBack",
                    requestFormId: id, dealerId: dealerId.value, dealerTypeId: dealerTypeID.value, dateTime: now.toString(), isSync: 0);
                await DatabaseHelper.insertSubmitFormInfoDFQ(data: subInfo.toJson());
                // await DatabaseHelper.deleteRequestForm();

                // await DatabaseHelper.updateKpiFormFileStatus(
                //   id: kpiFileID.value,
                // );
                // await DatabaseHelper.updateOSFormFileStatus(
                //   id: oSFileId.value,
                // );
                // await DatabaseHelper.updateCWMFormFileStatus(
                //   id: cWMFileID.value,
                // );

                await Future.delayed(const Duration(seconds: 2));
                isLoading.value = 0;
                // await DatabaseHelper.insertCurrentPage(AppConst.kpiForm);
                Get.offAllNamed(
                  AppPages.dashboardView,
                );
                Utils.showSnackBar("Save", "Successfully Save Dealer Feedback Form");

                // RequestForm data=RequestForm(isSync: 0, kpiForm:data, osForm: [], cWMForm: [], dFQForm: []
                // Navigator.pushNamed(context, AppPages.dealerFeedbackQuestionFormView, arguments: {
                //   "kpiForm": kpiForm,
                //   "oSForm": oSFormValue,
                //   "CWMF": value,
                // });
              },
              message: '"Your Dealer Feedback  Form \n has been submitted \n\n\n Save Form"');
        }
      });
    } catch (e) {
      isLoading.value = 0;
    }
  }

  /// get current location
  getLocation(BuildContext context) async {
    Position? currentPosition = await getCurrentPosition(context);

    lat.value = currentPosition!.latitude.toString();
    lon.value = currentPosition.longitude.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
