import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  final VoidCallback? callback;
  final String? buttonTxt;
  final Color? buttonColor;
  final Color? buttonTxtColors;
  final double? btnBorder;
  const Button(
      {Key? key,
      this.callback,
      this.buttonTxt,
      this.buttonColor,
      this.buttonTxtColors,
      this.btnBorder
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      child: Text(
        buttonTxt!,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          elevation: MaterialStateProperty.all(10),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(btnBorder ??10));
          })),
    );
  }
}



