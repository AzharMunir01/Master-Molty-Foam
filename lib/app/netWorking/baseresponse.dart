class BaseResponse {
  String? status;
  String? message;
  dynamic data;

  BaseResponse.constructor();

  BaseResponse({this.status, this.message, this.data});

  factory BaseResponse.fromJson(dynamic json  ) {
    try {
      return BaseResponse(
          status: json["status"], message: json["message"], data: json["data"]);
    } catch (ex) {
      return BaseResponse(
          status: "error",
          message: "Bad Response from Api this is hard coded msg",
          data: "");
    }
  }

  @override
  String toString() {
    return 'BaseResponse{IsSuccess: $status, Message: $message, Data: $data}';
  }
}
