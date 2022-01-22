import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/services/services.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({Key? key, required this.subject}) : super(key: key);

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final chunkBox = await Services.persist.openChunkBox(subject);
        Get.toNamed(Routes.subjectPage.name,
            arguments: {'subject': subject, 'chunkBox': chunkBox});
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('name: ${subject.name}'),
            Text('id: ${subject.id}'),
            Text('chunk box name: ${subject.chunkBoxName}'),
          ],
        ),
      ),
    );
  }
}
