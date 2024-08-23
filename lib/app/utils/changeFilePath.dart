import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

Future<String?> renameAndSaveImage({required File imageFile, required String newName}) async {
  try {
    // Get the directory to save the file
    final directory = await getApplicationDocumentsDirectory();
    String newFilePath = path.join(directory.path, newName + path.extension(imageFile.path).toLowerCase());

    // Copy the image to the new path with the new name
    final newImage = await imageFile.copy(newFilePath);

    print('Image saved as: ${newImage.path}');
    return newImage.path; // Return the file path with the correct extension
  } catch (e) {
    print('Error renaming and saving image: $e');
    return null;
  }
}
