import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/home/home_logic.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject.name, style: Get.textTheme.headline5),
          TextButton(
            onPressed: () async {
                final logic = Get.find<HomeLogic>();
                await logic.toSubjectPage(subject);
            },
            child: Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
