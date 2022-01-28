import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/pages/subjects/subjects_logic.dart';
import 'package:trainer/services/services.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(subject.name, style: Get.textTheme.headline5),
          TextButton(
            onPressed: () async {
                final logic = Get.find<SubjectsLogic>();
                await logic.toSubjectPage(subject);
            },
            child: Icon(Icons.play_arrow),
          ),
        ],
      ),
      // child: TextButton(
      //   style: ButtonStyle(
      //     alignment: Alignment.centerLeft,
      //     backgroundColor: MaterialStateProperty.all(Colors.white),
      //     shape: MaterialStateProperty.all(
      //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      //     elevation: MaterialStateProperty.all(3),
      //     overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.2)),
      //   ),
      //   onPressed: () async {
      //     final logic = Get.find<SubjectsLogic>();
      //     await logic.toSubjectPage(subject);
      //   },
      //   onLongPress: () async {
      //     final result = await Get.dialog(TextInputDialog(labels: ['Name'], defaultValues: [subject.name]));
      //     if (result != null) {
      //       subject.name = result[0];
      //       await subject.save();
      //     }
      //   },
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text('${subject.name}', style: Get.textTheme.bodyText1),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
