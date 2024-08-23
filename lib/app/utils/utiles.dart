import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/color.dart';
import '../widgets/button/Button.dart';

class Utils {
  static void showSnackBar(String title, String message, {Color? color}) {
    Get.snackbar(
      backgroundColor: color ?? Colors.transparent,
      duration: Duration(seconds: 3),
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      // backgroundColor: ,
      colorText: FColors.primaryColor,
    );
  }

  static void showAlertDialog({required BuildContext context,
    required Function() callback,
    required String message}) {
    // set up the button
    Widget okButton = SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            width: 120,
            child: Button(
              buttonColor: FColors.primaryColor,
              buttonTxt: "OK",
              callback: callback,
            ),
          )
        ],
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      // title: Text("My title"),
      content: Container(
        alignment: Alignment.center,
        // margin: EdgeInsets.all(10),
        width: 500,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.20,
        child: Text(
          textAlign: TextAlign.center,
          message,
          style: const TextStyle(
              color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500),
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> deleteFiles(List<String> filePaths) async {
    for (String filePath in filePaths) {
      try {
        // Create a File object with the specified path
        final file = File(filePath);

        // Check if the file exists
        if (await file.exists()) {
          // Delete the file
          await file.delete();

          print('File deleted successfully: $filePath');
        } else {
          print('File does not exist: $filePath');
        }
      } catch (e) {
        print('Error deleting file $filePath: $e');
      }
    }
  }

  static getTimeForImageName() {
    DateTime now = DateTime.now();
    return "${now.year}${now.minute}${now.day}${now.second}${now.microsecond} ";
  }

  static filePicker(var allow) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(

        type: FileType.custom,
        allowedExtensions: allow,
      );

      return result;
    } catch (e) {
      showSnackBar("Error", "Error picking file: $e",color:Colors.white);
      print("Error picking file: $e");
      return null;
    }
  }
}
