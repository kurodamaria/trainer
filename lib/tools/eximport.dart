import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/services/services.dart';
import 'package:path/path.dart' as path;

Future<void> exportSubject(Subject subject) async {
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
    dialogTitle: 'Select the directory where the exported file will be stored.',
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
  String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
    dialogTitle: 'Select the directory where the exported file will be stored.',
  );

  if (selectedDirectory != null) {
    final f = File(path.join(selectedDirectory,
        'trainer-export-${DateTime.now().millisecondsSinceEpoch}.json'));
    if (await f.exists() == false) {
      final subjectsBox = Services.persist.subjectsBox;
      final result =
          await Future.wait(subjectsBox.values.map((e) => e.toJson()));
      await f.writeAsString(jsonEncode(result));
    } else {
      if (Get.isSnackbarOpen == false) {
        Get.rawSnackbar(message: 'File exists :(');
      }
    }
  }
}

Future<void> importSubjectFromJson(String source) async {
  final decoded = jsonDecode(source) as Map<String, dynamic>;
  final subject = Subject(
      id: decoded['id'],
      name: decoded['name'],
      createdAt: DateTime.parse(decoded['createdAt']),
      chunkBoxName: decoded['chunkBoxName']);

  if (Services.persist.subjectsBox.containsKey(subject.id)) {
    debugPrint('subject id conflict');
  } else if (await Services.boxExists(subject.chunkBoxName)) {
    debugPrint('chunk id conflict');
  } else {
    await subject.save();
    final chunks = decoded['chunks'] as List<dynamic>;
    for (final chunk in chunks) {
      final c = Chunk(
          chunkBoxName: chunk['chunkBoxName'],
          createdAt: DateTime.parse(chunk['createdAt']),
          content: chunk['content'],
          hints: chunk['hints'],
          id: chunk['id'],
          marked: chunk['marked'],
          ref: chunk['ref'],
          subjectKey: chunk['subjectKey'],
          tags: (chunk['tags'] as List<dynamic>)
              .map((e) => e as String)
              .toList());
      await c.save();
    }
  }
}

Future<void> importFromFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(allowMultiple: true);

  if (result != null) {
    List<File> files = result.paths.map((path) => File(path!)).toList();
    for (final file in files) {
      final source = await file.readAsString();
      await importSubjectFromJson(source);
    }
  }
}
