import 'dart:developer';

class GetSyncData {
  List<Cities>? cities;
  List<DealerType>? dealerType;
  List<AnswerType>? answerType;
  List<AttachmentType>? attachmentType;
  List<CategoryWiseModelForm>? categoryWiseModelForm;
  List<CategoryWiseModelFormAnswerType>? categoryWiseModelFormAnswerType;
  List<CategoryWiseModelFormAttachmentType>? categoryWiseModelFormAttachmentType;

  List<Categories>? categories;
  List<DealerFeedbackForm>? dealerFeedbackForm;
  List<DealerFeedbackFormAnswers>? dealerFeedbackFormAnswers;

  List<DealerFeedbackFormAttachmentTypes>? dealerFeedbackFormAttachmentTypes;
  List<DealerFeedbackFormQuestions>? dealerFeedbackFormQuestions;

  List<FeedbackType>? feedbackType;
  List<KPIForm>? kPIForm;
  List<KPIFormAnswers>? kPIFormAnswers;


  List<KPIFormAnswerType>? kPIFormAnswerType;
  List<KPIFormAttachmentType>? kPIFormAttachmentType;

  List<KPIFormQuestions>? kPIFormQuestions;
  List<Dealers>? dealers;
  List<OSForm>? oSForm;
  List<OSFormAnswers>? oSFormAnswers;

  List<OSFormAnswerType>? oSFormAnswerType;
  List<OSFormAttachmentType>? oSFormAttachmentType;
  List<OSFormBoardDescription>? oSFormBoardDescription;

  List<QuestionType>? questionType;
  List<Zones>? zones;
  List<OSFormBoardImages>? oSFormBoardImages;
  List<CategoryWiseModelFormFormImages>? categoryWiseModelFormFormImages;
  List<CategoryWiseModelFormModels>? categoryWiseModelFormModels;
  List<DealerFeedbackFormAsnwerTypes>? dealerFeedbackFormAsnwerTypes;

  GetSyncData({
    this.cities,
    this.dealerType,
    this.answerType,
    this.attachmentType,
    this.categoryWiseModelForm,
    this.categoryWiseModelFormAnswerType,
    this.categoryWiseModelFormAttachmentType,
    this.categories,
    this.dealerFeedbackForm,
    this.dealerFeedbackFormAnswers,
    this.dealerFeedbackFormAttachmentTypes,
    this.dealerFeedbackFormQuestions,
    this.feedbackType,
    this.kPIForm,
    this.kPIFormAnswers,
    this.kPIFormAnswerType,
    this.kPIFormAttachmentType,
    this.kPIFormQuestions,
    this.dealers,
    this.oSForm,
    this.oSFormAnswers,
    this.oSFormAnswerType,
    this.oSFormAttachmentType,
    this.questionType,
    this.oSFormBoardDescription,
    this.zones,
    this.oSFormBoardImages,
    this.categoryWiseModelFormModels,
    this.dealerFeedbackFormAsnwerTypes,
  });

  GetSyncData.fromJson(Map<String, dynamic> json) {
    if (json['Cities'] != null) {
      cities = <Cities>[];
      json['Cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
    if (json['DealerType'] != null) {
      dealerType = <DealerType>[];
      json['DealerType'].forEach((v) {
        dealerType!.add(DealerType.fromJson(v));
      });
    }
    if (json['AnswerType'] != null) {
      answerType = <AnswerType>[];
      json['AnswerType'].forEach((v) {
        answerType!.add(AnswerType.fromJson(v));
      });
    }
    if (json['AttachmentType'] != null) {
      attachmentType = <AttachmentType>[];
      json['AttachmentType'].forEach((v) {
        attachmentType!.add(AttachmentType.fromJson(v));
      });
    }

    if (json['Category_Wise_ModelForm'] != null) {
      categoryWiseModelForm = <CategoryWiseModelForm>[];
      json['Category_Wise_ModelForm'].forEach((v) {
        categoryWiseModelForm!.add(CategoryWiseModelForm.fromJson(v));
      });
    }

    if (json['Category_Wise_ModelForm_AnswerType'] != null) {
      categoryWiseModelFormAnswerType = <CategoryWiseModelFormAnswerType>[];
      json['Category_Wise_ModelForm_AnswerType'].forEach((v) {
        categoryWiseModelFormAnswerType!.add(CategoryWiseModelFormAnswerType.fromJson(v));
      });
    }

    if (json['Category_Wise_ModelForm_FormImages'] != null) {
      categoryWiseModelFormFormImages = <CategoryWiseModelFormFormImages>[];
      json['Category_Wise_ModelForm_FormImages'].forEach((v) {
        categoryWiseModelFormFormImages!.add(CategoryWiseModelFormFormImages.fromJson(v));
      });
    }

    if (json['Category_Wise_ModelForm_AttachmentType'] != null) {
      categoryWiseModelFormAttachmentType = <CategoryWiseModelFormAttachmentType>[];
      json['Category_Wise_ModelForm_AttachmentType'].forEach((v) {
        categoryWiseModelFormAttachmentType!.add(CategoryWiseModelFormAttachmentType.fromJson(v));
      });
    }
    // categoryWiseModelFormAttachmentType =
    // json['Category_Wise_ModelForm_AttachmentType'];

    if (json['Categories'] != null) {
      categories = <Categories>[];
      json['Categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }

    if (json['DealerFeedbackForm'] != null) {
      dealerFeedbackForm = <DealerFeedbackForm>[];
      json['DealerFeedbackForm'].forEach((v) {
        dealerFeedbackForm!.add(DealerFeedbackForm.fromJson(v));
      });
    }

    if (json['DealerFeedbackFormAnswers'] != null) {
      dealerFeedbackFormAnswers = <DealerFeedbackFormAnswers>[];
      json['DealerFeedbackFormAnswers'].forEach((v) {
        dealerFeedbackFormAnswers!.add(DealerFeedbackFormAnswers.fromJson(v));
      });
    }
    // dealerFeedbackFormAnswers = json['DealerFeedbackFormAnswers'];

    if (json['DealerFeedbackFormAttachmentTypes'] != null) {
      dealerFeedbackFormAttachmentTypes = <DealerFeedbackFormAttachmentTypes>[];
      json['DealerFeedbackFormAttachmentTypes'].forEach((v) {
        dealerFeedbackFormAttachmentTypes!.add(DealerFeedbackFormAttachmentTypes.fromJson(v));
      });
    }

    if (json['DealerFeedbackFormQuestions'] != null) {
      dealerFeedbackFormQuestions = <DealerFeedbackFormQuestions>[];
      json['DealerFeedbackFormQuestions'].forEach((v) {
        dealerFeedbackFormQuestions!.add(DealerFeedbackFormQuestions.fromJson(v));
      });
    }

    if (json['FeedbackType'] != null) {
      feedbackType = <FeedbackType>[];
      json['FeedbackType'].forEach((v) {
        feedbackType!.add(FeedbackType.fromJson(v));
      });
    }
    if (json['KPIForm'] != null) {
      kPIForm = <KPIForm>[];
      json['KPIForm'].forEach((v) {
        kPIForm!.add(KPIForm.fromJson(v));
      });
    }  if (json['KPIFormAnswers'] != null) {
      kPIFormAnswers = <KPIFormAnswers>[];
      json['KPIFormAnswers'].forEach((v) {
        kPIFormAnswers!.add(KPIFormAnswers.fromJson(v));
      });
    }
    // kPIFormAnswers = json['KPIFormAnswers'];
    if (json['KPIFormAnswerType'] != null) {
      kPIFormAnswerType = <KPIFormAnswerType>[];
      json['KPIFormAnswerType'].forEach((v) {
        kPIFormAnswerType!.add(KPIFormAnswerType.fromJson(v));
      });
    }

    if (json['KPIFormAttachmentType'] != null) {
      kPIFormAttachmentType = <KPIFormAttachmentType>[];
      json['KPIFormAttachmentType'].forEach((v) {
        kPIFormAttachmentType!.add(KPIFormAttachmentType.fromJson(v));
      });
    }

    if (json['KPIFormQuestions'] != null) {
      kPIFormQuestions = <KPIFormQuestions>[];
      json['KPIFormQuestions'].forEach((v) {
        kPIFormQuestions!.add(KPIFormQuestions.fromJson(v));
      });
    }
    if (json['Dealers'] != null) {
      dealers = <Dealers>[];
      json['Dealers'].forEach((v) {
        dealers!.add(Dealers.fromJson(v));
      });
    }

    if (json['OSForm'] != null) {
      oSForm = <OSForm>[];
      json['OSForm'].forEach((v) {
        oSForm!.add(OSForm.fromJson(v));
      });
    }

    if (json['OSFormAnswers'] != null) {
      oSFormAnswers = <OSFormAnswers>[];
      json['OSFormAnswers'].forEach((v) {
        oSFormAnswers!.add(OSFormAnswers.fromJson(v));
      });
    }

    // oSFormAnswers = json['OSFormAnswers'];
    if (json['OSFormAnswerType'] != null) {
      oSFormAnswerType = <OSFormAnswerType>[];
      json['OSFormAnswerType'].forEach((v) {
        oSFormAnswerType!.add(OSFormAnswerType.fromJson(v));
      });
    }

    if (json['OSFormAttachmentType'] != null) {
      oSFormAttachmentType = <OSFormAttachmentType>[];
      json['OSFormAttachmentType'].forEach((v) {
        oSFormAttachmentType!.add(OSFormAttachmentType.fromJson(v));
      });
    }

    if (json['QuestionType'] != null) {
      questionType = <QuestionType>[];
      json['QuestionType'].forEach((v) {
        questionType!.add(QuestionType.fromJson(v));
      });
    }

    if (json['OSFormBoardDescription'] != null) {
      oSFormBoardDescription = <OSFormBoardDescription>[];
      json['OSFormBoardDescription'].forEach((v) {
        oSFormBoardDescription!.add(OSFormBoardDescription.fromJson(v));
      });
    }

    if (json['Zones'] != null) {
      zones = <Zones>[];
      json['Zones'].forEach((v) {
        zones!.add(Zones.fromJson(v));
      });
    }
    if (json['OSFormBoardImages'] != null) {
      oSFormBoardImages = <OSFormBoardImages>[];
      json['OSFormBoardImages'].forEach((v) {
        oSFormBoardImages!.add(OSFormBoardImages.fromJson(v));
      });
    }

    if (json['Category_Wise_ModelForm_Models'] != null) {
      categoryWiseModelFormModels = <CategoryWiseModelFormModels>[];
      json['Category_Wise_ModelForm_Models'].forEach((v) {
        categoryWiseModelFormModels!.add(CategoryWiseModelFormModels.fromJson(v));
      });
    }

    if (json['DealerFeedbackFormAsnwerTypes'] != null) {
      dealerFeedbackFormAsnwerTypes = <DealerFeedbackFormAsnwerTypes>[];
      json['DealerFeedbackFormAsnwerTypes'].forEach((v) {
        dealerFeedbackFormAsnwerTypes!.add(DealerFeedbackFormAsnwerTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['Cities'] = cities!.map((v) => v.toJson()).toList();
    }
    if (dealerType != null) {
      data['DealerType'] = dealerType!.map((v) => v.toJson()).toList();
    }
    if (answerType != null) {
      data['AnswerType'] = answerType!.map((v) => v.toJson()).toList();
    }
    if (attachmentType != null) {
      data['AttachmentType'] = attachmentType!.map((v) => v.toJson()).toList();
    }

    if (categoryWiseModelForm != null) {
      data['Category_Wise_ModelForm'] = categoryWiseModelForm!.map((v) => v.toJson()).toList();
    }

    if (categoryWiseModelFormAnswerType != null) {
      data['Category_Wise_ModelForm_AnswerType'] = categoryWiseModelFormAnswerType!.map((v) => v.toJson()).toList();
    }

    if (categoryWiseModelFormAttachmentType != null) {
      data['Category_Wise_ModelForm_AttachmentType'] = categoryWiseModelFormAttachmentType!.map((v) => v.toJson()).toList();
    }

    if (categories != null) {
      data['Categories'] = categories!.map((v) => v.toJson()).toList();
    }

    if (dealerFeedbackForm != null) {
      data['DealerFeedbackForm'] = dealerFeedbackForm!.map((v) => v.toJson()).toList();
    }
    if (dealerFeedbackForm != null) {
      data['DealerFeedbackFormAnswers'] = dealerFeedbackFormAnswers!.map((v) => v.toJson()).toList();
    }



    if (dealerFeedbackFormAttachmentTypes != null) {
      data['DealerFeedbackFormAttachmentTypes'] = dealerFeedbackFormAttachmentTypes!.map((v) => v.toJson()).toList();
    }

    data['DealerFeedbackFormQuestions'] = dealerFeedbackFormQuestions;
    if (feedbackType != null) {
      data['FeedbackType'] = feedbackType!.map((v) => v.toJson()).toList();
    }
    if (kPIForm != null) {
      data['KPIForm'] = kPIForm!.map((v) => v.toJson()).toList();
    }
    if (kPIFormAnswers != null) {
      data['KPIFormAnswers'] = kPIFormAnswers!.map((v) => v.toJson()).toList();
    }

    if (kPIFormAnswerType != null) {
      data['KPIFormAnswerType'] = kPIFormAnswerType!.map((v) => v.toJson()).toList();
    }
    data['KPIFormAttachmentType'] = kPIFormAttachmentType;
    if (kPIFormQuestions != null) {
      data['KPIFormQuestions'] = kPIFormQuestions!.map((v) => v.toJson()).toList();
    }

    if (dealers != null) {
      data['Dealers'] = dealers!.map((v) => v.toJson()).toList();
    }

    if (oSForm != null) {
      data['OSForm'] = oSForm!.map((v) => v.toJson()).toList();
    }

    if (oSFormAnswers != null) {
      data['OSFormAnswers'] = oSFormAnswers!.map((v) => v.toJson()).toList();
    }

    // data['OSFormAnswers'] = oSFormAnswers;
    if (oSFormAnswerType != null) {
      data['OSFormAnswerType'] = oSFormAnswerType!.map((v) => v.toJson()).toList();
    }

    if (oSFormBoardDescription != null) {
      data['OSFormBoardDescription'] = oSFormBoardDescription!.map((v) => v.toJson()).toList();
    }
    if (oSFormAttachmentType != null) {
      data['OSFormAttachmentType'] = oSFormAttachmentType!.map((v) => v.toJson()).toList();
    }

    if (questionType != null) {
      data['QuestionType'] = questionType!.map((v) => v.toJson()).toList();
    }
    if (zones != null) {
      data['Zones'] = zones!.map((v) => v.toJson()).toList();
    }
    if (oSFormBoardImages != null) {
      data['OSFormBoardImages'] = oSFormBoardImages!.map((v) => v.toJson()).toList();
    }

    if (categoryWiseModelFormModels != null) {
      data['Category_Wise_ModelForm_Models'] = categoryWiseModelFormModels!.map((v) => v.toJson()).toList();
    }

    if (dealerFeedbackFormAsnwerTypes != null) {
      data['DealerFeedbackFormAsnwerTypes'] = dealerFeedbackFormAsnwerTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? city;
  String? createdate;
  String? updatedate;
  int? updateby;

  Cities({this.id, this.city, this.createdate, this.updatedate, this.updateby});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['city'] = city;
    data['createdate'] = createdate;
    data['updatedate'] = updatedate;
    data['updateby'] = updateby;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return city.toString();
  }
}

class DealerType {
  int? id;
  String? dealerType;
  String? createdate;
  String? updatedate;
  int? updateby;

  DealerType({this.id, this.dealerType, this.createdate, this.updatedate, this.updateby});

  DealerType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealerType = json['dealer_type'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dealer_type'] = this.dealerType;
    data['createdate'] = this.createdate;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${dealerType.toString()}";
  }
}

class AnswerType {
  int? id;
  String? answersType;
  String? createdate;
  String? updatedate;
  int? updateby;

  AnswerType({this.id, this.answersType, this.createdate, this.updatedate, this.updateby});

  AnswerType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answersType = json['answers_type'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answers_type'] = this.answersType;
    data['createdate'] = this.createdate;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class AttachmentType {
  int? id;
  String? attachmentType;
  String? createdate;
  String? updatedate;
  int? updateby;

  AttachmentType({this.id, this.attachmentType, this.createdate, this.updatedate, this.updateby});

  AttachmentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attachmentType = json['attachment_type'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attachment_type'] = this.attachmentType;
    data['createdate'] = this.createdate;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class FeedbackType {
  int? id;
  String? feedbackType;
  String? createdate;
  String? updatedate;
  int? updateby;

  FeedbackType({this.id, this.feedbackType, this.createdate, this.updatedate, this.updateby});

  FeedbackType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedbackType = json['feedback_type'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['feedback_type'] = this.feedbackType;
    data['createdate'] = this.createdate;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class KPIForm {
  int? id;
  int? dealerType;
  int? questionType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;

  KPIForm({this.id, this.dealerType, this.questionType, this.createdate, this.createby, this.updatedate, this.updateby});

  KPIForm.fromJson(Map<String, dynamic> json) {
    // debugger();
    id = json['id'];
    dealerType = json['dealer_type'];
    questionType = json['question_type'];
    createdate = json['createdate'] ?? "";
    createby = json['createby'];
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dealer_type'] = this.dealerType;
    data['question_type'] = this.questionType;

    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class KPIFormAnswerType {
  int? kpiquestionsformid;
  int? answerType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? questionid;
  int? correctAnswer;

  KPIFormAnswerType({
    this.kpiquestionsformid,
    this.answerType,
    this.createdate,
    this.createby,
    this.updatedate,
    this.updateby,
    this.questionid,
    this.correctAnswer,
  });

  KPIFormAnswerType.fromJson(Map<String, dynamic> json) {
    kpiquestionsformid = json['kpiquestionsformid'];
    answerType = json['answer_type'];
    createdate = json['createdate'] ?? "";
    createby = json['createby'];
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
    questionid = json['questionid'];
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kpiquestionsformid'] = this.kpiquestionsformid;
    data['answer_type'] = this.answerType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['questionid'] = this.questionid;
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class KPIFormQuestions {
  int? kpiquestionsformId;
  String? question;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? id;
  int? remarks;
  String? guideline;
  int? isactive;

  KPIFormQuestions({
    this.kpiquestionsformId,
    this.question,
    this.createdate,
    this.createby,
    this.updatedate,
    this.updateby,
    this.id,
    this.remarks,
    this.guideline,
    this.isactive,
  });

  KPIFormQuestions.fromJson(Map<String, dynamic> json) {
    kpiquestionsformId = json['kpiquestionsform_id'];
    question = json['question'] ?? "";
    createdate = json['createdate'] ?? "";
    createby = json['createby'];
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
    id = json['id'];
    remarks = json['remarks'] == 1
        ? 1
        : json['remarks'] == 0
            ? 0
            : json['remarks']
                ? 1
                : 0;
    guideline = json['guideline'];
    isactive = json['isactive'] == 1
        ? 1
        : json['isactive'] == 0
            ? 0
            : json['isactive']
                ? 1
                : 0;
    // json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kpiquestionsform_id'] = this.kpiquestionsformId;
    data['question'] = this.question;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['id'] = this.id;
    data['remarks'] = this.remarks;
    data['guideline'] = this.guideline;
    data['isactive'] = this.isactive;

    return data;
  }
}

class QuestionType {
  int? id;
  String? questionType;
  String? createdate;
  String? updatedate;
  int? updateby;

  QuestionType({this.id, this.questionType, this.createdate, this.updatedate, this.updateby});

  QuestionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionType = json['question_type'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question_type'] = this.questionType;
    data['createdate'] = this.createdate;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class Zones {
  int? id;
  String? zone;
  String? createdate;
  String? updatedate;
  String? updateby;
  int? isactive;

  Zones({this.id, this.zone, this.createdate, this.updatedate, this.updateby, this.isactive});

  Zones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zone = json['zone'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'] ?? "";
    isactive = json['isactive'] ? 1 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zone'] = this.zone;
    data['createdate'] = this.createdate;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['isactive'] = this.isactive;
    return data;
  }
}

class KPIFormAttachmentType {
  int? kpiquestionsformid;
  int? attachmentType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? questionid;

  KPIFormAttachmentType(
      {this.kpiquestionsformid, this.attachmentType, this.createdate, this.createby, this.updatedate, this.updateby, this.questionid});

  KPIFormAttachmentType.fromJson(Map<String, dynamic> json) {
    kpiquestionsformid = json['kpiquestionsformid'];
    attachmentType = json['attachment_type'];
    createdate = json['createdate'] ?? "";
    createby = json['createby'];
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
    questionid = json['questionid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kpiquestionsformid'] = this.kpiquestionsformid;
    data['attachment_type'] = this.attachmentType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['questionid'] = this.questionid;
    return data;
  }
}
class Dealers {
  int? id;
  String? username;
  int? dealerType;
  String? dealershipName;
  String? ownerName;
  String? brand;
  String? dealerContactno;
  String? email;
  String? education;
  String? profession;
  String? previousexperience;
  String? investmentAmount;
  String? area;
  int? cityid;
  String? mainGroup;
  String? address;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  String? cnic;
  int? categoryType;
  String? isValidated;
  String? isApproved;
  String? verfication;
  String? scheduleVisitdateTo;
  String? scheduleVisitdateFrom;
  String? reason;
  String? crcName;
  String? crcContact;
  String? cancellationReason;
  String? additionalInfo;
  String? justification;
  String? validationDate;
  String? approvalDate;
  bool? isSelect;

  Dealers(
      {this.id,
        this.username,
        this.isSelect=true,
        this.dealerType,
        this.dealershipName,
        this.ownerName,
        this.brand,
        this.dealerContactno,
        this.email,
        this.education,
        this.profession,
        this.previousexperience,
        this.investmentAmount,
        this.area,
        this.cityid,
        this.mainGroup,
        this.address,
        this.createdate,
        this.createby,
        this.updatedate,
        this.updateby,
        this.cnic,
        this.categoryType,
        this.isValidated,
        this.isApproved,
        this.verfication,
        this.scheduleVisitdateTo,
        this.scheduleVisitdateFrom,
        this.reason,
        this.crcName,
        this.crcContact,
        this.cancellationReason,
        this.additionalInfo,
        this.justification,
        this.validationDate,
        this.approvalDate});

  Dealers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isSelect = json['isSelect'];
    username = json['username'] ?? "";
    dealerType = json['dealer_type'];
    dealershipName = json['Dealership_name'];
    ownerName = json['owner_name'] ?? "";
    brand = json['brand'] ?? "";
    dealerContactno = json['dealer_contactno'];
    email = json['email'];
    education = json['education'];
    profession = json['profession'];
    previousexperience = json['previousexperience'];
    investmentAmount = json['investment_amount'].toString();
    area = json['area'];
    cityid = json['cityid'];
    mainGroup = json['main_group'] ?? "";
    address = json['address'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    cnic = json['cnic'];
    categoryType = json['category_type'];
    isValidated = json['IsValidated'].toString();
    isApproved = json['IsApproved'].toString();
    verfication = json['Verfication'].toString();
    scheduleVisitdateTo = json['Schedule_visitdate_to'];
    scheduleVisitdateFrom = json['Schedule_visitdate_from'];
    reason = json['reason'];
    crcName = json['crc_name'];
    crcContact = json['crc_contact']??"";
    cancellationReason = json['cancellation_reason'];
    additionalInfo = json['additional_info'];
    justification = json['justification'];
    validationDate = json['validation_date'];
    approvalDate = json['approval_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['dealer_type'] = this.dealerType;
    data['Dealership_name'] = this.dealershipName;
    data['owner_name'] = this.ownerName;
    data['brand'] = this.brand;
    data['dealer_contactno'] = this.dealerContactno;
    data['email'] = this.email;
    data['education'] = this.education;
    data['profession'] = this.profession;
    data['previousexperience'] = this.previousexperience;
    data['investment_amount'] = this.investmentAmount;
    data['area'] = this.area;
    data['cityid'] = this.cityid;
    data['main_group'] = this.mainGroup;
    data['address'] = this.address;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['cnic'] = this.cnic;
    data['category_type'] = this.categoryType;
    data['IsValidated'] = this.isValidated;
    data['IsApproved'] = this.isApproved;
    data['Verfication'] = this.verfication;
    data['Schedule_visitdate_to'] = this.scheduleVisitdateTo;
    data['Schedule_visitdate_from'] = this.scheduleVisitdateFrom;
    data['reason'] = this.reason;
    data['crc_name'] = this.crcName;
    data['crc_contact'] = this.crcContact;
    data['cancellation_reason'] = this.cancellationReason;
    data['additional_info'] = this.additionalInfo;
    data['justification'] = this.justification;
    data['validation_date'] = this.validationDate;
    data['approval_date'] = this.approvalDate;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${dealershipName.toString()} ${id.toString()} ";
  }



}
// class Dealers {
//   int? id;
//   String? username;
//   int? dealerType;
//   String? dealershipName;
//   int? category;
//   String? ownerName;
//   String? brand;
//   String? dealerContactno;
//   String? area;
//   String? zone;
//   int? cityid;
//   String? mainGroup;
//   String? address;
//   String? createdate;
//   int? createby;
//   String? updatedate;
//   int? updateby;
//
//   Dealers(
//       {this.id,
//       this.username,
//       this.dealerType,
//       this.dealershipName,
//       this.category,
//       this.ownerName,
//       this.brand,
//       this.dealerContactno,
//       this.area,
//       this.zone,
//       this.cityid,
//       this.mainGroup,
//       this.address,
//       this.createdate,
//       this.createby,
//       this.updatedate,
//       this.updateby});
//
//   Dealers.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     username = json['username'] ?? "";
//     dealerType = json['dealer_type'];
//     dealershipName = json['Dealership_name'] ?? "";
//     category = json['category'];
//     ownerName = json['owner_name'] ?? "";
//     brand = json['brand'] ?? "";
//     dealerContactno = json['dealer_contactno'] ?? "";
//     area = json['area'] ?? "";
//     zone = json['zone'] ?? "";
//     cityid = json['cityid'];
//     mainGroup = json['main_group'] ?? "";
//     address = json['address'] ?? "";
//     createdate = json['createdate'] ?? "";
//     createby = json['createby'];
//     updatedate = json['updatedate'] ?? "";
//     updateby = json['updateby'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['username'] = this.username;
//     data['dealer_type'] = this.dealerType;
//     data['Dealership_name'] = this.dealershipName;
//     data['category'] = this.category;
//     data['owner_name'] = this.ownerName;
//     data['brand'] = this.brand;
//     data['dealer_contactno'] = this.dealerContactno;
//     data['area'] = this.area;
//     data['zone'] = this.zone;
//     data['cityid'] = this.cityid;
//     data['main_group'] = this.mainGroup;
//     data['address'] = this.address;
//     data['createdate'] = this.createdate;
//     data['createby'] = this.createby;
//     data['updatedate'] = this.updatedate;
//     data['updateby'] = this.updateby;
//     return data;
//   }
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return "${dealershipName.toString()}";
//   }
// }

class Categories {
  int? id;
  String? categoryType;
  String? createdate;
  String? updatedate;
  int? updateby;

  Categories({this.id, this.categoryType, this.createdate, this.updatedate, this.updateby});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryType = json['category_type'] ?? "";
    createdate = json['createdate'] ?? "";
    updatedate = json['updatedate'];
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_type'] = this.categoryType;
    data['createdate'] = this.createdate;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return categoryType.toString();
  }
}

class OSForm {
  int? id;
  int? dealerType;
  int? categoryType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;

  OSForm({this.id, this.dealerType, this.categoryType, this.createdate, this.createby, this.updatedate, this.updateby});

  OSForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dealerType = json['dealer_type'] ?? "";
    categoryType = json['category_type'] ?? "";
    createdate = json['createdate'] ?? "";
    createby = json['createby'];
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dealer_type'] = this.dealerType;
    data['category_type'] = this.categoryType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class OSFormAnswerType {
  int? osFiascaformid;
  int? answerType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? boardid;
  int? correctAnswer;

  OSFormAnswerType(
      {this.correctAnswer, this.osFiascaformid, this.answerType, this.createdate, this.createby, this.updatedate, this.updateby, this.boardid});

  OSFormAnswerType.fromJson(Map<String, dynamic> json) {
    osFiascaformid = json['os_fiascaformid'];
    answerType = json['answer_type'];
    createdate = json['createdate'] ?? "";
    createby = json['createby'];
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
    boardid = json['boardid'];
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['os_fiascaformid'] = this.osFiascaformid;
    data['answer_type'] = this.answerType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['boardid'] = this.boardid;
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class OSFormAttachmentType {
  int? osFiascaformid;
  int? attachmentType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? boardid;

  OSFormAttachmentType({this.osFiascaformid, this.attachmentType, this.createdate, this.createby, this.updatedate, this.updateby, this.boardid});

  OSFormAttachmentType.fromJson(Map<String, dynamic> json) {
    osFiascaformid = json['os_fiascaformid'];
    attachmentType = json['attachment_type'];
    createdate = json['createdate'] ?? "";
    createby = json['createby'];
    updatedate = json['updatedate'] ?? "";
    updateby = json['updateby'];
    boardid = json['boardid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['os_fiascaformid'] = this.osFiascaformid;
    data['attachment_type'] = this.attachmentType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['boardid'] = this.boardid;
    return data;
  }
}

class CategoryWiseModelForm {
  int? id;
  int? categoryType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;

  CategoryWiseModelForm({this.id, this.categoryType, this.createdate, this.createby, this.updatedate, this.updateby});

  CategoryWiseModelForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryType = json['category_type'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_type'] = this.categoryType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class CategoryWiseModelFormAnswerType {
  int? cwmformId;
  int? answerType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? modelid;
  String? correctAnswer;

  CategoryWiseModelFormAnswerType(
      {this.cwmformId, this.answerType, this.createdate, this.createby, this.updatedate, this.updateby, this.modelid, this.correctAnswer});

  CategoryWiseModelFormAnswerType.fromJson(Map<String, dynamic> json) {
    cwmformId = json['cwmform_id'];
    answerType = json['answer_type'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    modelid = json['modelid'];
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cwmform_id'] = this.cwmformId;
    data['answer_type'] = this.answerType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['modelid'] = this.modelid;
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class CategoryWiseModelFormAttachmentType {
  int? cwmformId;
  int? attachmentType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? modelid;

  CategoryWiseModelFormAttachmentType(
      {this.cwmformId, this.attachmentType, this.createdate, this.createby, this.updatedate, this.updateby, this.modelid});

  CategoryWiseModelFormAttachmentType.fromJson(Map<String, dynamic> json) {
    cwmformId = json['cwmform_id'];
    attachmentType = json['attachment_type'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    modelid = json['modelid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cwmform_id'] = this.cwmformId;
    data['attachment_type'] = this.attachmentType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['modelid'] = this.modelid;
    return data;
  }
}

class DealerFeedbackForm {
  int? id;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;

  DealerFeedbackForm({this.id, this.createdate, this.createby, this.updatedate, this.updateby});

  DealerFeedbackForm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class DealerFeedbackFormAttachmentTypes {
  int? dfqformId;
  int? attachmentType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? questionid;

  DealerFeedbackFormAttachmentTypes(
      {this.dfqformId, this.attachmentType, this.createdate, this.createby, this.updatedate, this.updateby, this.questionid});

  DealerFeedbackFormAttachmentTypes.fromJson(Map<String, dynamic> json) {
    dfqformId = json['dfqform_id'];
    attachmentType = json['attachment_type'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    questionid = json['questionid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dfqform_id'] = this.dfqformId;
    data['attachment_type'] = this.attachmentType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['questionid'] = this.questionid;
    return data;
  }
}

class DealerFeedbackFormQuestions {
  int? dfqformId;
  String? question;
  int? remarks;
  String? guideline;
  int? isactive;
  int? createby;
  String? creatdate;
  int? updateby;
  String? updatedate;
  int? id;

  DealerFeedbackFormQuestions(
      {this.dfqformId,
      this.question,
      this.remarks,
      this.guideline,
      this.isactive,
      this.createby,
      this.creatdate,
      this.updateby,
      this.updatedate,
      this.id});

  DealerFeedbackFormQuestions.fromJson(Map<String, dynamic> json) {
    dfqformId = json['dfqform_id'];
    question = json['question'];
    remarks = json['remarks'] == 1
        ? 1
        : json['remarks'] == 0
            ? 0
            : json['remarks']
                ? 1
                : 0;
    guideline = json['guideline'];
    isactive = json['isactive'] == 1
        ? 1
        : json['isactive'] == 0
            ? 0
            : json['isactive']
                ? 1
                : 0;
    // json['isactive'] ? 1 : 0;
    createby = json['createby'];
    creatdate = json['creatdate'];
    updateby = json['updateby'];
    updatedate = json['updatedate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dfqform_id'] = this.dfqformId;
    data['question'] = this.question;
    data['remarks'] = this.remarks;
    data['guideline'] = this.guideline;
    data['isactive'] = this.isactive;
    data['createby'] = this.createby;
    data['creatdate'] = this.creatdate;
    data['updateby'] = this.updateby;
    data['updatedate'] = this.updatedate;
    data['id'] = this.id;
    return data;
  }
}

class OSFormBoardDescription {
  int? id;
  int? osformId;
  int? categoryType;
  String? boarddescription;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? remarks;
  String? guideline;
  int? isactive;

  OSFormBoardDescription(
      {this.id,
      this.osformId,
      this.categoryType,
      this.boarddescription,
      this.createdate,
      this.createby,
      this.updatedate,
      this.updateby,
      this.remarks,
      this.guideline,
      this.isactive});

  OSFormBoardDescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    osformId = json['osform_id'];
    categoryType = json['category_type'];
    boarddescription = json['boarddescription'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    remarks = json['remarks'] == 1
        ? 1
        : json['remarks'] == 0
            ? 0
            : json['remarks']
                ? 1
                : 0;
    guideline = json['guideline'];
    isactive = json['isactive'] == 1
        ? 1
        : json['isactive'] == 0
            ? 0
            : json['isactive']
                ? 1
                : 0;
    // json['isactive'] ? 1 : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['osform_id'] = osformId;
    data['category_type'] = categoryType;
    data['boarddescription'] = boarddescription;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['remarks'] = this.remarks;
    data['guideline'] = this.guideline;
    data['isactive'] = this.isactive;
    return data;
  }
}

class OSFormBoardImages {
  int? id;
  int? isSync;
  int? formid;
  int? boardid;
  String? filepath;
  String? path;
  int? createby;
  String? createdate;

  OSFormBoardImages({this.id, this.formid, this.boardid, this.filepath, this.createby, this.createdate,this.isSync,this.path});

  OSFormBoardImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formid = json['formid'];
    isSync = json['isSync'];
    path = json['path'];
    boardid = json['boardid'];
    filepath = json['filepath'];
    createby = json['createby'];
    createdate = json['createdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['formid'] = this.formid;
    data['isSync'] =this.isSync ==null?0:this.isSync;
    data['path'] = this.path;
    data['boardid'] = this.boardid;
    data['filepath'] = this.filepath;
    data['createby'] = this.createby;
    data['createdate'] = this.createdate;
    return data;
  }
}

class CategoryWiseModelFormModels {
  int? id;
  int? cwmformId;
  int? categoryType;
  String? companyStandard;
  String? standard;
  int? remarks;
  int? isactive;
  String? guideline;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;

  CategoryWiseModelFormModels(
      {this.id,
      this.cwmformId,
      this.categoryType,
      this.companyStandard,
      this.standard,
      this.remarks,
      this.isactive,
      this.guideline,
      this.createdate,
      this.createby,
      this.updatedate,
      this.updateby});

  CategoryWiseModelFormModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cwmformId = json['cwmform_id'];
    categoryType = json['category_type'];
    companyStandard = json['company_standard'];
    standard = json['standard'];
    remarks = json['remarks'] == 1
        ? 1
        : json['remarks'] == 0
            ? 0
            : json['remarks']
                ? 1
                : 0;
    isactive = json['isactive'] == 1
        ? 1
        : json['isactive'] == 0
            ? 0
            : json['isactive']
                ? 1
                : 0;
    // json['isactive'];
    guideline = json['guideline'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cwmform_id'] = this.cwmformId;
    data['category_type'] = this.categoryType;
    data['company_standard'] = this.companyStandard;
    data['standard'] = this.standard;
    data['remarks'] = this.remarks;
    data['isactive'] = this.isactive;
    data['guideline'] = this.guideline;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}

class DealerFeedbackFormAsnwerTypes {
  int? dfqformId;
  int? answerType;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;
  int? questionid;
  String? correctAnswer;

  DealerFeedbackFormAsnwerTypes(
      {this.dfqformId, this.answerType, this.createdate, this.createby, this.updatedate, this.updateby, this.questionid, this.correctAnswer});

  DealerFeedbackFormAsnwerTypes.fromJson(Map<String, dynamic> json) {
    dfqformId = json['dfqform_id'];
    answerType = json['answer_type'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    questionid = json['questionid'];
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dfqform_id'] = this.dfqformId;
    data['answer_type'] = this.answerType;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['questionid'] = this.questionid;
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}
class DealerFeedbackFormAnswers {
  int? id;
  int? formId;
  int? questionId;
  String? answer;
  String? createdate;
  int? createby;
  String? updatedate;
  String? updateby;
  String? remarks;
  int? dealerId;
  int? answertypeId;

  DealerFeedbackFormAnswers(
      {this.id,
        this.formId,
        this.questionId,
        this.answer,
        this.createdate,
        this.createby,
        this.updatedate,
        this.updateby,
        this.remarks,
        this.dealerId,
        this.answertypeId});

  DealerFeedbackFormAnswers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formId = json['form_id'];
    questionId = json['question_id'];
    answer = json['answer'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    remarks = json['remarks'];
    dealerId = json['dealer_id'];
    answertypeId = json['answertype_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['form_id'] = this.formId;
    data['question_id'] = this.questionId;
    data['answer'] = this.answer;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['remarks'] = this.remarks;
    data['dealer_id'] = this.dealerId;
    data['answertype_id'] = this.answertypeId;
    return data;
  }
}


class KPIFormAnswers {
  int? id;
  int? formId;
  int? questionId;
  String? answer;
  int? answertypeId;
  String? createdate;
  int? createby;
  String? updatedate;
  String? updateby;
  String? remarks;
  int? dealerId;

  KPIFormAnswers(
      {this.id,
        this.formId,
        this.questionId,
        this.answer,
        this.answertypeId,
        this.createdate,
        this.createby,
        this.updatedate,
        this.updateby,
        this.remarks,
        this.dealerId});

  KPIFormAnswers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formId = json['form_id'];
    questionId = json['question_id'];
    answer = json['answer'];
    answertypeId = json['answertype_id'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    remarks = json['remarks'];
    dealerId = json['dealer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['form_id'] = this.formId;
    data['question_id'] = this.questionId;
    data['answer'] = this.answer;
    data['answertype_id'] = this.answertypeId;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['remarks'] = this.remarks;
    data['dealer_id'] = this.dealerId;
    return data;
  }
}



class OSFormAnswers {
  int? id;
  int? formId;
  String? answer;
  int? answertypeId;
  String? createdate;
  int? createby;
  String? updatedate;
  String? updateby;
  int? boardId;
  int? dealerId;
  String? remarks;

  OSFormAnswers(
      {this.id,
        this.formId,
        this.answer,
        this.answertypeId,
        this.createdate,
        this.createby,
        this.updatedate,
        this.updateby,
        this.boardId,
        this.dealerId,
        this.remarks});

  OSFormAnswers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formId = json['form_id'];
    answer = json['answer'];
    answertypeId = json['answertype_id'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
    boardId = json['board_id'];
    dealerId = json['dealer_id'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['form_id'] = this.formId;
    data['answer'] = this.answer;
    data['answertype_id'] = this.answertypeId;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    data['board_id'] = this.boardId;
    data['dealer_id'] = this.dealerId;
    data['remarks'] = this.remarks;
    return data;
  }
}


class CategoryWiseModelFormFormImages {
  int? id;
 String? path;
     int ?  isSync;
  int? categoryType;
  String? filepath;
  String? createdate;
  int? createby;
  String? updatedate;
  int? updateby;

  CategoryWiseModelFormFormImages(
      {this.id,
        this.categoryType,
        this.filepath,
        this.createdate,
        this.createby,
        this.updatedate,
        this.updateby,
        this.path,
        this.isSync,

      });

  CategoryWiseModelFormFormImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryType = json['category_type'];
    isSync = json['isSync'];
    path = json['path'];
    filepath = json['filepath'];
    createdate = json['createdate'];
    createby = json['createby'];
    updatedate = json['updatedate'];
    updateby = json['updateby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_type'] = this.categoryType;
    data['filepath'] = this.filepath;
    data['isSync'] = this.isSync==null?0:isSync;
    data['path'] = this.path;
    data['createdate'] = this.createdate;
    data['createby'] = this.createby;
    data['updatedate'] = this.updatedate;
    data['updateby'] = this.updateby;
    return data;
  }
}