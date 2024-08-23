import '../CategotoesWMFAModel/CategotoesWMFAModel.dart';
import '../OutdoorShopFasciaModel/OutdoorShopFasciaModel.dart';
import '../feddbackModle/feedbackModel.dart';
import '../kpiFormModel/kpiQuestionModel.dart';

class RequestForm {
  int? id;
  int isSync;
  KpiFormRequest kpiForm;
  OutdoorShopFasciaModel osForm;
  CategoriesWMFAModel cWMForm;
  FeedbackModels dFQForm;

  RequestForm({
    this.id,
    required this.isSync,
    required this.kpiForm,
    required this.osForm,
    required this.cWMForm,
    required this.dFQForm,
  });

  // Extract a RequestForm object from a Map.
  factory RequestForm.fromJson(Map<String, dynamic> json) {
    return RequestForm(
      id: json['id'],
      isSync: json['isSync'],
      kpiForm: KpiFormRequest.fromJson(json['kpiForm']),
      osForm: OutdoorShopFasciaModel.fromJson(json['osForm']),
      cWMForm: CategoriesWMFAModel.fromJson(json['cWMForm']),
      dFQForm: FeedbackModels.fromJson(json['dFQForm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isSync': isSync,
      'kpiForm': kpiForm.toJson(),
      'osForm': osForm.toJson(),
      'cWMForm': cWMForm.toJson(),
      'dFQForm': dFQForm.toJson(),
    };
  }
}
