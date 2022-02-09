import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/services/services.dart';

class HomeState {
  static final pageTitles = <String>[
    'Chunk Collection',
    'Search',
    'Statistics'
  ];

  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;
  final Box<Subject> subjectBox = Services.persist.subjectsBox;
  final RxString currentPageTitle = pageTitles[0].obs;
}
