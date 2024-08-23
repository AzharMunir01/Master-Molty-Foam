class KpiQuestionModel {
  String? remarks;
  String? evaluation;
  String? questionId;
  String? feedback;
  String? contactNo;
  String? value;
  String? uploadImage;
  String? uploadVideo;
  String? uploadAudio;
  String? formID;
  KpiQuestionModel(
      {this.evaluation,
      this.value,
      this.formID,
      this.uploadAudio,
      this.uploadImage,
      this.uploadVideo,
      this.questionId,
        // this.dealerType, this.kpiFormId,this
      this.feedback,
      this.remarks,
      this.contactNo});

  KpiQuestionModel.fromJson(Map<String, dynamic> json) {
    // kpiFormId = json['kpiFormId'];
    // dealerType = json['dealerType'];
    questionId = json['questionId'].toString();
    formID = json['formID'].toString();
    remarks = json['remarks'].toString();
    contactNo = json['contactNo']==null?"":json['contactNo'].toString();
    evaluation = json['evaluation'].toString();
    evaluation = json['feedback'].toString();
    value = json['value'].toString();
    uploadImage = json['uploadImage'].toString();
    uploadVideo = json['uploadVideo'].toString();
    uploadAudio = json['uploadAudio'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['kpiFormId'] = kpiFormId;
    // data['dealerType'] = dealerType;
    data['questionId'] = questionId;
    data['formID'] = formID;
    data['evaluation'] = evaluation=="false"?"":evaluation;
    data['feedback'] = feedback=="false"?"":feedback;
    data['remarks'] = remarks=="false"?"":remarks;
    data['contactNo'] = contactNo=="false"?"":contactNo;
    data['value'] = value=="false"?"":value;
    data['uploadImage'] = uploadImage=="false"?"":uploadImage;
    data['uploadVideo'] = uploadVideo=="false"?"":uploadVideo;
    data['uploadAudio'] = uploadAudio=="false"?"":uploadAudio;
    return data;
  }
}

class KpiFormRequest {
  String? lat;
  String? lon;
  String? dealerType;
  String? userId;
  String? dealerImage;
  String? dealerId;
  String? kpiFormId;
  List<KpiQuestionModel>? kpiQuestionModel;
  KpiFormRequest({this.dealerType, this.kpiFormId, this.kpiQuestionModel,this.dealerId,this.lat,this.lon,this.userId,this.dealerImage});

  KpiFormRequest.fromJson(Map<String, dynamic> json) {
    if (json['kpiQuestionModel'] != null) {
      kpiQuestionModel = <KpiQuestionModel>[];
      json['kpiQuestionModel'].forEach((v) {
        kpiQuestionModel!.add(KpiQuestionModel.fromJson(v));
      });
    }
    dealerType = json['dealerType'].toString();
    lat = json['lat'].toString();
    lon = json['lon'].toString();
    userId= json['userId'].toString();
    dealerImage= json['DealerImage'].toString();
    kpiFormId = json['kpiFormId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealerType'] = dealerType;
    data['kpiFormId'] = kpiFormId;
    data['dealerId'] = dealerId;
    data['lon'] = lon;
    data['lat'] = lat;
    data['Userid'] = userId;
    data['DealerImage'] = dealerImage;

    data['lat'] = lat;
    if (kpiQuestionModel != null) {
      data['kpiQuestionModel'] = kpiQuestionModel!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
