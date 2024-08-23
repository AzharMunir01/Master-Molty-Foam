import 'package:flutter/cupertino.dart';

import '../presentation/Category Wise Model Form Assign/ui/categoryWiseModelFormAssign.dart';
import '../presentation/DealerFeedback Question Form/ui/dealerFeedbackQuestionForm.dart';
import '../presentation/KPI Questions Form/ui/KPI Questions Form.dart';
import '../presentation/On Board Dealer Management/UI/OnBoardDealerManagement.dart';
import '../presentation/Outdoor Shop Fascia/ui/outdoorShopFascia.dart';
import '../presentation/callRecoard/callRecoardUi.dart';
import '../presentation/dashboard/ui/dashboardUi.dart';
import '../presentation/dashboard/ui/dealerView.dart';
import '../presentation/dashboard/ui/monthlySubmission.dart';
import '../presentation/dashboard/ui/oofLineSubmission.dart';
import '../presentation/dashboard/ui/todaySubmission.dart';
import '../presentation/login/ui/loginView.dart';
import '../presentation/menue/menueView.dart';
import '../presentation/splash/splash_screen.dart';
import 'app_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Routes {
  static List<GetPage> getPages = [
    GetPage(
      name: AppPages.splashScreen,
      page: () => const SplashScreen(),
    ),
    // GetPage(
    //   name: AppPages.calRecord,
    //   page: () =>  CalRecord(),
    // ),
    GetPage(
      name: AppPages.loginView,
      page: () => LoginView(),
    ),
    GetPage(
      name: AppPages.dashboardView,
      page: () => DashboardView(),
    ),
    GetPage(
      name: AppPages.offLineSubmission,
      page: () => OffLineSubmission(),
    ),
    GetPage(
      name: AppPages.dealerView,
      page: () => DealerView(),
    ),
    GetPage(
      name: AppPages.todaySubmission,
      page: () => TodaySubmission(),
    ),

    GetPage(
      name: AppPages.monthlySubmission,
      page: () => MonthlySubmission(),
    ),
    GetPage(
      name: AppPages.menueView,
      page: () => MenuView(),
    ),
    GetPage(
      name: AppPages.kPIQuestionsFormView,
      page: () => KPIQuestionsFormView(),
    ),
    GetPage(
      name: AppPages.onBoardDealerManagementView,
      page: () => OnBoardDealerManagementView(),
    ),
    GetPage(
      name: AppPages.dealerFeedbackQuestionFormView,
      page: () => DealerFeedbackQuestionFormView(),
    ),
    GetPage(
      name: AppPages.categoryWiseModelFormAssignView,
      page: () => CategoryWiseModelFormAssignView(),
    ),
    GetPage(
      name: AppPages.outdoorShopFasciaView,
      page: () => OutdoorShopFasciaView(),
    ),
  ];
}

