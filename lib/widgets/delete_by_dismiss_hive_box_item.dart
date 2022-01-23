import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:trainer/widgets/confirm_dialog.dart';

class DeleteByDismissHiveBoxItem<T extends HiveObject> extends StatelessWidget {
  const DeleteByDismissHiveBoxItem(
      {Key? key, required this.itemBuilder, required this.item})
      : super(key: key);

  final Widget Function(BuildContext context, T item) itemBuilder;
  final T item;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (d) async {
        final result = await Get.dialog(
          const ConfirmDialog(msg: 'You cannot undo this.', action: 'Delete'),
        );
        return result;
      },
      onDismissed: (d) async {
        await item.delete();
      },
      key: ValueKey<String>(item.key),
      child: itemBuilder(context, item),
    );
  }
}
