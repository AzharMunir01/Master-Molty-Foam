import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:molty_foam/app/widgets/noData.dart';

import '../../../theme/textStyle.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../controller/dashboardController.dart';

class MonthlySubmission extends StatelessWidget {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {

    return CustomBackground(
        back: true,
        alertText: "",
        isLoading: 0.obs,
        callback: () {},
        child:
        Obx(()=>
        controller.formSubmitFormInfo.isEmpty?noData("No forms submitted this month"):
        ListView.builder(
          reverse:true ,
            shrinkWrap: true,
            itemCount: controller.formSubmitFormInfo.length,
            itemBuilder: (_, i) {
              return _buildItem(
                i,
              );
            })));
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
                  .dealerType[controller.dealerType.indexWhere((element) => element.id == controller.formSubmitFormInfo[i].dealerTypeId)].dealerType),

          _buildItemRow("Dealer Name",
              controller.dealer[controller.dealer.indexWhere((element) => element.id == controller.formSubmitFormInfo[i].dealerId)].dealershipName),
          _buildItemRow("Dealer Contact",
              controller.dealer[controller.dealer.indexWhere((element) => element.id == controller.formSubmitFormInfo[i].dealerId)].dealerContactno),
          _buildItemRow(
              "Dealer City",
              controller
                  .city[controller.city.indexWhere((element) =>
                      element.id ==
                      controller.dealer[controller.dealer.indexWhere((element) => element.id == controller.formSubmitFormInfo[i].dealerId)].cityid)]
                  .city),
          _buildItemRow(
              "Form Type",
              controller.formSubmitFormInfo[i].type
          ),
          _buildItemRow(
              "Date Time",
              controller.formSubmitFormInfo[i].dateTime),
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
