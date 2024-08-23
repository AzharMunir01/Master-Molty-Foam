import 'dart:developer';

import '../../data/local/database/database.dart';
import '../../data/model/getSyncData.dart';
import '../../data/model/getSyncData.dart';
import '../../netWorking/apiAuth.dart';

class SyncData {
  ApiServices apiServices = ApiServices();
  getSyncData(int userID) async {

    final response = await apiServices.syncData(userID);
    if (response.status == "true") {
      final value = GetSyncData.fromJson(response.data);
      // await DatabaseHelper.insertCity(value.cities!);
      await DatabaseHelper.insertDealerType(value.dealerType!);
      await DatabaseHelper.insertAnswerType(value.answerType!);
      await DatabaseHelper.insertAttachmentType(value.attachmentType!);
      await DatabaseHelper.insertFeedbackType(value.feedbackType!);
      await DatabaseHelper.insertKPIForm(value.kPIForm!);
      await DatabaseHelper.insertKPIFormAnswerType(value.kPIFormAnswerType!);
      await DatabaseHelper.insertKPIFormQuestions(value.kPIFormQuestions!);
      await DatabaseHelper.insertQuestionType(value.questionType!);
      await DatabaseHelper.insertZones(value.zones!);
      await DatabaseHelper.insertDealer(value.dealers!);
      await DatabaseHelper.insertCategories(value.categories!);
      await DatabaseHelper.insertKPIFormAttachmentType(value.kPIFormAttachmentType!);
      await DatabaseHelper.insertOSForm(value.oSForm!);
      await DatabaseHelper.insertoSFormBoardDescription(value.oSFormBoardDescription!);
      await DatabaseHelper.insertOSFormBoardImages(value.oSFormBoardImages!);
      await DatabaseHelper.insertOSFormAnswerType(value.oSFormAnswerType!);
      await DatabaseHelper.insertOSFormAttachmentType(value.oSFormAttachmentType!);
      await DatabaseHelper.insertCategoryWiseModelForm(value.categoryWiseModelForm!);
      await DatabaseHelper.insertCategoryWiseModelFormModels(value.categoryWiseModelFormModels!);
      await DatabaseHelper.insertCategoryWiseModelFormAttachmentType(value.categoryWiseModelFormAttachmentType!);
      await DatabaseHelper.insertCategoryWiseModelFormAnswerType(value.categoryWiseModelFormAnswerType!);
      await DatabaseHelper.insertDealerFeedbackFormQuestions(value.dealerFeedbackFormQuestions!);
      await DatabaseHelper.insertDealerFeedbackFormAttachmentTypes(value.dealerFeedbackFormAttachmentTypes!);
      await DatabaseHelper.insertDealerFeedbackForm(value.dealerFeedbackForm!);
      await DatabaseHelper.insertDealerFeedbackFormAsnwerTypes(value.dealerFeedbackFormAsnwerTypes!);
      await DatabaseHelper.insertOSFormBoardImages(value.oSFormBoardImages!);
      await DatabaseHelper.insertCategoryWiseModelFormFormImages(value.categoryWiseModelFormFormImages!);
      await DatabaseHelper.insertCity(value.cities!);

      https: //molty.bmccrm.com:442/uploadedfiles/504_3d-artwork-1.png
      // final respon = await apiServices.getFormImages("504_3d-artwork-1.png");

      downloadFormImages();
    }
  }

  downloadFormImages() async {
    List<OSFormBoardImages> oSFormBoardImages = [];
    List<CategoryWiseModelFormFormImages> categoryWiseModelFormFormImage = [];
    oSFormBoardImages.clear();
    final oSFormBoardImage = await DatabaseHelper.getFormFiles(tableName: 'oSFormBoardImages');
    final categoryWiseModelFormFormImages = await DatabaseHelper.getFormFiles(tableName: 'categoryWiseModelFormFormImages');

    for (var result in oSFormBoardImage) {
      oSFormBoardImages.add(OSFormBoardImages.fromJson(result));
    }
    for (var result in categoryWiseModelFormFormImages) {
      categoryWiseModelFormFormImage.add(CategoryWiseModelFormFormImages.fromJson(result));
    }

    for (var i = 0; i < oSFormBoardImages.length; i++) {
      // var result = requestFormData[i];

      final val = await apiServices.getFormImages(oSFormBoardImages[i].filepath!);
      await DatabaseHelper.updateFormFilePath(id: oSFormBoardImages[i].id!, path: val.toString(), tableName: 'oSFormBoardImages', isSync: 1);

    }

    for (var i = 0; i < categoryWiseModelFormFormImage.length; i++) {
      // var result = requestFormData[i];

      final val = await apiServices.getFormImages(categoryWiseModelFormFormImage[i].filepath!);
      await DatabaseHelper.updateFormFilePath(id: categoryWiseModelFormFormImage[i].id!, path: val.toString(), tableName: 'categoryWiseModelFormFor'
          'mImages', isSync: 1);

    }





  }
}
