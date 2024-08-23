import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/textStyle.dart';

class UploadFile extends StatefulWidget {
  final Function()? callBack;
  final String? value;
  const UploadFile({this.callBack, this.value});

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.white,width: 1)
      ),
      child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Container(
          width:MediaQuery.of(context).size.width*0.70,
          child: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          widget.value!.isEmpty?"  Choose File":"  ${widget.value!}",style:widget.value!.isEmpty? FTextStyle.boldTextStyleGrey:FTextStyle
              .simpleTextStyleBlack,),),
        InkWell(
            onTap: widget.callBack!,
            child:Container(
          alignment: Alignment.center,
            height: 59,
            width: 90,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(5),bottomRight: Radius.circular(5)),
          color:Color(0XFF868E96)

        ),child: const Text(
          "Browse",style: TextStyle(color: Colors.white),),

        ))]),
    );
  }
}
