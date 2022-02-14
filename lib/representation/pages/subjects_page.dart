import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:trainer/data/provider/chunker.dart';
import 'package:trainer/data/repository/chunk_repository.dart';
import 'package:trainer/representation/subject_list_view.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: SubjectListView(
      //   // query: Get.arguments['query'] as MultiSelectable<Subject>,
      // ),
    );
  }

  static Future<dynamic>? ofQuery(MultiSelectable<Subject> query) {
    return Get.to(
      () => const SubjectsPage(),
      arguments: {'query': query},
    );
  }

  static Future<dynamic>? allSubjects() {
    return Get.to(
      () => const SubjectsPage(),
      arguments: {
        'query': Get.context!.read<ChunkRepository>().allSubjects,
      },
    );
  }
}
