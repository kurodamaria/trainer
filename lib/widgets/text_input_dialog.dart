import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInputDialog extends StatelessWidget {
  const TextInputDialog({Key? key, required this.labels}) : super(key: key);

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final values = labels.map((e) => ''.obs).toList();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...labels.map((e) => TextField(
                  decoration: InputDecoration(labelText: e),
                  onChanged: (value) {
                    values[labels.indexOf(e)].value = value;
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back(result: null);
                  },
                  child: Text('Quit'),
                ),
                Obx(() {
                  final enable = values.every((element) => element.isNotEmpty);
                  return TextButton(
                    onPressed: enable
                        ? () {
                            Get.back(result: values.map((e) => e.value).toList());
                          }
                        : null,
                    child: Text('Done'),
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
