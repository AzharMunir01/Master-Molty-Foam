class RequestFormModel {
  int isSync;
  String KPIForms;
  String OSForms;
  String CWMForms;
  // String DFQForms;

  RequestFormModel({
    required this.isSync,
    required this.KPIForms,
    required this.OSForms,
    required this.CWMForms,
    // required this.DFQForms,
  });

  // Convert a FormData object into a Map. The keys must correspond to the column names.
  Map<String, dynamic> toJson() {
    return {
      'isSync': isSync,
      'KPIForms': KPIForms,
      'OSForms': OSForms,
      'CWMForms': CWMForms,
      // 'DFQForms': DFQForms,
    };
  }

  // Extract a FormData object from a Map.
  factory RequestFormModel.fromJson(Map<String, dynamic> json) {
    return RequestFormModel(
      isSync: json['isSync'],
      KPIForms: json['KPIForms'],
      OSForms: json['OSForms'],
      CWMForms: json['CWMForms'],
      // DFQForms: json['DFQForms'],
    );
  }
}