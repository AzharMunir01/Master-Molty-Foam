class KPIQuestionsForm {
  String? dealerType;
  String? dealershipName;
  String? ownerName;
  String? dealerPicture;
  String? brand;
  String? code;
  String? contactNo;
  String? area;
  String? zone;
  String? city;
  List<KPIQuestions>? kPIQuestionsList;

  KPIQuestionsForm({
    this.dealerType,
    this.dealershipName,
    this.ownerName,
    this.dealerPicture,
    this.brand,
    this.code,
    this.contactNo,
    this.area,
    this.zone,
    this.city,
    this.kPIQuestionsList,
  });

  factory KPIQuestionsForm.fromJson(Map<String, dynamic> json) => KPIQuestionsForm(
    dealerType: json['dealerType'],
    dealershipName: json['dealershipName'],
    ownerName: json['ownerName'],
    dealerPicture: json['dealerPicture'],
    brand: json['brand'],
    code: json['code'],
    contactNo: json['contactNo'],
    area: json['area'],
    zone: json['zone'],
    city: json['city'],
    kPIQuestionsList: json['kPIQuestionsList'] != null
        ? List<KPIQuestions>.from(json['kPIQuestionsList'].map((x) => KPIQuestions.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    'dealerType': dealerType,
    'dealershipName': dealershipName,
    'ownerName': ownerName,
    'dealerPicture': dealerPicture,
    'brand': brand,
    'code': code,
    'contactNo': contactNo,
    'area': area,
    'zone': zone,
    'city': city,
    'kPIQuestionsList': kPIQuestionsList != null ? List<dynamic>.from(kPIQuestionsList!.map((x) => x.toJson())) : null,
  };
}

class KPIQuestions {
  String? evaluation;
  String? remarks;
  String? uploadImage;
  String? uploadAudio;
  String? uploadVideo;
  String? uploadContactNo;

  KPIQuestions({
    this.evaluation,
    this.remarks,
    this.uploadImage,
    this.uploadAudio,
    this.uploadVideo,
    this.uploadContactNo,
  });

  factory KPIQuestions.fromJson(Map<String, dynamic> json) => KPIQuestions(
    evaluation: json['evaluation'],
    remarks: json['remarks'],
    uploadImage: json['uploadImage'],
    uploadAudio: json['uploadAudio'],
    uploadVideo: json['uploadVideo'],
    uploadContactNo: json['uploadContactNo'],
  );

  Map<String, dynamic> toJson() => {
    'evaluation': evaluation,
    'remarks': remarks,
    'uploadImage': uploadImage,
    'uploadAudio': uploadAudio,
    'uploadVideo': uploadVideo,
    'uploadContactNo': uploadContactNo,
  };
}
