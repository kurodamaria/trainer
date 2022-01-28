import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trainer/widgets/hive_box_builder.dart';

class HiveBoxListBuilder<T> extends StatelessWidget {
  const HiveBoxListBuilder({
    Key? key,
    required this.itemBuilder,
    required this.boxName,
    this.filter,
    this.sort,
  }) : super(key: key);

  final Widget Function(BuildContext context, int index, T item) itemBuilder;
  final String boxName;
  final bool Function(T item)? filter;
  final int Function(T a, T b)? sort;

  @override
  Widget build(BuildContext context) {
    return HiveBoxFutureBuilder<T>(
      boxName: boxName,
      builder: (context, box) {
        return ValueListenableBuilder<Box<T>>(
          valueListenable: box.listenable(),
          builder: (context, box, child) {
            final filtered = (filter != null ? box.values.where((element) =>
                filter!(element)) : box.values).toList();
            if (sort != null) {
              filtered.sort(sort!);
            }
            return ScrollConfiguration(
              behavior: const CupertinoScrollBehavior(),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return itemBuilder(context, index, filtered.elementAt(index));
                },
                itemCount: filtered.length,
              ),
            );
          },
        );
      },
    );
  }
}
