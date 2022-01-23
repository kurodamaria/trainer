import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/widgets/chunks.dart';
import 'package:trainer/widgets/delete_by_dismiss_hive_box_item.dart';
import 'package:trainer/widgets/hive_box_list_builder.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

import 'subject_logic.dart';

class SubjectPage extends StatelessWidget {
  SubjectPage({Key? key}) : super(key: key);

  final logic = Get.find<SubjectLogic>(); final state = Get.find<SubjectLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(state.subject.name)),
      body: HiveBoxListBuilder<Chunk>(
        boxName: state.chunkBox.name,
        itemBuilder: (c, index, item) => DeleteByDismissHiveBoxItem<Chunk>(
          itemBuilder: (BuildContext context, item) {
            return ChunkView(chunk: item);
          },
          item: item,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = (await Get.dialog(
                  TextInputDialog(labels: ['Name', 'References'])))
              as List<String>?;
          if (result != null) {
            logic.addChunk(result[0], result[1]);
          }
        },
      ),
    );
  }
}
