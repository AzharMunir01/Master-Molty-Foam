import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routes/app_page.dart';
import '../theme/color.dart';
import '../theme/textStyle.dart';
import '../widgets/button/Button.dart';

showAlertDialog({required BuildContext context, required Function() callback}) {
  // set up the button
  Widget okButton = Container(
    width: double.infinity,
    child:Column(children: [
      SizedBox(
        width: 120,
        child: Button(buttonColor:FColors.primaryColor,buttonTxt: "OK",callback:
        callback
        //     (){
        //   Navigator.pop(context);
        //   Navigator.pushNamed(context, AppPages.outdoorShopFasciaView);
        //
        // }
        ,),)
    ],),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    // contentPadding: const EdgeInsets.all(10),
    backgroundColor: Colors.white,
    insetPadding: EdgeInsets.all(10),
    // title: Text("My title"),
    content: Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.all(10),
      width: 500,
      height:MediaQuery.of(context).size.height*0.20,
      child: const Text(
    textAlign: TextAlign.center,
      "Your KPI Question Form \n has been submitted \n\n\nGo to next form",
      style:  TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.w500),
    ),),
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
