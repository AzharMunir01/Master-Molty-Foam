import 'dart:developer';

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../data/model/OutdoorShopFasciaModel/OutdoorShopFasciaModel.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../utils/appConst.dart';
import '../../../utils/imageShow.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/spinKits/spinKits.dart';
import '../../../widgets/uploadFileInput.dart';
import '../controller/controller.dart';

class OutdoorShopFasciaView extends StatefulWidget {
  const OutdoorShopFasciaView({Key? key}) : super(key: key);

  @override
  State<OutdoorShopFasciaView> createState() => _OutdoorShopFasciaViewState();
}

class _OutdoorShopFasciaViewState extends State<OutdoorShopFasciaView> {
  final OutdoorShopFasciaController controller = Get.put(OutdoorShopFasciaController());
  final List<GlobalKey> _widgetKeys = [];
  @override
  build(
    BuildContext context,
  ) {
    return CustomBackground(
        alertText: "",
        isLoading: controller.isLoading,
        callback: () {},
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _body(),
          ),
        ));
  }

  _body() {
    return Padding(padding:
      EdgeInsets.symmetric(horizontal: 8)
      ,child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _formHeading(),
        _dealerInfo(),
        const SizedBox(
          height: 20,
        ),
        _buildList(),
        _submitBtn(),
        const SizedBox(
          height: 200,
        ),
      ],
    ),);
  }
  _required(String val) {
    return Row(
      children: [
        Text(
          val,
          style: FTextStyle.simpleTextStyleBlack,
        ),
        Text(
          val=="Remarks"?"": AppConst.required,
          style: FTextStyle.headerRedTextStyle,
        ),
      ],
    );
  }

  _error(String? validationValue, String val) {
    Rx<String>? val1="".obs;
    val1.value=validationValue!;
    return Obx(() {
      return val1.value == "" &&controller.checkValidationState.value
          ?Text(
        "   $val",
        style: FTextStyle.textErrorStyle,
      )
          : const SizedBox();
    });
  }
  _submitBtn() {
    return Obx(() => Padding(padding:EdgeInsets.symmetric(vertical: 50) ,child: SizedBox(
        width: double.infinity,
        child: Button(
          buttonTxt: "Submit",
          buttonColor: controller.isValidState.value ? FColors.primaryColor : FColors.primaryColor.withOpacity(0.4),
          callback: controller.isValidState.value
              ? () {
            controller.oSFormSaveData(
              context: context,
            );
          }
              : () async {
            await     controller.checkOSFormQuestionModel();
            ///
            scrollable();
            controller.checkValidationState.value=true;

          },
        )),));
  }
  GlobalKey? key;
  Future<void> scrollable() async {
    key = _widgetKeys[controller.currentValidateIndex.value];
    final cont = key?.currentContext!;
    await Scrollable.ensureVisible(cont!);

  }
  _formHeading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        textAlign: TextAlign.start,
        "Outdoor Shop Fascia",
        style: FTextStyle.headerBlackTextStyle,
      ),
    );
  }

  ///
  _buildList() {
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.outdoorShopFasciaModel.length,
          itemBuilder: (_, i)  {
            _widgetKeys.add(GlobalKey());
            return Container(key: _widgetKeys[i], child: _buildType(i));
            // typeWidget(index: index, outdoorShopFasciaModel: value.outdoorShopFasciaModel, value: value);
          }),
    );
  }

  _buildType(int i) {
    return Column(
      children: [
        _invisibleField(i),
        _buildValue(i),
        _buildFeedback(i),
        _buildEvaluation(i),
        _buildImageView(i),
        _visibleField(i),
        _buildFiles(i),
      ],
    );
  }

  _invisibleField(int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16,),
        Text(
          textAlign: TextAlign.start,
          "${i + 1}. Board Description",
          style: FTextStyle.headerRedTextStyle,
        ),
        SizedBox(height: 16,),
        InputWidget(
          textEditingController: TextEditingController(text:controller.outdoorShopFasciaModel[i].boarDescription ?? ""),
          hint: " ",
          isenable: false,
        ),

      ],
    );
  }

  _buildImageView(int i) {





      List<String?> li= controller.outdoorShopFasciaModel[i].imagePath!.where((e) => e.boardid == int.parse(controller.outdoorShopFasciaModel[i]
          .boardDescriptionId!)).map((e) => e.path).toList();

      // li.forEach((element) {
      //   element ??=controller.outdoorShopFasciaModel[i].imagePath![1].path!;
      // });
  // controller.outdoorShopFasciaModel[i].imagePath!.isNotEmpty ?int.parse(controller.outdoorShopFasciaModel[i].boardDescriptionId!)
  //     ==controller.outdoorShopFasciaModel[i].imagePath.where((e) => e.boardid==int.parse(controller.outdoorShopFasciaModel[i].boardDescriptionId!)))
  // if(controller.outdoorShopFasciaModel[i].imagePath! !=[]) {
  //   for (int val = 0; i > controller.outdoorShopFasciaModel[i].imagePath!.length; i++) {
  //     li.add(controller.outdoorShopFasciaModel[i].imagePath![val].path!);
  //   }
  //
  // }

    return Align(
      alignment: Alignment.center,
      child: Button(
        buttonTxt: "View",
        buttonColor: FColors.btnbg,
        callback: () {
          /// image view
          showImageView(context,li,i:i,paths:controller.outdoorShopFasciaModel[i].imagePath![0].path );
        },
      ),
    );
  }

  _visibleField(int i) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.outdoorShopFasciaModel[i].contactNo == ""
            ? Column(
          children: [
            _required("Contact No"),

            const SizedBox(
              height: 16,
            ),
            InputWidget(
              length: 11,
              errorText:controller.outdoorShopFasciaSave[i].contactNo==""?AppConst.contact:null,
              hint: "0000-0000000",
              inputType: TextInputType.number,
              valChanged: (val) {
                if( controller.isValidMobileNumber(val.toString())){

                  controller.outdoorShopFasciaSave[i].contactNo = val.toString();
                }else{

                  controller.outdoorShopFasciaSave[i].contactNo="";
                }
                // controller.outdoorShopFasciaSave[i].contactNo = val.toString();
                controller.checkOSFormQuestionModel();
              },
            ),

          ],
        )
            : const SizedBox(),
        // _error(controller.outdoorShopFasciaSave[i].contactNo,AppConst.contact),

        controller.outdoorShopFasciaModel[i].remarks == ""
            ? _required("Remarks")
            : const SizedBox(),
        const SizedBox(
          height: 16,
        ),
        controller.outdoorShopFasciaModel[i].remarks == ""
            ? InputWidget(
          hint: "Remarks",
          valChanged: (val) {
            controller.outdoorShopFasciaSave[i].remarks = val.toString();
            controller.checkOSFormQuestionModel();
          },
        )
            : const SizedBox(),
        // _error(controller.outdoorShopFasciaSave[i].remarks,AppConst.remarks)

      ],
    ));
  }

  _buildEvaluation(int i) {
    return Obx(() => controller.outdoorShopFasciaModel[i].evaluation == ""
        ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child:Column (
          crossAxisAlignment: CrossAxisAlignment.end,
          children:[

            Row(
              children: [
                _required("Evaluation"),
                Spacer(),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  // allowHalfRating: false, // Ensure only full stars
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // int intRating = rating.round();
                    controller.outdoorShopFasciaSave[i].evaluation = rating.ceil().toString();

                    print(controller.outdoorShopFasciaSave[i].evaluation);
                    print(controller.outdoorShopFasciaSave[i].evaluation);

                    controller.checkOSFormQuestionModel();
                    print(rating);
                  },
                )
              ],
            ),


            _error(controller.outdoorShopFasciaSave[i].evaluation,AppConst.rating),
          ]),
    )
        : const SizedBox());
  }

  Widget _buildValue(int i) {
    return Obx(() {
      final kpiQuestionSave = controller.outdoorShopFasciaSave[i];
      final kpiQuestionModel = controller.outdoorShopFasciaModel[i];
      return kpiQuestionModel.value == ""
          ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
             SizedBox(height: 16,),
        _required("Select "),
            Row(
              children: [
                Checkbox(
                  value: kpiQuestionSave.value == "1" ? true : false,
                  onChanged: (bool? val) {
                    controller.outdoorShopFasciaSave[i].value = val! ? "1" : "";
                    controller.checkOSFormQuestionModel();
                  },
                ),
                const Text(
                  "Yes",
                  style: FTextStyle.simpleTextStyleBlack,
                ),
                Checkbox(
                  value: kpiQuestionSave.value == "0" ? true : false,
                  onChanged: (bool? val) {
                    controller.outdoorShopFasciaSave[i].value = val! ? "0" : "";
                    controller.checkOSFormQuestionModel();
                  },
                ),
                const Text(
                  "No",
                  style: FTextStyle.simpleTextStyleBlack,
                ),
                Spacer(),
              ],
            ),
        _error(controller.outdoorShopFasciaSave[i].value, AppConst.checkBox)
      ])
          : SizedBox();
    });
  }

  Widget _buildFeedback(int i) {
    return Obx(() {
      final kpiQuestionModel = controller.outdoorShopFasciaModel[i];
      return kpiQuestionModel.feedback == ""
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(children:[Row(
                children: [
                  const SizedBox(height: 16),
                  kpiQuestionModel.feedback == ""
                      ? _required("Feedback")
                      : const SizedBox(),
                  Spacer(),
                  kpiQuestionModel.feedback == ""
                      ? Row(
                          children: [
                            _buildFeedbackCheckbox(controller.outdoorShopFasciaSave[i].feedback == "1" ? true : false, "Good", (val) {
                              controller.outdoorShopFasciaSave[i].feedback = val == null || val == true ? "1" : "";
                              controller.checkOSFormQuestionModel();
                            }),
                            _buildFeedbackCheckbox(controller.outdoorShopFasciaSave[i].feedback == "2" ? true : false, "Fair", (val) {
                              controller.outdoorShopFasciaSave[i].feedback = val == null || val == true ? "2" : "";
                              controller.checkOSFormQuestionModel();
                            }),
                            _buildFeedbackCheckbox(controller.outdoorShopFasciaSave[i].feedback == "3" ? true : false, "Bad", (val) {
                              controller.outdoorShopFasciaSave[i].feedback = val == null || val == true ? "3" : "";

                              controller.checkOSFormQuestionModel();
                            }),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),

                _error(controller.outdoorShopFasciaSave[i].feedback, AppConst.feedback)
              ]),
            )
          : const SizedBox();
    });
  }

  Widget _buildFeedbackCheckbox(bool value, String label, ValueChanged<Object?> valChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: valChanged,
        ),
        Text(
          label,
          style: FTextStyle.simpleTextStyleBlack,
        ),
      ],
    );
  }

  _buildFiles(
    int i,
  ) {
    return Obx(() {
      final questionModel = controller.outdoorShopFasciaModel[i];
      final questionSave = controller.outdoorShopFasciaSave[i];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (questionModel.uploadImage == "")
            _buildFileUpload("Image", ["png", "jpeg", "jpg"], questionSave.uploadImage, () {
              controller.openFilePicker(
                value: "Image",
                index: i,
                allow: ["png", "jpeg", "jpg"],
              );
            }),
          _error(controller.outdoorShopFasciaSave[i].uploadImage, AppConst.image),
          if (questionModel.uploadVideo == "")
            _buildFileUpload("Video", ['mp4', 'avi', 'mov'], questionSave.uploadVideo, () {
              controller.openFilePicker(
                value: "Video",
                index: i,
                allow: ['mp4', 'avi', 'mov'],
              );
            }),
          _error(controller.outdoorShopFasciaSave[i].uploadVideo, AppConst.video),
          if (questionModel.uploadAudio == "")
            _buildFileUpload("Audio", ["mp3"], questionSave.uploadAudio, () {
              controller.openFilePicker(
                value: "Audio",
                index: i,
                allow: ["mp3"],
              );
            }),
          _error(controller.outdoorShopFasciaSave[i].uploadAudio, AppConst.audio),
        ],
      );
    });
  }

  _buildFileUpload(String fileType, List<String> allowedFormats, String? value, VoidCallback callBack) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _required("Upload $fileType"),

        const SizedBox(height: 16),
        UploadFile(
          value: "$value",
          callBack: callBack,
        ),
     
      ],
    );
  }

  ///
  _textType({String? title, String? val, bool? isEnable = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        title!,
        style: FTextStyle.simpleTextStyleBlack,
      ),
      const SizedBox(
        height: 16,
      ),
      InputWidget(
        textEditingController: TextEditingController(text: val ?? ""),
        hint: " ",
        isenable: isEnable ?? false,
      ),
      const SizedBox(
        height: 20,
      ),
    ]);
  }

  _dealerInfo() {

    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _textType(
              title: "Dealer Type",
              val: controller.dealerType.isNotEmpty
                  ? (controller.dealerType[controller.dealerType.indexWhere(
                      (item) => item.id == controller.dealerTypeId.value)]?.dealerType ?? "")
                  : "",
            ),

            _textType(
              title: "Dealership Name",
              val: controller.dealer.isNotEmpty
                  ? (controller.dealer[controller.dealer.indexWhere(
                      (item) => item.id == controller.dealerId.value)]?.dealershipName ?? "")
                  : "",
            ),

            _textType(
              title: "Category ",
              val:

              controller.categories.isNotEmpty
                  ? (controller.categories[controller.categories.indexWhere(
                      (item) => item.id == controller.dealer[controller.dealer.indexWhere(
                              (item) => item.id == controller.dealerId.value)]?.categoryType)]?.categoryType ?? "")
                  : "",

              // controller.categories.isNotEmpty
              //     ? (controller.categories[controller.categories.indexWhere(
              //         (item) => item.id == controller.dealerId.value)]?.categoryType ?? "")
              //     : "",
            )

            // _textType(
            //     title: "Category ",
            //     val:
            //     controller
            //         .categories[controller.categories.indexWhere(
            //             (item) => item.id == controller.dealerId.value)]
            //         .categoryType),
            // _textType(title: "Category ", val: (controller.categories[controller.categories.indexWhere((v) =>v.id==controller.categoryTypesID.value)]
            //     .categoryType )
            //     .toString()),
          ],
        ));
  }
}
