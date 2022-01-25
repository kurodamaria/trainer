import 'package:get/get.dart';
import 'package:trainer/pages/add_chunk/add_chunk_binding.dart';
import 'package:trainer/pages/add_chunk/add_chunk_view.dart';
import 'package:trainer/pages/edit_chunk/edit_chunk_binding.dart';
import 'package:trainer/pages/edit_chunk/edit_chunk_view.dart';
import 'package:trainer/pages/preview_chunk/preview_chunk_binding.dart';
import 'package:trainer/pages/preview_chunk/preview_chunk_view.dart';
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
  static final addChunkPage = GetPage(
    name: '/add_chunk',
    page: () => AddChunkPage(),
    binding: AddChunkBinding(),
  );
  static final editChunkPage = GetPage(
    name: '/edit_chunk',
    page: () => EditChunkPage(),
    binding: EditChunkBinding(),
  );
  static final previewChunkPage = GetPage(
    name: '/preview_chunk',
    page: () => PreviewChunkPage(),
    binding: PreviewChunkBinding(),
  );
  static final testPage = GetPage(
    name: '/test',
    page: () => TestPage(),
    binding: TestBinding(),
  );

  static const initialRoute = '/';

  static final getPages = <GetPage>[
    subjectsPage,
    subjectPage,
    addChunkPage,
    previewChunkPage,
    editChunkPage,
    testPage,
  ];
}
