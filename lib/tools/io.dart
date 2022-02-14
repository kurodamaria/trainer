import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:permission_handler/permission_handler.dart';

/// Compress file and get Uint8List
Future<Uint8List?> compressImage(File file, {int quality = 70}) async {
  var result = await FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: quality,
  );
  return result;
}

Future<Uint8List?> compressImageForPreview(Uint8List imageData,
    {int quality = 40}) async {
  var result = await FlutterImageCompress.compressWithList(
    imageData,
    quality: quality,
  );
  return result;
}

Future<File?> pickAFile({FileType type = FileType.any}) async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: type);

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }
  return null;
}

Future<List<File>?> pickMultipleFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: true);

  if (result != null) {
    List<File> files = result.paths.map((path) => File(path!)).toList();
    return files;
  } else {
    return null;
  }
}

Future<Directory?> pickADirectory() async {
  if (await Permission.manageExternalStorage.request().isGranted) {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      return null;
    }
    return Directory(selectedDirectory);
  }
  return null;
}
