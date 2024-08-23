import 'package:flutter/material.dart';

import '../theme/color.dart';
import '../theme/textStyle.dart';

noData(String text){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    CircleAvatar(
      radius:60,
      backgroundColor:Colors.grey.withOpacity(0.3),
      child: const Padding(padding:EdgeInsets.all(10) ,child: Icon(Icons.folder_copy,color:FColors.primaryColor,size:70,),) ,),
     SizedBox(height: 10,)
,    Text(
      textAlign: TextAlign.center,
      text,style: FTextStyle.simpleTextStyleBlack,)

  ],);



}