import 'dart:convert';

class PostFormData {
  int? id;
  int? isSync;
  String? kPIForms;
  String? oSForms;
  String? cWMForms;
  // String? dFQForms;

  PostFormData({this.kPIForms, this.oSForms, this.cWMForms,
    // this.dFQForms,
    this.id,this.isSync});

  PostFormData.fromJson(Map<String, dynamic> json) {
    kPIForms = json['KPIForms'];
    id = json['id'];
    isSync = json['isSync'];
    oSForms = json['OSForms'];
    cWMForms = json['CWMForms'];
    // dFQForms = json['DFQForms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['KPIForms'] = jsonDecode(kPIForms!);
    data['OSForms'] = jsonDecode(oSForms!);
    data['CWMForms'] = jsonDecode(cWMForms!);
    // data['DFQForms'] = jsonDecode(dFQForms!);
    return data;
  }
}

class    DFQForms{
  String? dFQForms;
  int? id;
  DFQForms({this.dFQForms,this.id});
  DFQForms.fromJson(Map<String, dynamic> json) {
    dFQForms = json['DFQForms'];
    id = json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DFQForms'] = jsonDecode(dFQForms!);
    return data;
  }
}