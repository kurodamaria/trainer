import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/widgets/preview_chunk.dart';

import 'preview_chunk_logic.dart';

class PreviewChunkPage extends StatelessWidget {
  PreviewChunkPage({Key? key}) : super(key: key);

  final logic = Get.find<PreviewChunkLogic>();
  final state = Get.find<PreviewChunkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        logic.backReedit();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Preview'),
          actions: [
            IconButton(
                onPressed: () {
                  logic.doSave();
                },
                icon: Icon(Icons.check))
          ],
        ),
        body: ChunkCard(
          chunk: state.chunk,
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: Text('Edit')),
              TextButton(
                onPressed: () {},
                child: Text('Fail'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
