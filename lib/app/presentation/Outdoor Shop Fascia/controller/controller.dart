import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import '../../../data/local/database/database.dart';
import '../../../data/model/OutdoorShopFasciaModel/OutdoorShopFasciaModel.dart';
import '../../../data/model/getSyncData.dart';
import '../../../data/model/userModel.dart';
import '../../../routes/app_page.dart';
import '../../../utils/alertDialog.dart';
import '../../../utils/appConst.dart';
import '../../../utils/changeFilePath.dart';
import '../../../utils/getLatLon.dart';
import '../../../utils/utiles.dart';

class OutdoorShopFasciaController extends GetxController {
  final isLoading = 1.obs;
  RxInt currentValidateIndex = RxInt(-1);
  final fileBaseUrl = "/uploadedfiles/".obs;
  final saveFile = <String>[].obs;
  final checkValidationState = false.obs;
  final dealerType = <DealerType>[].obs;
  final dealer = <Dealers>[].obs;
  final categories = <Categories>[].obs;
  final categoriesIndex = RxInt(-1);
  final oSFormId = RxInt(-1);
  final oSFileId = RxInt(-1);
  final oSForm = <OSForm>[].obs;
  final oSFormBoardImages = <OSFormBoardImages>[].obs;
  final oSFormBoardDescription = <OSFormBoardDescription>[].obs;
  final oSFormAttachmentType = <OSFormAttachmentType>[].obs;
  final outdoorShopFasciaModel = <OutdoorShopFasciaModel>[].obs;
  final outdoorShopFasciaSave = <OutdoorShopFasciaModel>[].obs;
  final oSFormAnswerType = <OSFormAnswerType>[].obs;
  final categoryTypesID = RxInt(-1);
  final dealerTypeId = RxInt(-1);
  final dealerId = RxInt(-1);
  final user = <UserModel>[].obs;
  final kpiFileID = RxInt(-1);
  final requestID = RxInt(-1);
  final isValidState = false.obs;
  final lat = RxString("");
  final lon = RxString('');
  // Categories
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
  /// get dealer type
  Future<void> getDealer() async {
    // isLoading.value = 1;
    try {
      categories.clear();
      await DatabaseHelper.insertCurrentPage(AppConst.oSForm);

      final kpiFormIds = await DatabaseHelper.getKpiFormIDS();
      if (kpiFormIds.isNotEmpty) {
        dealerTypeId.value = kpiFormIds[0]["dealerTypeID"];
        dealerId.value = kpiFormIds[0]["dealerID"];
        requestID.value = kpiFormIds[0]["requestFormID"];
        kpiFileID.value = kpiFormIds[0]["kpiFileID"];
        final getUser = await DatabaseHelper.getUsers();
        for (var result in getUser) {
          user.add(UserModel.fromJson(result));
        }
      } else {
        throw Exception("KPI form IDs not found");
      }

      // Get dealer types
      final results = await DatabaseHelper.getDealerType();
      dealerType.clear();
      for (var result in results) {
        dealerType.add(DealerType.fromJson(result));
      }

      // Get dealer details
      if (dealerId.value != -1) {
        dealer.clear();
        final result = await DatabaseHelper.getDealer(dealerTypeId.value);
        for (var dealerResult in result) {
          dealer.add(Dealers.fromJson(dealerResult));
        }

        categoryTypesID.value = dealer[dealer.indexWhere((item) => item.dealerType == dealerTypeId.value && item.id == dealerId.value)].categoryType!;

      } else {
        throw Exception("Dealer ID is null");
      }

      // Get categories
      getCategories();
    } catch (e) {

      isLoading.value = 0;
      print('Error in getDealer: $e');
      // Handle error or show error dialog to the user
    }
  }

  /// get categories
  Future<void> getCategories() async {
    try {

      categories.clear();
      categories.addAll((await DatabaseHelper.getCategories()).map((value) => Categories.fromJson(value)));



      getOSForm(categoryTypesID.value);
      // isLoading.value = 1;
    } catch (e) {
      print('Error in getCategories: $e');
      // Handle error or show error dialog to the user
    }
  }

  /// get os Form
  Future<void> getOSForm(int categoryType) async {
    try {

      oSForm.clear();
      oSForm.addAll(
          (await DatabaseHelper.getOSForm( dealerTypeId: dealerTypeId.value,categoryType: categoryType )).map((value) => OSForm.fromJson(value)));
      List<int> osFormIds=[];
      print(oSForm[0].id);
      osFormIds.add(oSForm[0].id!);

      // kpiFormIds.addAll(kPIForm)
      // for(int i=0; i<oSForm.value.length; i++){
      //   osFormIds.add(oSForm[i].id!);
      // }
      oSFormBoardDescription.clear();
      // oSFormBoardDescription.addAll((await DatabaseHelper.getOSFormBoardDescription(osformIds:osFormIds, ))
      oSFormBoardDescription.addAll((await DatabaseHelper.getOSFormBoardDescription(osformId: oSForm[0].id!, categoryType: categoryType))
          .map((value) => OSFormBoardDescription.fromJson(value)));

      oSFormAttachmentType.clear();
      oSFormAttachmentType
          .addAll((await DatabaseHelper.getOSFormAttachmentType(osformIds: osFormIds)).map((value) => OSFormAttachmentType.fromJson(value)));

      oSFormAnswerType.addAll((await DatabaseHelper.getOSFormAnswerType(osformIds: osFormIds)).map((value) => OSFormAnswerType.fromJson(value)));
      oSFormBoardImages.clear();
      oSFormBoardImages
          .addAll((await DatabaseHelper.getOSFormBoardImages(osformIds: osFormIds)).map((value) => OSFormBoardImages.fromJson(value)));

      outdoorShopFasciaModel.clear();
      outdoorShopFasciaSave.clear();
      oSFormId.value = oSForm[0].id!;

      for (var i = 0; i < oSFormBoardDescription.length; i++) {

        OutdoorShopFasciaModel data = OutdoorShopFasciaModel(
          // boarDescription: oSFormBoardDescription[oSFormBoardDescription.indexWhere((element) => element.id == oSForm[0].id)].boarddescription,
          boarDescription: oSFormBoardDescription[i].boarddescription,
          imagePath:
          oSFormBoardImages.isNotEmpty?oSFormBoardImages:[],
              // ? oSFormBoardImages.where((image) => image.boardid == oSFormBoardDescription[i].osformId).toList()
              // : [],
          // oSFormBoardImages.isNotEmpty
          //     ? (oSFormBoardImages
          //         .where((image) => image.boardid == oSFormBoardDescription[i].id || image.formid == osFormIds)
          //         .map((image) => image.path ?? "")
          //         .cast<String>()
          //         .toList())
          //     : [],
          boardDescriptionId: oSFormBoardDescription[i].id.toString(),
          // oSForm[i].id!.toString(),
          categoryId: categoryType.toString(),
          value: oSFormAnswerType.isNotEmpty
              ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(2) ? "" : "false")
              : "false",
          evaluation: oSFormAnswerType.isNotEmpty
              ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(1) ? "" : "false")
              : "false",
          feedback: oSFormAnswerType.isNotEmpty
              ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(3) ? "" : "false")
              : "false",
          uploadImage: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(1) ? "" : "false")
              : "false",
          uploadAudio: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(2) ? "" : "false")
              : "false",
          uploadVideo: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(3) ? "" : "false")
              : "false",
          contactNo: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(4) ? "" : "false")
              : "false",
          remarks: oSFormBoardDescription[i].remarks == 1 ? "" : "false",
        );

        OutdoorShopFasciaModel data1 = OutdoorShopFasciaModel(
          formID:oSFormBoardDescription[i].osformId.toString(),
          boardDescriptionId:oSFormBoardDescription[i].id.toString(),
          // boardDescriptionId:oSFormBoardDescription[i].boarddescription,
          categoryId: categoryType.toString(),
          value: oSFormAnswerType.isNotEmpty
              ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(2) ? "" : "false")
              : "false",
          evaluation: oSFormAnswerType.isNotEmpty
              ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(1) ? "" : "false")
              : "false",
          feedback: oSFormAnswerType.isNotEmpty
              ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(3) ? "" : "false")
              : "false",
          uploadImage: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(1) ? "" : "false")
              : "false",
          uploadAudio: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(2) ? "" : "false")
              : "false",
          uploadVideo: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(3) ? "" : "false")
              : "false",
          contactNo: oSFormAttachmentType.isNotEmpty
              ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(4) ? "" : "false")
              : "false",
          remarks: oSFormBoardDescription[i].remarks == 1 ? "" : "false",
        );

        outdoorShopFasciaSave.add(data1);
        outdoorShopFasciaModel.add(data);
        isLoading.value = 0;
      }

      // for (var i = 0; i < oSFormBoardDescription.length; i++) {
      //
      //   OutdoorShopFasciaModel data = OutdoorShopFasciaModel(
      //     // boarDescription: oSFormBoardDescription[oSFormBoardDescription.indexWhere((element) => element.id == oSForm[0].id)].boarddescription,
      //     boarDescription: oSFormBoardDescription[i].boarddescription,
      //     imagePath:
      //     oSFormBoardImages.isNotEmpty?oSFormBoardImages:[],
      //         // ? oSFormBoardImages.where((image) => image.boardid == oSFormBoardDescription[i].osformId).toList()
      //         // : [],
      //     // oSFormBoardImages.isNotEmpty
      //     //     ? (oSFormBoardImages
      //     //         .where((image) => image.boardid == oSFormBoardDescription[i].id || image.formid == osFormIds)
      //     //         .map((image) => image.path ?? "")
      //     //         .cast<String>()
      //     //         .toList())
      //     //     : [],
      //     boardDescriptionId: oSFormBoardDescription[i].id.toString(),
      //     // oSForm[i].id!.toString(),
      //     categoryId: categoryType.toString(),
      //     value: oSFormAnswerType.isNotEmpty
      //         ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(2) ? "" : "false")
      //         : "false",
      //     evaluation: oSFormAnswerType.isNotEmpty
      //         ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(1) ? "" : "false")
      //         : "false",
      //     feedback: oSFormAnswerType.isNotEmpty
      //         ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(3) ? "" : "false")
      //         : "false",
      //     uploadImage: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(1) ? "" : "false")
      //         : "false",
      //     uploadAudio: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(2) ? "" : "false")
      //         : "false",
      //     uploadVideo: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(3) ? "" : "false")
      //         : "false",
      //     contactNo: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(4) ? "" : "false")
      //         : "false",
      //     remarks: oSFormBoardDescription[i].remarks == 1 ? "" : "false",
      //   );
      //
      //   OutdoorShopFasciaModel data1 = OutdoorShopFasciaModel(
      //     formID:oSFormBoardDescription[i].osformId.toString(),
      //     boardDescriptionId:oSFormBoardDescription[i].boarddescription,
      //     categoryId: categoryType.toString(),
      //     value: oSFormAnswerType.isNotEmpty
      //         ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(2) ? "" : "false")
      //         : "false",
      //     evaluation: oSFormAnswerType.isNotEmpty
      //         ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(1) ? "" : "false")
      //         : "false",
      //     feedback: oSFormAnswerType.isNotEmpty
      //         ? (getAnswerType(id: oSFormBoardDescription[i].id!, osformId: osFormIds).contains(3) ? "" : "false")
      //         : "false",
      //     uploadImage: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(1) ? "" : "false")
      //         : "false",
      //     uploadAudio: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(2) ? "" : "false")
      //         : "false",
      //     uploadVideo: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(3) ? "" : "false")
      //         : "false",
      //     contactNo: oSFormAttachmentType.isNotEmpty
      //         ? (getAttachmentType(id: oSFormBoardDescription[i].id!, osformId:osFormIds).contains(4) ? "" : "false")
      //         : "false",
      //     remarks: oSFormBoardDescription[i].remarks == 1 ? "" : "false",
      //   );
      //
      //   outdoorShopFasciaSave.add(data1);
      //   outdoorShopFasciaModel.add(data);
      //   isLoading.value = 0;
      // }

      isLoading.value = 0;
    } catch (e) {
      isLoading.value = 0;
      print('Error in getOSForm: $e');
      // Handle error or show error dialog to the user
    }
  }
  List<int?> getAttachmentType({required int id, required List<int> osformId}) {
    try {
      return oSFormAttachmentType
          .where((element) => element.boardid == id && osformId.contains(element.osFiascaformid))
          .map((element) => element.attachmentType)
          .toList();
    } catch (e) {
      print('Error in getAttachmentType: $e');
      // Handle error or return an empty list if an error occurs
      return [];
    }
  }

  // List<int?> getAttachmentType({required int id, required int osformId}) {
  //   try {
  //     return oSFormAttachmentType
  //         .where((element) => element.boardid == id && element.osFiascaformid == osformId)
  //         .map((element) => element.attachmentType)
  //         .toList();
  //   } catch (e) {
  //     print('Error in getAttachmentType: $e');
  //     // Handle error or return an empty list if an error occurs
  //     return [];
  //   }
  // }

  // List<int?> getAnswerType({required int id, required int osformId}) {
  //   try {
  //     return oSFormAnswerType
  //         .where((element) => element.boardid == id && element.osFiascaformid == osformId)
  //         .map((element) => element.answerType)
  //         .toList();
  //   } catch (e) {
  //     print('Error in getAnswerType: $e');
  //     // Handle error or return an empty list if an error occurs
  //     return [];
  //   }
  // }
  List<int?> getAnswerType({required int id, required List<int> osformId}) {
    try {
      return oSFormAnswerType
          .where((element) => element.boardid == id && osformId.contains(element.osFiascaformid))
          .map((element) => element.answerType)
          .toList();
    } catch (e) {
      print('Error in getAnswerType: $e');
      // Handle error or return an empty list if an error occurs
      return [];
    }
  }


  bool checkOSFormQuestionModel() {
    outdoorShopFasciaSave.refresh();
    isValidState.value =false;
    // debugger();
    // for (int i = 0; i < outdoorShopFasciaSave.length; i++) {
      // debugger();
    for (int index = 0; index < outdoorShopFasciaSave.length; index++) {
    var model = outdoorShopFasciaSave[index];
    if (model.value == "" ||
    model.evaluation == "" ||
    model.uploadVideo == "" ||
    model.uploadAudio == "" ||
    model.uploadImage == "" ||
    model.feedback == "" ||
    model.contactNo == ""
    // model.remarks == ""
    ) {
    //   debugger();
    // isValidState.value = false;
      currentValidateIndex.value == -1 ? currentValidateIndex.value = index : "";
      outdoorShopFasciaSave;
    // return false;
    }else{
      // debugger();
      isValidState.value =true;

    }
    }
  // for (var model in outdoorShopFasciaSave) {
    //   if (model.value == "" ||
    //       model.evaluation == "" ||
    //       model.uploadVideo == "" ||
    //       model.uploadAudio == "" ||
    //       model.uploadImage == "" ||
    //       model.feedback == "" ||
    //       model.contactNo == "" ||
    //       model.remarks == "") {
    //     isValidState.value = false;
    //     outdoorShopFasciaSave;
    //     return false;
    //   }
    // }
    outdoorShopFasciaSave;
    // isValidState.value = true;

    return true;
  }



  // for (int i = 0; i < outdoorShopFasciaSave.length; i++) {
  // var model = outdoorShopFasciaSave[i];
  // if (model.value == "" ||
  // model.evaluation == "" ||
  // model.uploadVideo == "" ||
  // model.uploadAudio == "" ||
  // model.uploadImage == "" ||
  // model.feedback == "" ||
  // model.contactNo == "" ||
  // model.remarks == "") {
  // isValidState.value = false;
  // outdoorShopFasciaSave;
  // return false;
  // }
  // }





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
        questionFile(outdoorShopFasciaSave[index].uploadImage, path.basename(newFilePath));
        outdoorShopFasciaSave[index].uploadImage = fileName;
        break;

      case "Audio":
        questionFile(outdoorShopFasciaSave[index].uploadAudio, path.basename(newFilePath));
        outdoorShopFasciaSave[index].uploadAudio = fileName;
        break;

      default:
        questionFile(outdoorShopFasciaSave[index].uploadVideo, path.basename(newFilePath));
        outdoorShopFasciaSave[index].uploadVideo = fileName;
        break;
    }

    checkOSFormQuestionModel();
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

  oSFormSaveData({
    required BuildContext context,
  }) async {
    try {
      isLoading.value = 2;

      // if (position == null) {
      //   throw Exception('Failed to get location');
      // }
      // lat.value = position.latitude.toString();
      // lon.value = position.longitude.toString();
      await getCurrentPosition(context).then((value) {
        isLoading.value = 0;
        lat.value = value!.latitude.toString();
        lon.value = value.longitude.toString();

        if (lat.value != "") {
          Utils.showAlertDialog(
            context: context,
            callback: () async {
              try {
                isLoading.value = 2;
                Get.back();
                OutdoorShopFasciaRequest data = OutdoorShopFasciaRequest(
                  lat: lat.value,
                  lon: lon.value,
                  dealerId: dealerId.value.toString(),
                  osFormId: oSFormId.value.toString(),
                  dealerType: dealerTypeId.value.toString(),
                  outdoorShopFasciaModel: outdoorShopFasciaSave,
                );

                String dataJson = jsonEncode(data.toJson());

                await DatabaseHelper.formRequestUpdate(
                  id: requestID.value,
                  columnName: "OSForms",
                  val: dataJson,
                );

                if (oSFileId.value != -1) {
                  await DatabaseHelper.oSFormFileUpdate(
                    id: oSFileId.value,
                    val: jsonEncode(saveFile),
                  );
                } else {
                  List formFile=[];

                  for(int i=0; i<saveFile.length; i++){
                    formFile.add({
                      "status":false,
                      "path":saveFile[i]
                    });
                  }
                  // oSFileId.value = await DatabaseHelper.insertOSFormFile(jsonEncode(formFile),requestID.value);
                  oSFileId.value = await DatabaseHelper.insertOSFormFile(jsonEncode(saveFile),requestID.value);
                }

                await DatabaseHelper.insertOSFormSaveID(
                  oSFileID: oSFileId.value,
                  dealerType: dealerTypeId.value,
                  dealerID: dealerId.value,
                  requestFormID: requestID.value,
                  categoriesType: categoryTypesID.value, kpiFileID: kpiFileID.value,
                );

                await Future.delayed(const Duration(seconds: 2));
                Utils.showSnackBar("Save", "Successfully Save OSForm");
                isLoading.value = 0;
                Get.offAllNamed(AppPages.categoryWiseModelFormAssignView);
              } catch (e) {
                isLoading.value = 0;
                print('Error during database operations: $e');
                // Handle error or show error dialog to the user
              }
            },
            message: '"Your Outdoor Shop Fascia Form \n has been submitted \n\n\nGo to next form",',
          );
        } else {
          isLoading.value = 0;
        }
      });
    } catch (e) {
      isLoading.value = 0;
      print('Error during location fetching: $e');
      // Handle error or show error dialog to the user
    }
  }
}
