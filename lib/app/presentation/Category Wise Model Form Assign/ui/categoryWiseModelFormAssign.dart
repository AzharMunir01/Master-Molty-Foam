import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../utils/appConst.dart';
import '../../../utils/imageShow.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/uploadFileInput.dart';
import '../controller/controller.dart';

class CategoryWiseModelFormAssignView extends StatefulWidget {
  const CategoryWiseModelFormAssignView({Key? key}) : super(key: key);

  @override
  State<CategoryWiseModelFormAssignView> createState() =>
      _CategoryWiseModelFormAssignViewState();
}

class _CategoryWiseModelFormAssignViewState
    extends State<CategoryWiseModelFormAssignView> {
  final CategoryWiseModelFormAssignController controller =
      Get.put(CategoryWiseModelFormAssignController());
  final List<GlobalKey> _widgetKeys = [];
  @override
  build(
    BuildContext context,
  ) {
    // controller.isLoading.value = 0;
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
    return Column (
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
    );
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
  GlobalKey? key;
  _submitBtn() {
    return Obx(() =>Padding(padding:EdgeInsets.symmetric(vertical: 20) ,child: SizedBox(
        width: double.infinity,
        child: Button(
          buttonTxt: "Submit",
          buttonColor: controller.isValidState.value
              ? FColors.primaryColor
              : FColors.primaryColor.withOpacity(0.5),
          callback: controller.isValidState.value
              ? () {
            controller.cWMSaveData(
              context: context,
            );
          }
              : () async {
            await     controller.checkCWFormQuestionModel();
            ///
            scrollable();
            controller.checkValidationState.value=true;

          },
        )),));
  }
  Future<void> scrollable() async {
    key = _widgetKeys[controller.currentValidateIndex.value];
    final cont = key?.currentContext!;
    await Scrollable.ensureVisible(cont!);

  }
  _buildList() {
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.categoriesWMFAModel.length,
          itemBuilder: (_, i) {
            _widgetKeys.add(GlobalKey());
            return Container(key: _widgetKeys[i], child: _buildType(i));
            // typeWidget(index: index, outdoorShopFasciaModel: value.outdoorShopFasciaModel, value: value);
          }),
    );
  }

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
                val: controller
                    .dealerTypes[controller.dealerTypes.indexWhere(
                        (item) => item.id == controller.dealerTypeId.value)]
                    .dealerType),
            _textType(
              title: "Dealership Name",
              val: controller.dealers.isNotEmpty
                  ? (controller.dealers[controller.dealers.indexWhere(
                      (item) => item.id == controller.dealerId.value)]?.dealershipName ?? "")
                  : "",
            ),
            // _textType(
            //     title: "Dealership Name",
            //     val: controller
            //         .dealers[controller.dealers.indexWhere(
            //             (item) => item.id == controller.categoriesType.value)]
            //         .dealershipName),
        _textType(
          title: "Category ",
          val:

          controller.categories.isNotEmpty
              ? (controller.categories[controller.categories.indexWhere(
                  (item) => item.id == controller.dealers[controller.dealers.indexWhere(
                      (item) => item.id == controller.dealerId.value)]?.categoryType)]?.categoryType ?? "")
              : "",)
            // _textType(
            //     title: "Category ",
            //     val:
            //     controller
            //         .categories[controller.categories.indexWhere(
            //             (item) => item.id == controller.dealerId.value)]
            //         .categoryType),
        // controller
        //             .categories[controller.categories.indexWhere(
        //                 (item) => item.id == controller.dealerTypeId.value)]
        //             .categoryType),
          ],
        ));
  }

  _formHeading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        "Category Wise Model Form Assign",
        style: FTextStyle.headerBlackTextStyle,
      ),
    );
  }

  _buildType(int i) {
    return Column(
      children: [
        _invisibleField(i),
        _buildImageView(i),
        _buildEvaluation(i),
        _buildFeedback(i),
        _visibleField(i),
        _buildValue(i),
        _buildFiles(i),
      ],
    );
  }

  _buildEvaluation(int i) {
    return Obx(() => controller.categoriesWMFAModel[i].evaluation == ""
        ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
        Row(
          children: [
            _required("Evaluation"),
            Spacer(),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,/**/
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                controller.categoriesWMFASave[i].evaluation =rating.ceil().toString();

                print(controller.categoriesWMFASave[i].evaluation);
                print(controller.categoriesWMFASave[i].evaluation);

                controller.checkCWFormQuestionModel();
                print(rating);
              },
            )
          ],
        ),
        _error(controller.categoriesWMFASave[i].evaluation, AppConst.rating)
      ],),
    )
        : const SizedBox());
  }

  _invisibleField(int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${i + 1}. Type",
          style: FTextStyle.headerRedTextStyle,
        ),
        _textType(
            title: "Company Standard",
            val: controller.categoryWiseModelFormModels[i].companyStandard!),
        _textType(
            title: "Standard",
            val: controller.categoryWiseModelFormModels[i].standard!),

      ],
    );
  }

  _buildImageView(int i) {
    return Align(
      alignment: Alignment.center,
      child: Button(
        buttonTxt: "View",
        buttonColor: FColors.btnbg,
        callback: () {

          /// image view
          showImageView(context, controller.categoriesWMFAModel[i].imagesPath!,i:200);
        },
      ),
    );
  }

  ///
  _visibleField(int i) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.categoriesWMFAModel[i].contactNo == ""
            ? Column(
          children: [
            _required("Contact No"),
            const SizedBox(
              height: 16,
            ),
            InputWidget(
              // length: 11,
              errorText:controller.categoriesWMFASave[i].contactNo==""?AppConst.contact:null,
              hint: "0000-0000000",
              inputType: TextInputType.number,
              valChanged: (val) {
                if( controller.isValidMobileNumber(val.toString())){

                  controller.categoriesWMFASave[i].contactNo = val.toString();
                }else{

                  controller.categoriesWMFASave[i].contactNo="";
                }
                // controller.categoriesWMFASave[i].contactNo =
                    val.toString();
                controller.checkCWFormQuestionModel();
              },
            ),
            // _error(controller.categoriesWMFASave[i].contactNo, AppConst.contact)
          ],
        )
            : const SizedBox(),
        controller.categoriesWMFAModel[i].remarks == ""
            ? _required("Remarks")
            : const SizedBox(),
        const SizedBox(
          height: 16,
        ),
        controller.categoriesWMFAModel[i].remarks == ""
            ? InputWidget(
          hint: "Remarks",
          valChanged: (val) {
            controller.categoriesWMFASave[i].remarks = val.toString();
            controller.checkCWFormQuestionModel();
          },
        )
            : const SizedBox(),
        // _error(controller.categoriesWMFASave[i].remarks, AppConst.remarks)
      ],
    ));
  }

  Widget _buildValue(int i) {
    return Obx(() {
      final kpiQuestionSave = controller.categoriesWMFASave[i];
      final kpiQuestionModel = controller.categoriesWMFAModel[i];
      return kpiQuestionModel.value == ""
          ? Column(children: [
            Row(
        children: [
          _required("Select "),
          Checkbox(
            value: kpiQuestionSave.value == "1" ? true : false,
            onChanged: (bool? val) {
              controller.categoriesWMFASave[i].value = val! ? "1" : "";
              controller.checkCWFormQuestionModel();
            },
          ),
          const Text(
            "Yes",
            style: FTextStyle.simpleTextStyleBlack,
          ),
          Checkbox(
            value: kpiQuestionSave.value == "0" ? true : false,
            onChanged: (bool? val) {
              controller.categoriesWMFASave[i].value = val! ? "0" : "";
              controller.checkCWFormQuestionModel();
            },
          ),
          const Text(
            "No",
            style: FTextStyle.simpleTextStyleBlack,
          ),
          Spacer(),
        ],
      ),
        _error(controller.categoriesWMFASave[i].value, AppConst.checkBox)
      ],)
          : SizedBox();
    });
  }

  Widget _buildFeedback(int i) {
    return Obx(() {
      final kpiQuestionModel = controller.categoriesWMFAModel[i];
      return kpiQuestionModel.feedback == ""
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical:0),
          child: Row(
            children: [
              const SizedBox(height: 16),
              kpiQuestionModel.feedback == ""
                  ?_required("Feedback")
                  : const SizedBox(),
              const Spacer(),
              kpiQuestionModel.feedback == ""
                  ? Row(
                children: [
                  _buildFeedbackCheckbox(
                      controller.categoriesWMFASave[i].feedback == "1"
                          ? true
                          : false,
                      "Good", (val) {
                    controller.categoriesWMFASave[i].feedback =
                    val == null || val == true ? "1" : "";
                    controller.checkCWFormQuestionModel();
                  }),
                  _buildFeedbackCheckbox(
                      controller.categoriesWMFASave[i].feedback == "2"
                          ? true
                          : false,
                      "Fair", (val) {
                    controller.categoriesWMFASave[i].feedback =
                    val == null || val == true ? "2" : "";
                    controller.checkCWFormQuestionModel();
                  }),
                  _buildFeedbackCheckbox(
                      controller.categoriesWMFASave[i].feedback == "3"
                          ? true
                          : false,
                      "Bad", (val) {
                    controller.categoriesWMFASave[i].feedback =
                    val == null || val == true ? "3" : "";

                    controller.checkCWFormQuestionModel();
                  }),
                ],
              )
                  : const SizedBox(),
            ],
          ),
        ),
          _error(controller.categoriesWMFASave[i].feedback, AppConst.feedback)
      ],)
          : const SizedBox();
    });
  }

  Widget _buildFeedbackCheckbox(
      bool value, String label, ValueChanged<Object?> valChanged) {
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
      final questionModel = controller.categoriesWMFAModel[i];
      final questionSave = controller.categoriesWMFASave[i];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (questionModel.uploadImage == "")
            _buildFileUpload(
                "Image", ["png", "jpeg", "jpg"], questionSave.uploadImage, () {
              controller.openFilePicker(
                value: "Image",
                index: i,
                allow: ["png", "jpeg", "jpg"],
              );
            }),
          _error(controller.categoriesWMFASave[i].uploadImage, AppConst.image),
          if (questionModel.uploadVideo == "")
            _buildFileUpload(
                "Video", ['mp4', 'avi', 'mov'], questionSave.uploadVideo, () {
              controller.openFilePicker(
                value: "Video",
                index: i,
                allow: ['mp4', 'avi', 'mov'],
              );
            }),
          _error(controller.categoriesWMFASave[i].uploadVideo, AppConst.video),
          if (questionModel.uploadAudio == "")
            _buildFileUpload("Audio", ["mp3"], questionSave.uploadAudio, () {
              controller.openFilePicker(
                value: "Audio",
                index: i,
                allow: ["mp3"],
              );
            }),
          _error(controller.categoriesWMFASave[i].uploadAudio, AppConst.audio),
        ],
      );
    });
  }

  _buildFileUpload(String fileType, List<String> allowedFormats, String? value,
      VoidCallback callBack) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _required("Upload $fileType"),
        const SizedBox(height: 16),
        UploadFile(
          value: "${value}",
          callBack: callBack,
        ),

      ],
    );
  }
}
