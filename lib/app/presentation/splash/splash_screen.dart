import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../data/local/database/database.dart';
import '../../data/model/userModel.dart';
import '../../netWorking/sevices/backgrounServices.dart';
import '../../routes/app_page.dart';
import '../syncData/syncData.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    decideWhatToDo();

  }

  getCurrentPage() async {

    final getUser = await DatabaseHelper.getUsers();

  setState(() {
    for (var result in getUser) {
      user.add(UserModel.fromJson(result));
    }
  });

    }



  List<UserModel> user = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/bgImage.png",
              ),
              fit: BoxFit.fitWidth)),
      child: Image.asset("assets/images/master-logo.png"),
    ));
  }
  Future<void> decideWhatToDo() async {
    await DatabaseHelper.init();
    await Future.delayed(const Duration(seconds: 3));
    // SyncData().getSyncData();
 await   getCurrentPage();
    await Future.delayed(const Duration(seconds: 3));

    user.isNotEmpty?{
      startStart(),
      Get.offAllNamed(AppPages.dashboardView)

    }:
    // Navigator.pushNamed(context, AppPages.dashboardView);
      Navigator.pushReplacementNamed(context, AppPages.loginView);
    }
  final PeriodicTask _periodicTask = PeriodicTask();
  startStart(){

    _periodicTask.start();
  }

}
