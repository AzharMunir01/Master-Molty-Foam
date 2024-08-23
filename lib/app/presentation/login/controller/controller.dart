import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../data/local/database/database.dart';
import '../../../data/model/userModel.dart';
import '../../../netWorking/apiAuth.dart';
import '../../../netWorking/sevices/backgrounServices.dart';
import '../../../routes/app_page.dart';
import '../../../utils/NavigationService.dart';
import '../../../utils/appConst.dart';
import '../../../utils/utiles.dart';
import '../../../widgets/Animations/animated_widget.dart';
import '../../syncData/syncData.dart';

class LoginController extends GetxController {
  final Rx<PeriodicTask> _periodicTask = PeriodicTask().obs;
  final ApiServices _apiServices = ApiServices();
  final TextEditingController userName = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  final isLoading = false.obs;
  final userData = UserModel().obs;
  final isEnable = false.obs;
  final isValidate = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getLoginLocal() async {
    try {
      isUpdate(true);
      final data = await DatabaseHelper.getUsers();
      if (data.isEmpty) {
        Utils.showSnackBar("Error", "User does not exist offline",color:Colors.white);
        getLogin();
      } else {
        userData(UserModel.fromJson(data[0]));
        final value = offlineValidation();
        if (value.isEmpty) {
           DatabaseHelper.insertBgService(0);
          Get.offAllNamed(AppPages.dashboardView);
          Utils.showSnackBar("Success", "Login successful",color:Colors.white);
          isUpdate(false);
        } else {
          getLogin();
          Utils.showSnackBar("Error", value);
        }
      }
    } catch (e) {
      print("Error in getLoginLocal: $e");
      Utils.showSnackBar("Error", "Something went wrong",color:Colors.white);
    }
  }

  String offlineValidation() {
    if (userData.value.username == userName.text && userData.value.password == userPassword.text) {
      return "";
    } else {
      return "Please check your username or password";
    }
  }

  Future<void> getLogin() async {
    try {
      final response = await _apiServices.loginApi(loginData());

      if (response.status == "false") {
        isUpdate(false);
        Utils.showSnackBar("Error", response.message ?? "Unknown error",color:Colors.white);
      } else {
        if (response.data["status"] == "true") {
          userData(UserModel.fromJson(response.data["data"][0]));
          final authToken = AuthToken.fromJson(response.data["AuthToken"]);
          token = authToken.accessToken!;
          if (userData.value.roleId == 3 || userData.value.roleId == 4) {
            // await SyncData().getSyncData(userData.value.userId!);
            _periodicTask.value.start();
            await DatabaseHelper.insertUser(userData.value);
            await DatabaseHelper.insertUserAuthToken(authToken);
            await DatabaseHelper.insertCurrentPage(AppConst.kpiForm);
            isUpdate(false);
            Get.offAllNamed(AppPages.dashboardView);
            Utils.showSnackBar("Success", response.message ?? "Unknown message");
          } else {
            isUpdate(false);
            Utils.showSnackBar("Error", "This user ID is not allowed for mobile application",color:Colors.white);
          }
        } else if (response.data["status"] == "false") {
          Utils.showSnackBar("Error", response.data["Message"] ?? "Unknown message",color:Colors.white);
          isUpdate(false);
        } else {
          isUpdate(false);
        }
      }
    } catch (e) {
      isUpdate(false);
      print("Error in getLogin: $e");
      Utils.showSnackBar("Error", "$e");
    } finally {
      // isUpdate();
    }
  }

  void isUpdate(bool val) {
    if (val) {
      Get.dialog(const RotatedImageWidget(), barrierDismissible: false);
    } else {
      Navigator.of(NavigationService.navigatorKey.currentContext!).pop();
    }
  }

  void isVisible() {
    isEnable.value = !isEnable.value;
  }

  void validation() {
    isValidate.value = userName.text.isNotEmpty && userPassword.text.isNotEmpty;
  }

  Map<String, String> loginData() {
    return {
      'LoginName': userName.text.trim(),
      'UserPassword': userPassword.text.trim(),
    };
  }
}
