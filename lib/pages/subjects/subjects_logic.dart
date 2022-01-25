import 'dart:developer';

import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/services/services.dart';

import 'subjects_state.dart';

class SubjectsLogic extends GetxController {
  final SubjectsState state = SubjectsState();

  Future<Subject> addSubject(String name) async {
    final subject = Subject.minimal(name: name);
    subject.save();
    return subject;
  }

  Future<void> toSubjectPage(Subject subject) async {
    final chunkBox = await Services.persist.openChunkBox(subject);
    Get.toNamed(Routes.subjectPage.name,
        arguments: {'subject': subject, 'chunkBox': chunkBox});
  }
}
