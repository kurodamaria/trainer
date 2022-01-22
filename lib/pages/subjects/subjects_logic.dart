import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

import 'subjects_state.dart';

class SubjectsLogic extends GetxController {
  final SubjectsState state = SubjectsState();

  Future<Subject> addSubject(String name) async {
    final subject = Subject.minimal(name: name);
    subject.save();
    return subject;
  }
}
