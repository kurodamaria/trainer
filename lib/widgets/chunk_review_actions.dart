import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';

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

class FailChunkAction extends StatelessWidget {
  const FailChunkAction({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        chunk.failTimes += 1;
        chunk.save();
      },
      onLongPress: () {
        if (chunk.failTimes > 0) {
          chunk.failTimes -= 1;
          chunk.save();
        }
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.red.withOpacity(0.1)),
      ),
      child: Text(
        'Fail',
        style: TextStyle(color: Colors.red),
      ),
    );
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
        EditChunkAction(chunk: chunk),
      ],
    );
  }
}
