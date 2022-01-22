import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trainer/widgets/confirm_dialog.dart';

class HiveBoxListView<T> extends StatelessWidget {
  const HiveBoxListView(
      {Key? key, required this.itemBuilder, required this.box})
      : super(key: key);

  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final Box<T> box;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box<T> b, c) {
        return ListView.builder(
          itemBuilder: (context, index) => Dismissible(
            direction: DismissDirection.endToStart,
            confirmDismiss: (d) async {
              final result = await Get.dialog(
                ConfirmDialog(
                    msg: 'You cannot undo this.', action: 'Delete'),
              );
              return result;
            },
            onDismissed: (d) {
              box.deleteAt(index);
            },
            key: ValueKey<String>(b.keyAt(index)),
            child: itemBuilder(context, index, b.getAt(index)!),
          ),
          itemCount: b.length,
        );
      },
    );
  }
}
