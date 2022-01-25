import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subject/subject_logic.dart';
import 'package:trainer/widgets/bottom_sheet_container.dart';
import 'package:trainer/widgets/bottom_sheet_handler.dart';
import 'package:trainer/widgets/markdown.dart';
import 'package:trainer/widgets/switch_with_description.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

class ChunkView extends StatelessWidget {
  ChunkView({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  // final chunk = Chunk(
  //   front: r'求$$\frac{dy}{dx}+y\sin x=0$$的通解',
  //   refs: '364 9.1.3',
  //   hints: [r'$$g(y)dy=f(x)dx$$', r'$$\frac{1}{y}dy=-\sin xdx$$'],
  // );

  final showHints = true.obs;

  @override
  Widget build(BuildContext context) {

    return Card(
      shadowColor: Colors.black,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${DateFormat.yMMMd().format(chunk.createdAt)}',
                    style: Get.textTheme.headline6),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.edit),
                ),
                SwitchWithDescription(description: 'Hints', value: showHints),
              ],
            ),
            const Divider(color: Colors.black),
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Markdown(r'求$$\frac{dy}{dx}+y\sin x=0$$的通解'),
            ),
            Obx(() {
              if (showHints.value) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(color: Colors.black),
                    Markdown(r'$$g(y)dy=f(x)dx$$')
                  ],
                );
              } else {
                return SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }
}
