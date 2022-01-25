import 'package:flutter/material.dart';
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
    bool? showHints,
  })  : showHints = showHints?.obs ?? false.obs,
        super(key: key);

  final Chunk chunk;

  final Widget? trailing;

  final RxBool showHints;

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
              if (trailing != null)
                Divider(color: Colors.black),
              if (trailing != null)
                trailing!
            ],
          ),
        ),
      ),
    );
  }
}
