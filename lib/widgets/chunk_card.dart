import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainer/models/models.dart';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: showLevel ? calculateLevel(chunk.failTimes) : null,
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
                    Text('${DateFormat.yMMMd().format(chunk.createdAt)}',
                        style: Get.textTheme.bodyText1),
                    VerticalDivider(color: Colors.black),
                    Expanded(
                      child: Center(
                          child:
                              Text(chunk.ref, style: Get.textTheme.bodyText1)),
                    ),
                    VerticalDivider(color: Colors.black),
                    Text('Fails: ${chunk.failTimes}'),
                    Align(
                      child: SwitchWithDescription(
                          description: 'Hints', value: showHints),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.black),
              Markdown(chunk.content),
              Obx(() {
                if (showHints.value == true) {
                  if (chunk.hints.isNotEmpty) {
                    return Markdown(chunk.hints);
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(color: Colors.black),
                        Center(child: Text('No hints :P')),
                      ],
                    );
                  }
                } else {
                  return SizedBox();
                }
              }),
              if (chunk.tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(height: 30),
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Chip(
                        label: Text(
                          chunk.tags[index],
                        ),
                        labelStyle: TextStyle(fontSize: 12),
                      ),
                      itemCount: chunk.tags.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 4),
                    ),
                  ),
                ),
              if (trailing != null) Divider(color: Colors.black),
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
