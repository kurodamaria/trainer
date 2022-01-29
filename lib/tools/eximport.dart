import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/services/services.dart';
import 'package:path/path.dart' as path;

Future<void> exportSubject(Subject subject) async {
  String? selectedDirectory =
  await FilePicker.platform.getDirectoryPath(
    dialogTitle:
    'Select the directory where the exported file will be stored.',
  );

  if (selectedDirectory != null) {
    final f = File(path.join(selectedDirectory,
        'trainer-export-${DateTime.now().millisecondsSinceEpoch}.json'));
    if (await f.exists() == false) {
      final result = await subject.toJson();
      await f.writeAsString(jsonEncode(result));
    } else {
      if (Get.isSnackbarOpen == false) {
        Get.rawSnackbar(message: 'File exists :(');
      }
    }
  }
}

void exportAll() async {
  String? selectedDirectory =
  await FilePicker.platform.getDirectoryPath(
    dialogTitle:
    'Select the directory where the exported file will be stored.',
  );

  if (selectedDirectory != null) {
    final f = File(path.join(selectedDirectory,
        'trainer-export-${DateTime.now().millisecondsSinceEpoch}.json'));
    if (await f.exists() == false) {
      final subjectsBox = Services.persist.subjectsBox;
      final result = await Future.wait(
          subjectsBox.values.map((e) => e.toJson()));
      await f.writeAsString(jsonEncode( result));
    } else {
      if (Get.isSnackbarOpen == false) {
        Get.rawSnackbar(message: 'File exists :(');
      }
    }
  }
}

Future<void> importFromFile() async {

}
