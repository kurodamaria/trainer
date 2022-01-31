import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/pages/subject/subject_logic.dart';

class ChunkSortButton extends StatelessWidget {
  ChunkSortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) {
        return <PopupMenuEntry<int>>[
          const PopupMenuItem(
            child: Text('Default'),
            value: 0,
          ),
          const PopupMenuItem(
            child: Text('Newest first'),
            value: 1,
          ),
          const PopupMenuItem(
            child: Text('Marked first'),
            value: 2,
          ),
        ];
      },
      onSelected: (index) {
        final logic = Get.find<SubjectLogic>();
        logic.switchSort(index);
      },
    );
  }
}
