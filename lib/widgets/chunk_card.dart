import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/tools/datetime.dart';
import 'package:trainer/widgets/markdown.dart';
import 'package:trainer/widgets/switch_with_description.dart';

class ChunkCard extends StatelessWidget {
  ChunkCard({
    Key? key,
    this.trailing,
    required this.chunk,
    this.showLevel = true,
    bool? showHints,
  })  : showHints = showHints?.obs ?? false.obs,
        super(key: key);

  final Chunk chunk;

  final Widget? trailing;

  final RxBool showHints;

  final bool showLevel;

  /// For render equations and handle render exceptions of flutter_tex.
  final RxBool _renderMarkdown = false.obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(
                      DateFormat.yMMMd().format(chunk.createdAt),
                      style: Get.textTheme.bodyText1,
                    ),
                    const VerticalDivider(),
                    Text('${DateTimeTools.daysAgo(chunk.createdAt)} Days Ago'),
                    const VerticalDivider(),
                    Expanded(
                      child: Text(chunk.ref, style: Get.textTheme.bodyText1),
                    ),
                  ],
                ),
              ),
              const Divider(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Obx(() {
                  debugPrint('build');
                  if (_renderMarkdown.isTrue) {
                    return Markdown(chunk.content);
                  } else {
                    return Text(chunk.content);
                  }
                }),
                onTap: () {
                  // send a stream
                  _renderMarkdown.value = !_renderMarkdown.value;
                },
                onDoubleTap: () {
                  showHints.value = !showHints.value;
                },
              ),
              Obx(() {
                if (showHints.value == true) {
                  if (chunk.hints.isNotEmpty) {
                    return Markdown(chunk.hints);
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Divider(),
                        Center(child: Text('No hints :P')),
                      ],
                    );
                  }
                } else {
                  return const SizedBox();
                }
              }),
              if (chunk.tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(height: 30),
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Chip(
                        label: Text(
                          chunk.tags[index],
                        ),
                        labelStyle: const TextStyle(fontSize: 12),
                      ),
                      itemCount: chunk.tags.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(width: 4),
                    ),
                  ),
                ),
              if (trailing != null) const Divider(),
              if (trailing != null) trailing!
            ],
          ),
        ),
      ),
    );
  }
}

Color calculateLevel(int failTimes) {
  if (failTimes <= 3) {
    return Colors.white;
  } else {
    return Colors.yellow[300]!;
  }
}
