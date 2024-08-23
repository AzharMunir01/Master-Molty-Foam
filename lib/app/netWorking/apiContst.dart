class ApiConst {
  static const int requestTimeOut =60; //sec
  /// stage
  // static const baseUrl = "https://molty.bmccrm.com:442/MoltyDMAPP/MoltyDMAPI/api/";
  ///live
  static const baseUrl = "https://moltydms.bmccrm.com/MoltyDMApi/api/";
  // static const fileBaseUri = "https://molty.bmccrm.com:442/MoltyDMAPP";
  static const fileBaseUri = "https://moltydms.bmccrm.com";

  /// end point
  static const login = "${baseUrl}Session/MobileLogin";
  static const syncDataGet = "${baseUrl}Admin/SyncDataGet?UserID=";
  static const formDataRequest = "${baseUrl}Admin/SyncDataUpload";
  static const syncDataUploadDealerFeedback = "${baseUrl}Admin/SyncDataUploadDealerFeedback";
  static const dealerOnBoardingRequest = "${baseUrl}Admin/DealerOnBoarding";
  static const syncImageUpload = "${baseUrl}Admin/SyncImageUpload";
}

// live login
// hafizazhar
// abc123`