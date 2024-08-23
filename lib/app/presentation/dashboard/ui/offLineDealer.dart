import 'package:animations/animations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../netWorking/sevices/backgrounServices.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../utils/utiles.dart';
import '../../../widgets/Animations/animated_widget.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/noData.dart';
import '../controller/dashboardController.dart';
import 'dashboardUi.dart';

class OffLineDealer extends StatelessWidget {
  OffLineDealer({Key? key}) : super(key: key);
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        back: true,
        alertText: "",
        isLoading:0.obs,
        callback: () {},
        child:  Obx(()=> Stack(children: [ controller.offLineDealer.isEmpty?noData("No Dealer Available OffLine "):
        ListView.builder(
            shrinkWrap: true,
            itemCount:controller.offLineDealer.length,
            itemBuilder: (_, i) {
              return _buildItem(
                i,
              );
            }),

          Align(
            alignment: Alignment.bottomCenter,
            child: Obx(() {
              return controller.offLineDealer.isEmpty?SizedBox():Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                child: Button(
                    buttonTxt: "isSync",
                    buttonColor: FColors.primaryColor,
                    callback:() async {
                      final connectionResult = await checkConnection();
                      if (connectionResult) {
                        Get.dialog(const RotatedImageWidget(), barrierDismissible: true);
                        try {
                          if(await controller.isSync()==0) {
                            await BackgroundServices().getOnBoardDealer();
                            // await BackgroundServices().getFormFiles();
                            // await BackgroundServices().getFormData();

                            Get.offAll(DashboardView());
                          }else{
                            Get.back();
                            Utils.showSnackBar("Wait", "Please Some wait",color:Colors.white);
                          }
                        }catch(e){
                          Get.back();
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

        ]  )));
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
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          _buildItemRow("Dealer Name", controller.offLineDealer[i].dealershipName!),
          _buildItemRow("Contact", controller.offLineDealer[i].crcContact ?? ""),
          _buildItemRow("nic", controller.offLineDealer[i].cnic!.toString()),
          _buildItemRow("Email", controller.offLineDealer[i].email ?? ""),
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
}
