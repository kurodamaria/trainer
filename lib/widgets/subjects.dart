import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/home/home_logic.dart';
import 'package:trainer/tools/datetime.dart';
import 'package:trainer/tools/eximport.dart';
import 'package:trainer/widgets/hive_box_builder.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject.name, style: Get.textTheme.headline5),
          TextButton(
            onPressed: () async {
              final logic = Get.find<HomeLogic>();
              await logic.toSubjectPage(subject);
            },
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}

class SubjectDrawer extends StatelessWidget {
  const SubjectDrawer({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerHeader(
          child: Text(subject.name, style: Get.textTheme.headline3),
        ),
        HiveBoxFutureBuilder<Chunk>(
          boxName: subject.chunkBoxName,
          builder: (context, box) {
            return Text('Total: ${box.length}', style: Get.textTheme.headline5);
          },
        ),
        const SizedBox(height: 10),
        Text('Chunk Box ID:', style: Get.textTheme.headline5),
        Text(subject.chunkBoxName),
        const SizedBox(height: 10),
        Text('Create At:', style: Get.textTheme.headline5),
        Text(DateTimeTools.formatDateTime(subject.createdAt)),
        Text('${DateTimeTools.daysAgo(subject.createdAt)} Days Ago'),
        const Divider(),
        TextButton(
          onPressed: () async {
            await exportSubject(subject);
          },
          child: const Text('Export'),
        ),
      ],
    );
  }
}
