import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subject/subject_state.dart';
import 'package:trainer/widgets/add_floating_action_button.dart';
import 'package:trainer/widgets/chunk_card.dart';
import 'package:trainer/widgets/chunk_review_actions.dart';
import 'package:trainer/widgets/delete_by_dismiss_hive_box_item.dart';
import 'package:trainer/widgets/hive_box_list_builder.dart';
import 'package:trainer/widgets/subjects.dart';

import 'subject_logic.dart';

class SubjectPage extends StatelessWidget {
  SubjectPage({Key? key}) : super(key: key);

  final logic = Get.find<SubjectLogic>();
  final state = Get.find<SubjectLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(state.subject.name),
      ),
      body: PageView(
        children: [
          _AllChunks(),
          _MarkedChunks(),
        ],
        physics: const NeverScrollableScrollPhysics(),
        controller: state.pageController,
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: state.currentFilterIndex.value,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.all_inbox), label: 'All'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Marked'),
          ],
          onTap: (index) {
            logic.switchFilter(index);
          },
        );
      }),
      endDrawer: Drawer(
        child: SubjectDrawer(subject: state.subject),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endTop,
      floatingActionButton: AddFloatingActionButton(
        toolTip: 'Add a new chunk',
        onPressed: () async {
          Get.toNamed(
            Routes.editChunkPage.name,
            arguments: {
              'chunk': Chunk.minimal( content: '', ref: '',
                subjectKey: state.subject.id,
              ),
              'title': 'Add new chunk',
            },
          );
        },
      ),
    );
  }
}

class _AllChunks extends StatelessWidget {
  _AllChunks({Key? key}) : super(key: key);

  final state = Get.find<SubjectLogic>().state;

  @override
  Widget build(BuildContext context) {
    return HiveBoxListBuilder<Chunk>(
      boxName: state.chunkBox.name,
      filter: SubjectState.filters[0],
      itemBuilder: (c, index, item) => DeleteByDismissHiveBoxItem<Chunk>(
        itemBuilder: (BuildContext context, item) {
          return ChunkCard(
            chunk: item,
            trailing: ChunkReviewActions(chunk: item),
          );
        },
        item: item,
      ),
    );
  }
}

class _MarkedChunks extends StatelessWidget {
  _MarkedChunks({Key? key}) : super(key: key);

  final state = Get.find<SubjectLogic>().state;

  @override
  Widget build(BuildContext context) {
    return HiveBoxListBuilder<Chunk>(
      boxName: state.chunkBox.name,
      filter: SubjectState.filters[1],
      itemBuilder: (c, index, item) => DeleteByDismissHiveBoxItem<Chunk>(
        itemBuilder: (BuildContext context, item) {
          return ChunkCard(
            chunk: item, trailing: ChunkReviewActions(chunk: item), ); },
        item: item,
      ),
    );
  }
}
