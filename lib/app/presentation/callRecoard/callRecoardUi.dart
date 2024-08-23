// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dialpad/flutter_dialpad.dart';
//
// class CalRecord extends StatelessWidget {
//
//   static const platform = MethodChannel('molty.com.molty/channel');
//
//   Future<void> _openDialerAndRecord(String phoneNumber) async {
//     try {
//
//       final result = await platform.invokeMethod('openDialerAndRecord', phoneNumber);
//       print(result+"fsdfsf");
//     } on PlatformException catch (e) {
//       print("Failed to start call and recording: '${e.message}'.");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Call Recording Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                 onPressed: () => _openDialerAndRecord('03025737543'), // Replace with the desired phone number
//                 child: Text('Call and Record'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// void showCustomDialog(BuildContext context, Function() callback) {
//   const platform = MethodChannel('molty.com.molty/channel');
//   Future<void> _openDialerAndRecord(String phoneNumber) async {
//     try {
//
//       final result = await platform.invokeMethod('openDialerAndRecord', phoneNumber);
//       debugger();
//       print(result+"fsdfsf");
//     } on PlatformException catch (e) {
//       print("Failed to start call and recording: '${e.message}'.");
//     }
//   }
//   showDialog(
//
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         title: const Text('Choose an action'),
//         content: const SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text('Please select one of the following options:'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton.icon(
//             icon: Icon(Icons.photo_library, color: Colors.blue),
//             label: Text('Gallery'),
//             onPressed: callback,
//           ),
//           TextButton.icon(
//             icon: const Icon(Icons.call, color: Colors.green),
//             label: Text('Call'),
//             onPressed: () {
//               _openDialerAndRecord('03025737543');
//               // Handle the call button press
//               Navigator.of(context).pop();
//               // Add your call selection logic here
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
//
//
