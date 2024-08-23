import 'package:get/get_rx/src/rx_types/rx_types.dart';

class FeedbackModels {
  // int? dealerId;
  // int? dealerType;
  // int? dfqformId;
  String? questionId;
  String? evaluation;
  String? feedback;
  String? value;
  String? contactNo;
  String? remarks;
  String? uploadImage;
  String? uploadVideo;
  String? uploadAudio;
  FeedbackModels(
      {this.evaluation,
      // this.dealerId,
      // this.dealerType,
      this.value,
      this.uploadAudio,
      this.uploadImage,
      this.uploadVideo,
      // this.dfqformId,
      this.questionId,
      this.feedback,
      this.remarks,
      this.contactNo});

  FeedbackModels.fromJson(Map<String, dynamic> json) {
    // dealerId = json['dealerId'];
    // dealerType = json['dealerType'];
    // dealerId = json['dealerId'];
    // dfqformId = json['dfqformId'];
    questionId = json['questionId'];
    evaluation = json['evaluation'];
    evaluation = json['feedback'];
    value = json['value'];
    contactNo = json['contactNo'];
    remarks = json['remarks'];
    uploadImage = json['uploadImage'];
    uploadVideo = json['uploadVideo'];
    uploadAudio = json['uploadAudio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['dfqformId'] = dfqformId;
    // data['dealerType'] = dealerType;
    data['questionId'] = questionId=="false"?"":questionId;
    data['contactNo'] = contactNo=="false"?"":contactNo;
    data['evaluation'] = evaluation=="false"?"":evaluation;

    data['feedback'] = feedback=="false"?"":feedback;
    data['value'] = value=="false"?"":value;
    data['remarks'] = remarks=="false"?"":remarks;
    data['uploadImage'] = uploadImage=="false"?"":uploadImage;
    data['uploadVideo'] = uploadVideo=="false"?"":uploadVideo;
    data['uploadAudio'] = uploadAudio=="false"?"":uploadAudio;
    return data;
  }
}

class FeedbackModelsRequest {
  String? lat;
  String? lon;
  String? dealerType;
  String? dealerId;
  String? DFQFormId;
  String? userId;
  List<FeedbackModels>? feedbackModels;

  FeedbackModelsRequest({this.dealerType, this.dealerId, this.feedbackModels, this.DFQFormId,this.lon,this.lat, this.userId});

  FeedbackModelsRequest.fromJson(Map<String, dynamic> json) {
    DFQFormId = json['DFQFormId'].toString();
    dealerType = json['dealerType'].toString();
    lon = json['lon'].toString();
    lat = json['lat'].toString();
    userId= json['userId'].toString();
    dealerId = json['dealerId'].toString();
    if (json['outdoorShopFasciaModel'] != null) {
      feedbackModels = <FeedbackModels>[];
      json['feedbackModels'].forEach((v) {
        feedbackModels!.add(FeedbackModels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealerType'] = dealerType;
    data['lat'] = lat;
    data['lon'] = lon;
    data['DFQFormId'] = DFQFormId;
    data['dealerId'] = dealerId;
    data['Userid'] = userId;
    if (feedbackModels != null) {
      data['feedbackModels'] = feedbackModels!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
