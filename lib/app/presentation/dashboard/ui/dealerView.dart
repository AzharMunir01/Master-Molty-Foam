import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../theme/textStyle.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/noData.dart';
import '../controller/dashboardController.dart';

class DealerView extends StatelessWidget {
  DealerView({Key? key}) : super(key: key);
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
      back: true,
        alertText: "",
        isLoading:0.obs,
        callback: () {},
        child: Obx(()=> controller.dealer.isEmpty?noData("No Dealer Available "):ListView.builder(
            shrinkWrap: true,
            itemCount: controller.dealer.length,
            itemBuilder: (_, i) {
              return _buildItem(
                i,
              );
            })));
  }

  _buildItem(int i) {

    // style:widget.isenable !=null ||widget.isenable==true ?FTextStyle.textFielhintStyleGrey: FTextStyle.textFieldStyleblack,
    return Container(
      padding: EdgeInsets.all(10),
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          _buildItemRow("Dealer Name", controller.dealer[i].dealershipName!),
          _buildItemRow("Contact", controller.dealer[i].dealerContactno ?? ""),
          _buildItemRow("nic", controller.dealer[i].cnic!.toString()),
          _buildItemRow("Email", controller.dealer[i].email ?? ""),
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
  // _buildItemRow(String? title, String? val) {
  //   return Padding(
  //     padding: EdgeInsets.all(10),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text("$title", style: FTextStyle.textFieldStyleblack),
  //         Text(
  //           val!,
  //           style: FTextStyle.textFielhintStyleGrey,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
