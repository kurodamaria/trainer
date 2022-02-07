import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/widgets/switch_with_description.dart';

import 'settings_logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final logic = Get.find<SettingsLogic>();
  final state = Get.find<SettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          children: [
            DefaultTextStyle(
              style: const TextStyle(fontSize: 18),
              child: SwitchWithDescription(
                description: 'Render Markdown By Default',
                onChanged: (value) {
                  if (value == false) {
                    logic.setPreviewPlainText();
                  } else {
                    logic.setCardPreviewMarkdown();
                  }
                },
              ),
            ),
          ],
        ));
  }
}
