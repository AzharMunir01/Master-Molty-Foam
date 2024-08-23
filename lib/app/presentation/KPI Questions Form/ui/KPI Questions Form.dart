import 'dart:developer';
import 'dart:ffi';

import 'package:animated_reorderable_list/animated_reorderable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:molty_foam/app/utils/appConst.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../data/model/getSyncData.dart';
import '../../../theme/color.dart';
import '../../../theme/textStyle.dart';
import '../../../utils/utiles.dart';
import '../../../widgets/button/Button.dart';
import '../../../widgets/customBg/customBackground.dart';
import '../../../widgets/dropDown/dropdown.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/uploadFileInput.dart';
import '../controller/kpiFormController.dart';
import 'dart:io';

class KPIQuestionsFormView extends StatefulWidget {
  const KPIQuestionsFormView({Key? key}) : super(key: key);

  @override
  State<KPIQuestionsFormView> createState() => _KPIQuestionsFormViewState();
}

class _KPIQuestionsFormViewState extends State<KPIQuestionsFormView> {
  final KpiFormController controller = Get.put(KpiFormController());
  List<GlobalKey> _widgetKeys = [];
  // ScrollController scrollController = ScrollController();
  @override
  build(BuildContext context) {
    // controller.isLoading.value = 0;
    // _widgetKeys = [];
    //
    // controller.isLoading.value = 0;
    return CustomBackground(
        alertText: "",
        isLoading: controller.isLoading,
        callback: () {},
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: _body()

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     ///
              //
              //     /// kPIFormQuestions
              //     ListView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: controller.kpiQuestionModel.length,
              //         itemBuilder: (_, index) {
              //           return questionWidget(index, controller);
              //         }),
              //
              //     const SizedBox(
              //       height: 100,
              //     ),
              //   ],
              // ),
              ),
        ));
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          _buildDropDown(),
          _dealerInfo(),
          _buildList(),
          const SizedBox(
            height: 20,
          ),
          _submitBtn(),
          const SizedBox(
            height: 200,
          ),
        ],
      ),
    );
  }

  _buildDropDown() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "KPI Questions Form",
              style: FTextStyle.headerBlackTextStyle,
            ),
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
                selectedItem: controller.selectedDealerIndex.value == -1 ? "Select Dealer Type" : "",
                list: controller.dealerType == [] ? [] : controller.dealerType,
                valChanged: (Object? v) async {
                  // final value = v as DealerType;
                  // print(value.id.toString());
                  call(v);
                  _widgetKeys = [];
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
            singleDropDown(
              disabledIds:controller.todayDealerIds,
              selectedId: controller.dealerId.value == -1 ? 0 : controller.selectedId.value,
              // controller.selectedItem.value, // Ensure this is a valid ID or null
              title: 'Select Dealer',
              list: controller.dealer.isEmpty ? [] : controller.dealer,
              valChanged: (Dealers? v) {
                final value = v as Dealers;

                controller.dealerId.value = -1;
                controller.selectedDealerIndex.value = -1;
                // controller.todayDealerIds.addAll([4, 6, 7]);
                // controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
                // controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
                bool isAnyDealerIdMatch = controller.todayDealerIds
                    .any((element) => element == controller.dealer[controller.dealer.indexWhere((element) => element.id == value.id)].id);
                // controller.checkKpiQuestionModel()
                // controller.formSubmitFormInfo.any((e) =>e.dateTime.currentDay  );
                isAnyDealerIdMatch
                    ? Utils.showSnackBar("Alert", "You Have Already Call this Dealer")
                    : controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
                controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
                controller.selectedId.value=controller.dealer[controller.selectedDealerIndex.value].id!;
                controller.checkKpiQuestionModel();

                // if (value == null) return;
                // controller.selectedDealerIndex.value=-1;
                // controller.selectedId.value==-1;
                // final selectedDealerId = value.id;
                // bool isAnyDealerIdMatch = controller.todayDealerIds
                //     .any((element) => element == selectedDealerId);
                //
                // if (isAnyDealerIdMatch) {
                //   Utils.showSnackBar("Alert", "You Have Already Called this Dealer");
                // } else {
                //   controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == selectedDealerId);
                //   controller.dealerId.value = selectedDealerId!;
                //   controller.selectedId.value = controller.dealerId.value;
                //   controller.checkKpiQuestionModel();
                // }
              },
            )

            // singleDropDown(
            //     disabledIds:[4,6,7],
            //     selectedItem:controller.selectedItem.value,
            //     // controller.selectedDealerIndex.value == -1
            //     //     ? "Select Dealer "
            //     //     : controller.dealer[controller.selectedDealerIndex.value].dealershipName ,
            //     title: 'Select Dealer',
            //     list: controller.dealer.isEmpty ? [] : controller.dealer,
            //     valChanged: (Object? v) {
            //       final value = v as Dealers;
            //       controller.todayDealerIds;
            //       // controller.selectedDealerIndex.value = -1;
            //       // controller.todayDealerIds.add(4);
            //       // controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
            //       // controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
            //       bool isAnyDealerIdMatch = controller.todayDealerIds
            //           .any((element) => element == controller.dealer[controller.dealer.indexWhere((element) => element.id == value.id)].id);
            //       // controller.checkKpiQuestionModel()
            //       // controller.formSubmitFormInfo.any((e) =>e.dateTime.currentDay  );
            //       isAnyDealerIdMatch
            //           ? Utils.showSnackBar("Alert", "You Have Already Call this Dealer")
            //           : controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
            //       controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
            //       controller.selectedItem.value=controller.dealer[controller.selectedDealerIndex.value].dealershipName!;
            //       controller.checkKpiQuestionModel();
            //     })

            // DropDownWidget(
            //           enable: true,
            //           title: "",
            //           selectedItem:controller.selectedDealerIndex.value==-1? "Select Dealer ":controller.dealer[controller.selectedDealerIndex.value].dealershipName,
            //           list: controller.dealer.isEmpty ? [] : controller.dealer,
            //           valChanged: (Object? v) {
            //
            //             final value = v as Dealers;
            //
            //             controller.selectedDealerIndex.value=-1;
            //
            //             // controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
            //             // controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
            //             bool isAnyDealerIdMatch = controller.todayDealerIds.any(
            //                     (element) => element == controller.dealer[controller.dealer.indexWhere((element) => element.id == value.id)].id
            //             );
            //             // controller.checkKpiQuestionModel()
            //             // controller.formSubmitFormInfo.any((e) =>e.dateTime.currentDay  );
            //             isAnyDealerIdMatch?
            //             Utils.showSnackBar("Alert", "You Have Already Call this Dealer"):
            //             controller.selectedDealerIndex.value = controller.dealer.indexWhere((element) => element.id == value.id);
            //             controller.dealerId.value = controller.dealer[controller.selectedDealerIndex.value].id!;
            //
            //             controller.checkKpiQuestionModel();
            //           },
            //           showSearchBOX: true),
          ],
        ));
  }

  Future<void> call(Object? v) async {
    await Future.delayed(const Duration(seconds: 1));
    final value = v as DealerType;
    print(value.id.toString());
    controller.getQuestion(value.id!);
  }

  _required(String val) {
    return Row(
      children: [
        Text(
          val,
          style: FTextStyle.simpleTextStyleBlack,
        ),
        Text(
          val == "Remarks" ? "" : AppConst.required,
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

  _dealerImage() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _required(
              "Dealer Picture",
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                _settingModalBottomSheet(context, () {
                  Get.back();
                  controller.imageSelector(context, "gallery");
                }, () {
                  Get.back();
                  controller.imageSelector(context, "camera");
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
                          // fit: BoxFit.fitHeight,
                          width: 100, // Adjust width and height as needed
                          height: 100,
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }

  _textType({String? title, String? val, bool? isEnable = false, int? maxLine}) {
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
        maxLine: maxLine ?? 1,
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
    return Obx(() {
      int i = controller.selectedDealerIndex.value;
      return i != -1
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textType(
                  title: "Owner Name",
                  val: controller.dealer[i].ownerName!,
                ),
                _textType(title: "Dealership Name", val: controller.dealer[i].dealershipName!),
                _dealerImage(),
                _textType(title: "Brand ", val: controller.dealer[i].brand!),
                _textType(title: "Contact No ", val: controller.dealer[i].dealerContactno!),
                _textType(title: "Area", val: controller.dealer[i].area!),
                _textType(title: "Address", val: controller.dealer[i].address),
                _textType(title: "Cnc", val: controller.dealer[i].cnic),
                _textType(title: "Profession", val: controller.dealer[i].profession),
                _textType(title: "Email", val: controller.dealer[i].email),
                _textType(title: "Education", val: controller.dealer[i].education),
              ],
            )
          : const SizedBox();
    });
  }

  GlobalKey? key;
  _submitBtn() {
    return Obx(() => controller.liItemCont.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
                width: double.infinity,
                child: Button(
                  buttonTxt: "Submit",
                  buttonColor: controller.isValidState.value ? FColors.primaryColor : FColors.primaryColor.withOpacity(0.6),
                  callback: controller.isValidState.value
                      ? () {
                          controller.kpiSaveData(context);
                        }
                      : () async {
                          // _scrollToIndex(30);
                          await controller.checkKpiQuestionModel();

                          ///
                          scrollable();

                          // scrollController.animateTo(offset, duration: duration, curve: curve)
                          controller.checkValidationState.value = true;
                        },
                )))
        : const SizedBox());
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> scrollable() async {
    key = _widgetKeys[controller.currentValidateIndex.value];
    final cont = key?.currentContext!;
    await Scrollable.ensureVisible(cont!);
  }

  _buildList() {
    return Obx(() => Stack(
          children: [
            controller.liItemCont.isNotEmpty
                ? controller.liItemCont.length == controller.kPIFormQuestions.length
                    ? SizedBox()
                    : progressCircul()
                : SizedBox(),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.liItemCont.length,
                itemBuilder: (_, i) {
                  _widgetKeys.add(GlobalKey());
                  return Container(key: _widgetKeys[i], child: _buildType(i));
                  // typeWidget(index: index, outdoorShopFasciaModel: value.outdoorShopFasciaModel, value: value);
                })
          ],
        ));
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

  _invisibleField(int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          "${i + 1}. Question",
          style: FTextStyle.headerRedTextStyle,
        ),
        const SizedBox(
          height: 16,
        ),
        InputWidget(
          isenable: false,
          // maxLine: 2,
          textEditingController: TextEditingController(text: controller.kPIFormQuestions[i].question),
          hint: "Brouchers",
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Guideline",
          style: FTextStyle.simpleTextStyleBlack,
        ),
        const SizedBox(
          height: 16,
        ),
        InputWidget(
          // maxLine: 2,
          isenable: false,
          textEditingController: TextEditingController(text: controller.kPIFormQuestions[i].guideline),
          hint: "Guideline",
        ),
      ],
    );
  }

  _visibleField(int i) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.kpiQuestionModel[i].contactNo == ""
                ? Column(
                    children: [
                      _required("Contact No"),

                      const SizedBox(
                        height: 16,
                      ),
                      InputWidget(
                        // length: 11,
                        errorText: controller.kpiQuestionSave[i].contactNo == "" ? AppConst.contact : null,
                        hint: "0000-0000000",
                        inputType: TextInputType.number,
                        valChanged: (val) {
                          if (controller.isValidMobileNumber(val.toString())) {
                            controller.kpiQuestionSave[i].contactNo = val.toString();
                          } else {
                            controller.kpiQuestionSave[i].contactNo = "";
                          }

                          controller.checkKpiQuestionModel();
                        },
                      ),
                      // _error(controller.kpiQuestionSave[i].contactNo,AppConst.contact),
                    ],
                  )
                : const SizedBox(),
            controller.kpiQuestionModel[i].remarks == "" ? _required("Remarks") : const SizedBox(),
            const SizedBox(
              height: 16,
            ),
            controller.kpiQuestionModel[i].remarks == ""
                ? InputWidget(
                    hint: "Remarks",
                    valChanged: (val) {
                      controller.kpiQuestionSave![i].remarks = val.toString();
                      controller.checkKpiQuestionModel();
                    },
                  )
                : const SizedBox(),
            // _error(controller.kpiQuestionSave![i].remarks,AppConst.remarks),
          ],
        ));
  }

  _buildEvaluation(int i) {
    return Obx(() => controller.kpiQuestionModel[i].evaluation == ""
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                _required(
                  "Evaluation",
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                        controller.kpiQuestionSave[i].evaluation = rating.ceil().toString();

                        print(controller.kpiQuestionSave[i].evaluation);
                        print(controller.kpiQuestionModel[i].evaluation);

                        controller.checkKpiQuestionModel();
                        print(rating);
                      },
                    ),
                    _error(controller.kpiQuestionSave[i].evaluation, AppConst.rating)
                  ],
                )
              ],
            ),
          )
        : const SizedBox());
  }

  Widget _buildValue(int i) {
    return Obx(() {
      final kpiQuestionSave = controller.kpiQuestionSave[i];
      final kpiQuestionModel = controller.kpiQuestionModel[i];
      return kpiQuestionModel.value == ""
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                _required("Select "),
                Row(
                  children: [
                    Checkbox(
                      value: kpiQuestionSave.value == "1" ? true : false,
                      onChanged: (bool? val) {
                        controller.kpiQuestionSave[i].value = val! ? "1" : "";
                        controller.checkKpiQuestionModel();
                      },
                    ),
                    const Text(
                      "Yes",
                      style: FTextStyle.simpleTextStyleBlack,
                    ),
                    Checkbox(
                      value: kpiQuestionSave.value == "0" ? true : false,
                      onChanged: (bool? val) {
                        controller.kpiQuestionSave[i].value = val! ? "0" : "";
                        controller.checkKpiQuestionModel();
                      },
                    ),
                    const Text(
                      "No",
                      style: FTextStyle.simpleTextStyleBlack,
                    ),
                    Spacer(),
                  ],
                ),
                _error(controller.kpiQuestionSave[i].value, AppConst.checkBox)
              ],
            )
          : SizedBox();
    });
  }

  Widget _buildFeedback(int i) {
    return Obx(() {
      final kpiQuestionModel = controller.kpiQuestionModel[i];
      return kpiQuestionModel.feedback == ""
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Row(
                  children: [
                    const SizedBox(height: 16),
                    kpiQuestionModel.feedback == "" ? _required("Feedback") : const SizedBox(),
                    Spacer(),
                    kpiQuestionModel.feedback == ""
                        ? Row(
                            children: [
                              _buildFeedbackCheckbox(controller.kpiQuestionSave[i].feedback == "1" ? true : false, "Good", (val) {
                                controller.kpiQuestionSave[i].feedback = val == null || val == true ? "1" : "";
                                controller.checkKpiQuestionModel();
                              }),
                              _buildFeedbackCheckbox(controller.kpiQuestionSave[i].feedback == "2" ? true : false, "Fair", (val) {
                                controller.kpiQuestionSave[i].feedback = val == null || val == true ? "2" : "";
                                controller.checkKpiQuestionModel();
                              }),
                              _buildFeedbackCheckbox(controller.kpiQuestionSave[i].feedback == "3" ? true : false, "Bad", (val) {
                                controller.kpiQuestionSave[i].feedback = val == null || val == true ? "3" : "";

                                controller.checkKpiQuestionModel();
                              }),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
                _error(controller.kpiQuestionSave[i].feedback, AppConst.feedback)
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
      final questionModel = controller.kpiQuestionModel[i];
      final questionSave = controller.kpiQuestionSave[i];

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
          _error(controller.kpiQuestionSave[i].uploadImage, AppConst.image),
          if (questionModel.uploadVideo == "")
            _buildFileUpload("Video", ['mp4', 'avi', 'mov'], questionSave.uploadVideo, () {
              controller.openFilePicker(
                value: "Video",
                index: i,
                allow: ['mp4', 'avi', 'mov'],
              );
            }),
          _error(controller.kpiQuestionSave[i].uploadVideo, AppConst.video),
          if (questionModel.uploadAudio == "")
            _buildFileUpload("Audio", ["mp3"], questionSave.uploadAudio, () {
              controller.openFilePicker(
                value: "Audio",
                index: i,
                allow: ["mp3"],
              );
            }),
          _error(controller.kpiQuestionSave[i].uploadAudio, AppConst.audio)
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
        // Text(
        //   "Upload $fileType",
        //   style: FTextStyle.simpleTextStyleBlack,
        // ),
        const SizedBox(height: 16),
        UploadFile(
          value: "$value",
          callBack: callBack,
        ),
      ],
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
                child: const ListTile(
                    title: Row(children: [
                  Icon(Icons.camera_alt_outlined, color: FColors.primaryDarkColor),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: Text('Camera', style: FTextStyle.boldTextStyleTheme))
                ])),
              ),
            ],
          );
        });
  }
}
