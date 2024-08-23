import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:molty_foam/app/presentation/dashboard/ui/todaySubmission.dart';

import '../../../routes/app_page.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../controller/dashboardController.dart';
import 'lastVisit.dart';
import 'offLineDealer.dart';


class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final DashboardController controller = Get.put(DashboardController());
  // final DashboardController controller = Get.put(DashboardController());
  bool refresh = true;
  @override
  Widget build(BuildContext context,) {
    // controller.submitFormInfo();
    return

      CustomBackground(
        alertText: "",
        isLoading:0.obs,
        callback: () {},
        child: Obx((){
          return

            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DashboardButton(
                            imagePath: "assets/images/dealer.png",
                            value:controller.dealer.length.toString(),
                            title: "Dealer",
                            onTap: () {

                              Get.toNamed(AppPages.dealerView);

                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: DashboardButton(
                            imagePath:"assets/images/request.png",
                            value:"fdf",
                            title: "Today Submission",
                            onTap: () {
                              Get.to(TodaySubmission());
                              // Get.toNamed(AppPages.todaySubmission);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DashboardButton(
                            imagePath: "assets/images/submission.png",
                            value:controller.monthlySubmission.length.toString(),
                            title: "Monthly Submission",
                            onTap: () {
                              Get.toNamed(AppPages.monthlySubmission);
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: DashboardButton(
                            imagePath:"assets/images/request.png",
                            value:controller.offlineRequest.length.toString(),
                            title: "Offline Request",
                            onTap: () {
                              Get.toNamed(AppPages.offLineSubmission);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DashboardButton(
                            imagePath: "assets/images/visit.png",
                            value: controller.lastVisited.length.toString(),
                            title: "Last Visit",
                            onTap: () {
                              Get.to(LastVisit());

                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: DashboardButton(
                            imagePath: "assets/images/visit.png",
                            value:controller.offlineRequest.length.toString(),
                            title: "Offline Dealer",
                            onTap: () {

                              Get.to(OffLineDealer());

                            },
                          ),
                        ),
                      ],
                    ),
                  ])));

        }));
  }
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

}



class DashboardButton extends StatelessWidget {
  final Function() onTap;
  final String? title;
  final String? value;
  final String? imagePath;
  const DashboardButton({Key? key, this.title, required this.onTap, this.imagePath,this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Card(
      elevation: 0,
      shadowColor: FColors.primaryDarkColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(

          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child:
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.height * 0.05,
                    child: Image.asset(imagePath!, fit: BoxFit.contain),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: FTextStyle.boldTextStyleTheme,
                  ),
                ],

            ),
          )),
    ),);


  }
}

