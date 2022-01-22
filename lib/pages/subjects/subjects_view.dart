import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/app/routes.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/widgets/confirm_dialog.dart';
import 'package:trainer/widgets/hive_box_list_view.dart';
import 'package:trainer/widgets/subjects.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

import 'subjects_logic.dart';

class SubjectsPage extends StatelessWidget {
  SubjectsPage({Key? key}) : super(key: key);

  final logic = Get.find<SubjectsLogic>();
  final state = Get.find<SubjectsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
      ),
      body: HiveBoxListView<Subject>(
        itemBuilder: (c, index, item) {
          return SubjectView(subject: item);
        },
        box: state.subjects,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = (await Get.dialog(TextInputDialog(labels: ['Name']))) as List<String>?;
          if (result != null) {
            final name = result[0];
            logic.addSubject(name);
          }
        },
      ),
    );
  }
}

// class _SubjectsList extends StatelessWidget {
//   const _SubjectsList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final logic = Get.find<SubjectsLogic>();
//     final state = logic.state;
//     return ValueListenableBuilder(
//       valueListenable: state.subjects.listenable(),
//       builder: (context, Box<Subject> subjects, child) {
//         debugPrint('build');
//         return ListView.builder(
//           itemBuilder: (context, index) {
//             final subject = subjects.getAt(index)!;
//             return GestureDetector(
//               onTap: () async {
//                 final chunkBox = await logic.openChunkBox(subject);
//                 Get.toNamed(Routes.subjectPage.name, arguments: {
//                   'subject': subject,
//                   'chunkBox': chunkBox,
//                 });
//               },
//               child: Card(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Name: ${subject.name}'),
//                     // Text('Id: ${subject.id}'),
//                     // Text('ChunkBoxId(name): ${subject.chunkBoxId}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//           itemCount: subjects.length,
//         );
//       },
//     );
//   }
// }
//
// class _AddButton extends StatelessWidget {
//   const _AddButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {
//         Get.dialog(_AddWidget());
//       },
//       child: Icon(Icons.add),
//     );
//   }
// }
//
// class _AddWidget extends StatelessWidget {
//   const _AddWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final name = ''.obs;
//
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'name'),
//               onChanged: (value) {
//                 name.value = value;
//               },
//             ),
//             Obx(() {
//               return TextButton(
//                 onPressed: name.value.isNotEmpty
//                     ? () async {
//                         final logic = Get.find<SubjectsLogic>();
//                         await logic.addSubject(name.value);
//                         Get.back();
//                       }
//                     : null,
//                 child: Text('Add'),
//               );
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
