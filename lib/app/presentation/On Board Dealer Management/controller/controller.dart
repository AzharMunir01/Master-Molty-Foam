import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:molty_foam/app/utils/utiles.dart';
import '../../../data/local/database/database.dart';
import '../../../data/model/getSyncData.dart';
import '../../../data/model/onBoardDealerModel.dart';
import '../../../data/model/userModel.dart';
import '../../../routes/app_page.dart';
import '../../../utils/alertDialog.dart';
import '../../../utils/prefrence/inputValidation.dart';

class OnBoardDealerManagementController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  MaskedTextController cnic = MaskedTextController(mask: '00000-0000000-0');
  TextEditingController address = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController education = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController previousExperience = TextEditingController();
  TextEditingController investmentAmount = TextEditingController();
  final imageFile = Rxn<PickedFile>();
  final cities = <Cities>[].obs;
  final user = <UserModel>[].obs;
  final isValid = false.obs;
  final isLoading = 1.obs;
  final errorMessage = "".obs;
  final dealerType = <DealerType>[].obs;
  final categories = <Categories>[].obs;
  final dealerTypeId = "".obs;
  final categoriesId = "".obs;
   void onInit(){
     super.onInit();

     getCities();


   }
  /// get dealer type list
  getCities() async {
    // await clearField();

    final results = await DatabaseHelper.getCity();
    final getUser = await DatabaseHelper.getUsers();

    for (var result in results) {
      cities.add(Cities.fromJson(result));
    }

    for (var result in getUser) {
      user.add(UserModel.fromJson(result));
    }
    final val = await DatabaseHelper.getDealerType();

    // Initialize the list here
    dealerType.clear();
    for (var result in val) {
      dealerType.add(DealerType.fromJson(result));
    }
    categories.clear();
    final data = await DatabaseHelper.getCategories();

    for (var result in data) {
      categories.add(Categories.fromJson(result));
    }

    isLoading.value = 0;

  }

  saveOnBoarDealer(BuildContext context) async {
    isLoading.value = 2;
    await Future.delayed(const Duration(seconds: 1));
    Utils.showAlertDialog(
        context: context,
        callback: () async {
          Get.back();
          isLoading.value = 2;
    final data = OnBoardDealerManagement(
        name: name.text,
        mobileNumber: mobileNumber.text,
        email: email.text,
        city: city.text,
        cnic: cnic.text,
        address: address.text,
        area: area.text,
        education: education.text,
        profession: profession.text,
        previousExperience: previousExperience.text,
        investmentAmount: investmentAmount.text,
        dealerType: dealerTypeId.value.toString(),
        categoryType: categoriesId.value.toString(),
        userId: user[0].userId.toString(),
        isSync: 0,
        imageFile: imageFile.value!.path);


    int  results = await DatabaseHelper.insertOnBoardDM(data);
    await Future.delayed(const Duration(seconds: 2));
          isLoading.value = 0;
       if(results==0){
         showDialogs(context);

       }else{

         Get.offAllNamed( AppPages.dashboardView);

       }

  }, message: 'Your On Board Dealer  Form \n has been submitted \n\n\nGo to Save form');}

  void formValidation() {
    final validationStatus = validateForm(
      name.text,
      cnic.text,
      mobileNumber.text,
      email.text,
      city.text,
      address.text,
      area.text,
      education.text,
      profession.text,
      previousExperience.text,
      investmentAmount.text,
      imageFile.value,
      categoriesId.value ?? "", // Provide a default value if categoriesId is null
      dealerTypeId.value ?? "", // Provide a default value if dealerTypeId is null
    );

    if (validationStatus == ValidationStatus.valid) {
      isValid.value = true;
      errorMessage.value = "";
    } else {
      isValid.value = false;
      errorMessage.value = validationStatus.message;
    }

  }

  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":
        imageFile.value = await ImagePicker.platform.pickImage(source: ImageSource.gallery, imageQuality: 90);
        break;
      case "camera":
        imageFile.value = await ImagePicker.platform.pickImage(source: ImageSource.camera, imageQuality: 90);
        break;
    }
    formValidation();
    if (imageFile.value != null) {

    } else {
      print("You have not taken image");
    }
  }
}

enum ValidationStatus {
  valid(""),
  invalidName("Invalid name"),
  invalidCnic("Invalid CNIC"),
  invalidMobileNumber("Invalid mobile number"),
  invalidEmail("Invalid email"),
  invalidCity("Invalid city"),
  invalidAddress("Invalid address"),
  invalidArea("Invalid area"),
  invalidEducation("Invalid education"),
  invalidProfession("Invalid profession"),
  invalidPreviousExperience("Invalid previous experience"),
  invalidInvestmentAmount("Invalid investment amount"),
  invalidImageFile("No image selected"),
  dealerTypeId("Select dealer Type"),
  categoriesId("Select Category Type");

  final String message;
  const ValidationStatus(this.message);
}

ValidationStatus validateForm(
  String name,
  String cnic,
  String mobileNumber,
  String email,
  String city,
  String address,
  String area,
  String education,
  String profession,
  String previousExperience,
  String investmentAmount,
  PickedFile? imageFile,
  String dealerTypeId,
  String categoriesId,
) {
  if (name.isEmpty) return ValidationStatus.invalidName;
  if (InputValidation.cnicValidation(cnic).isNotEmpty) return ValidationStatus.invalidCnic;
  if (InputValidation.numberValidation(mobileNumber)==false) return ValidationStatus.invalidMobileNumber;
  if (InputValidation.emailValidation(email).isNotEmpty) return ValidationStatus.invalidEmail;
  if (city.isEmpty) return ValidationStatus.invalidCity;
  if (address.isEmpty) return ValidationStatus.invalidAddress;
  if (area.isEmpty) return ValidationStatus.invalidArea;
  if (education.isEmpty) return ValidationStatus.invalidEducation;
  if (profession.isEmpty) return ValidationStatus.invalidProfession;
  if (previousExperience.isEmpty) return ValidationStatus.invalidPreviousExperience;
  if (investmentAmount.isEmpty) return ValidationStatus.invalidInvestmentAmount;
  if (imageFile == null || imageFile.path.isEmpty) return ValidationStatus.invalidImageFile;
  if (dealerTypeId.toString() == "") return ValidationStatus.dealerTypeId;
  if (categoriesId.toString() == "") return ValidationStatus.categoriesId;
  return ValidationStatus.valid;
}
void showDialogs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.transparent, // Add this line to make the background transparent
        child: AlertDialog(
          backgroundColor: Colors.white, // Set your desired background color here
          title: const Text("Error"),
          content: Text("This cnc Number Already Exist"),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}