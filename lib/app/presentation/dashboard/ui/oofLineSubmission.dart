

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../utils/utiles.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/noData.dart';
import '../controller/dashboardController.dart';

class OffLineSubmission extends StatefulWidget {
  const OffLineSubmission({Key? key}) : super(key: key);

  @override
  State<OffLineSubmission> createState() => _OffLineSubmissionState();
}

class _OffLineSubmissionState extends State<OffLineSubmission> {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {

    return
      CustomBackground(
        back: controller.isBack.value,
        alertText: "",
        isLoading: 0.obs,
        callback: () {},
        child:Obx(()=>
        Stack(children: [
            // controller.offLineSubmissionForm.isEmpty?noData("No form found offline"): ListView.builder(
            controller.offLineSubmissionForm.isEmpty?noData("No form found offline"): ListView.builder(
              shrinkWrap: true,
              itemCount: controller.offLineSubmissionForm.length,
              // controller.offLineSubmissionForm.length,
              itemBuilder: (_, i) {
                return _buildItem(
                  i,
                );
              }),

          Align(
              alignment: Alignment.bottomCenter,
              child: Obx(() {
            return controller.offLineSubmissionForm.isEmpty?SizedBox():Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              child: Button(
                buttonTxt: "isSync",
                buttonColor: FColors.primaryColor,
                callback:() async {
               final connectionResult = await checkConnection();
             if (connectionResult) {
               // Get.dialog(const RotatedImageWidget(), barrierDismissible: true);
               try {
                 formUploadingPercentage();
              await controller.syncForm(context);
                 // await BackgroundServices().getFormFiles();
                 // // await BackgroundServices().getFormData();
                 // await BackgroundServices().getDFQForms();
                 // await BackgroundServices().getOnBoardDealer();
              await controller.submitFormInfo();
              // controller.offLineSubmissionForm.isEmpty?  Get.offAll(DashboardView());
               }catch(e){
                 Utils.showSnackBar("Error", "Something wrong Please try again",color:Colors.white);
               }
                  // controller.getLoginLocal();
                }else{
               Utils.showSnackBar("Error", "Please check your internet connection",color:Colors.white);

             }


                }
              ),
            );
          }
          ),)


        ],)


    ));
  }
  static Future<bool> checkConnection() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }

  _buildItem(int i) {
    // style:widget.isenable !=null ||widget.isenable==true ?FTextStyle.textFielhintStyleGrey: FTextStyle.textFieldStyleblack,
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          _buildItemRow(
              "Dealer Type",
              controller
                  .dealerType[controller.dealerType.indexWhere((element) => element.id == controller.offLineSubmissionForm[i].dealerTypeId)].dealerType),
          _buildItemRow("Dealer Name",
              controller.dealer[controller.dealer.indexWhere((element) => element.id == controller.offLineSubmissionForm[i].dealerId)].dealershipName),
          _buildItemRow("Dealer Contact",
              controller.dealer[controller.dealer.indexWhere((element) => element.id == controller.offLineSubmissionForm[i].dealerId)].dealerContactno),
          _buildItemRow(
              "Dealer City",
              controller
                  .city[controller.city.indexWhere((element) =>
              element.id ==
                  controller.dealer[controller.dealer.indexWhere((element) => element.id == controller.offLineSubmissionForm[i].dealerId)].cityid)]
                  .city),
          _buildItemRow(
              "Form Type",
              controller.offLineSubmissionForm[i].type
          ),

          _buildItemRow(
              "Date Time",
              controller.offLineSubmissionForm[i].dateTime),
        ],
      ),
    );
  }

  _buildItemRow(String? title, String? val) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      Expanded(
          flex: 2,
          child: Text("$title", style: FTextStyle.textFieldStyleblack)),
          Spacer(),
          // Expanded(child:SizedBox()),
           Expanded(
               flex: 4,
               child: Text(

             textAlign: TextAlign.start,
             val ?? "",
             style: FTextStyle.textFielhintStyleGrey,
           )),
        ],
      ),
    );
  }
  void formUploadingPercentage() {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        "Please wait, Upload data...",
        style: TextStyle(fontSize: 18, color: FColors.primaryColor, fontWeight: FontWeight.bold),
      ),
      content: Obx(() =>SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 20,
          ),
          Text("Uploading Form ${controller.formDialog.value}/ ${controller.offLineSubmissionForm.length}"),
          const SizedBox(
            height: 10,
          ),
          Text("${controller.formName.value} Images   ${controller.imageIndex.value}/ ${controller.totalImage.value}"),
        ],
      ))),
      actions: [],
    );

    showDialog(
      barrierDismissible: false, // Ensure the dialog can't be dismissed by tapping outside
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return false; // Allow dialog to close
          },
          child: alert,
        );
      },
    );
  }
}
