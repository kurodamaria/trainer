import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subject/subject_logic.dart';
import 'package:trainer/widgets/bottom_sheet_container.dart';
import 'package:trainer/widgets/bottom_sheet_handler.dart';
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
              child: TeXView(
                child: TeXViewMarkdown(
                  r'求$$\frac{dy}{dx}+y\sin x=0$$的通解',
                ),
              ),
            ),
            Obx(() {
              if (showHints.value) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(color: Colors.black),
                    TeXView(
                      child: TeXViewMarkdown(
                          r'$$g(y)dy=f(x)dx$$'
                      ),
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            })
          ],
        ),
      ),
      // child: ExpansionTile(
      //   expandedCrossAxisAlignment: CrossAxisAlignment.start,
      //   childrenPadding: EdgeInsets.symmetric(horizontal: 16),
      //   title: Text(chunk.name),
      //   children: [
      //     Divider(color: Colors.black),
      //     Text('Ref: ${chunk.ref}'),
      //     SizedBox(height: 8),
      //     _PointIllustrator(point: chunk.points, max: 2000),
      //     _Actions(chunk: chunk),
      //   ],
      // ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Tooltip(
                message: 'See hints',
                child: TextButton(
                  onPressed: () {
                    Get.bottomSheet(
                      _AttemptsSheet(chunk: chunk),
                      enableDrag: true,
                      // isScrollControlled: true,
                    );
                  },
                  child: const Icon(Icons.remove_red_eye),
                ),
              ),
              Tooltip(
                message: 'Edit',
                child: TextButton(
                  onPressed: () async {
                    final result = await Get.dialog(TextInputDialog(
                      labels: const ['Name', 'Reference'],
                      defaultValues: [chunk.name, chunk.ref],
                    ));
                    if (result != null) {
                      final logic = Get.find<SubjectLogic>();
                      await logic.updateChunk(chunk, result[0], result[1]);
                    }
                  },
                  child: const Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Tooltip(
                message: 'Success',
                child: TextButton(
                  onPressed: () async {
                    await _addAttempt(true);
                  },
                  child: const Icon(Icons.plus_one),
                ),
              ),
              Tooltip(
                message: 'Fail',
                child: TextButton(
                  onPressed: () async {
                    await _addAttempt(false);
                  },
                  child: const Icon(Icons.exposure_minus_1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _addAttempt(bool success) async {
    final logic = Get.find<SubjectLogic>();
    final result = await Get.dialog(const TextInputDialog(labels: ['Memo']));

    if (result != null) {
      if (success) {
        await logic.success(chunk, result[0]);
      } else {
        await logic.fail(chunk, result[0]);
      }
    } else {
      Get.rawSnackbar(message: 'You must input memo.');
    }
  }
}

class _PointIllustrator extends StatelessWidget {
  const _PointIllustrator({Key? key, required this.point, required this.max})
      : super(key: key);

  final int point;
  final int max;

  @override
  Widget build(BuildContext context) {
    final color = HSLColor.fromAHSL(
      1,
      point / max * 255,
      1,
      0.3,
    );
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text('Points: $point'),
        ),
        LinearProgressIndicator(
          color: color.toColor(),
          backgroundColor: color.withAlpha(0.3).toColor(),
          value: point / max,
        ),
      ],
    );
  }
}

class _AttemptsSheet extends StatelessWidget {
  const _AttemptsSheet({Key? key, required this.chunk}) : super(key: key);

  final Chunk chunk;

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Column(
        children: [
          const BottomSheetHandler(),
          Text('${chunk.name}'),
        ],
      ),
    );
  }
}
