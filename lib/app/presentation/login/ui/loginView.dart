import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/spinKits/spinKits.dart';
import '../controller/controller.dart'; // Import your Button widget
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController controller = Get.put(LoginController());
  @override
  void initState(){
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height:MediaQuery.of(context).size.height*0.9999,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bgImage.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          child:ListView(children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            Align(
                alignment: Alignment.topCenter,
                child:


                  Image.asset("assets/images/master-logo.png", scale: 1.3),


            ),
            SizedBox(height:MediaQuery.of(context).size.height * 0.09,),
            Card(
              elevation: 10,
              color: const Color(0xffF4F4F4),
              shadowColor: FColors.primaryColor,
              // shadowColor: FColors.primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text("LOGIN", style: FTextStyle.boldTextStyleBlue),
                    const SizedBox(height: 30),
                    InputWidget(
                      textEditingController: controller.userName,
                      valChanged: (value) {
                        controller.userName.text = value.toString();
                        controller.validation();
                      },
                      hint: "User Name",
                      suffixIcon: Icons.mail_outline,
                    ),
                    const SizedBox(height: 30),
                    Obx(() =>  InputWidget(
                      maxLine: 1,
                        textEditingController: controller.userPassword,
                        valChanged: (value) {
                          controller.userPassword.text = value.toString();
                          controller.validation();
                        },
                        hint: "Password",
                        suffixIcon: controller.isEnable.value ?  Icons.visibility_outlined:Icons.visibility_off ,
                        obscureText: controller.isEnable.value ? false : true,
                        suffixIconOnPressed: () {
                          controller.isVisible();
                        })),
                    const SizedBox(height: 30),
                    const Text("Forgot Password ?", style: TextStyle(color: FColors.accentColor, fontSize: 16)),
                    const SizedBox(height: 20),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const SizedBox();
                      } else {
                        return SizedBox(
                          width: double.infinity,
                          child: Button(
                            buttonTxt: "Sign In",
                            buttonColor: controller.isValidate.value ? FColors.primaryColor : FColors.disableColor,
                            callback:controller.isValidate.value? () {
                              controller.getLoginLocal();
                            }:(){},
                          ),
                        );
                      }
                    }),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],)




        //   Column(
        //   children: [
        //     SizedBox(height: MediaQuery.of(context).size.height * 0.10),
        //
        //     SizedBox(height: MediaQuery.of(context).size.height * 0.07),
        //
        //   ],
        // ),],),


    ));
  }
  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }
}
