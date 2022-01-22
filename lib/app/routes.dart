import 'package:get/get.dart';
import 'package:trainer/pages/subject/subject_binding.dart';
import 'package:trainer/pages/subject/subject_view.dart';
import 'package:trainer/pages/subjects/subjects_binding.dart';
import 'package:trainer/pages/subjects/subjects_view.dart';

class Routes {
  static final subjectsPage = GetPage(
      name: '/', page: () => SubjectsPage(), binding: SubjectsBinding());
  static final subjectPage = GetPage(
    name: '/subject',
    page: () => SubjectPage(),
    binding: SubjectBinding(),
  );

  static const initialRoute = '/';

  static final getPages = <GetPage>[
    subjectsPage,
    subjectPage,
  ];
}
