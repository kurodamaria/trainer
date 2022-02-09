import 'package:get/get.dart';
import 'package:trainer/pages/edit_chunk/edit_chunk_binding.dart';
import 'package:trainer/pages/edit_chunk/edit_chunk_view.dart';
import 'package:trainer/pages/home/home_binding.dart';
import 'package:trainer/pages/home/home_view.dart';
import 'package:trainer/pages/preview_chunk/preview_chunk_binding.dart';
import 'package:trainer/pages/preview_chunk/preview_chunk_view.dart';
import 'package:trainer/pages/resolve_conflict/resolve_conflict_binding.dart';
import 'package:trainer/pages/resolve_conflict/resolve_conflict_view.dart';
import 'package:trainer/pages/search/search_binding.dart';
import 'package:trainer/pages/search/search_view.dart';
import 'package:trainer/pages/settings/settings_binding.dart';
import 'package:trainer/pages/settings/settings_view.dart';
import 'package:trainer/pages/subject/subject_binding.dart';
import 'package:trainer/pages/subject/subject_view.dart';
import 'package:trainer/pages/test/test_binding.dart';
import 'package:trainer/pages/test/test_view.dart';

class Routes {
  static final subjectPage = GetPage(
    name: '/subject',
    page: () => SubjectPage(),
    binding: SubjectBinding(),
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
  static final searchPage = GetPage(
    name: '/search',
    page: () => SearchPage(),
    binding: SearchBinding(),
  );
  static final testPage = GetPage(
    name: '/test',
    page: () => TestPage(),
    binding: TestBinding(),
  );
  static final homePage = GetPage(
    name: '/',
    page: () => HomePage(),
    binding: HomeBinding()
  );
  static final settingsPage = GetPage(
    name: '/settings',
    page: () => SettingsPage(),
    binding: SettingsBinding(),
  );
  static final resolveConflictPage = GetPage(
    name: '/resolve-conflict',
    page: () => ResolveConflictPage(),
    binding: ResolveConflictBinding(),
  );


  static const initialRoute = '/';

  static final getPages = <GetPage>[
    homePage,
    subjectPage,
    previewChunkPage,
    editChunkPage,
    testPage,
    searchPage,
    settingsPage,
    resolveConflictPage,
  ];
}
