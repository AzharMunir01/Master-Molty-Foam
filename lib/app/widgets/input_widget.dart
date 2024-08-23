import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/color.dart';
import '../theme/textStyle.dart';


class InputWidget extends StatefulWidget {
  final TextInputType? inputType;
  final TextInputAction? action;
  final String? hint;
  final int? maxLine;
  final String? label;
  final IconData? suffixIcon;
  final void Function()? suffixIconOnPressed;
  final String? errorText;
  final bool? obscureText;
  final int? maxLength;
  final String? textInputFormatter;
  final String? prefix;
  final int? length;
  final TextEditingController? textEditingController;
  ValueChanged<Object?>? valChanged;
  final bool? isenable;
  bool isStartZero=true;
  InputWidget(
      {Key? key,
        this.inputType,
        this.action = TextInputAction.next,
        this.hint,
        this.maxLine,
        this.suffixIcon,
        this.suffixIconOnPressed,
        this.errorText,
        this.obscureText,
        this.textInputFormatter,
        this.label,
        this.valChanged,
        this.textEditingController,
        this.prefix,
        this.length,
        this.maxLength,
        this.isStartZero=true,

        this.isenable})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {

  bool isFocus=false;

  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            isFocus = hasFocus;
          });
        },
        child:TextFormField(
          // style: TextStyle(fontSize: 15),
          obscureText: widget.obscureText == null ? false :  widget.obscureText!,
          keyboardType:  widget.inputType,
          controller:  widget.textEditingController,
          maxLength:  widget.maxLength,
          maxLines:widget.maxLine??30,
          minLines: 1,
          // widget.maxLine??1,
          style:widget.isenable !=null ||widget.isenable==true ?FTextStyle.textFielhintStyleGrey: FTextStyle.textFieldStyleblack,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp( widget.textInputFormatter == null
                ? '[0-9a-zA-Z @._ ]'
                :  widget.textInputFormatter!)),

            widget.isStartZero?  FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z @._ ]')): FilteringTextInputFormatter.deny(RegExp(r'^0+')),


            widget.length != null?
            LengthLimitingTextInputFormatter( widget.length):LengthLimitingTextInputFormatter(100),
          ],
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabled:  widget.isenable == false ? false : true,
              contentPadding: const EdgeInsets.all(20.0),
              hintStyle:  FTextStyle.textFielhintStyleGrey,
              // FTextStyle.simpleTextStyleGrey,
              hintText:  widget.hint,
              labelText:  widget.label,
              labelStyle: FTextStyle.simpleTextStyleTheme,
              errorStyle: TextStyle(fontSize: 12),
              isDense: true,

              prefix:  widget.prefix != null ?  const Text('+92',style: FTextStyle.simpleTextStyleTheme,):null,
              suffixIcon: InkWell(onTap:  widget.suffixIconOnPressed,child:Icon( widget.suffixIcon,color: isFocus?FColors.primaryDarkColor:Colors.grey,),) ,
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: FColors.primaryDarkColor),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(16))) ,
              errorText:  widget.errorText),
          onChanged:  widget.valChanged,
          textInputAction:  widget.action,

        ));
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import '../theme/color.dart';
// import '../theme/textStyle.dart';
//
//
// class InputWidget extends StatefulWidget {
//   final TextInputType? inputType;
//   final TextInputAction? action;
//   final String? hint;
//   final String? label;
//   final IconData? suffixIcon;
//   final void Function()? suffixIconOnPressed;
//   final String? errorText;
//   final bool? obscureText;
//   final int? maxLength;
//   final String? textInputFormatter;
//   final String? prefix;
//   final int? length;
//   final TextEditingController? textEditingController;
//   ValueChanged<Object?>? valChanged;
//   final bool? isenable;
//   bool isStartZero=true;
//   InputWidget(
//       {Key? key,
//         this.inputType,
//         this.action = TextInputAction.next,
//         this.hint,
//         this.suffixIcon,
//         this.suffixIconOnPressed,
//         this.errorText,
//         this.obscureText,
//         this.textInputFormatter,
//         this.label,
//         this.valChanged,
//         this.textEditingController,
//         this.prefix,
//         this.length,
//         this.maxLength,
//         this.isStartZero=true,
//
//         this.isenable})
//       : super(key: key);
//
//   @override
//   State<InputWidget> createState() => _InputWidgetState();
// }
//
// class _InputWidgetState extends State<InputWidget> {
//
//   bool isFocus=false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Focus(
//         onFocusChange: (hasFocus) {
//           setState(() {
//             isFocus = hasFocus;
//           });
//         },
//         child:TextFormField(
//
//           // style: TextStyle(fontSize: 15),
//           obscureText: widget.obscureText == null ? false :  widget.obscureText!,
//           keyboardType:  widget.inputType,
//           controller:  widget.textEditingController,
//           maxLength:  widget.maxLength,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp( widget.textInputFormatter == null
//                 ? '[0-9a-zA-Z @._ ]'
//                 :  widget.textInputFormatter!)),
//
//             widget.isStartZero?  FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z @._ ]')): FilteringTextInputFormatter.deny(RegExp(r'^0+')),
//
//
//             widget.length != null?
//             LengthLimitingTextInputFormatter( widget.length):LengthLimitingTextInputFormatter(100),
//           ],
//           decoration: InputDecoration(
//               filled: true,
//               fillColor: Colors.white,
//               enabled:  widget.isenable == false ? false : true,
//               contentPadding: const EdgeInsets.all(15.0),
//               hintStyle:  FTextStyle.simpleTextStyleGrey,
//               hintText:  widget.hint,
//               labelText:  widget.label,
//               labelStyle: FTextStyle.simpleTextStyleTheme,
//               errorStyle: TextStyle(fontSize: 12),
//               isDense: true,
//               prefix:  widget.prefix != null ?  const Text('+92',style: FTextStyle.simpleTextStyleTheme,):null,
//               suffixIcon: InkWell(onTap:  widget.suffixIconOnPressed,child:Icon( widget.suffixIcon,color: isFocus?FColors.primaryDarkColor:Colors.grey,),) ,
//               focusedErrorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                   borderRadius: BorderRadius.all(Radius.circular(5))),
//               errorBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red),
//                   borderRadius: BorderRadius.all(Radius.circular(5))),
//               focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: FColors.primaryDarkColor),
//                   borderRadius: BorderRadius.all(Radius.circular(5))),
//               enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black),
//                   borderRadius: BorderRadius.all(Radius.circular(5))),
//               disabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color:Colors.white),
//                   borderRadius: BorderRadius.all(Radius.circular(5))) ,
//               errorText:  widget.errorText),
//           onChanged:  widget.valChanged,
//           textInputAction:  widget.action,
//         ));
//   }
// }
