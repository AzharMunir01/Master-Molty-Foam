import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../routes/app_page.dart';
import '../../theme/color.dart';
import '../../utils/utiles.dart';
import '../Animations/animated_widget.dart';
import '../spinKits/spinKits.dart';

class CustomBackground extends StatefulWidget {
  final Widget child;
  final Rx<int> isLoading;
  final String alertText;
  final bool? back;
  final Function() callback;
  CustomBackground({
    required this.child,
    required this.alertText,
    required this.isLoading,
    this.back,
    required this.callback,
  });

  @override
  State<CustomBackground> createState() => _CustomBackgroundState();
}

class _CustomBackgroundState extends State<CustomBackground> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: const Color(0xffEEECEE),
          resizeToAvoidBottomInset: false,
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(),
              Expanded(child: Obx(() {
                widget.isLoading.value == 2 ? FocusScope.of(context).unfocus() : "";

                return Stack(
                  children: [
                    widget.isLoading.value == 1
                        ? progressCircul()
                        : AbsorbPointer(
                            absorbing: widget.isLoading.value == 2 || widget.isLoading.value == 1
                                ? true
                                : false, // Change this to true to see the difference
                            child: widget.child),
                    widget.isLoading.value == 2
                        ? progressCircul()
                        : const SizedBox(),
                  ],
                );
              }))
            ],
            // children: [customAppBar(),Expanded(child: widget.child)],
          ),
        ),
        onWillPop: () {
          if (widget.back == null) {
            return Future.value(false);
          } else {

            return Future.value(widget.back);
          }
        });
  }

  customAppBar() {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
          color: FColors.primaryColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Image.asset(
            "assets/images/master-logo.png",
            scale: 5,
          ),
          const Spacer(),
          // Image.asset("assets/images/logouts.png"),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.offNamed(AppPages.menueView);
            },
            child: Card(
              elevation: 0,
              color: FColors.primaryColor,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Image.asset("assets/images/menu .png"),
              ),
            ),
          ),
          const SizedBox(
            width: 0,
          ),
        ],
      ),
    );
  }
}


progressCircul(){

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Card(
         shadowColor: Colors.black.withOpacity(0.7),
        shape: CircleBorder(),
        elevation: 20,
        child:  RotatedImageWidget(),
      )
    ],
  );
}