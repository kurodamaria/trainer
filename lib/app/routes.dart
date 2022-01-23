import 'package:get/get.dart';
import 'package:trainer/pages/subject/subject_binding.dart';
import 'package:trainer/pages/subject/subject_view.dart';
import 'package:trainer/pages/subjects/subjects_binding.dart';
import 'package:trainer/pages/subjects/subjects_view.dart';
import 'package:trainer/pages/test/test_binding.dart';
import 'package:trainer/pages/test/test_view.dart';

class Routes {
  static final subjectsPage = GetPage(
      name: '/', page: () => SubjectsPage(), binding: SubjectsBinding());
  static final subjectPage = GetPage(
    name: '/subject',
    page: () => SubjectPage(),
    binding: SubjectBinding(),
  );
  static final testPage = GetPage(
    name: '/test',
    page: () => TestPage(),
    binding: TestBinding(),
  );

  static const initialRoute = '/test';

  static final getPages = <GetPage>[
    subjectsPage,
    subjectPage,
    testPage,
  ];
}
