import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Future<void> toPage(int page) async {
    await state.pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInExpo,
    );
    state.currentIndex.value = page;
    state.currentPageTitle.value = HomeState.pageTitles[page];
  }

  Future<Subject> addNewCollection({required String name}) async {
    final Subject subject = Subject.minimal(name: name);
    await subject.save();
    return subject;
  }
}
