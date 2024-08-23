import '../getSyncData.dart';

class OutdoorShopFasciaModel {
  // int? dealerType;
  // int? dealerId;
  String? boardDescriptionId;
  String? boarDescription;
  String? categoryId;
  // int? osFormId;
  String? evaluation;
  String? formID;
  String? feedback;
  String? value;
  String? contactNo;
  String? remarks;
 List<OSFormBoardImages>? imagePath;
  String? uploadImage;
  String? uploadVideo;
  String? uploadAudio;
  OutdoorShopFasciaModel(
      {this.evaluation, this.formID,this.value, this.uploadAudio, this.uploadImage, this.uploadVideo, this.boardDescriptionId, this.categoryId,this
          .feedback,this.remarks,this.contactNo,this.imagePath,this.boarDescription});

  OutdoorShopFasciaModel.fromJson(Map<String, dynamic> json) {
    // osFormId = json['osFormId'];
    // dealerType = json['dealerType'];
    categoryId = json['categoryId'];
    formID = json['formID'];
    categoryId = json['imagePath'];
    // dealerId = json['dealerId'];
    boardDescriptionId = json['boardDescriptionId'];
    boarDescription = json['boarDescription'];
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
    // data['osFormId'] = osFormId;
    // data['dealerType'] = dealerType;
    // data['dealerId'] = dealerId;
    data['categoryId'] = categoryId=="false"?"":categoryId;
    data['formID'] = formID;
    data['contactNo'] = contactNo=="false"?"":contactNo;
    data['boardDescriptionId'] = boardDescriptionId=="false"?"":boardDescriptionId;
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

class OutdoorShopFasciaRequest {
  String? lat;
  String? lon;
  String? dealerType;
  String? dealerId;
  String? osFormId;
  List<OutdoorShopFasciaModel>? outdoorShopFasciaModel;

  OutdoorShopFasciaRequest({this.dealerType,this.dealerId,this.outdoorShopFasciaModel,this.osFormId,this.lon,this.lat});


  OutdoorShopFasciaRequest.fromJson(Map<String, dynamic> json) {
    osFormId = json['osFormId'].toString();
    dealerType = json['dealerType'].toString();
    dealerId = json['dealerId'].toString();
    lon = json['lon'].toString();
    lat = json['lat'].toString();
    if (json['outdoorShopFasciaModel'] != null) {
      outdoorShopFasciaModel = <OutdoorShopFasciaModel>[];
      json['outdoorShopFasciaModel'].forEach((v) {
        outdoorShopFasciaModel!.add(OutdoorShopFasciaModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dealerType'] = dealerType;
    data['lat'] = lat;
    data['lon'] = lon;
    data['osFormId'] = osFormId;
    data['dealerId'] = dealerId;
    if (outdoorShopFasciaModel != null) {
      data['outdoorShopFasciaModel'] = outdoorShopFasciaModel!.map((v) => v.toJson()).toList();
    }



    return data;
  }

}