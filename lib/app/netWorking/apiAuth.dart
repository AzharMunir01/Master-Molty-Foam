import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:molty_foam/app/netWorking/responseMessages.dart';
import 'package:path_provider/path_provider.dart';
import '../presentation/dashboard/controller/dashboardController.dart';
import 'apiContst.dart';
import 'baseresponse.dart';
import 'package:image/image.dart' as img; // Import the image package

String token = '';

class ApiServices {
  static Future<bool> checkConnection() async {
    var connection = await Connectivity().checkConnectivity();
    if (connection == ConnectivityResult.mobile || connection == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
// Name { get; set; }
// mobileNumber { get; set; }
// email { get; set; }
// city { get; set; }
// cnic { get; set; }
// address { get; set; }
// area { get; set; }
// education { get; set; }
// profession { get; set; }
// previousExperience { get; set; }
// investmentAmount { get; set; }
// dealertype { get; set; }
// categorytype { get; set; }
// Userid { get; set; }
//

  @override
  Future<BaseResponse> onBDManagement(value) async {
    try {
      final connectionResult = await checkConnection();
      if (connectionResult) {
        var uri = Uri.parse(ApiConst.dealerOnBoardingRequest);
        var request = http.MultipartRequest('POST', uri)
          ..fields['Name'] = value.name
          ..fields['mobileNumber'] = value.mobileNumber
          ..fields['email'] = value.email
          ..fields['city'] = value.city
          ..fields['cnic'] = value.cnic
          ..fields['address'] = value.address
          ..fields['area'] = value.area
          ..fields['education'] = value.education
          ..fields['profession'] = value.profession
          ..fields['previousExperience'] = value.previousExperience
          ..fields['investmentAmount'] = value.investmentAmount
          ..fields['dealertype'] = value.dealerType
          ..fields['categorytype'] = value.categoryType
          ..fields['Userid'] = value.userId
          ..files.add(await http.MultipartFile.fromPath('imageFile', value.imageFile));
        request.headers.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        });

        var response = await request.send().timeout(const Duration(seconds: ApiConst.requestTimeOut));
        var responded = await http.Response.fromStream(response);
        print(response.stream);
        print(responded);

        return checkResponseType(responded);
      } else {
        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      return exceptionMsg(e);
    }
  }

  @override
  Future<BaseResponse> loginApi(value) async {
    // TODO: implement loginApi
    try {
      final connectivityResult = await checkConnection();
      if (connectivityResult) {
        final http.Response response = await http
            .post(Uri.parse(ApiConst.login),
                headers: {
                  "content-type": "application/json",
                },
                body: jsonEncode(value))
            .timeout(const Duration(seconds: ApiConst.requestTimeOut));
        print(response.body);
        return checkResponseType(response);
      } else {
        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      return exceptionMsg(e);
    }
  }

  @override
  Future<BaseResponse> formDataRequest(value) async {
    // TODO: implement loginApi
    try {
      final connectivityResult = await checkConnection();
      if (connectivityResult) {
        final http.Response response = await http
            .post(Uri.parse(ApiConst.formDataRequest),
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
                body: jsonEncode(value))
            .timeout(const Duration(seconds: ApiConst.requestTimeOut));

        print(response.body);

        return checkResponseType(response);
      } else {
        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      return exceptionMsg(e);
    }
  }

  Future<BaseResponse> syncDataUploadDealerFeedback(value) async {
    // TODO: implement loginApi
    try {
      final connectivityResult = await checkConnection();
      if (connectivityResult) {
        final http.Response response = await http
            .post(Uri.parse(ApiConst.syncDataUploadDealerFeedback),
                headers: {
                  'Authorization': 'Bearer $token',
                  'Content-Type': 'application/json',
                },
                body: jsonEncode(value))
            .timeout(const Duration(seconds: ApiConst.requestTimeOut));

        print(response.body);

        return checkResponseType(response);
      } else {
        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      return exceptionMsg(e);
    }
  }

  @override
  Future<BaseResponse> syncData(userID) async {
    // TODO: implement loginApi
    try {
      final connectivityResult = await checkConnection();
      if (connectivityResult) {
        final response = await http.get(
          Uri.parse(ApiConst.syncDataGet + userID.toString()),
          headers: {
            // 'Authorization':
            //     'Bearer $token'
          },
        ).timeout(const Duration(seconds: ApiConst.requestTimeOut));
        print(response.body);

        return checkResponseType(response);
      } else {
        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      return exceptionMsg(e);
    }
  }

  Future<String> getFormImages(url) async {
    try {
      final connectivityResult = await checkConnection();
      if (connectivityResult) {
        final response = await http.get(
          Uri.parse("${ApiConst.fileBaseUri}$url"),
          // headers: {
          //   'Authorization':
          //   'Bearer $token', // Set token here
          // },
        );
        print(response.body);

        if (response.statusCode == 200) {
          final fileName = url.split('/').last;
          final path = '${(await getTemporaryDirectory()).path}/$fileName';
          final File file = File(path);
          await file.writeAsBytes(response.bodyBytes);
          /* if(path != null){
            throw Exception('Failed to load file');
          }*/
          return path;
        } else {
          throw Exception('Failed to load file');
        }
      } else {
        throw Exception(ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      throw e;
    }
  }

  BaseResponse exceptionMsg(var e) {
    if (e.toString() == "TimeoutException after 0:00:60.000000: Future not completed") {
      return BaseResponse(status: "false", message: "Error msg : Might be Network issue or Server unreachable");
    } else {
      return BaseResponse(status: "false", message: "Error msg : $e");
    }
  }

  Future<BaseResponse> checkResponseType(dynamic response) async {
    if (response.statusCode == 200) {
      return BaseResponse(status: "true", message: response.reasonPhrase, data: jsonDecode(response.body));
      // BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      return BaseResponse(status: "false", message: response.reasonPhrase);
    }
  }
  Future<BaseResponse> sendFormFilesBg(List<String> filePaths) async {
    // final DashboardController controller = Get.find<DashboardController>();
    // controller.imageIndex.value = 0;
    // controller.totalImage.value = filePaths.length;
    try {
      final connectionResult = await checkConnection();
      if (connectionResult) {
        var uri = Uri.parse(ApiConst.syncImageUpload);
        var request = http.MultipartRequest('POST', uri);
        if (filePaths.isEmpty) {
          return BaseResponse(status: "false", message: "File does not Exist..");
        }

        // Add multiple files to the request
        for (int i = 0; i < filePaths.length; i++) {
          String filePath = filePaths[i];

          if (File(filePath).existsSync()) {
            var originalFile = File(filePath);
            var fileBytes = originalFile.readAsBytesSync();
            var fileSize = fileBytes.length;
            print("Original file: $filePath, Size: $fileSize bytes");

            // controller.imageIndex.value = i + 1;

            // Compress the image using flutter_image_compress
            Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
              fileBytes,
              quality: 60, // Compression quality (0 - 100)
              minWidth: 700, // Minimum width of the compressed image
            );

            if (compressedBytes == null) {
              throw Exception('Failed to compress image');
            }

            // Add the compressed image data to the request
            request.files.add(http.MultipartFile.fromBytes(
              'files',
              compressedBytes,
              filename: originalFile.uri.pathSegments.last, // Keep the original file name
            ));
          } else {
            print("File does not exist: $filePath");
            return BaseResponse(status: "false", message: "File not found: $filePath");
          }
        }

        var response = await request.send().timeout(const Duration(seconds: 200));
        var responded = await http.Response.fromStream(response);

        print(response.statusCode);
        print(responded.body);
        if (response.statusCode == 200) {
          return checkResponseType(responded);
        } else {
          return BaseResponse(status: "false", message: "Error: ${response.statusCode} - ${responded.body}");
        }
      } else {
        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      print("Exception: $e");
      return exceptionMsg(e);
    }
  }
  Future<BaseResponse> sendFormFiles(List<String> filePaths) async {
    final DashboardController controller = Get.find<DashboardController>();
    controller.imageIndex.value = 0;
    controller.totalImage.value = filePaths.length;
    try {
      final connectionResult = await checkConnection();
      if (connectionResult) {
        var uri = Uri.parse(ApiConst.syncImageUpload);
        var request = http.MultipartRequest('POST', uri);
        if (filePaths.isEmpty) {
          return BaseResponse(status: "false", message: "File does not Exist..");
        }

        // Add multiple files to the request
        for (int i = 0; i < filePaths.length; i++) {
          String filePath = filePaths[i];

          if (File(filePath).existsSync()) {
            var originalFile = File(filePath);
            var fileBytes = originalFile.readAsBytesSync();
            var fileSize = fileBytes.length;
            print("Original file: $filePath, Size: $fileSize bytes");

            controller.imageIndex.value = i + 1;

            // Compress the image using flutter_image_compress
            Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
              fileBytes,
              quality: 60, // Compression quality (0 - 100)
              minWidth: 700, // Minimum width of the compressed image
            );

            if (compressedBytes == null) {
              throw Exception('Failed to compress image');
            }

            // Add the compressed image data to the request
            request.files.add(http.MultipartFile.fromBytes(
              'files',
              compressedBytes,
              filename: originalFile.uri.pathSegments.last, // Keep the original file name
            ));
          } else {
            print("File does not exist: $filePath");
            return BaseResponse(status: "false", message: "File not found: $filePath");
          }
        }

        var response = await request.send().timeout(const Duration(seconds: 200));
        var responded = await http.Response.fromStream(response);

        print(response.statusCode);
        print(responded.body);
        if (response.statusCode == 200) {
          return checkResponseType(responded);
        } else {
          return BaseResponse(status: "false", message: "Error: ${response.statusCode} - ${responded.body}");
        }
      } else {
        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      print("Exception: $e");
      return exceptionMsg(e);
    }
  }

/*  Future<BaseResponse> sendFormFiles(List<String> filePaths) async {
    Directory tempDir = await getTemporaryDirectory();
    try {
      final connectionResult = await checkConnection();
      if (connectionResult) {
        var uri = Uri.parse(ApiConst.syncImageUpload);
        var request = http.MultipartRequest('POST', uri);

        // Add multiple files to the request
        for (String filePath in filePaths) {
          if (File(filePath).existsSync()) {
            var originalFile = File(filePath);
            var fileSize = originalFile.lengthSync();
            print("Original file: $filePath, Size: $fileSize bytes");


            // Compress the image
            img.Image image = img.decodeImage(originalFile.readAsBytesSync())!;
            img.Image resizedImage = img.copyResize(image, width: 720); // Resize to 800px width

            // Save the compressed image temporarily
            Directory tempDir = await getTemporaryDirectory();
            String tempPath = tempDir.path + '/temp_${DateTime.now().millisecondsSinceEpoch}.jpg';
            File compressedFile = File(tempPath)
              ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 60));

            // Rename the compressed file to the original file name
            String newFilePath = tempDir.path + '/' + originalFile.uri.pathSegments.last;
            compressedFile.renameSync(newFilePath);

            // Add the compressed file with the original name to the request
            request.files.add(await http.MultipartFile.fromPath('files', newFilePath));

            // Clean up the temporary file
           // compressedFile.deleteSync();
          } else {
            print("File does not exist: $filePath");
            return BaseResponse(status: "false", message: "File not found: $filePath");
          }
        }


        var response = await request.send().timeout(const Duration(seconds: 200));
        var responded = await http.Response.fromStream(response);

        print(response.statusCode);
        print(responded.body);
        if (response.statusCode == 200) {
          // Clean up the entire temporary directory
          tempDir.deleteSync(recursive: true);
          return checkResponseType(responded);
        } else {

          tempDir.deleteSync(recursive: true);

          return BaseResponse(status: "false", message: "Error: ${response.statusCode} - ${responded.body}");
        }
      } else {

        return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
      }
    } catch (e) {
      print("Exception: $e");
      return exceptionMsg(e);
    }
  }*/

  ///
//   Future<BaseResponse> sendFormFiles(filePaths) async {
//     try {
//
//       final connectionResult = await checkConnection();
//       if (connectionResult) {
//         // https://moltydms.bmccrm.com/MoltyDMApi/api/
//         var uri = Uri.parse(ApiConst.syncImageUpload);
//         // var uri = Uri.parse("https://moltydms.bmccrm.com/MoltyDMApi/api/Admin/SyncImageUpload");
//         // var uri = Uri.parse("https://moltydms.bmccrm.com/MoltyDMApi/api/Admin/SyncImageUpload");
//         // var uri = Uri.parse("https://molty.bmccrm.com:442/MoltyDMAPP/MoltyDMAPI/api/Admin/SyncImageUpload");
//         var request = http.MultipartRequest('POST', uri);
//
//         // Add multiple files to the request
//         for (String filePath in filePaths) {
//           if (File(filePath).existsSync()) {
//
//             var fileSize = File(filePath).lengthSync();
//             print("Uploading file: $filePath, Size: $fileSize bytes");
//             request.files.add(await http.MultipartFile.fromPath('files', filePath));
//           } else {
//             print("File does not exist: $filePath");
//             return BaseResponse(status: "false", message: "File not found: $filePath");
//           }
//         }
//
//         // Set headers if needed (do not set Content-Type for MultipartRequest)
//         // request.headers.addAll({
//         //   'Authorization': 'Bearer $token',
//         // });
//
//         var response = await request.send().timeout(const Duration(seconds: 200));
//         var responded = await http.Response.fromStream(response);
//
//         print(response.statusCode);
//         print(responded.body);
//         if (response.statusCode == 200) {
//           return checkResponseType(responded);
//         } else {
//           return BaseResponse(status: "false", message: "Error: ${response.statusCode} - ${responded.body}");
//         }
//       } else {
//         return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
//       }
//     } catch (e) {
//       print("Exception: $e");
//       return exceptionMsg(e);
//     }
//   }
  ///
  // @override
  // Future<BaseResponse> sendFormFiles(value) async {
  //   try {
  //     final connectionResult = await checkConnection();
  //     if (connectionResult) {
  //
  //
  //       var uri = Uri.parse("https://molty.bmccrm.com:442/MoltyDMAPP/MoltyDMAPI/api/Admin/SyncImageUpload");
  //       // var uri = Uri.parse(ApiConst.dealerOnBoardingRequest);
  //       // var request = http.MultipartRequest('POST', uri);
  //       var request = http.MultipartRequest('POST', uri);
  //       // Add multiple files to the request
  //       for (String filePath in value) {
  //         request.files.add(await http.MultipartFile.fromPath('files', filePath));
  //       }
  //
  //
  //   request.headers.addAll({
  //   // 'Authorization':
  //   // 'Bearer $token',
  //     'Content-Type': 'application/json',
  //   });
  //   var response = await request.send().timeout(const Duration(seconds:200));
  //   var responded = await http.Response.fromStream(response);
  //
  //   print(response.stream);
  //   print(responded);
  //
  //   return checkResponseType(responded);
  //   } else {
  //   return BaseResponse(status: "false", message: ResponseMessages.NETWORK_ERROR);
  //   }
  //   } catch (e) {
  //   return exceptionMsg(e);
  //   }
  // }
}

Future<Uint8List> compressImage(Uint8List fileBytes) async {
  // Compress the image using flutter_image_compress
  Uint8List? compressedBytes = await FlutterImageCompress.compressWithList(
    fileBytes,
    quality: 60, // Compression quality (0 - 100)
    minWidth: 700, // Minimum width of the compressed image
  );

  if (compressedBytes == null) {
    throw Exception('Failed to compress image');
  }

  return compressedBytes;
}
// Function to compress image
/*Future<Uint8List> compressImage(Uint8List fileBytes) async {
  // Decode the image
  img.Image? image = img.decodeImage(fileBytes);
  if (image == null) {
    throw Exception('Failed to decode image');
  }

  // Resize the image
  img.Image resizedImage = img.copyResize(image, width: 800);

  // Encode the image to JPEG format
  return Uint8List.fromList(img.encodeJpg(resizedImage, quality: 60));
}*/

// Function that will run in the isolate
void _compressImageInIsolate(List<dynamic> args) {
  final Uint8List fileBytes = args[0];
  final SendPort sendPort = args[1];

  // Perform the compression
  final result = compressImage(fileBytes);
  result.then((compressedBytes) => sendPort.send(compressedBytes));
}

Future<Uint8List> compressImageInIsolate(Uint8List fileBytes) async {
  final ReceivePort receivePort = ReceivePort();
  await Isolate.spawn(_compressImageInIsolate, [fileBytes, receivePort.sendPort]);
  return await receivePort.first;
}
