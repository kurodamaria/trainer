import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';

import 'add_chunk_logic.dart';

class AddChunkPage extends StatelessWidget {
  AddChunkPage({Key? key}) : super(key: key);

  final logic = Get.find<AddChunkLogic>();
  final state = Get.find<AddChunkLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new chunk'),
        actions: [
          Obx(() {
            return IconButton(
              onPressed: logic.canSave()
                  ? () {
                      logic.confirmSave();
                    }
                  : null,
              icon: Icon(Icons.save),
            );
          })
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Content',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    textInputAction: TextInputAction.next,
                    maxLines: 10,
                    onChanged: (value) {
                      logic.setContent(value);
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      labelText: 'Ref',
                    ),
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      logic.setRef(value);
                    },
                    onFieldSubmitted: (value) async {
                      logic.confirmSave();
                    },
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Hints',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    textInputAction: TextInputAction.next,
                    maxLines: 5,
                    onChanged: (value) {
                      logic.setHints(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
