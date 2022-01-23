import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trainer/widgets/hive_box_builder.dart';

class HiveBoxListBuilder<T> extends StatelessWidget {
  const HiveBoxListBuilder(
      {Key? key,
      required this.itemBuilder,
      required this.boxName})
      : super(key: key);

  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final String boxName;

  @override
  Widget build(BuildContext context) {
    return HiveBoxFutureBuilder<T>(
      boxName: boxName,
      builder: (context, box) {
        return ValueListenableBuilder<Box<T>>(
          valueListenable: box.listenable(),
          builder: (context, box, child) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return itemBuilder(context, index, box.getAt(index)!);
              },
              itemCount: box.length,
            );
          },
        );
      },
    );
  }
}
