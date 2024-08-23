import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/noData.dart';
import '../controller/dashboardController.dart';

class LastVisit extends StatelessWidget {
  LastVisit({Key? key}) : super(key: key);
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return CustomBackground(
        back: true,
        alertText: "",
        isLoading: 0.obs,
        callback: () {},
        child: noData("No Available Last Visit ")
      // ListView.builder(
      //     shrinkWrap: true,
      //     itemCount: controller.dealer.length,
      //     itemBuilder: (_, i) {
      //       return _buildItem(
      //         i,
      //       );
      //     })

    );
  }
}