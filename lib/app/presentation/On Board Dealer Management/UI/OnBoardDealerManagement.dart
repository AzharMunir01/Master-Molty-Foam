import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../data/model/getSyncData.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../utils/alertDialog.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/dropDown/dropdown.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/spinKits/spinKits.dart';
import '../controller/controller.dart';
import 'dart:io';


class OnBoardDealerManagementView extends StatelessWidget {
  final OnBoardDealerManagementController controller = Get.put(OnBoardDealerManagementController());

  @override
  Widget build(BuildContext context,) {

    return CustomBackground(
        alertText: "",
        isLoading: controller.isLoading,
        callback: () {},
      child: Obx((){
        return  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text("New On Board Dealer ", style: FTextStyle.headerBlackTextStyle),
                    const SizedBox(height: 20),
                    const Text("Name ", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Name",
                      textInputFormatter: '[a-zA-Z ]',
                      textEditingController: controller.name,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidName.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        print(val);
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Dealer Type",
                      style: FTextStyle.simpleTextStyleBlack,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //
                    // /// select Dealer type
                    DropDownWidget(
                      // key: currencyFromKey,
                        enable: true,
                        // enable: typeValue == "1" ? false : true,
                        title: "",
                        selectedItem: "Select Dealer Type",
                        list: controller.dealerType == [] ? [] : controller.dealerType,
                        valChanged: (Object? v) {
                          final value = v as DealerType;
                          print(value.id.toString());
                          controller.dealerTypeId.value = value.id.toString();
                          controller.formValidation();
                          // ref.read(kpiFormController).getDealerType(value);
                        },
                        showSearchBOX: true),
                    Text(controller.errorMessage.value == ValidationStatus.dealerTypeId.message ? controller.errorMessage.value : "",
                        style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Category",
                      style: FTextStyle.simpleTextStyleBlack,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropDownWidget(
                      // key: currencyFromKey,
                        enable: true,
                        // enable: typeValue == "1" ? false : true,
                        title: "",
                        selectedItem: "Select Categories",
                        list: controller.categories == [] ? [] : controller.categories,
                        valChanged: (Object? v) {
                          final val = v as Categories;
                          // ref.read(outdoorShopFasciaController).dealerTypeId = kpiFormValue.dealerTypeId;
                          // ref.read(outdoorShopFasciaController).dealerId = kpiFormValue.dealer[kpiFormValue.selectedDealerIndex!].id!;

                          print(val.id.toString());
                          controller.categoriesId.value = val.id.toString();
                          controller.formValidation();
                          // ref.read(kpiFormController).getDealerType(value);
                        },
                        showSearchBOX: true),
                    Text(controller.errorMessage.value == ValidationStatus.categoriesId.message ? controller.errorMessage.value : "",
                        style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(
                      height: 20,
                    ),
                    //
                    const Text("CNIC No", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      textEditingController: controller.cnic,
                      inputType: TextInputType.number,
                      hint: "XXXXX-XXXXXXX-X",
                      errorText: controller.errorMessage.value == ValidationStatus.invalidCnic.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Dealer Image", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        _settingModalBottomSheet(context, () {
                          Get.back();
                          controller.imageSelector(context, "gallery");
                        }, () {
                          controller.imageSelector(context, "camera");
                          Get.back();
                        });
                      },
                      child: controller.imageFile.value.isNull
                          ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.withOpacity(0.6),
                        child: const ClipOval(
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      )
                          : CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: ClipOval(
                          child: Image.file(
                            File(controller.imageFile.value!.path),
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Mobile/Phone No", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      // length: 10,
                      hint: "Enter Mobile/Phone No",
                      textEditingController: controller.mobileNumber,
                      inputType: TextInputType.number,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidMobileNumber.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Email", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Email",
                      textEditingController: controller.email,
                      inputType: TextInputType.emailAddress,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidEmail.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("City", style: FTextStyle.simpleTextStyleBlack),

                    const SizedBox(height: 16),

                    /// select city
                    DropDownWidget(
                        enable: true,
                        title: "",
                        selectedItem: "Select Dealer Type",
                        list: controller.cities == [] ? [] : controller.cities,
                        valChanged: (Object? v) {
                          final value = v as Cities;
                          print(value.id);
                          controller.city.text = value.id.toString();
                          controller.formValidation();

                        },
                        showSearchBOX: true),
                    Text(controller.errorMessage.value == ValidationStatus.invalidCity.message ? controller.errorMessage.value : "",
                        style: FTextStyle.simpleTextStyleBlack),

                    const Text("Address", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Address",
                      textEditingController: controller.address,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidAddress.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Area/Location of Interest", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Area/Location of Interest",
                      textEditingController: controller.area,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidArea.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Education", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Education",
                      textEditingController: controller.education,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidEducation.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Profession", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Profession",
                      textEditingController: controller.profession,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidProfession.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Any Previous Experience?", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Any Previous Experience?",
                      textEditingController: controller.previousExperience,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidPreviousExperience.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text("Investment Amount", style: FTextStyle.simpleTextStyleBlack),
                    const SizedBox(height: 16),
                    InputWidget(
                      hint: "Enter Investment Amount",
                      textEditingController: controller.investmentAmount,
                      inputType: TextInputType.number,
                      errorText: controller.errorMessage.value == ValidationStatus.invalidInvestmentAmount.message ? controller.errorMessage.value : null,
                      valChanged: (val) {
                        controller.formValidation();
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Button(
                        buttonTxt: "Submit",
                        buttonColor: controller.isValid.value ? FColors.primaryColor : FColors.primaryColor.withOpacity(0.5),
                        callback: controller.isValid.value
                            ? () {
                          controller.formValidation();
                          if (controller.isValid.value) {
                            controller.saveOnBoarDealer(context);
                          } else {
                          }
                        }
                            : () {},
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            );
      })
    );
  }

  void _settingModalBottomSheet(context, Function() callGallery, Function() callCamera) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              InkWell(
                onTap: callGallery,
                child: const ListTile(
                  title: Row(children: [
                    Icon(
                      Icons.upload_file,
                      color: FColors.primaryDarkColor,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'Gallery',
                          style: FTextStyle.boldTextStyleTheme,
                        ))
                  ]),
                ),
              ),
              InkWell(
                onTap: callCamera,
                child: ListTile(
                    title: Row(children: const [
                  Icon(Icons.camera_alt_outlined, color: FColors.primaryDarkColor),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: Text('Camera', style: FTextStyle.boldTextStyleTheme))
                ])),
              ),
            ],
          );
        });
  }
}
