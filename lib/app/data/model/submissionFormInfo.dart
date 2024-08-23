class SubmitFormInfo {
  int? isSync;
  int? requestFormId;
  int? dealerId;
  int? dealerTypeId;
  String? dateTime;
  String? type;

  SubmitFormInfo({
    this.isSync,
    this.requestFormId,
    this.dealerId,
    this.dealerTypeId,
    this.dateTime,
    this.type,
  });

  // Convert a SubmitFormInfo object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'isSync': isSync,
      'type': type,
      'requestFormId': requestFormId,
      'dealerId': dealerId,
      'dealerTypeId': dealerTypeId,
      'dateTime': dateTime, // Convert DateTime to ISO 8601 string
    };
  }

  // Extract a SubmitFormInfo object from a Map object
  factory SubmitFormInfo.fromMap(Map<String, dynamic> map) {
    return SubmitFormInfo(
      isSync: map['isSync'],
      type: map['type'],
      requestFormId: map['requestFormId'],
      dealerId: map['dealerId'],
      dealerTypeId: map['dealerTypeId'],
      dateTime: map['dateTime'] , // Convert ISO 8601 string to DateTime
    );
  }

  // Convert a SubmitFormInfo object into a JSON object
  Map<String, dynamic> toJson() => toMap();

  // Extract a SubmitFormInfo object from a JSON object
  factory SubmitFormInfo.fromJson(Map<String, dynamic> json) => SubmitFormInfo.fromMap(json);
}

// void main() {
//   // Example usage
//   SubmitFormInfo submitFormInfo = SubmitFormInfo(
//     requestFormId: 1,
//     dealerId: 123,
//     dealerTypeId: 456,
//     dateTime: DateTime.now(),
//   );
//
//   // Convert SubmitFormInfo object to JSON
//   Map<String, dynamic> json = submitFormInfo.toJson();
//   print('SubmitFormInfo to JSON: $json');
//
//   // Convert JSON to SubmitFormInfo object
//   SubmitFormInfo newSubmitFormInfo = SubmitFormInfo.fromJson(json);
//   print('SubmitFormInfo from JSON: ${newSubmitFormInfo.dateTime}');
// }
