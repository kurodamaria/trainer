import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_chunk_logic.dart';

class EditChunkPage extends StatelessWidget {
  EditChunkPage({Key? key}) : super(key: key);

  final logic = Get.find<EditChunkLogic>();
  final state = Get.find<EditChunkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(state.title),
        actions: [_SaveIconButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _InputFieldCard(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Content',
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                maxLines: 10,
                onChanged: (value) {
                  logic.setContent(value);
                },
              ),
            ),
            _InputFieldCard(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ref',
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  logic.setRef(value);
                },
              ),
            ),
            _InputFieldCard(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Hints',
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                maxLines: 10,
                onChanged: (value) {
                  logic.setHints(value);
                },
              ),
            ),
            _InputFieldCard(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'tags, separated with a space',
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                ),
                maxLines: 5,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    logic.setTags(value.split(' '));
                  } else {
                    logic.setTags([]);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveIconButton extends StatelessWidget {
  _SaveIconButton({Key? key}) : super(key: key);

  final logic = Get.find<EditChunkLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return IconButton(
        onPressed: logic.canSave() ? () {
          logic.previewAndSave();
        } : null,
        icon: const Icon(Icons.save),
      );
    });
  }
}

class _InputFieldCard extends StatelessWidget {
  const _InputFieldCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: child,
      ),
    );
  }
}
