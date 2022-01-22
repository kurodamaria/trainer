import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainer/models/models.dart';
import 'package:trainer/services/services.dart';
import 'package:trainer/widgets/chunks.dart';
import 'package:trainer/widgets/hive_box_list_view.dart';
import 'package:trainer/widgets/text_input_dialog.dart';

import 'subject_logic.dart';

class SubjectPage extends StatelessWidget {
  SubjectPage({Key? key}) : super(key: key);

  final logic = Get.find<SubjectLogic>();
  final state = Get.find<SubjectLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(state.subject.name)),
      body: HiveBoxListView<Chunk>(
        box: state.chunkBox,
        itemBuilder: (c, index, item) => ChunkView(chunk: item),
      ),
      // body: const _ChunkList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = (await Get.dialog(
                  TextInputDialog(labels: ['Name', 'References'])))
              as List<String>?;
          if (result != null) {
            logic.addChunk(result[0], result[1]);
          }
        },
      ),
    );
  }
}

// class _ChunkList extends StatelessWidget {
//   const _ChunkList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final logic = Get.find<SubjectLogic>();
//     final state = logic.state;
//     return ValueListenableBuilder(
//       valueListenable: state.chunkBox.listenable(),
//       builder: (context, Box<Chunk> chunkBox, child) {
//         // return Text('${chunkBox.length}');
//         return ListView.builder(
//           itemBuilder: (context, index) {
//             final chunk = chunkBox.getAt(index)!;
//             final reveals = 0.obs;
//             return Dismissible(
//               key: ValueKey<String>(chunk.key),
//               direction: DismissDirection.endToStart,
//               background: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Icon(Icons.delete),
//                 ],
//               ),
//               confirmDismiss: (d) async {
//                 // Show a dialog and return the ... enn thing
//                 return await Get.dialog(_ConfirmDeleteChunkDialog());
//               },
//               onDismissed: (d) async {
//                 await logic.deleteChunk(chunk);
//               },
//               child: Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 8),
//                 child: ExpansionTile(
//                   title: Text(chunk.name),
//                   childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
//                   expandedCrossAxisAlignment: CrossAxisAlignment.start,
//                   subtitle: Text('Ref: ${chunk.ref}'),
//                   children: [
//                     const Divider(color: Colors.grey),
//                     _AttemptViewer(chunk: chunk, reveals: reveals),
//                     Row(
//                       children: [
//                         TextButton(
//                           onPressed: () async {
//                             final box = await logic.openAttemptBox(chunk);
//                             if (box.length == reveals.value) {
//                               Get.rawSnackbar(message: 'No more attempts');
//                             } else {
//                               reveals.value += 1;
//                             }
//                           },
//                           child: const Icon(Icons.remove_red_eye_outlined),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             reveals.value = 0;
//                           },
//                           child: const Icon(Icons.stop_screen_share_sharp),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   Get.dialog(_ModifyChunkDialog(chunk: chunk));
//                                 },
//                                 child: const Icon(Icons.edit),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             TextButton(
//                               onPressed: () {
//                                 Get.dialog(_AddAttemptDialog(
//                                     chunk: chunk, success: true));
//                               },
//                               child: const Icon(Icons.plus_one),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 Get.dialog(_AddAttemptDialog(
//                                     chunk: chunk, success: false));
//                               },
//                               child: const Icon(Icons.exposure_minus_1),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//           itemCount: chunkBox.length,
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
//         Get.dialog(const _AddDialog());
//       },
//       child: const Icon(Icons.add),
//       tooltip: 'Add a new chunk',
//     );
//   }
// }
//
// class _AddDialog extends StatelessWidget {
//   const _AddDialog({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final name = ''.obs;
//     final ref = ''.obs;
//
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               decoration: const InputDecoration(labelText: 'Name'),
//               onChanged: (value) {
//                 name.value = value;
//               },
//             ),
//             TextField(
//               decoration: const InputDecoration(labelText: 'Reference'),
//               onChanged: (value) {
//                 ref.value = value;
//               },
//             ),
//             Obx(() {
//               final enable = name.value.isNotEmpty && ref.value.isNotEmpty;
//               return TextButton(
//                 onPressed: enable
//                     ? () async {
//                         final logic = Get.find<SubjectLogic>();
//                         logic.addChunk(name.value, ref.value);
//                         Get.back();
//                       }
//                     : null,
//                 child: const Text('Add'),
//               );
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _AttemptViewer extends StatelessWidget {
//   const _AttemptViewer({Key? key, required this.chunk, required this.reveals})
//       : super(key: key);
//
//   final Chunk chunk;
//   final RxInt reveals;
//
//   @override
//   Widget build(BuildContext context) {
//     final logic = Get.find<SubjectLogic>();
//     return FutureBuilder(
//       future: Services.persist.openAttemptBox(chunk),
//       builder: (BuildContext context, AsyncSnapshot<Box<Attempt>> snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasData) {
//             final box = snapshot.data!;
//             // return Text('Attempts: ${box.length}');
//             return ValueListenableBuilder(
//               valueListenable: box.listenable(),
//               builder: (context, Box<Attempt> box, child) {
//                 return Obx(() {
//                   return Column(
//                     children: [
//                       // _SuccessesFails(chunk: chunk),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           final attempt = box.getAt(index)!;
//                           final reached = false.obs;
//                           return Dismissible(
//                             key: ValueKey<String>(attempt.key),
//                             child: ListTile(title: Text(attempt.memo)),
//                             direction: DismissDirection.endToStart,
//                             background: Container(
//                               // color: Colors.redAccent,
//                               alignment: Alignment.centerRight,
//                               child: Obx(() {
//                                 return Icon(Icons.delete,
//                                     color: reached.value
//                                         ? Colors.red
//                                         : Colors.black);
//                               }),
//                             ),
//                             confirmDismiss: (d) async {
//                               reveals.value -= 1;
//                               attempt.delete();
//                             },
//                             onUpdate: (detail) {
//                               reached.value = detail.reached;
//                             },
//                           );
//                         },
//                         itemCount: reveals.value,
//                       ),
//                     ],
//                   );
//                 });
//               },
//             );
//           } else {
//             return Text('Attempts: Error ${snapshot.error}');
//           }
//         }
//         return const Text('Attempts: Loading...');
//       },
//     );
//   }
// }
//
// class _ModifyChunkDialog extends StatelessWidget {
//   const _ModifyChunkDialog({Key? key, required this.chunk}) : super(key: key);
//
//   final Chunk chunk;
//
//   @override
//   Widget build(BuildContext context) {
//     final name = chunk.name.obs;
//     final ref = chunk.ref.obs;
//
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: TextEditingController(text: name.value),
//               decoration: const InputDecoration(labelText: 'Name'),
//               onChanged: (value) {
//                 name.value = value;
//               },
//             ),
//             TextField(
//               controller: TextEditingController(text: ref.value),
//               decoration: const InputDecoration(labelText: 'Reference'),
//               onChanged: (value) {
//                 ref.value = value;
//               },
//             ),
//             Obx(() {
//               final enable = name.value.isNotEmpty && ref.value.isNotEmpty;
//               return TextButton(
//                 onPressed: enable
//                     ? () async {
//                         chunk.name = name.value;
//                         chunk.ref = ref.value;
//                         await chunk.save();
//                         Get.back();
//                       }
//                     : null,
//                 child: const Text('Done'),
//               );
//             })
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _AddAttemptDialog extends StatelessWidget {
//   const _AddAttemptDialog(
//       {Key? key, required this.chunk, required this.success})
//       : super(key: key);
//
//   final Chunk chunk;
//   final bool success;
//
//   @override
//   Widget build(BuildContext context) {
//     final memo = ''.obs;
//
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Add Attempt', style: Get.textTheme.headline6),
//             Text(
//                 'You ${success ? 'succeed' : 'failed'}! Input your hint for next you.',
//                 style: Get.textTheme.bodyText2),
//             TextField(
//               decoration: const InputDecoration(labelText: 'Memo'),
//               maxLines: 4,
//               onChanged: (value) {
//                 memo.value = value;
//               },
//             ),
//             Obx(() {
//               return TextButton(
//                 onPressed: memo.value.isNotEmpty
//                     ? () async {
//                         // final logic = Get.find<SubjectLogic>();
//                         // await logic.addAttempt(chunk, success, memo.value);
//                         // Get.back();
//                       }
//                     : null,
//                 child: const Text('Done'),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _ConfirmDeleteChunkDialog extends StatelessWidget {
//   const _ConfirmDeleteChunkDialog({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Confirm deletion', style: Get.textTheme.headline6),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Get.back(result: false);
//                     },
//                     child: Text('Cancel')),
//                 SizedBox(width: 24),
//                 TextButton(
//                   onPressed: () {
//                     Get.back(result: true);
//                   },
//                   child: Text('Delete', style: TextStyle(color: Colors.red)),
//                   style: ButtonStyle(
//                       overlayColor: MaterialStateProperty.all(
//                           Colors.red.withOpacity(0.1))),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // class _SuccessesFails extends StatelessWidget {
// //   const _SuccessesFails({Key? key, required this.chunk}) : super(key: key);
// //
// //   final Chunk chunk;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Expanded(
// //           child: Card(
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Text(
// //                 'Success: ${chunk.attempts.where((element) => element.success == true).length}',
// //               ),
// //             ),
// //           ),
// //         ),
// //         Expanded(
// //           child: Card(
// //             child: Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Text(
// //                 'Fail: ${chunk.attempts.where((element) => element.success == false).length}',
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
