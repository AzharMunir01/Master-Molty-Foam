import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../data/model/feddbackModle/feedbackModel.dart';
import '../../../data/model/getSyncData.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../utils/appConst.dart';
import '../../../utils/imageShow.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/dropDown/dropdown.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/uploadFileInput.dart';
import '../controller/dealerFeedbackQuestionForm.dart';

class DealerFeedbackQuestionFormView extends StatefulWidget {
  const DealerFeedbackQuestionFormView({Key? key}) : super(key: key);

  @override
  State<DealerFeedbackQuestionFormView> createState() => _DealerFeedbackQuestionFormViewState();
}

class _DealerFeedbackQuestionFormViewState extends State<DealerFeedbackQuestionFormView> {
  final DealerFeedbackQuestionFormController controller = Get.put(DealerFeedbackQuestionFormController());

  @override
  build(BuildContext context) {
    return CustomBackground(
        alertText: "",
        isLoading: controller.isLoading,
        callback: () {},
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: _body()),
        ));
  }

  ///
  _body() {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 8) ,child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _formHeading(),
        _buildDropDown(),
        // _dealerInfo(),
        const SizedBox(
          height: 20,
        ),
        _buildList(),
        const SizedBox(height: 20,),
        _submitBtn(),
        const SizedBox(height: 200,),
      ],
    ),);
  }
  _buildDropDown() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(
          height: 16,
        ),
        const Text(
          "Dealer Type",
          style: FTextStyle.simpleTextStyleBlack,
        ),
        const SizedBox(
          height: 16,
        ),
        DropDownWidget(
            enable: true,
            title: "",
            selectedItem: "Select Dealer Type",
            list: controller.dealerType == [] ? [] : controller.dealerType,
            valChanged: (Object? v) async {
              final value = v as DealerType;
              controller.dealer.clear();
              controller.getDealer(value.id!);
              // print(value.id.toString());
              // call(v);
              // controller.getQuestion(value.id!);
            },
            showSearchBOX: true),
        const SizedBox(
          height: 16,
        ),
        const Text(
          "Dealer Name",
          style: FTextStyle.simpleTextStyleBlack,
        ),
        const SizedBox(
          height: 16,
        ),
        // controller.dealerId.value==-1?


        singleDropDown(
          disabledIds:controller.todayDealerIds,
          selectedId: controller.dealerId.value == -1 ? 0 : controller.selectedId.value,
          // controller.selectedItem.value, // Ensure this is a valid ID or null
          title: 'Select Dealer',
          list: controller.dealer.isEmpty ? [] : controller.dealer,
          valChanged: (Dealers? v) {
            final value = v as Dealers;
            controller.dealerId.value=value.id!;
            controller.selectedId.value=value.id!;
          },
        )




        // DropDownWidget(
        //     enable: true,
        //     title: "",
        //     selectedItem:  controller.dealerId.value==-1 ?"Select":"Select Dealer ",
        //     list: controller.dealerId.value==-1 &&controller.dealer.isEmpty ? [] : controller.dealer,
        //     valChanged: (Object? v) {
        //       final value = v as Dealers;
        //       controller.dealerId.value=value.id!;
        //       // controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
        //       // controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
        //       // controller.checkKpiQuestionModel();
        //     },
        //     showSearchBOX: false)


      // :DropDownWidget(
            // enable: true,
            // title: "",
            // selectedItem: controller.dealer.isEmpty ?"Select":"Select Dealer ",
            // list: controller.dealer.isEmpty ? [] : controller.dealer,
            // valChanged: (Object? v) {
            //   final value = v as Dealers;
            //   // controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
            //   // controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
            //   // controller.checkKpiQuestionModel();
            // },
            // showSearchBOX: true),
      ],
    ));
  }
  _required(String val) {
    return Row(
      children: [
        Text(
          val,
          style: FTextStyle.simpleTextStyleBlack,
        ),
        Text(
          val=="Remarks"?"":AppConst.required,
          style: FTextStyle.headerRedTextStyle,
        ),
      ],
    );
  }

  _error(String? validationValue, String val) {
    Rx<String>? val1 = "".obs;
    val1.value = validationValue!;
    return Obx(() {
      return val1.value == "" && controller.checkValidationState.value
          ? Text(
              "   $val",
              style: FTextStyle.textErrorStyle,
            )
          : const SizedBox();
    });
  }

  _submitBtn() {
    return Obx(
      () => Padding(padding:EdgeInsets.symmetric(vertical : 8) ,child: SizedBox(
          width: double.infinity,
          child: Button(
            buttonTxt: "Submit",
            buttonColor: controller.isValidState.value ? FColors.primaryColor : FColors.primaryColor.withOpacity(0.5),
            callback: controller.isValidState.value
                ? () {
              controller.fdFormSaveData(context);
            }
                : () {
              controller.checkValidationState.value = true;
            },
          )),),
    );
  }

  _buildList() {
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.feedbackModelsSave.length,
          itemBuilder: (_, i) {
            return _buildType(
              i,
            );
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


          children: [
            _textType(
                title: "Dealer Type",
                val: controller.dealerType[controller.dealerType.indexWhere((item) => item.id == controller.dealerTypeID.value)].dealerType),
            _textType(
                title: "Dealership Name",
                val: controller.dealer[controller.dealer.indexWhere((item) => item.id == controller.dealerId.value)].dealershipName),
          ],
        ));
  }

  _formHeading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(textAlign: TextAlign.start,
        "Dealer Feedback Question Form",
        style: FTextStyle.headerBlackTextStyle,
      ),
    );
  }

  _buildType(int i) {
    return Column(
      children: [
        _invisibleField(i),
        _buildValue(i),
        _buildFeedback(i),
        _buildEvaluation(i),
        _visibleField(i),

        _buildFiles(i),
      ],
    );
  }

  _buildEvaluation(int i) {
    return controller.feedbackModels[i].evaluation == ""
        ? Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  _required("Evaluation"),
                  Spacer(),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      controller.feedbackModelsSave[i].evaluation = rating.ceil().toString();

                      print(controller.feedbackModelsSave[i].evaluation);
                      print(controller.feedbackModelsSave[i].evaluation);

                      controller.checkFeedbackModel();
                      print(rating);
                    },
                  )
                ],
              ),
            ),
            _error(controller.feedbackModelsSave[i].evaluation, AppConst.rating)
          ])
        : const SizedBox();
  }

  _invisibleField(int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text(
          "${i + 1}. Question",
          style: FTextStyle.headerRedTextStyle,
        ),
        _textType(title: "", val: controller.dealerFeedbackFormQuestions[i].question),
        _textType(title: "Guideline", val: controller.dealerFeedbackFormQuestions[i].guideline),
      ],
    );
  }

  ///
  _visibleField(int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        controller.feedbackModels[i].contactNo == ""
            ? Column(
                children: [
                  _required("Contact No"),
                  InputWidget(
                    // length: 11,
                    errorText:controller.feedbackModelsSave[i].contactNo==""?AppConst.contact:null,
                    hint: "0000-0000000",

                    inputType: TextInputType.number,
                    valChanged: (val) {
                      if( controller.isValidMobileNumber(val.toString())){

                        controller.feedbackModelsSave[i].contactNo = val.toString();
                      }else{

                        controller.feedbackModelsSave[i].contactNo="";
                      }
                      // controller.feedbackModelsSave[i].contactNo = val.toString();
                      controller.checkFeedbackModel();
                    },
                  ),
                  // _error(controller.feedbackModelsSave[i].contactNo, AppConst.contact)
                ],
              )
            : const SizedBox(),
        controller.feedbackModels[i].remarks == "" ? _required("Remarks") : const SizedBox(),
        const SizedBox(
          height: 16,
        ),
        controller.feedbackModels[i].remarks == ""
            ? InputWidget(
                hint: "Remarks",
                valChanged: (val) {
                  controller.feedbackModelsSave[i].remarks = val.toString();
                  controller.checkFeedbackModel();
                },
              )
            : const SizedBox(),
        // _error(controller.feedbackModelsSave[i].remarks, AppConst.remarks)
      ],
    );
  }

  Widget _buildValue(int i) {
    return Obx(() {
      final kpiQuestionSave = controller.feedbackModelsSave[i];
      final kpiQuestionModel = controller.feedbackModels[i];
      return kpiQuestionModel.value == ""
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 16,
              ),
              _required("Select "),
              Row(
                children: [
                  Checkbox(
                    value: kpiQuestionSave.value == "1" ? true : false,
                    onChanged: (bool? val) {
                      controller.feedbackModelsSave[i].value = val! ? "1" : "";
                      controller.checkFeedbackModel();
                    },
                  ),
                  const Text(
                    "Yes",
                    style: FTextStyle.simpleTextStyleBlack,
                  ),
                  Checkbox(
                    value: kpiQuestionSave.value == "0" ? true : false,
                    onChanged: (bool? val) {
                      controller.feedbackModelsSave[i].value = val! ? "0" : "";
                      controller.checkFeedbackModel();
                    },
                  ),
                  const Text(
                    "No",
                    style: FTextStyle.simpleTextStyleBlack,
                  ),
                  Spacer(),
                ],
              ),
              _error(controller.feedbackModelsSave[i].value, AppConst.checkBox)
            ])
          : SizedBox();
    });
  }

  Widget _buildFeedback(int i) {
    return Obx(() {
      final kpiQuestionModel = controller.feedbackModels[i];
      return kpiQuestionModel.feedback == ""
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      const SizedBox(height: 16),
                      kpiQuestionModel.feedback == "" ? _required("Feedback") : const SizedBox(),
                      Spacer(),
                      kpiQuestionModel.feedback == ""
                          ? Row(
                              children: [
                                _buildFeedbackCheckbox(controller.feedbackModelsSave[i].feedback == "1" ? true : false, "Good", (val) {
                                  controller.feedbackModelsSave[i].feedback = val == null || val == true ? "1" : "";
                                  controller.checkFeedbackModel();
                                }),
                                _buildFeedbackCheckbox(controller.feedbackModelsSave[i].feedback == "2" ? true : false, "Fair", (val) {
                                  controller.feedbackModelsSave[i].feedback = val == null || val == true ? "2" : "";
                                  controller.checkFeedbackModel();
                                }),
                                _buildFeedbackCheckbox(controller.feedbackModelsSave[i].feedback == "3" ? true : false, "Bad", (val) {
                                  controller.feedbackModelsSave[i].feedback = val == null || val == true ? "3" : "";

                                  controller.checkFeedbackModel();
                                }),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                _error(controller.feedbackModelsSave[i].feedback, AppConst.feedback)
              ],
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
      final questionModel = controller.feedbackModels[i];
      final questionSave = controller.feedbackModelsSave[i];

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
          _error(controller.feedbackModelsSave[i].uploadImage, AppConst.image),
          if (questionModel.uploadVideo == "")
            _buildFileUpload("Video", ['mp4', 'avi', 'mov'], questionSave.uploadVideo, () {
              controller.openFilePicker(
                value: "Video",
                index: i,
                allow: ['mp4', 'avi', 'mov'],
              );
            }),
          _error(controller.feedbackModelsSave[i].uploadVideo, AppConst.video),
          if (questionModel.uploadAudio == "")
            _buildFileUpload("Audio", ["mp3"], questionSave.uploadAudio, () {
              controller.openFilePicker(
                value: "Audio",
                index: i,
                allow: ["mp3"],
              );
            }),
          _error(controller.feedbackModelsSave[i].uploadAudio, AppConst.audio),
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

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
