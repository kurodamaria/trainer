import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/widgets/delete_by_dismiss_hive_box_item.dart';
import 'package:trainer/widgets/hive_box_list_builder.dart';
import 'package:trainer/widgets/subjects.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

import 'subjects_logic.dart';

class SubjectsPage extends StatelessWidget {
  SubjectsPage({Key? key}) : super(key: key);

  final logic = Get.find<SubjectsLogic>();
  final state = Get.find<SubjectsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
      ),
      body: HiveBoxListBuilder<Subject>(
        boxName: state.subjects.name,
        itemBuilder: (c, index, item) => DeleteByDismissHiveBoxItem<Subject>(
          itemBuilder: (context, item) => SubjectView(subject: item),
          item: item,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = (await Get.dialog(TextInputDialog(labels: ['Name'])))
              as List<String>?;
          if (result != null) {
            final name = result[0];
            logic.addSubject(name);
          }
        },
      ),
    );
  }
}
