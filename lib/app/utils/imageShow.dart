
import 'dart:developer';

import 'package:path/path.dart' as path;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';
void showImageView(BuildContext context, List<String?> imagePaths, {int? i,String? paths}) {
      // debugger();
  if (imagePaths.any((path) => path != null && path.isNotEmpty)) {
    // imagePaths.add(paths);

  }else{
    imagePaths=[];
  }

  if(paths != null &&paths =="") {
    imagePaths.isEmpty ? imagePaths.add(paths) : "";
    imagePaths = imagePaths.map((element) => element ?? paths).toList();
  }
  String filePath =imagePaths.isNotEmpty? path.basename(imagePaths[0]!):"";
  String fileExtension =imagePaths.isNotEmpty?  path.extension(filePath):"";
  // Set up the AlertDialog
  final alert = AlertDialog(
    backgroundColor: Colors.white,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       Text(
          fileExtension==".pdf"?"PDF View":"Image View",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        TextButton(onPressed:() {
        Navigator.pop(context); // Close the dialog
      },  child:Image.asset("assets/images/close.png",height: 50,),)
        // GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context); // Close the dialog
        //   },
        //   child: Image.asset("assets/images/close.png"),
        // )
      ],
    ),
    content:SizedBox(
      // height:MediaQuery.of(context).size.height*0.60,
      width: 500,
      child: Stack(
      // mainAxisSize: MainAxisSize.min,
      children: [

        imagePaths.isEmpty?Text("Please refresh data image not available") :
        ListView.builder(
        shrinkWrap: true,
        itemCount:
         imagePaths!.length,
        itemBuilder: (context, index) {

          return ImageContainer(imagePath:imagePaths[index]!);
          // return ImageContainer(imagePath:i==200?imagePaths[index]: imagePaths[i!]);
        },
      )

      ],
    ),),
  );

  // Show the dialog
  showDialog(
    barrierDismissible: false,
    context: context, // Use the provided context
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class ImageContainer extends StatelessWidget {
  final String? imagePath;

  const ImageContainer({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    String filePath = path.basename(imagePath!);
    String fileExtension = path.extension(filePath);
    // debugger();
    return imagePath ==null?SizedBox():Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          // height: MediaQuery.of(context).size.height*0.70,
          child:fileExtension==".pdf"? PdfViewerPage(filePath: imagePath,context:context)
          : Image.file(File(imagePath!)),
        )
      ],
    );
  }
}
// class PdfViewerPage extends StatelessWidget {
//   final String filePath;
//
//   PdfViewerPage({required this.filePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('PDF Viewer'),
//       // ),
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.70,
//           child: SfPdfViewer.file(
//             File(filePath),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class PdfViewerPage extends StatelessWidget {
//   final String filePath;
//
//   PdfViewerPage({required this.filePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body:  SfPdfViewer.file(
//           File(filePath),
//         ),
//
// );
//   }
// }
//
// class PdfViewerPage extends StatelessWidget {
//   final String filePath;
//
//   PdfViewerPage({required this.filePath});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//         height:MediaQuery.of(context).size.height * 0.50,
//         width: 500,
//         child: SfPdfViewer.file(
//           scrollDirection: PdfScrollDirection.horizontal,
//           File(filePath),
//         ),);
//
//   }
// }
Widget PdfViewerPage({String? filePath, BuildContext? context}){

  return  Container(
    height:MediaQuery.of(context!).size.height * 0.50,
    width: 500,
    child: SfPdfViewer.file(
      scrollDirection: PdfScrollDirection.horizontal,
      File(filePath!),
    ),);
}