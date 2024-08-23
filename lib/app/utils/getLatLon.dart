// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// Future<Position?> getCurrentPosition() async {
//   final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
//
//   // Check if location services are enabled
//   bool isLocationServiceEnabled = await geolocator.isLocationServiceEnabled();
//   if (!isLocationServiceEnabled) {
//     // Location services are disabled, handle accordingly
//     return null;
//   }
//
//   // Check if the app has permission to access location
//   LocationPermission permission = await geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     // Request permission from the user
//     permission = await geolocator.requestPermission();
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, direct user to settings
//       bool opened = await openAppSettings();
//       if (!opened) {
//         // Handle the case when the settings could not be opened
//         print("Error: Could not open settings");
//         return null;
//       }
//     }
//     if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
//       // Permission denied, handle accordingly
//       return null;
//     }
//   }
//
//   try {
//     // Fetch the current position
//     Position position = await geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     return position;
//   } catch (e) {
//     print("Error: $e");
//     return null; // Return null if there's an error
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Position?> getCurrentPosition(BuildContext context) async {
  final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;

  // Check if location services are enabled
  bool isLocationServiceEnabled = await geolocator.isLocationServiceEnabled();
  if (!isLocationServiceEnabled) {
    // Show a dialog to inform the user to enable location services
    _showDialog(
      context,
      title: 'Location Services Off',
      content: 'Please turn on location services in Settings.',
    );
    return null;
  }

  // Check if the app has permission to access location
  LocationPermission permission = await geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    // Request permission from the user
    permission = await geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, direct user to settings
      bool opened = await openAppSettings();
      if (!opened) {
        // Handle the case when the settings could not be opened
        _showDialog(
          context,
          title: 'Permission Required',
          content: 'Please enable location permissions in Settings.',
        );
        return null;
      }
    }
    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      // Permission denied, handle accordingly
      _showDialog(
        context,
        title: 'Permission Denied',
        content: 'Location permission is required for this feature.',
      );
      return null;
    }
  }

  try {
    // Fetch the current position
    Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  } catch (e) {
    print("Error: $e");
    _showDialog(
      context,
      title: 'Error',
      content: 'Failed to get current position: $e',
    );
    return null; // Return null if there's an error
  }
}

void _showDialog(BuildContext context, {required String title, required String content}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.transparent, // Add this line to make the background transparent
        child: AlertDialog(
          backgroundColor: Colors.white, // Set your desired background color here
          title: Text(title),
          content: Text(content),
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

