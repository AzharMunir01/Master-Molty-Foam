import '../data/model/onBoardDealerModel.dart';
import 'baseresponse.dart';

abstract class ApiFunction{

  Future<BaseResponse> loginApi(var value);
  Future<BaseResponse> formDataRequest(var value);
  Future<BaseResponse> onBDManagement(OnBoardDealerManagement value);
  Future<BaseResponse> sendFormFiles(var value);
  Future<BaseResponse> syncData(int userID);
  Future<String>  getFormImages(String url);


}