import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../routes/app_page.dart';
import '../../theme/color.dart';
import '../../theme/textStyle.dart';
import '../../utils/appConst.dart';
import '../../widgets/Animations/animated_widget.dart';
import '../audioFile.dart';
import '../callRecoard/callRecoardUi.dart';
import '../dashboard/controller/dashboardController.dart';
class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {

   DashboardController? controller;
  @override
  void initState(){
    super.initState();
    controller = Get.put(DashboardController());

  }
  @override
  Widget build(BuildContext context) {
controller!. getcurrentPage();
controller!.submitFormInfo();
    return Scaffold(
      backgroundColor: const Color(0xffEEECEE),
      body: SafeArea(
        child:  SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Menu", style: FTextStyle.headerRedTextStyle),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, AppPages.dashboardView);
                    },
                    child: Image.asset("assets/images/close.png"),
                  )
                ],
              ),
              const SizedBox(height: 30),
           Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                padding: EdgeInsets.all(20),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [  buildUserInfo(),

                    buildMenuTabs(context),],)),
            ],
          ),
        )),
      ),
    );

  }
  void dispose(){
    super.dispose();
    controller!.dispose();
  }
  Widget buildUserInfo() {
    return Obx(() {
      final user = controller!.user;
      if (user.isEmpty) return const SizedBox(height: 80,);
      return Padding(padding:const EdgeInsets.symmetric(horizontal: 20) ,child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${user.isNotEmpty ? (user[0].firstName ?? '') : ''} ${user.isNotEmpty ? (user[0].lastName ?? '') : ''}",
            style: FTextStyle.boldTextStyleBlue,
          ),
          const SizedBox(height: 5),
          Text(user.isNotEmpty ? (user[0].roleName ?? '') : ''),
          const SizedBox(height: 20),

        ],
      ),);
    });
  }
   static const platform = MethodChannel('molty.com.molty/channel');
   Future<void> _openDialerAndRecord(String phoneNumber) async {
     try {

       final result = await platform.invokeMethod('openDialerAndRecord', phoneNumber);

       print(result+"fsdfsf");
     } on PlatformException catch (e) {
       print("Failed to start call and recording: '${e.message}'.");
     }
   }

   Future<List<FileSystemEntity>> getFiles() async {
     final directory = Directory('/storage/emulated/0/Download/molty');
     if (await directory.exists()) {
       return directory.listSync().where((item) => item.path.endsWith('.mp3')).toList();
     }
     return [];
   }

  Widget buildMenuTabs(BuildContext context) {
    return Obx(()=>Column(
      children: [
        menuTab(
          val: 0,
          img: 'assets/images/dashboard.png',
          text: 'Dashboard',
          callback: () => Get.offAllNamed(AppPages.dashboardView),
        ),
        menuTab(
          val: 0,
          img: 'assets/images/refresh.png',
          text: 'Refresh',
          callback: () {
            fetchFormPercentage();
            controller!.getSyncData(0);
            // Get.dialog(const RotatedImageWidget(), barrierDismissible: true);
          }
        ),
        // menuTab(
        //   val: 0,
        //   img: 'assets/images/nmyNms.png',
        //   text: 'Call Record',
        //   callback: () {
        //     _openDialerAndRecord("03025737543");
        //     // showCustomDialog(context,(){
        //     //   Get.back();
        //     // });
        //     // controller!.getSyncData(controller!.user[0].userId!);
        //     // Get.dialog(const RotatedImageWidget(), barrierDismissible: true);
        //   }
        // ),

        // menuTab(
        //   val: 0,
        //   img: 'assets/images/nmyNms.png',
        //   text: 'Open Call Record',
        //   callback: (){Get.to(FileListScreen());},
        // ),



        menuTab(
          val: 0,
          img: 'assets/images/eraser.png',
          text: 'Clear Form Request',
          callback: () {
            controller!.clearFormRequest();
            toast(text: "Cleare Form Request");
            },
        ),
        menuTab(
          img: 'assets/images/KPI Question Form.png',
          text: 'KPI Question Form',
            color: controller!.formIndex.value >0?Colors.green:Colors.white,
          callback:controller!.currentPage.value==AppConst.kpiForm ||controller!.currentPage.value==""?() => Get.offAllNamed(AppPages.kPIQuestionsFormView):(){
            // toast();
          },
        ),
        menuTab(
          color:controller!.formIndex.value >1?Colors.green:Colors.white,
          img: 'assets/images/Outdoor Shop Fascia.png',
          text: 'Outdoor Shop Fascia',
          callback:controller!.currentPage.value==AppConst.oSForm? () => Get.offAllNamed(AppPages.outdoorShopFasciaView):(){
            toast();
          },
        ),
        menuTab(
          color:controller!.formIndex.value >2?Colors.green:Colors.white,
          img: 'assets/images/Category Wise Model Form Assign.png',
          text: 'Category Wise Model Form Assign',
          callback:controller!.currentPage.value==AppConst.cWMForm? () =>
              Get.offAllNamed(AppPages.categoryWiseModelFormAssignView):(){
            toast();
          },
        ),
        menuTab(
          img: 'assets/images/Dealer Feedback Question Form.png',
          val: 0,
          text: 'Dealer Feedback Question Form',
          callback:
          // controller!.currentPage.value==AppConst.dFBForm ?
              () =>
              Get.offAllNamed(AppPages.dealerFeedbackQuestionFormView)
          //       :(){
          //   // toast();
          // },
        ),
        menuTab(
          val: 0,
          img: 'assets/images/On Board Dealer Management.png',
          text: 'New On Board Dealer ',
          callback: () =>Get.offAllNamed(AppPages.onBoardDealerManagementView),
        ),


        menuTab(
          val: 0,
          img: 'assets/images/logout.png',
          text: 'Logout',
          callback: () {
            // _showDialog();
            (controller!.offLineSubmissionForm.isEmpty&&controller!.offLineDealer.isEmpty)?
            controller!.logOut(context): _showDialog();


          }
        ),
      ],
    ));
  }

  Widget menuTab(
      {required String img,
      required String text,
       Color? color,
       int? val,
      required Function() callback}) {

    return TextButton(
      onPressed: callback,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Row(
          children: [
            Image.asset(img,height: 30,),
            const SizedBox(width: 30),
            Text(
              text,
              style: FTextStyle.simpleTextStyleBlack,
            ),
            Spacer(),
            (controller!.formIndex.value ==0 ||val==0) ?SizedBox():
            Icon(Icons.check_box_sharp,color:color,),


          ],
        ),
      ),
    );
  }

    FToast fToast= FToast();
  toast({String? text}){
    fToast.init(context);
    fToast.showToast(

      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: FColors.primaryColor),
        child:  Text(text??"Please Fill Previous Form",style:TextStyle(color: Colors.white),),),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
   void _showDialog() {
     showDialog(

       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           backgroundColor: Colors.white,
           title: Text('Error',style:FTextStyle.boldTextStyleBlack ,),
           content: Text('Please Sync Data',style:FTextStyle.boldTextStyleBlack ,),
           actions: <Widget>[
             // TextButton(
             //   child: Text('Cancel'),
             //   onPressed: () {
             //     Navigator.of(context).pop(); // Close the dialog
             //   },
             // ),
             TextButton(
               child: Text('OK'),
               onPressed: () {
                 // Perform some action if needed
                 Navigator.of(context).pop(); // Close the dialog
               },
             ),
           ],
         );
       },
     );
   }
   void fetchFormPercentage() {
     AlertDialog alert = AlertDialog(
       backgroundColor: Colors.white,
       title: const Text(
         "Please wait....",
         style: TextStyle(fontSize: 18, color: FColors.primaryColor, fontWeight: FontWeight.bold),
       ),
       content:
       Obx(() =>
           SizedBox(
             width: MediaQuery.of(context).size.width,
             child: Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 20,bottom: 20),
                 child: LinearPercentIndicator(
                   width: MediaQuery.of(context).size.width - 140,
                   // animation: true,
                   lineHeight: 20.0,
                   // animationDuration: 2000,
                   percent:controller!.percentage.value,
                   center: Text("${(controller!.percentage.value * 100).toStringAsFixed(1)}%",style: TextStyle(color: Colors.white),),
                   linearStrokeCap: LinearStrokeCap.roundAll,
                   // progressColor: Colors.greenAccent, // This will be overridden by the gradient
                   linearGradient: LinearGradient(
                     colors: [Colors.blue,Colors.blue.withOpacity(0.5), Colors.greenAccent,],
                     begin: Alignment.centerLeft,
                     end: Alignment.centerRight,
                   ),
                 ),
               )

             ],
           ),
           ),
     ),
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


