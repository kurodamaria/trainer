import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subject/subject_logic.dart';
import 'package:trainer/widgets/switch_with_description.dart';

class EditChunkAction extends StatelessWidget {
  const EditChunkAction({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Get.toNamed(
          Routes.editChunkPage.name,
          arguments: {'chunk': chunk, 'title': 'Edit Chunk'},
        );
      },
      child: const Text('Edit'),
    );
  }
}

class MarkChunkAction extends StatelessWidget {
  const MarkChunkAction({
    Key? key,
    required this.chunk,
  }) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      child: GestureDetector(
        onTap: () {
          final logic = Get.find<SubjectLogic>();
          logic.markChunk(chunk, !chunk.marked);
        },
        child: Icon(
          Icons.star,
          color: chunk.marked? Colors.amber : Colors.grey,
        ),
      ),
      message: 'Mark this chunk',
    );
    // return SwitchWithDescription(
    //   description: 'Mark',
    //   initialValue: chunk.marked,
    //   onChanged: (value) {
    //     chunk.marked = value;
    //     chunk.save();
    //   },
    // );
  }
}

class ChunkReviewActions extends StatelessWidget {
  const ChunkReviewActions({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // FailChunkAction(chunk: chunk),
        MarkChunkAction(chunk: chunk),
        EditChunkAction(chunk: chunk),
      ],
    );
  }
}
