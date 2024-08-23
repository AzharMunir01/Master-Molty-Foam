import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../data/local/database/database.dart';
import '../../../data/model/getSyncData.dart';
import '../../../data/model/kpiFormModel/kpiQuestionModel.dart';
import '../../../data/model/requestFormModel/requestFormMOdel.dart';
import '../../../data/model/submissionFormInfo.dart';
import '../../../data/model/userModel.dart';
import '../../../netWorking/apiAuth.dart';
import '../../../routes/app_page.dart';
import '../../../utils/alertDialog.dart';
import '../../../utils/appConst.dart';
import '../../../utils/changeFilePath.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import '../../../utils/getLatLon.dart';
import '../../../utils/utiles.dart';

class KpiFormController extends GetxController {
  final fileBaseUrl = "/uploadedfiles/".obs;
  final requestID = RxInt(-1);
  RxInt currentValidateIndex = RxInt(-1);
  final liItemCont = <RxInt>[].obs;
  final kpiFormFileId = RxInt(-1);
  final saveFile = <String>[].obs;
  final isLoading = RxInt(1);
  final isValidState = false.obs;
  final checkValidationState = false.obs;
  final dealerType = <DealerType>[].obs;
  final dealerTypeId = RxInt(0);
  final dealerId = RxInt(-1);
  final kPIFormId = RxInt(-1);
  final dealer = <Dealers>[].obs;
  final kPIForm = <KPIForm>[].obs;
  final kPIFormQuestions = <KPIFormQuestions>[].obs;
  final kpiQuestionModel = <KpiQuestionModel>[].obs;
  RxList<KpiQuestionModel> kpiQuestionSave = <KpiQuestionModel>[].obs;
  final kPIFormAttachmentType = <KPIFormAttachmentType>[].obs;
  final kPIFormAnswerType = <KPIFormAnswerType>[].obs;
  final attachmentType = <AttachmentType>[].obs;
  final answerType = <AnswerType>[].obs;
  final selectedDealerIndex = RxInt(-1);
  final imageFile = Rxn<PickedFile>();
  final dealerFilePath = Rxn<String>();
  final lat = RxString("");
  final selectedId =RxInt(-1);
  final lon = RxString('');
  final formSubmitFormInfo = <SubmitFormInfo>[].obs;
  final user = <UserModel>[].obs;
  RxList<int> todayDealerIds = <int>[].obs;
  @override
  void onInit() {
    super.onInit();
    getDealerDB();
  }

  bool isValidMobileNumber(String number) {
    // Define the regex pattern for validating mobile numbers
    final RegExp regex = RegExp(r"^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$");

    // Check if the number matches the regex pattern
    return regex.hasMatch(number);
  }

  /// get dealer type list
  Future<void> getDealerDB() async {
    try {
      // final data = await DatabaseHelper.getCurrentPage();

      await DatabaseHelper.insertCurrentPage(AppConst.kpiForm);
      final results = await DatabaseHelper.getDealerType();
      final getUser = await DatabaseHelper.getUsers();
      for (var result in getUser) {
        user.add(UserModel.fromJson(result));
      }
      dealerType.clear();
      todayDealerIds.clear();
      formSubmitFormInfo.clear();
      for (var result in results) {
        dealerType.add(DealerType.fromJson(result));
      }
      final currentDate = DateTime.now();
      final currentDay = DateFormat('yyyy-MM-dd').format(currentDate); // Format should match the date format in formSubmitFormInfo
      formSubmitFormInfo.addAll((await DatabaseHelper.getSubmitFormInfo()).map((e) => SubmitFormInfo.fromJson(e)));
      for(int i=0; i<formSubmitFormInfo.length; i++){
        DateFormat('yyyy-MM-dd').format(DateTime.parse(formSubmitFormInfo[i].dateTime!))==currentDay?
        todayDealerIds.add(formSubmitFormInfo[i].dealerId!):"";
      }

      /// get attachmentType
      final attachmentTypeData = await DatabaseHelper.getAttachmentType();
      for (var result in attachmentTypeData) {
        attachmentType.add(AttachmentType.fromJson(result));
      }

      /// get answerType
      final answerTypeData = await DatabaseHelper.getAnswerTypeData();
      for (var result in answerTypeData) {
        answerType.add(AnswerType.fromJson(result));
      }
      isLoading.value = 0;
    } catch (e) {
      // Handle the error gracefully
      print('Error in getDealerDB: $e');
      // You can show a snackbar, log the error, or handle it in any other appropriate way.
    }
  }

  Future<void> getQuestion(int id) async {
    try {
      isLoading.value = 2;
      await clearField();
      dealerTypeId.value = id;
      final results = await DatabaseHelper.getDealer(dealerTypeId.value);
      dealer.addAll(results.map((result) => Dealers.fromJson(result)));
      kPIForm.clear();
      // final kpiFormData = await DatabaseHelper.getKPIForm(dealerTypeId.value);
      kPIForm.addAll((await DatabaseHelper.getKPIForm(dealerTypeId.value)).map((e) => KPIForm.fromJson(e)));

      if (kPIForm.isNotEmpty) {
        // final kpiForm = KPIForm.fromJson(kpiFormData.first);
        // kPIForm.add(kpiForm);
        // kPIFormId.value = kpiForm.id!;
        List<int> kpiFormIds = [];
        print(kPIForm[0].id);
        // kpiFormIds.addAll(kPIForm)
        for (int i = 0; i < kPIForm.value.length; i++) {
          kpiFormIds.add(kPIForm[i].id!);
        }
        kPIFormQuestions.addAll((await DatabaseHelper.getKPIFormQuestions(kpiFormIds)).map((question) => KPIFormQuestions.fromJson(question)));

        kPIFormAttachmentType
            .addAll((await DatabaseHelper.getKPIFormAttachmentType(kpiFormIds)).map((value) => KPIFormAttachmentType.fromJson(value)));
        // .addAll((await DatabaseHelper.getKPIFormAttachmentType(kPIFormId.value)).map((value) => KPIFormAttachmentType.fromJson(value)));
        kPIFormAnswerType.addAll((await DatabaseHelper.getKPIFormAnswerType(kpiFormIds)).map((value) => KPIFormAnswerType.fromJson(value)));
        // kPIFormAnswerType.addAll((await DatabaseHelper.getKPIFormAnswerType(kPIFormId.value)).map((value) => KPIFormAnswerType.fromJson(value)));
        for (var question in kPIFormQuestions) {
          final questionId = question.id.toString();
          final attachmentType = getAttachmentType(
            kpiQuestionsFormId: question.kpiquestionsformId!,
            // kpiQuestionsFormId: kPIForm[0].id!,
            questionId: question.id!,
          );
          final answerType = getAnswerType(
            kpiQuestionsFormId: question.kpiquestionsformId!,
            // kpiQuestionsFormId: kPIForm[0].id!,
            questionId: question.id!,
          );
          kpiQuestionModel.add(
            KpiQuestionModel(
              questionId: questionId,
              value: getValueFromAnswerType(answerType, 2),
              evaluation: getValueFromAnswerType(answerType, 1),
              feedback: getValueFromAnswerType(answerType, 3),
              uploadImage: getValueFromAttachmentType(attachmentType, 1),
              uploadAudio: getValueFromAttachmentType(
                attachmentType,
                2,
              ),
              uploadVideo: getValueFromAttachmentType(
                attachmentType,
                3,
              ),
              remarks: question.remarks == 1 ? "" : "false",
              contactNo: getValueFromAttachmentType(attachmentType, 4),
            ),
          );

          kpiQuestionSave.add(
            KpiQuestionModel(
              formID: question.kpiquestionsformId.toString(),
              questionId: questionId,
              value: getValueFromAnswerType(answerType, 2),
              evaluation: getValueFromAnswerType(answerType, 1),
              feedback: getValueFromAnswerType(answerType, 3),
              uploadImage: getValueFromAttachmentType(attachmentType, 1),
              uploadAudio: getValueFromAttachmentType(
                attachmentType,
                2,
              ),
              uploadVideo: getValueFromAttachmentType(
                attachmentType,
                3,
              ),
              remarks: question.remarks == 1 ? "" : "false",
              contactNo: getValueFromAttachmentType(attachmentType, 4),
            ),
          );
        }
        isLoading.value = 0;
        updateItemCont();
      } else {
        isLoading.value = 0;
        kPIForm.clear();
      }
    } catch (e) {
      print('Error in getDealerById: $e');
      // Handle error appropriately, e.g., show a snackbar or notify the user.
    }
  }

  updateItemCont() async {
    kPIFormQuestions.refresh();
    for (int i = 0; i < kPIFormQuestions.length; i++) {
      await Future.delayed(const Duration(milliseconds: 0));

      liItemCont.add(isLoading);
      liItemCont.refresh(); // Your code using 'question' here
    }
  }

  clearField() async {
    liItemCont.clear();
    selectedDealerIndex.value = -1;
    kPIForm.clear();
    kPIFormQuestions.clear();
    dealer.clear();
    kPIFormAnswerType.clear();
    kpiQuestionModel.clear();
    kpiQuestionSave.clear();
  }

  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFile.value = await ImagePicker.platform.pickImage(source: ImageSource.gallery, imageQuality: 90);
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile.value = await ImagePicker.platform.pickImage(source: ImageSource.camera, imageQuality: 90);
        break;
    }

    DateTime now = DateTime.now();

    if (imageFile.value!.path != "") {
      File imageFil = File(imageFile.value!.path);
      dealerFilePath.value = await renameAndSaveImage(
          imageFile: imageFil,
          newName: "${now.year}${now.minute}${now.day} "
              "$dealerTypeId-$dealerId-$kPIFormId");
    } else {
      print("You have not taken image");
    }
  }
  // Future imageSelector(BuildContext context, String pickerType) async {
  //   var result;
  //   switch (pickerType) {
  //     case "gallery":
  //
  //       /// GALLERY IMAGE PICKER
  //       result = await ImagePicker.platform
  //           .pickImage(source: ImageSource.gallery, imageQuality: 90);
  //       break;
  //
  //     case "camera": // CAMERA CAPTURE CODE
  //       result = await ImagePicker.platform
  //           .pickImage(source: ImageSource.camera, imageQuality: 90);
  //       break;
  //   }
  //
  //   if (result != null) {
  //     File imageFil = File(result.path);
  //     dealerFilePath.value = await renameAndSaveImage(
  //         imageFile: imageFil,
  //         newName:
  //             "${Utils.getTimeForImageName()}$dealerTypeId-$dealerId-$kPIFormId");
  //     await questionFile(
  //         imageFile.value!.path, path.basename(dealerFilePath.value!));
  //     imageFile.value = result.path;
  //   } else {
  //     print("You have not taken image");
  //   }
  // }

  ApiServices apiServices = ApiServices();

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
        questionFile(kpiQuestionSave[index].uploadImage, path.basename(newFilePath));
        kpiQuestionSave[index].uploadImage = fileName;
        break;

      case "Audio":
        questionFile(kpiQuestionSave[index].uploadAudio, path.basename(newFilePath));
        kpiQuestionSave[index].uploadAudio = fileName;
        break;

      default:
        questionFile(kpiQuestionSave[index].uploadVideo, path.basename(newFilePath));
        kpiQuestionSave[index].uploadVideo = fileName;
        break;
    }

    checkKpiQuestionModel();
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

  bool checkKpiQuestionModel() {
    kpiQuestionSave.refresh();
    currentValidateIndex.value = -1;
    for (int index = 0; index < kpiQuestionSave.length; index++) {
      var model = kpiQuestionSave[index];
      if (model.value == "" ||
          model.uploadImage == "" ||
          model.evaluation == "" ||
          model.uploadVideo == "" ||
          model.uploadAudio == "" ||
          model.feedback == "" ||
          // model.remarks == "" ||
          dealerId.value == -1 ||
          model.contactNo == "") {
        currentValidateIndex.value == -1 ? currentValidateIndex.value = index : ""; // Set the index of the invalid model
        isValidState.value = false;
        return false;
      }
    }

    isValidState.value = true;
    return true;
  }

  // bool checkKpiQuestionModel() {
  //   kpiQuestionSave.refresh();
  //   for (var model in kpiQuestionSave) {
  //     kpiQuestionModel;
  //     if (model.value == "" ||
  //         model.uploadImage == "" ||
  //         model.evaluation == "" ||
  //         model.uploadVideo == "" ||
  //         model.uploadAudio == "" ||
  //         model.feedback == "" ||
  //         // model.remarks == "" ||
  //         dealerId.value == -1 ||
  //         model.contactNo == "") {
  //       currentValidateIndex=  get current index solve
  //       isValidState.value = false;
  //       /// for test
  //       // isValidState.value = true;
  //       kpiQuestionSave;
  //
  //       return false;
  //     }
  //   }
  //   kpiQuestionSave;
  //   isValidState.value = true;
  //
  //   return true;
  // }

  String getValueFromAnswerType(List<int?> answerType, int type) {
    return answerType.isNotEmpty && answerType.contains(type) ? "" : "false";
  }

  String getValueFromAttachmentType(List<int?> attachmentType, int type, {String defaultVal = "false"}) {
    return attachmentType.isNotEmpty && attachmentType.contains(type) ? "" : defaultVal;
  }

  List<int?> getAttachmentType({required int kpiQuestionsFormId, required int questionId}) {
    return kPIFormAttachmentType
        .where(
          (element) => element.kpiquestionsformid == kpiQuestionsFormId && element.questionid == questionId,
        )
        .map((element) => element.attachmentType)
        .toList();
  }

  List<int?> getAnswerType({required int kpiQuestionsFormId, required int questionId}) {
    return kPIFormAnswerType
        .where(
          (element) => element.kpiquestionsformid == kpiQuestionsFormId && element.questionid == questionId,
        )
        .map((element) => element.answerType)
        .toList();
  }

  void kpiSaveData(
    BuildContext context,
  ) async {
    try {
      isLoading.value = 2;
      await getCurrentPosition(context).then((value) {
        lat.value = value!.latitude.toString();
        lon.value = value.longitude.toString();
        if (lat.value != "") {
          isLoading.value = 0;

          Utils.showAlertDialog(
            message: "Your KPI Question Form \n has been submitted \n\n\nGo to next form",
            context: context,
            callback: () async {
              Get.back();
              isLoading.value = 2;
              KpiFormRequest data = KpiFormRequest(
                lat: lat.value,
                lon: lon.value,
                dealerImage: "$fileBaseUrl$dealerFilePath",
                userId: user[0].userId.toString(),
                kpiFormId: kPIFormId.toString(),
                dealerType: dealerTypeId.toString(),
                kpiQuestionModel: kpiQuestionSave,
                dealerId: dealerId.toString(),
              );
              RequestFormModel formData = RequestFormModel(
                isSync: 0,
                KPIForms: jsonEncode(data.toJson()),
                OSForms: '',
                CWMForms: '',
                // DFQForms: '',
              );
              print(jsonEncode(data.toJson()));
              // if (kpiFormFileId.value != -1) {
              //   await DatabaseHelper.kpiFormFileUpdate(id: kpiFormFileId.value, val: jsonEncode(saveFile));
              // } else {
              //   kpiFormFileId.value = await DatabaseHelper.insertKpiFormFile(jsonEncode(saveFile),requestID.value);
              // }

              if (requestID.value != -1) {
                await DatabaseHelper.formRequestUpdate(id: requestID.value, columnName: "KPIForms", val: jsonEncode(data.toJson()));

              } else {
                List formFile=[];

                for(int i=0; i<saveFile.length; i++){
                  formFile.add({
                    "status":false,
                    "path":saveFile[i]
                  });
                }

                requestID.value = await DatabaseHelper.insertKpiRequest(data: formData.toJson());
                // kpiFormFileId.value = await DatabaseHelper.insertKpiFormFile(jsonEncode(formFile),requestID.value);
                kpiFormFileId.value = await DatabaseHelper.insertKpiFormFile(jsonEncode(saveFile),requestID.value);
              }

              await DatabaseHelper.insertKpiFormSaveID(
                kpiFileID: kpiFormFileId.value,
                dealerType: dealerTypeId.value,
                dealerID: dealerId.value,
                requestFormID: requestID.value,
              );
              await Future.delayed(const Duration(seconds: 2));
              Get.offAllNamed(AppPages.outdoorShopFasciaView);
              Utils.showSnackBar("Save", "Successfully Save KPI Form");
            },
          );
        }
      });
    } catch (e) {
      isLoading.value = 0;
      print('Error in kpiSaveData: $e');
      context.loaderOverlay.hide();
      // Handle the exception
      // You can show an error message or perform other actions as needed
    }
  }

  /// get current location

  @override
  void dispose() {
    // Dispose of resources here
    super.dispose();
  }
}
