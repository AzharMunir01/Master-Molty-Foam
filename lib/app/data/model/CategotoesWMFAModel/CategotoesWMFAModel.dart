class CategoriesWMFAModel {
  // int? dealerType;
  // int? dealerId;
  // int? cMFormMId;
  String? categoriesWiseFormId;
  String? categoryId;
  String? evaluation;
  String? feedback;
  String? value;
  String? contactNo;
  String? remarks;
  String? uploadImage;
  String? uploadVideo;
  String? uploadAudio;
  String? formID;
  List<String>? imagesPath;
  CategoriesWMFAModel(
      {this.evaluation,
      this.value,
        this.imagesPath,
      // this.cMFormMId,
      // this.dealerType,
      // this.dealerId,
      this.uploadAudio,
      this.formID,
      this.uploadImage,
      this.uploadVideo,
      this.categoriesWiseFormId,
      this.categoryId,
      this.feedback,
      this.remarks,
      this.contactNo});

  CategoriesWMFAModel.fromJson(Map<String, dynamic> json) {
    categoriesWiseFormId = json['categoriesWiseFormId'].toString();
    categoryId = json['categoryId'].toString();
    formID = json['formID'].toString();
    evaluation = json['evaluation'].toString();
    // cMFormMId = json['cMFormMId'];
    feedback = json['feedback'].toString();
    imagesPath = json['imagesPath'];
    // dealerType = json['dealerType'];
    // dealerId = json['dealerId'];
    value = json['value'].toString();
    contactNo = json['contactNo'].toString();
    remarks = json['remarks'].toString();
    uploadImage = json['uploadImage'].toString();
    uploadVideo = json['uploadVideo'].toString();
    uploadAudio = json['uploadAudio'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoriesWiseFormId'] = categoriesWiseFormId=="false"?"":categoriesWiseFormId;
    data['categoryId'] = categoryId=="false"?"":categoryId;
    data['evaluation'] = evaluation=="false"?"":evaluation;
    data['formID'] =formID;
    // data['dealerType'] = dealerType;
    // data['cMFormMId'] = cMFormMId;
    // data['dealerId'] = dealerId;
    data['feedback'] = feedback=="false"?"":feedback;
    data['contactNo'] = contactNo=="false"?"":contactNo;
    data['value'] = value=="false"?"":value;
    data['remarks'] = remarks=="false"?"":remarks;
    data['uploadImage'] = uploadImage=="false"?"":uploadImage;
    data['uploadVideo'] = uploadVideo=="false"?"":uploadVideo;
    data['uploadAudio'] = uploadAudio=="false"?"":uploadAudio;
    return data;
  }
}


class CategoriesWMFRequest {
  String? lat;
  String? lon;
  String? dealerId;
  String? dealerType;
  String? cMFormMId;
  List<CategoriesWMFAModel>? categoriesWMFAModel;
  CategoriesWMFRequest({this.dealerType, this.cMFormMId, this.categoriesWMFAModel,this.dealerId,this.lat,this.lon});

  CategoriesWMFRequest.fromJson(Map<String, dynamic> json) {
    if (json['categoriesWMFAModel'] != null) {
      categoriesWMFAModel = <CategoriesWMFAModel>[];
      json['categoriesWMFAModel'].forEach((v) {
        categoriesWMFAModel!.add(CategoriesWMFAModel.fromJson(v));
      });
    }
    dealerType = json['dealerType'].toString();
    lat = json['lat'].toString();
    lon = json['lon'].toString();
    cMFormMId = json['cMFormMId'].toString();
    dealerId = json['dealerId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealerId'] = dealerId;
    data['lon'] = lon;
    data['lat'] = lat;
    data['dealerType'] = dealerType;
    data['cMFormMId'] = cMFormMId;
    if (categoriesWMFAModel != null) {
      data['categoriesWMFAModel'] = categoriesWMFAModel!.map((v) => v.toJson()).toList();
    }

    return data;
  }







}