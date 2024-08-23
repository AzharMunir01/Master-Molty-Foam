import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';

import '../../../data/local/database/database.dart';
import '../../../data/model/CategotoesWMFAModel/CategotoesWMFAModel.dart';
import '../../../data/model/getSyncData.dart';
import '../../../data/model/submissionFormInfo.dart';
import '../../../data/model/userModel.dart';
import '../../../routes/app_page.dart';
import '../../../utils/appConst.dart';
import '../../../utils/changeFilePath.dart';
import '../../../utils/getLatLon.dart';
import '../../../utils/utiles.dart';

class CategoryWiseModelFormAssignController extends GetxController {
  final isLoading = RxInt(1);
  final fileBaseUrl = "/uploadedfiles/".obs;
  RxInt dealerTypeId = (-1).obs;
  RxInt dealerId = (-1).obs;
  RxInt currentValidateIndex = RxInt(-1);
  ///
  final oSFormFileId = RxInt(-1);
  RxInt kpiFileID = (-1).obs;
  RxInt categoriesType = (-1).obs;
  RxInt requestID = (-1).obs;
  final saveFile = <String>[].obs;
  RxInt cWMFileID = (-1).obs;
  final dealerTypes = <DealerType>[].obs;
  final dealers = <Dealers>[].obs;
  final categories = <Categories>[].obs;
  RxInt cMFormMId = (-1).obs;
  final categoryWiseModelForm = <CategoryWiseModelForm>[].obs;
  final categoryWiseModelFormFormImages = <CategoryWiseModelFormFormImages>[].obs;
  final categoryWiseModelFormModels = <CategoryWiseModelFormModels>[].obs;
  final categoryWiseModelFormAttachmentType = <CategoryWiseModelFormAttachmentType>[].obs;
  final categoryWiseModelFormAnswerType = <CategoryWiseModelFormAnswerType>[].obs;
  final categoriesWMFAModel = <CategoriesWMFAModel>[].obs;
  final categoriesWMFASave = <CategoriesWMFAModel>[].obs;
  final isValidState = false.obs;
  final checkValidationState = false.obs;
  final lat = RxString("");
  final lon = RxString("");
  final oSFileId = RxInt(-1);
  final user = <UserModel>[].obs;
  @override
  void onInit() {
    super.onInit();

    getDealer();
  }
  bool isValidMobileNumber(String number) {
    // Define the regex pattern for validating mobile numbers
    final RegExp regex = RegExp(r"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$");

    // Check if the number matches the regex pattern
    return regex.hasMatch(number);
  }
  Future<void> getDealer() async {
    try {
      await DatabaseHelper.insertCurrentPage(AppConst.cWMForm);

      /// get kpi form ids
      final kpiFormIds = await DatabaseHelper.getOSFormIDS();
      dealerTypeId.value = await kpiFormIds[0]["dealerTypeID"];
      dealerId.value = await kpiFormIds[0]["dealerID"];
      requestID.value = await kpiFormIds[0]["requestFormID"];
      kpiFileID.value = await kpiFormIds[0]["kpiFileID"];
      oSFileId.value = await kpiFormIds[0]["oSFileID"];
      categoriesType.value = await kpiFormIds[0]["categoriesType"];
      final results = await DatabaseHelper.getDealerType();
      dealerTypes.clear();
      for (var result in results) {
        dealerTypes.add(DealerType.fromJson(result));
      }
      dealers.clear();
      final result = await DatabaseHelper.getDealer(dealerTypeId.value);
      // final result = await DatabaseHelper.getDealer(dealerId.value);

      for (var result in result) {
        dealers.add(Dealers.fromJson(result));
      }
      final getUser = await DatabaseHelper.getUsers();
      for (var result in getUser) {
        user.add(UserModel.fromJson(result));
      }
      /// get category

      categories.clear();
      final data = await DatabaseHelper.getCategories();

      for (var result in data) {
        categories.add(Categories.fromJson(result));
      }

      /// get categoris
      getCategoryWiseModelForm(categoryType: categoriesType.value);
    } catch (e) {}
  }

  getCategoryWiseModelForm({int? categoryType}) async {
    try {
      categoryWiseModelForm.clear();
      categoryWiseModelForm
          .addAll((await DatabaseHelper.getCategoryWiseModelForm(catogryType: categoryType!)).map((value) => CategoryWiseModelForm.fromJson(value)));
      categoryWiseModelFormModels.clear();
      categoryWiseModelFormModels.addAll(
          (await DatabaseHelper.getCategoryWiseModelFormModels(catogryType: categoryType!, cwmformId: categoryWiseModelForm[0].id!))
              .map((value) => CategoryWiseModelFormModels.fromJson(value)));

      categoryWiseModelFormAttachmentType.clear();
      categoryWiseModelFormAttachmentType.addAll(
          (await DatabaseHelper.getCategoryWiseModelFormAttachmentType(cwmformId: categoryWiseModelForm[0].id!))
              .map((value) => CategoryWiseModelFormAttachmentType.fromJson(value)));

      categoryWiseModelFormAnswerType.clear();
      categoryWiseModelFormAnswerType.addAll((await DatabaseHelper.getCategoryWiseModelFormAnswerType(cwmformId: categoryWiseModelForm[0].id!))
          .map((value) => CategoryWiseModelFormAnswerType.fromJson(value)));

      categoryWiseModelFormFormImages.clear();
      categoryWiseModelFormFormImages.addAll((await DatabaseHelper.getCategoryWiseModelFormFormImages(osformId: categoriesType.value!))
          .map((value) => CategoryWiseModelFormFormImages.fromJson(value)));
      categoriesWMFAModel.clear();
      categoriesWMFASave.clear();
      cMFormMId.value = categoryWiseModelForm[0].id!;
      for (var i = 0; i < categoryWiseModelFormModels.length; i++) {
        CategoriesWMFAModel data = CategoriesWMFAModel(
            imagesPath: categoryWiseModelFormFormImages.isNotEmpty
                ? categoryWiseModelFormFormImages
                    .where((image) => image.categoryType == categoryWiseModelFormModels[i].categoryType || image.id == categoryWiseModelForm[0].id)
                    .map((image) => image.path ?? "")
                    .cast<String>()
                    .toList()
                : [],
            categoriesWiseFormId: categoryWiseModelForm[0].id!.toString(),
            categoryId: categoryType.toString(),
            value: categoryWiseModelFormAnswerType.isNotEmpty
                ? (getAnswerType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(2) ? "" : "false")
                : "false",
            // kPIFormAnswerType
            evaluation: categoryWiseModelFormAnswerType.isNotEmpty
                ? (getAnswerType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(1) ? "" : "false")
                : "false",
            feedback: categoryWiseModelFormAnswerType.isNotEmpty
                ? (getAnswerType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(3) ? "" : "false")
                : "false",
            uploadImage: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(1) ? "" : "false")
                : "false",
            uploadAudio: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(2) ? "" : "false")
                : "false",
            uploadVideo: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(3) ? "" : "false")
                : "false",
            contactNo: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(4) ? "" : "false")
                : "false",
            remarks: categoryWiseModelFormModels[i].remarks == 1 ? "" : "false");

        CategoriesWMFAModel data1 = CategoriesWMFAModel(
            formID:categoryWiseModelForm[0].id.toString(),
            // dealerType: dealerType,
            // dealerId: dealerId,
            // cMFormMId: categoryWiseModelForm[0].id,
            categoriesWiseFormId: categoryWiseModelFormModels[i].id!.toString(),
            categoryId: categoryType.toString(),
            value: categoryWiseModelFormAnswerType.isNotEmpty
                ? (getAnswerType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(2) ? "" : "false")
                : "false",
            // kPIFormAnswerType
            evaluation: categoryWiseModelFormAnswerType.isNotEmpty
                ? (getAnswerType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(1) ? "" : "false")
                : "false",
            feedback: categoryWiseModelFormAnswerType.isNotEmpty
                ? (getAnswerType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(3) ? "" : "false")
                : "false",
            uploadImage: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(1) ? "" : "false")
                : "false",
            uploadAudio: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(2) ? "" : "false")
                : "false",
            uploadVideo: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(3) ? "" : "false")
                : "false",
            contactNo: categoryWiseModelFormAttachmentType.isNotEmpty
                ? (getAttachmentType(id: categoryWiseModelFormModels[i].id!, cwmformId: categoryWiseModelForm[0].id!).contains(4) ? "" : "false")
                : "false",
            remarks: categoryWiseModelFormModels[i].remarks == 1 ? "" : "false");
        categoriesWMFAModel.add(data);
        categoriesWMFASave.add(data1);
      }
      isLoading.value = 0;
    } catch (e) {
      isLoading.value = 0;
    }
  }

  List<int?> getAttachmentType({required int id, required int cwmformId}) {
    return categoryWiseModelFormAttachmentType
        .where(
          (element) => element.modelid == id && element.cwmformId == cwmformId,
        )
        .map((element) => element.attachmentType)
        .toList();
  }

  List<int?> getAnswerType({required int id, required int cwmformId}) {
    return categoryWiseModelFormAnswerType
        .where(
          (element) => element.modelid == id && element.cwmformId == cwmformId,
        )
        .map((element) => element.answerType)
        .toList();
  }

  bool checkCWFormQuestionModel() {
    currentValidateIndex.value = -1;
    categoriesWMFASave.refresh();
    // for (var model in categoriesWMFASave) {
    for (int index = 0; index < categoriesWMFASave.length; index++) {
      var model = categoriesWMFASave[index];
      if (model.value == "" ||
          model.evaluation == "" ||
          model.uploadVideo == "" ||
          model.uploadImage == "" ||
          model.uploadAudio == "" ||
          model.feedback == "" ||
          model.contactNo == ""
          // model.remarks == ""
      )
      {
        currentValidateIndex.value == -1 ? currentValidateIndex.value = index : ""; // Set the index of the invalid model
        isValidState.value = false;
        categoriesWMFASave;

        return false;
      }
    }
    categoriesWMFASave;
    isValidState.value = true;

    return true;
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
        questionFile(categoriesWMFASave[index].uploadImage, path.basename(newFilePath));
        categoriesWMFASave[index].uploadImage = fileName;
        break;

      case "Audio":
        questionFile(categoriesWMFASave[index].uploadAudio, path.basename(newFilePath));
        categoriesWMFASave[index].uploadAudio = fileName;
        break;

      default:
        questionFile(categoriesWMFASave[index].uploadVideo, path.basename(newFilePath));
        categoriesWMFASave[index].uploadVideo = fileName;
        break;
    }

    checkCWFormQuestionModel();
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

  cWMSaveData({
    required BuildContext context,
  }) async {
    isLoading.value = 2;

    // .toJson() as KpiFormRequest;

    await getCurrentPosition(context).then((value) {
      isLoading.value = 0;
      lat.value = value!.latitude.toString();
      lon.value = value.longitude.toString();

      if (lat.value != "") {
        CategoriesWMFRequest data = CategoriesWMFRequest(
            lat: lat.value,
            lon: lon.value,
            cMFormMId: cMFormMId.toString(),
            dealerType: dealerTypeId.toString(),
            dealerId: dealerId.toString(),
            categoriesWMFAModel: categoriesWMFASave);
        jsonEncode(data.toJson());
        Utils.showAlertDialog(
            context: context,
            callback: () async {
              Get.back();
              isLoading.value = 2;
              await DatabaseHelper.formRequestUpdate(id: requestID.value, columnName: "CWMForms", val: jsonEncode(data.toJson()));
              if (cWMFileID.value != -1) {
                await DatabaseHelper.cWMFormFileUpdate(id: cWMFileID.value, val: jsonEncode(saveFile));
              } else {
                List formFile=[];

                for(int i=0; i<saveFile.length; i++){
                  formFile.add({
                    "status":false,
                    "path":saveFile[i]
                  });
                }
                // cWMFileID.value = await DatabaseHelper.insertCWMFormFile(jsonEncode(formFile),requestID.value);
                cWMFileID.value = await DatabaseHelper.insertCWMFormFile(jsonEncode(saveFile),requestID.value);
              }

              await DatabaseHelper.updateKpiFormFileStatus(
                id: kpiFileID.value,
              );
              await DatabaseHelper.updateOSFormFileStatus(
                id: oSFileId.value,
              );
              await DatabaseHelper.updateCWMFormFileStatus(
                id: cWMFileID.value,
              );
              await DatabaseHelper.insertCurrentPage(AppConst.kpiForm);
              DateTime now = DateTime.now();
              final subInfo = SubmitFormInfo(
                type: "KPI Monitoring",
                  requestFormId: requestID.value, dealerId: dealerId.value, dealerTypeId: dealerTypeId.value, dateTime: now.toString(), isSync: 0);
              await DatabaseHelper.insertSubmitFormInfo(data: subInfo.toJson());
              // await DatabaseHelper.deleteRequestForm();
              // await DatabaseHelper.insertCWMFormSaveID(
              //   kpiFileID: kpiFileID.value,
              //   oSFileID: oSFileId.value,
              //   cWMFileID: cWMFileID.value,
              //   dealerType: dealerTypeId.value,
              //   dealerID: dealerId.value,
              //   requestFormID: requestID.value,
              // );
              await Future.delayed(const Duration(seconds: 2));
              isLoading.value = 0;
              Utils.showSnackBar("Save", "Successfully Save Category Wise Form");
              Get.offAllNamed(
                AppPages.dashboardView,
              );
            },
            message: "Your Category Wise Form \n has been submitted \n\n\nSave form");
      }
    });
  }

  /// get current location
  getLocation(BuildContext context) async {
    Position? currentPosition = await getCurrentPosition(context);

    lat.value = currentPosition!.latitude.toString();
    lon.value = currentPosition.longitude.toString();
  }
}
